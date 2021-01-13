// Normal Map Shader infers fragment normals from a normal map, making a material bumpy.
// This shader also supports albedo and specular tint.
// CatlikeCoding authored this tutorial shader: https://catlikecoding.com/unity/tutorials/rendering/part-6/
Shader "Custom/Normal Map Shader"
{
    Properties
    {
        _Tint ("Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Albedo", 2D) = "white" {}

        _DetailTex("Detail Texture", 2D) = "gray" {}
        // More efficient than computing bumpiness every frame, given that bumpiness doesn't change
        // RGB encoding: Normal Map visualizes xyz normals as rgb (or more accurately xzy -> rbg in unity)
        // DXT5nm encoding: Normal Map encodes xyz normals as 0,y,0,x
        [NoScaleOffset] _NormalMap ("Normals", 2D) = "bump" {}
        _BumpScale ("Bump Scale", Float) = 1
        [NoScaleOffset] _DetailNormalMap ("Detail Normals", 2D) = "bump" {}
        _DetailBumpScale ("Detail BumpScale", Float) = 1

        [Gamma] _Metallic ("Metallic", Range(0, 1)) = 0
        _Smoothness ("Smoothness", Range(0, 1)) = 0.5
    }
    
    // Can set configurations for all passes here.
    // Helpful for configuring the shader to maintain a synched workflow.
    CGINCLUDE

    // Configure whether the binormal should be calc'd in the Fragment program
    // If BINORMAL_PER_FRAGMENT is not defined, binormals will be calc'd in the Vertex program
    #define BINORMAL_PER_FRAGMENT

    ENDCG

    SubShader
    {
        Pass
        {
            // Informs Unity of what role this Pass plays in rendering, and thus which data we need access to
            Tags {
                "LightMode" = "ForwardBase"
            }

            CGPROGRAM
        
            // Shader level 3.0 ensures that Unity selects the best BRDF function
            #pragma target 3.0

            #pragma vertex MyVertexProgram
            #pragma fragment MyFragmentProgram

            // The precise implementation of the UNITY_BRDF_PBS macro is chosen based on platform
            // Includes UnityStandardBRDF and UnityStandardUtils
            #include "UnityPBSLighting.cginc"
            
            float4 _Tint;
			sampler2D _MainTex, _DetailTex;
			float4 _MainTex_ST, _DetailTex_ST;
            sampler2D _NormalMap, _DetailNormalMap;
            float _BumpScale, _DetailBumpScale;
            float _Metallic;
            float _Smoothness;
            
			struct VertexData {
				float4 position: POSITION;
				float2 uv: TEXCOORD0;
                float3 normal: NORMAL;
                // 4th component of the tangent vector is the binormal/bitangent sign (w = +/-1); (B = w(N x T)).
                float4 tangent: TANGENT;
			};

            struct Interpolators
            {
                float4 position: SV_POSITION;
                // Pack the main and detail UVs together: main in xy, detail in zw
                float4 uv: TEXCOORD0;
                float3 normal: NORMAL;
                
                // If we should calc the binormal in the fragment shader, use a 4-component tangent interpolator.
                // Else if we should calc the binormal in the vertex shader, add a binormal interpolator.
                #if defined(BINORMAL_PER_FRAGMENT)
                    float4 tangent: TEXCOORD2;
                #else
                    float3 tangent: TEXCOORD2;
                    float3 binormal: TEXCOORD3;
                #endif

                float3 worldPos: TEXCOORD4;
            };
            
            // B = w(N x T). Creates the 3rd vector we need to span the tangent space.
            // Used in either the Vertex or Fragment programs, depending on the state of BINORMAL_PER_FRAGMENT
            float3 CreateBinormal(float3 normal, float3 tangent, float binormalSign) {
                return cross(normal, tangent) * (binormalSign * unity_WorldTransformParams.w);
            }

			// Takes the vertex' homogenous coordinates as input.
            // Returns coordinates for the final position of the vertex.
            Interpolators MyVertexProgram(VertexData v)
            {
				Interpolators i;
                i.position = UnityObjectToClipPos(v.position);
                i.worldPos = mul(unity_ObjectToWorld, v.position);
                i.normal = UnityObjectToWorldNormal(v.normal);

                #if defined(BINORMAL_PER_FRAGMENT)
                    i.tangent = float4(UnityObjectToWorldDir(v.tangent.xyz), v.tangent.w);
                #else
                    i.tangent = UnityObjectToWorldDir(v.tangent.xyz);
                    i.binormal = CreateBinormal(i.normal, i.tangent, v.tangent.w);
                #endif

                i.uv.xy = TRANSFORM_TEX(v.uv, _MainTex);
                i.uv.zw = TRANSFORM_TEX(v.uv, _DetailTex);

				return i;
            }
            
            void InitializeFragmentNormal(inout Interpolators i) {
                // This UnityStandardUtils function uses the correct decoding for normal maps
                // and scales normals if the shader target allows for it.
                float3 mainNormal = UnpackScaleNormal(tex2D(_NormalMap, i.uv.xy), _BumpScale);
                float3 detailNormal = UnpackScaleNormal(tex2D(_DetailNormalMap, i.uv.zw), _DetailBumpScale);
                
                // Whiteout blending: makes combining steep slopes less lossy
                float3 tangentSpaceNormal = BlendNormals(mainNormal, detailNormal); // UnityStandardUtils whiteout blend and normalize

                #if defined(BINORMAL_PER_FRAGMENT)
                    float3 binormal = CreateBinormal(i.normal, i.tangent.xyz, i.tangent.w);
                #else
                    float3 binormal = i.binormal;
                #endif

                // Convert the bumped normal from tangent space to world space
                // Note the swap of yz -> zy components, which is necessary because normal maps
                // conventionally store 'up' in Z(blue) but Unity stores 'up' in Y(green).
                i.normal = normalize(
                    tangentSpaceNormal.x * i.tangent +
                    tangentSpaceNormal.y * binormal +
                    tangentSpaceNormal.z * i.normal 
                );
            }

            // Input types to Fragment Program should exactly match output of Vertex Program.
            // Returns RGBA colour value for the pixel.
            // SV_TARGET semantic = System Value default shader TARGET (frame buffer)
            float4 MyFragmentProgram(Interpolators i): SV_TARGET
            {
                InitializeFragmentNormal(i);
                
                float3 lightDir = _WorldSpaceLightPos0.xyz;
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
                float3 lightColor = _LightColor0.rgb;
                float3 albedo = tex2D(_MainTex, i.uv.xy).rgb * _Tint.rgb;
                albedo *= tex2D(_DetailTex, i.uv.zw) * unity_ColorSpaceDouble;

                float3 specularTint = albedo * _Metallic;
                float oneMinusReflectivity = 1 - _Metallic;
                albedo = DiffuseAndSpecularFromMetallic(
					albedo, _Metallic, specularTint, oneMinusReflectivity
				);

                UnityLight light;
                light.color = lightColor;
                light.dir = lightDir;
                light.ndotl = DotClamped(i.normal, lightDir);

                // Set to black for this iteration
                UnityIndirect indirectLight;
                indirectLight.diffuse = 0;
                indirectLight.specular = 0;

                return UNITY_BRDF_PBS(
                    albedo, specularTint,
                    oneMinusReflectivity, _Smoothness,
                    i.normal, viewDir,
                    light, indirectLight
                );
            }
            ENDCG
            
        }
    }
}