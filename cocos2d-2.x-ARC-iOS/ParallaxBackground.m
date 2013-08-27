//
//  ParallaxBackground.m
//  PlaneGame
//
//  Created by Martin on 13-8-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ParallaxBackground.h"


@implementation ParallaxBackground

- (id) init
{
    if (self = [super init])
    {
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        // 将纹理添加到cache
        CCTexture2D *gameArtTexture = [[CCTextureCache sharedTextureCache] addImage: @"game-art.pvr.ccz"];
        
        // 创建背景精灵批处理
        spriteBatch = [CCSpriteBatchNode batchNodeWithTexture: gameArtTexture];
        
        int numStripes = 7;
        
        // Add the 6 different layer objects and position them on the screen
		for (int i = 0; i < numStripes; i++)
		{
			NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
			CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
			sprite.anchorPoint = CGPointMake(0, 0.5f);
			sprite.position = CGPointMake(100, screenSize.height / 2);
			[spriteBatch addChild:sprite z:i tag:i];
		}
        
        // 添加7个条纹
        for (int i = 0; i < numStripes; i++) {
            NSString *frameName = [NSString stringWithFormat: @"bg%i.png", i];
            CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:frameName];
            sprite.anchorPoint = CGPointMake(0, 0.5f);
            sprite.position = CGPointMake(screenSize.width - 1, screenSize.height / 2);
            sprite.flipX = YES;
            [spriteBatch addChild: sprite z: i tag: i + numStripes];
            
        }
        [self addChild: spriteBatch];
        
        // Initialize the array that contains the scroll factors for individual stripes;
        speedFactors = [NSMutableArray arrayWithCapacity: numStripes];
        [speedFactors addObject: [NSNumber numberWithFloat: 0.3f]];
        [speedFactors addObject: [NSNumber numberWithFloat: 0.5f]];
        [speedFactors addObject: [NSNumber numberWithFloat: 0.5f]];
        [speedFactors addObject: [NSNumber numberWithFloat: 0.8f]];
        [speedFactors addObject: [NSNumber numberWithFloat: 0.8f]];
        [speedFactors addObject: [NSNumber numberWithFloat: 1.2f]];
        [speedFactors addObject: [NSNumber numberWithFloat: 1.2f]];
        NSAssert(speedFactors.count == numStripes, @"speedFactors count does not match numStripes!");
        
        scrollSpeed = 1.0f;
        [self scheduleUpdate];
    }
    return self;
}

- (void) update: (ccTime) delta
{
    for (CCSprite *sprite in spriteBatch.children) {
        NSNumber *factor = [speedFactors objectAtIndex: sprite.zOrder];
        CGPoint pos = sprite.position;
        pos.x -= (scrollSpeed * factor.floatValue) * (delta * 100);
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        if (pos.x < -screenSize.width)
        {
            pos.x += (screenSize.width * 2) - 2;
        }
        sprite.position = pos;
    }
}

@end
