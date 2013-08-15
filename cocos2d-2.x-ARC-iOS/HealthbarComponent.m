//
//  HealthbarComponent.m
//  PlaneGame
//
//  Created by Martin on 13-8-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "HealthbarComponent.h"
#import "Enemy.h"


@implementation HealthbarComponent

-(void) onEnter
{
    [super onEnter];
    [self scheduleUpdate];
}

-(void) reset
{
    float parentWidthHalf = self.parent.contentSize.width / 2;
    float parentHeight = self.parent.contentSize.height;
    float selfHeight = self.contentSize.height;
    self.position = CGPointMake(parentWidthHalf, parentHeight + selfHeight);
    self.scaleX = 1.0f;
    self.visible = YES;
}

-(void) update:(ccTime)delta
{
    if (self.parent.visible) {
        NSAssert([self.parent isKindOfClass:[Enemy class]], @"not a Enemy");
        Enemy* enemy = (Enemy*)self.parent;
        self.scaleX = enemy.hitPoints / (float)enemy.initialHitPoints;
    }
    else if (self.visible)
    {
        self.visible = NO;
    }
}

@end
