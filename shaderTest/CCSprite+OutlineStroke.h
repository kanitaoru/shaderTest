//
//  CCSprite+OutlineStroke.h
//  shaderTest
//
//  Created by Shintaro Taya on 13/02/22.
//  Copyright (c) 2013年 taoru. All rights reserved.
//

#import "CCSprite.h"

@interface CCSprite (OutlineStroke)

- (void)createOutlineWithStroke:(float)stroke color:(ccColor3B)color;

@end
