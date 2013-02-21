#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
uniform sampler2D u_texture;

void main()
{
    vec4 normalColor = texture2D(u_texture, v_texCoord);
    
    float alpha = 1.0;
    vec4 rColor = vec4(1.0);
    for(int x=0; x<3; x++){
        for (int y=0; y<3; y++) {
            vec2 addTexCoord = vec2(x-1,y-1);
            vec4 color = texture2D(u_texture,vec2(v_texCoord.x-addTexCoord.x, v_texCoord.y-addTexCoord.y));
            rColor.a *= color.a;
        }
    }
    
    gl_FragColor = vec4(rColor.a);
}