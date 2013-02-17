//
//  ShaderSprite.m
//  shaderTest
//
//  Created by Shintaro Taya on 13/02/17.
//  Copyright (c) 2013年 taoru. All rights reserved.
//

#import "ShaderSprite.h"
#import "CCFileUtils.h"

@interface ShaderSprite ()

@property (nonatomic, assign) NSInteger colorUniformLocation;
@property (nonatomic, retain) CCTexture2D *colorRampTexture;

@end

@implementation ShaderSprite

- (id)initWithFile:(NSString *)filename
{
    if (self = [super initWithFile:filename]) {
        
        CCGLProgram *shader = [[CCGLProgram alloc] initWithVertexShaderFilename:@"emboss.vsh"
                                                         fragmentShaderFilename:@"emboss.fsh"];
        
        [shader addAttribute:kCCAttributeNamePosition index:kCCVertexAttrib_Position];
        [shader addAttribute:kCCAttributeNameColor index:kCCVertexAttribFlag_Color];
        [shader addAttribute:kCCAttributeNameTexCoord index:kCCVertexAttrib_TexCoords];
        
        [shader link];
        
        [shader updateUniforms];
//        
//        uniformCenter = glGetUniformLocation( shader.program, "center");
//        uniformResolution = glGetUniformLocation( shader.program, "resolution");
//        uniformTime = glGetUniformLocation( shader.program, "time");
//        
        self.shaderProgram = shader;
        
//        [shader release];
    }
    return self;
}

- (void)dealloc
{
    self.colorRampTexture = nil;
    [super dealloc];
}

//-(void) draw
//{
//	CC_NODE_DRAW_SETUP();
////    
////	float w = SIZE_X, h = SIZE_Y;
////	GLfloat vertices[12] = {0,0, w,0, w,h, 0,0, 0,h, w,h};
////    
////	//
////	// Uniforms
////	//
////	[self.shaderProgram setUniformLocation:uniformCenter withF1:center_.x f2:center_.y];
////	[self.shaderProgram setUniformLocation:uniformResolution withF1:resolution_.x f2:resolution_.y];
////    
////	// time changes all the time, so it is Ok to call OpenGL directly, and not the "cached" version
////	glUniform1f( uniformTime, time_ );
////    //	[self.shaderProgram setUniformLocation:uniformTime with1f:time_];
////    
//    
//	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
//    
////	glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, vertices);
//    
////	glDrawArrays(GL_TRIANGLES, 0, 6);
//	
//	CC_INCREMENT_GL_DRAWS(1);
//}

@end
