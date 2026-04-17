#version 300 es
precision mediump float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

// config
const float THRESHOLD = 0.12;

const vec3 adj_red     = vec3(1.1, 0.9, 0.8);
const vec3 adj_green   = vec3(0.9, 0.85, 0.9);
const vec3 adj_yellow  = vec3(1.1, 1.1, 0.7);
const vec3 adj_blue    = vec3(0.7, 0.8, 0.85);
const vec3 adj_magenta = vec3(0.80, 0.8, 0.9);
const vec3 adj_cyan    = vec3(0.8, 1.1, 0.85);
const vec3 adj_white   = vec3(0.9, 0.9, 0.8);

// Palette
const vec3 PAL_BG      = vec3(0.067, 0.067, 0.090);
const vec3 PAL_BLACK   = vec3(0.082, 0.082, 0.082);
const vec3 PAL_RED     = vec3(0.996, 0.094, 0.345);
const vec3 PAL_GREEN   = vec3(0.314, 0.918, 0.482);
const vec3 PAL_YELLOW  = vec3(0.882, 0.918, 0.549);
const vec3 PAL_BLUE    = vec3(0.125, 0.490, 0.541);
const vec3 PAL_MAGENTA = vec3(0.933, 0.475, 0.776);
const vec3 PAL_CYAN    = vec3(0.420, 0.780, 0.867);
const vec3 PAL_WHITE   = vec3(0.867, 0.867, 0.867);

void main() {
    vec4 pix = texture(tex, v_texcoord);
    vec3 color = pix.rgb;

    // dont touch black and background color
    if (distance(color, PAL_BG) < THRESHOLD || distance(color, PAL_BLACK) < THRESHOLD) {
        fragColor = pix;
        return;
    }

    if      (distance(color, PAL_RED)     < THRESHOLD) color *= adj_red;
    else if (distance(color, PAL_GREEN)   < THRESHOLD) color *= adj_green;
    else if (distance(color, PAL_YELLOW)  < THRESHOLD) color *= adj_yellow;
    else if (distance(color, PAL_BLUE)    < THRESHOLD) color *= adj_blue;
    else if (distance(color, PAL_MAGENTA) < THRESHOLD) color *= adj_magenta;
    else if (distance(color, PAL_CYAN)    < THRESHOLD) color *= adj_cyan;
    else if (distance(color, PAL_WHITE)   < THRESHOLD) color *= adj_white;

    // Global filter
    color.b *= 0.9;

    fragColor = vec4(color, pix.a);
}
