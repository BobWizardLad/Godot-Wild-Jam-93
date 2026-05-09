shader_type canvas_item;

// This captures the pixels behind the sprite
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Get the color of the screen at the current pixel position
    vec4 bg_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    
    // Get the sprite's own texture color (the "mask")
    vec4 sprite_color = texture(TEXTURE, UV);
    
    // Invert the background color: (1.0 - color)
    vec3 inverted_rgb = 1.0 - bg_color.rgb;
    
    // Apply the inversion ONLY where the sprite has visible pixels (alpha)
    COLOR = vec4(inverted_rgb, sprite_color.a);
}