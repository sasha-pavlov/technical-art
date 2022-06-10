// From Catlike Coding Unity Basics 2: Building a Graph
//      https://catlikecoding.com/unity/tutorials/basics/building-a-graph/

// World position-based surface shader for Unity's default render pipeline
Shader "Graph/Point Surface"
{
    Properties
    {
        _Smoothness ("Smoothness", Range(0, 1)) = 0.5
    }

    SubShader
    {
        CGPROGRAM

        // Pragma ("action"/compiler directive) to generate the following shader:
        //      surface:                a surface shader
        //      Standard:               with standard lighting
        //      fullforwardshadows:     and full support for shadows
        //      ConfigureSurface:       using our ConfigureSurface function for configuration
        #pragma surface ConfigureSurface Standard fullforwardshadows
        
        // Set minimum shader level and quality
        #pragma target 3.0

        // Input structure for ConfigureSurface
        struct Input
        {
            float3 worldPos;
        };

        // Use _Smoothness property in this SubShader
        float _Smoothness;

        // Configuration function for the standard surface shader
        void ConfigureSurface(Input input, inout SurfaceOutputStandard surface)
        {
            surface.Smoothness = _Smoothness;
            surface.Albedo.rg = saturate(input.worldPos.xy * 0.5 + 0.5);
        }

        ENDCG
    }

    // Fallback to the standard diffuse shader
    FallBack "Diffuse"
}