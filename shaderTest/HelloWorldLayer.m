//
//  HelloWorldLayer.m
//  shaderTest
//
//  Created by Shintaro Taya on 13/02/17.
//  Copyright taoru 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "ShaderLayer.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
        CCMenuItem *item = [CCMenuItemFont itemWithString:@"Ramp" block:^(id sender) {
            CCScene *scene = [CCScene node];
			[scene addChild: [ShaderLayer node]];
			[[CCDirector sharedDirector] pushScene:scene];
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
        [menu alignItemsHorizontallyWithPadding:20.0f];
        [menu setPosition:ccp(self.contentSize.width/2, self.contentSize.height/2-50)];
        
        [self addChild:menu];
        
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
