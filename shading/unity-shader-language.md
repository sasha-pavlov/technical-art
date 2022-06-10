# Unity Shader Language

Personal notes on writing shaders in the Unity `.shader` syntax.

- [Unity Shader Language](#unity-shader-language)
  - [Useage](#useage)
  - [.shader file structure](#shader-file-structure)
    - [Properties](#properties)
    - [Subshaders](#subshaders)
    - [pragmas](#pragmas)
    - [Configuration functions](#configuration-functions)
      - [Input](#input)
      - [Output](#output)
    - [Fallbacks](#fallbacks)

## Useage

For use with Unity's `default render pipeline`. To use this pipeline, make sure that `Edit > Project Settings > Graphics > Scriptable Render Pipeline Settings` is set to `None`.

## .shader file structure

```shader
Shader "Shader Name" {
    Properties {
        _ConfigurableProperty ("ConfigurableProperty Label", Range(0,1)) = 0.5
    }
    SubShader {
        CGPROGRAM
        #pragma someCompilerDirective

        struct Input {
            float3 worldPos;
        };

        float _ConfigurableProperty;

        void ConfigureShader(Input input, inout OutputType output) {
            output.Property = _ConfigurableProperty;
        }

        ENDCG
    }

    FallBack "Fallback Shader"
}
```

### Properties

Shader `Properties` appear in the Unity editor as configurable fields. To use a property in a SubShader, remember to declare it as a variable within that SubShader.

### Subshaders

`SubShader` code is written in a hybrid of `CG` and `HLSL`. It is enclosed in CGPROGRAM and ENDCG keywords.

### pragmas
Directives made to the compiler.

Common pragmas:
- `#pragma target 3.0`: set minimum shader level and quality
- `#pragma surface ConfigureSurface Standard fullforwardshadows`: using our ConfigureSurface function, generate a surface shader with standard lighting and full support for shadows

### Configuration functions

Configuration functions decorate shaders.

#### Input

The input structure for a shader config function should be defined above the function itself.

Common inputs:
- `float3 worldPos`: the world position of the vertex

#### Output

The `inout` keyword specifies that this argument is passed to the config function and then used to contain the result.

### Fallbacks