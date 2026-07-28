#version 460 core
#include <flutter/runtime_effect.glsl>

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / u_resolution;
    
    // Grid system
    vec2 grid_uv = uv * 40.0;
    vec2 id = floor(grid_uv);
    vec2 g_uv = fract(grid_uv) - 0.5;
    
    // Simple digital pulse
    float pulse = sin(u_time * 0.5 + id.x * 0.1 + id.y * 0.1) * 0.5 + 0.5;
    float dotVal = smoothstep(0.1, 0.05, length(g_uv));
    
    // Futuristic data scanline
    float scanline = sin(uv.y * 100.0 - u_time * 2.0) * 0.1;
    
    // Color palette based on design system
    vec3 base_color = vec3(0.02, 0.01, 0.04); // Deep charcoal
    vec3 accent = vec3(0.54, 0.36, 0.96); // Neon Purple (#8B5CF6)
    
    vec3 final_color = base_color;
    final_color += dotVal * accent * pulse * 0.2;
    final_color += scanline * accent * 0.05;
    
    // Subtle glow based on mouse
    float mouse_dist = length(uv - (u_mouse / u_resolution));
    final_color += accent * (1.0 - smoothstep(0.0, 0.5, mouse_dist)) * 0.1;

    fragColor = vec4(final_color, 1.0);
}
