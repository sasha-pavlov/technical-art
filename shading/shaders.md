# Shaders

The GPU renders 3D objects by running their shader programs. By writing shaders, we can create materials that use custom math/logic to decide how a point should be visualized.

Shaders are efficient to update. A single material can be assigned to many assets, yet by using the asset properties (ex. location) each asset can be semi-uniquely visualized. When a change in material is needed (ex. restyling a game), we can skip recreating and re-importing every asset's materials, and instead modify a few shaders. Shaders enable:

- Nice materials for small teams who lack the resources to paint textures for each asset,
- Prototyping visual styles (even if the final product contains painted textures),
- Resolution-agnostic materials

Thus, pretty much anything that can be done with a texture or texture-like map is a fair target for shader creation.

- [Shaders](#shaders)
  - [Unity settings for visual quality](#unity-settings-for-visual-quality)
    - [VSync](#vsync)
    - [Shadows](#shadows)
  - [Inputs for shaders](#inputs-for-shaders)
  - [Math for shaders](#math-for-shaders)
    - [Sinusoidal functions](#sinusoidal-functions)
    - [Saturation](#saturation)
  - [Common types of shaders](#common-types-of-shaders)
    - [Surface shaders](#surface-shaders)

See also `shader-graph.md` and `unity-shader-language.md` for language/tool-specific notes.

## Unity settings for visual quality

To maximize performance:
- only have one scene or game window visible
- collapse large object hierarchies

### VSync

Enabling Vsync in Game view (`Free Apect` dropdown) synchronizes the framerate with the display refresh rate, reducing visual tearing. Unreliable if a scene window is visible.

### Shadows

Unity renders shadows into textures. Settings for this can be found in:
- default render pipeline: `Edit > Project Settings > Quality > Shadows`
- URP: `URP asset inspector > Shadows`

Shadow settings:
- `Shadow Distance`: reduce area mapped to shadow maps, increasing nearby shadow resolution but reducing distal shadow quality
- `Shadow Cascades`: use up to 4 shadow maps, sampling from them based on distance. Nearby shadows have a higher resolution, but shadow rendering happens multiple times.
- `Soft Shadows` (set by `Quality Level` in the default render pipeline)
- `Shadow Resolution` (set by `Quality Level` quality in the default render pipeline)

## Inputs for shaders

Within a shader we can use any of the following properties to determine the rendering of a vertex:

- `albedo`, the spectrum of light diffusely reflected by a surface. A 3-dimensional vector.
- `position`, world or local. A 3-dimensional vector.
- `time`.

## Math for shaders

### Sinusoidal functions

Bound within a fixed range.

Position along the y axis (ie. distance from the x axis) as you walk around a circle.

### Saturation

Clamp all components to [0,1].

Common shader operation, available in all shader langs. Use to ensure that:

- color components stay in range

## Common types of shaders

### Surface shaders

Surface shaders calculate lighting using adjustable values such as color and glossiness. Unity's standard surface shader only works with the default render pipeline.
