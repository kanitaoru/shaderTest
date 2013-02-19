//
//  ShaderEmbossLayer.m
//  shaderTest
//
//  Created by Shintaro Taya on 13/02/20.
//  Copyright (c) 2013年 taoru. All rights reserved.
//

#import "ShaderEmbossLayer.h"

@implementation ShaderEmbossLayer

- (NSString *)fragmentShader
{
    return @"shader_emboss.fsh";
}

@end
