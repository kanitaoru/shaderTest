#ifdef GL_ES
precision mediump float;
#endif

// 1
varying vec2 v_texCoord;        // vertex shaderから渡されたtexCoord座標
uniform sampler2D u_texture;    // コードで渡されたテクスチャ

void main()
{
    // 2
    // Define the size for one pixel of your texture in texCoords space (normalized 0, – 1).
    vec2 onePixel = vec2(1.0 / 480.0, 1.0 / 320.0);
    
    // 3
    vec2 texCoord = v_texCoord;
    
    // 4
    vec4 color;
    color.rgb = vec3(0.5);
    color -= texture2D(u_texture, texCoord - onePixel) * 5.0;
    color += texture2D(u_texture, texCoord + onePixel) * 5.0;
    // 5
    color.rgb = vec3((color.r + color.g + color.b) / 3.0);
    gl_FragColor = vec4(color.rgb, 1);
}