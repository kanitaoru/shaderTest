//
//  CCSprite+OutlineStroke.m
//  shaderTest
//
//  Created by Shintaro Taya on 13/02/22.
//  Copyright (c) 2013年 taoru. All rights reserved.
//

#import "CCSprite+OutlineStroke.h"

@implementation CCSprite (OutlineStroke)

- (void)createOutlineWithStroke:(float)stroke color:(ccColor3B)color
{
    CGPoint center = ccp(self.texture.contentSize.width * self.anchorPoint.x + stroke, self.texture.contentSize.height * self.anchorPoint.y + stroke);
    float factor = [self isKindOfClass:[CCLabelTTF class]] ? 2.0f : 1.0f;
    CCRenderTexture *render = [CCRenderTexture renderTextureWithWidth:self.texture.contentSize.width * factor * self.scaleX + stroke*2
                                                               height:self.texture.contentSize.height* factor * self.scaleY + stroke*2];
    ccColor3B   origColor   = self.color;
    CGPoint     origAnchor  = self.anchorPoint;
    CGPoint     origPos     = self.position;
    float       origScale   = self.scale;
    ccBlendFunc origBlend   = self.blendFunc;
    
    [self setBlendFunc:(ccBlendFunc) { GL_SRC_ALPHA, GL_ONE }];
    
    NSInteger drawNum   = 8;
    
    [render begin];
    
    self.color          = color;
    self.scaleY         *= -1;
    
    float radian = 0.0;
    for (int i=0; i<drawNum; i++) {
        self.position = ccpAdd(center, ccp(cosf(radian) * stroke, sinf(radian) * stroke));
        [self visit];
        radian += CC_DEGREES_TO_RADIANS(360.0f/drawNum);
    }
    
    self.blendFunc  = origBlend;
    self.color      = origColor;
    self.position   = center;
    [self visit];
    
    [render end];
    
    self.anchorPoint    = origAnchor;
    self.position       = origPos;
    self.scale          = origScale;
    
    self.texture = render.sprite.texture;
}

@end
