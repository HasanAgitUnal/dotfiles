#version 300 es
precision mediump float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

// Kelvin Sıcaklığı: 3000.0 (Sıcak/Gece), 4500.0 (Daha nötr)
const float TEMP = 5650.0;

// Tanner Helland algoritması: Kelvin'den RGB katsayılarına dönüşüm
vec3 get_temp_weight(float k) {
    float t = k / 100.0;
    float r, g, b;

    if (t <= 66.0) {
        r = 1.0;
        // Yeşil hesabı
        g = clamp(0.39008 * log(t) - 0.63184, 0.0, 1.0);
        // Mavi hesabı
        if (t <= 19.0) b = 0.0;
        else b = clamp(0.54320 * log(t - 10.0) - 1.19625, 0.0, 1.0);
    } else {
        // 6600K üstü (Soğuk renkler)
        r = clamp(1.29293 * pow(t - 60.0, -0.13320), 0.0, 1.0);
        g = clamp(1.12989 * pow(t - 60.0, -0.07551), 0.0, 1.0);
        b = 1.0;
    }
    return vec3(r, g, b);
}

void main() {
    vec4 pix = texture(tex, v_texcoord);
    
    // Katsayıları al
    vec3 weight = get_temp_weight(TEMP);
    
    // Siyahları (0.0) çarpsak da sonuç 0.0 kalır, yani siyahlar "ezilmez".
    // Tüm ekran homojen ve lineer bir işleme tabi tutulduğu için leke yapmaz.
    vec3 color = pix.rgb * weight;

    fragColor = vec4(color, pix.a);
}
