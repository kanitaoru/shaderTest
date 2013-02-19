#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
uniform sampler2D u_texture;

void main()
{
    vec3 normalColor = texture2D(u_texture, v_texCoord).rgb;
    
    float avg = (normalColor.r + normalColor.g + normalColor.b) / 3.0;
    
    gl_FragColor = vec4(avg, avg, avg, 1);
}