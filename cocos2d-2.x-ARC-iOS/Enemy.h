//
//  Enemy.h
//  PlaneGame
//
//  Created by Martin on 13-8-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum{
    EnemyTypeUFO = 0,
    EnemyTypeCruiser,
    EnemyTypeBoss,
    EnemyType_MAX,
} EnemyTypes;

@interface Enemy : CCSprite {
    EnemyTypes type;
    int initialHitPoints;
    int hitPoints;
}

@property (readonly, nonatomic) int initialHitPoints;
@property (readonly, nonatomic) int hitPoints;

+(id) enemyWithType:(EnemyTypes)enemyType;
+(int) getSpawnFrequecyForEnemyType:(EnemyTypes)enemyType;
-(void)spawn;
-(void)gotHit;
@end
