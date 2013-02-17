//
//  ShaderLayer.m
//  shaderTest
//
//  Created by Shintaro Taya on 13/02/18.
//  Copyright 2013年 taoru. All rights reserved.
//

#import "ShaderLayer.h"

@interface ShaderLayer ()

@property (nonatomic, retain) CCSprite *sprite;
@property (nonatomic, assign) NSInteger colorRampUniformLocation;
@property (nonatomic, retain) CCTexture2D *colorRampTexture;

@end

@implementation ShaderLayer

- (id)init
{
    self = [super init];
    if (self) {
        // 1
        _sprite = [[CCSprite spriteWithFile:@"Default.png"] retain];
        _sprite.anchorPoint = CGPointZero;
        _sprite.rotation = 90;
        _sprite.position = ccp(0, 320);
        [self addChild:_sprite];
        
        // 2
        const GLchar *fragmentSource = (GLchar*)[[NSString stringWithContentsOfFile:[[CCFileUtils sharedFileUtils] fullPathFromRelativePath:@"shader_ramp.fsh"]
                                                                           encoding:NSUTF8StringEncoding
                                                                              error:nil] UTF8String];
        CCGLProgram *shaderProgram = [[CCGLProgram alloc] initWithVertexShaderByteArray:ccPositionTextureA8Color_vert
                                                                fragmentShaderByteArray:fragmentSource];

        _sprite.shaderProgram = shaderProgram;
        [_sprite.shaderProgram addAttribute:kCCAttributeNamePosition index:kCCVertexAttrib_Position];
        [_sprite.shaderProgram addAttribute:kCCAttributeNameTexCoord index:kCCVertexAttrib_TexCoords];
        [_sprite.shaderProgram link];
        [_sprite.shaderProgram updateUniforms];
        
        [shaderProgram release];
        
        // 3
        _colorRampUniformLocation = glGetUniformLocation(_sprite.shaderProgram.program, "u_colorRampTexture");
        glUniform1i(_colorRampUniformLocation, 1);
        
        // 4
        _colorRampTexture = [[[CCTextureCache sharedTextureCache] addImage:@"colorRamp.png"] retain];
        [_colorRampTexture setAliasTexParameters];
        
        // 5
        [_sprite.shaderProgram use];
        glActiveTexture(GL_TEXTURE1);
        glBindTexture(GL_TEXTURE_2D, [_colorRampTexture name]);
        glActiveTexture(GL_TEXTURE0);
    }
    return self;
}

- (void)dealloc
{
    self.sprite = nil;
    self.colorRampTexture = nil;
    [super dealloc];
}

@end
