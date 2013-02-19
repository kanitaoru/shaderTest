//
//  AbstractShaderLayer.h
//  shaderTest
//
//  Created by Shintaro Taya on 13/02/20.
//  Copyright 2013年 taoru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AbstractShaderLayer : CCLayer {
    
}

@property (nonatomic, retain) CCSprite *sprite;
@property (nonatomic, retain) CCSprite *background;

+ (CCScene *)scene;

/**
 *  fragmentShader FileName
 *  適宜オーバーライド
 */
- (NSString *)fragmentShader;
- (NSString *)fragmentShaderForSprite;

/**
 *  Background Spriteにattribute変数をセットする
 *  適宜オーバーライド
 */
- (void)addAttributesForBackground;
- (void)addAttributesForSprite;

@end
