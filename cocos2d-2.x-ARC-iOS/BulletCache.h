//
//  BulletCache.h
//  PlaneGame
//
//  Created by Martin on 13-8-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BulletCache : CCNode {
    CCSpriteBatchNode* batch;
    NSUInteger nextInactiveBullet;
}

-(void) shootBulletFrom:(CGPoint)startPosition velocity:(CGPoint)velocity frameName:(NSString*)frameName isPlayerBullet:(BOOL)playerBullet;
-(BOOL) isPlayerBulletCollidingWithRect:(CGRect)rect;
-(BOOL) isBulletCollidingWithRect:(CGRect)rect usePlayerBullets:(BOOL)usePlayerBullets;
@end
