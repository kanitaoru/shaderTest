//
//  ShaderOutlineLayer.m
//  shaderTest
//
//  Created by Shintaro Taya on 13/02/20.
//  Copyright (c) 2013年 taoru. All rights reserved.
//

#import "ShaderOutlineLayer.h"

@implementation ShaderOutlineLayer

- (NSString *)fragmentShader
{
    return @"shader_normal.fsh";
}

- (NSString *)fragmentShaderForSprite
{
    return @"shader_outline.fsh";
}

@end
