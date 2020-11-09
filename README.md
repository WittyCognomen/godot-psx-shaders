# godot-psx-shaders

Demo can be found at [godot-psx-shaders-demo](https://github.com/WittyCognomen/godot-psx-shaders-demo)

![Godot PSX Shaders](https://raw.githubusercontent.com/WittyCognomen/godot-psx-shaders/master/godot_psx.png)

## About

A set of shaders imitating the rendering style of a fifth generation game console. 

Separated into transparent (psx\_transparent.shader) and and alpha scissor (psx.shader) shaders due to depth issues and a lack of #defines.

Features:

- Perspective incorrect affine texture warping (togglable).
- Vertex snapping.
- Hard distance culling on a per-material basis.
- Alpha scissor transparency and alpha transparency.
- Toggle between albedo (lit) and emissive (unlit) color.
- Clamped color range (default 2^5 = 32 per channel, simulating a 15-bit color range) with dithering post-process shader. 
	- (Included: psx-accurate dither matrix, 2x2 and 8x8 positional (bayer) matrices, and a blue noise pattern)
- Support for different dithering matrices. Dithering matrix can be omitted as well.
- Stippled (Sega Saturn style) transparency.
- Animated UV maps.

## Limitations

- GLES3 only due to limitations of Godot's current shader system.
- Vertex lit objects do not receive shadows. If you want to use Godot's shadow system, you'll need to use per-pixel lighting.
- Double-sided objects are lit differently on different sides, toggle emissive (unlit) if you want the same color from both sides.
- Inaccurate dithering of transparency.

## Tips

See demo for example usage.

The dithering post-process receives the dithering matrix as a shader uniform. Make sure the texture asset is imported as uncompressed, repeat enabled, and disable: filtering, mipmaps, and srgb.
