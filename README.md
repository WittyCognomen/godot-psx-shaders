# godot-psx-shaders

Demo can be found at (snip)

![Godot PSX Shaders](https://raw.githubusercontent.com/WittyCognomen/godot-psx-shaders/master/godot_psx.png)

## About

A set of shaders imitating the rendering style of a fifth generation game console. 

Separated into transparent (psx\_transparent.shader) and and alpha scissor (psx.shader) shaders due to depth issues and a lack of #defines.

Features:

 * Perspective incorrect affine texture warping (togglable).
 * Alpha scissor transparency and alpha transparency.
 * Toggle between albedo (lit) and emissive (unlit) color.
 * A dithering post-process shader. (Included: 2x2 and 8x8 Bayer matrices, and a psx-accurate dither matrix.
 * Support for different dithering matrices.

## Limitations

 * GLES3 only due to limitations of Godot's current shader system.
 * Vertex lit objects do not receive shadows. If you want to use Godot's shadow system, you'll need to use per-pixel lighting.
 * Double-sided objects are lit differently on different sides, toggle emissive (unlit) if you want the same color from both sides.
 * Inaccurate dithering of transparency.

## Tips

See demo for example usage.

The dithering post-process receives the dithering matrix as a shader uniform. Make sure the texture asset is imported as uncompressed, repeat enabled, and disable: filtering, mipmaps, and srgb.
