//
//  AbstractShaderLayer.m
//  shaderTest
//
//  Created by Shintaro Taya on 13/02/20.
//  Copyright 2013年 taoru. All rights reserved.
//

#import "AbstractShaderLayer.h"


@implementation AbstractShaderLayer

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [self node];
    [scene addChild:layer];
    
    return scene;
}

- (id)init
{
    if (self = [super init]) {
        
        // CreateShader
        const GLchar *fragmentSource = [[NSString stringWithContentsOfFile:[[CCFileUtils sharedFileUtils] fullPathFromRelativePath:[self fragmentShader]]
                                                                  encoding:NSUTF8StringEncoding
                                                                     error:nil] UTF8String];
        
        CCGLProgram *shaderProgram  = [[CCGLProgram alloc] initWithVertexShaderByteArray:ccPositionTextureA8Color_vert
                                                                 fragmentShaderByteArray:fragmentSource];
        
        _background = [[CCSprite spriteWithFile:@"Default.png"] retain];
        _background.position  = ccp(self.contentSize.width*0.5f, self.contentSize.height*0.5f);
        _background.rotation  = 90;
        [self addChild:_background z:0];
        
        _background.shaderProgram = shaderProgram;
        
        // VertexShaderへの入力変数(Attribute変数)をセット
        [self addAttributesForBackground];
        
        // glLinkProgramが呼ばれShaderProgramをリンクする
        // glGetProgramでリンクが成功したかをチェックしている
        [_background.shaderProgram link];
        
        // glUniform が呼ばれ uniform変数をセット
        // u_texutreに元のCCSpriteのテクスチャがセットされている（たぶん）
        // glUniform1iの"1i"は、UniformLocation + GLint型変数１つを表す
        [_background.shaderProgram updateUniforms];
        
        [shaderProgram release];
        
        [_background.shaderProgram use];
        
        
        // DragSprite
        _sprite = [[CCSprite spriteWithFile:@"Icon-72.png"] retain];
        [self addChild:_sprite z:1];
        
        const GLchar *fragmentForSprite = [[NSString stringWithContentsOfFile:[[CCFileUtils sharedFileUtils] fullPathFromRelativePath:[self fragmentShaderForSprite]]
                                                                     encoding:NSUTF8StringEncoding
                                                                        error:nil] UTF8String];
        
        CCGLProgram *shaderProgramForSprite  = [[CCGLProgram alloc] initWithVertexShaderByteArray:ccPositionTextureA8Color_vert
                                                                          fragmentShaderByteArray:fragmentForSprite];
        
        _sprite.shaderProgram = shaderProgramForSprite;
        [self addAttributesForSprite];
        [_sprite.shaderProgram link];
        [_sprite.shaderProgram updateUniforms];
        [shaderProgramForSprite release];
        [_sprite.shaderProgram use];
        
        
        
        // Back Scene
        CCMenuItem *backItem = [CCMenuItemFont itemWithString:@"Back"
                                                        block:^(id sender) {
                                                            [[CCDirector sharedDirector] popScene];
                                                        }];
        CCMenu *menu = [CCMenu menuWithItems:backItem, nil];
        [menu alignItemsHorizontally];
        [menu setPosition:ccp(self.contentSize.width/2, 30)];
        
        [self addChild:menu];
        
        self.touchEnabled = YES;
    }
    return self;
}

- (void)dealloc
{
    self.sprite     = nil;
    self.background = nil;
    [super dealloc];
}

- (NSString *)fragmentShader
{
    return @"shader_emboss.fsh";
}

- (NSString *)fragmentShaderForSprite
{
    return @"shader_emboss.fsh";
}

- (void)addAttributesForBackground
{
    [_background.shaderProgram addAttribute:kCCAttributeNamePosition index:kCCVertexAttrib_Position];
    [_background.shaderProgram addAttribute:kCCAttributeNameTexCoord index:kCCVertexAttrib_TexCoords];
    //    [_background.shaderProgram addAttribute:kCCAttributeNameColor    index:kCCVertexAttrib_Color];
    
}

- (void)addAttributesForSprite
{
    [_sprite.shaderProgram addAttribute:kCCAttributeNamePosition index:kCCVertexAttrib_Position];
    [_sprite.shaderProgram addAttribute:kCCAttributeNameTexCoord index:kCCVertexAttrib_TexCoords];
    //    [_sprite.shaderProgram addAttribute:kCCAttributeNameColor    index:kCCVertexAttrib_Color];
    
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [[CCDirector sharedDirector] convertTouchToGL:touch];
    
    self.sprite.position = touchPoint;
}

@end
