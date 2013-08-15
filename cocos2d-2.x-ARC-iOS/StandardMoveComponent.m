//
//  StandardMoveComponent.m
//  PlaneGame
//
//  Created by Martin on 13-8-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "StandardMoveComponent.h"


@implementation StandardMoveComponent

-(id) init
{
    if (self = [super init]) {
        velocity = CGPointMake(-100, 0);
        [self scheduleUpdate];
    }
    return self;
}

-(void) update:(ccTime)delta
{
    if (self.parent.visible) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        if (self.parent.position.x > screenSize.width * 0.5f) {
            self.parent.position = ccpAdd(self.parent.position, ccpMult(velocity, delta));
        }
    }
}

@end
