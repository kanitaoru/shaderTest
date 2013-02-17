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

@property (nonatomic, assign) NSInteger colorRampUniformLocation;
@property (nonatomic, retain) CCTexture2D *colorRampTexture;

@end

@implementation ShaderSprite

- (id)initWithFile:(NSString *)filename
{
    if (self = [super initWithFile:filename]) {
        
        const GLchar *shaderSource = (GLchar *)[[NSString stringWithContentsOfFile:[[CCFileUtils sharedFileUtils] fullPathFromRelativePath:@"shader_ramp.fsh"]
                                                                          encoding:NSUTF8StringEncoding
                                                                             error:nil] UTF8String];
        CCGLProgram *shader = [[CCGLProgram alloc] initWithVertexShaderByteArray:ccPositionTextureA8Color_vert
                                                         fragmentShaderByteArray:shaderSource];
        
        self.shaderProgram = shader;
        
        [self.shaderProgram addAttribute:kCCAttributeNamePosition index:kCCVertexAttrib_Position];
        [self.shaderProgram addAttribute:kCCAttributeNameTexCoord index:kCCVertexAttrib_TexCoords];
        [self.shaderProgram link];
        [self.shaderProgram updateUniforms];
        
        [shader release];
        
        _colorRampUniformLocation = glGetUniformLocation(self.shaderProgram.program, "u_colorRampTexture");
        glUniform1i(_colorRampUniformLocation, 1);
        
        _colorRampTexture = [[CCTextureCache sharedTextureCache] addImage:@"colorRamp.png"];
        [_colorRampTexture setAliasTexParameters];
        
        [self.shaderProgram use];
        
        glActiveTexture(GL_TEXTURE1);
        glBindTexture(GL_TEXTURE_2D, [_colorRampTexture name]);
        glActiveTexture(GL_TEXTURE0);
    }
    return self;
}

- (void)dealloc
{
    self.colorRampTexture = nil;
    [super dealloc];
}

@end
