//
//  StandardShootComponent.m
//  PlaneGame
//
//  Created by Martin on 13-8-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "StandardShootComponent.h"
#import "BulletCache.h"
#import "GameLayer.h"


@implementation StandardShootComponent

@synthesize shootFrequency, bulletFrameName;

-(id) init
{
    if (self = [super init])
    {
        [self scheduleUpdate];
    }
    return self;
}

-(void) update:(ccTime)delta
{
    if (self.parent.visible)
    {
        updateCount += delta;
        
        if(updateCount >= shootFrequency)
        {
            updateCount = 0;
            
            GameLayer* game = [GameLayer sharedGameLayer];
            CGPoint startPos = ccpSub(self.parent.position, CGPointMake(self.parent.contentSize.width * 0.5f, 0));
            [game.bulletCache shootBulletFrom:startPos velocity:CGPointMake(-200, 0) frameName:bulletFrameName isPlayerBullet:NO];
        }
    }
}
@end
