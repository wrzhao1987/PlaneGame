//
//  EnemyCache.m
//  PlaneGame
//
//  Created by Martin on 13-8-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "EnemyCache.h"
#import "Enemy.h"
#import "BulletCache.h"
#import "GameLayer.h"


@implementation EnemyCache
-(id) init
{
    if (self = [super init])
    {
        // Get any image from the texture atlas we're using
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"monster-a.png"];
        batch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
        [self addChild:batch];
        
        [self initEnemies];
        [self scheduleUpdate];
    }
    return self;
}

-(void) initEnemies
{
    // Create the enemies array containing further arrays for each type
    enemies = [NSMutableArray arrayWithCapacity:EnemyType_MAX];
    
    // Create the arrays for each type
    for (NSUInteger i = 0; i < EnemyType_MAX; i++)
    {
        // Depending on enemy type the array capacity is set
        // To hold the desied number of enemies
        NSUInteger capacity = 0;
        switch (i)
        {
            case EnemyTypeUFO:
                capacity = 6;
                break;
            case EnemyTypeCruiser:
                capacity = 3;
                break;
            case EnemyTypeBoss:
                capacity = 1;
                break;
            default:
                [NSException exceptionWithName:@"EnemyCache Exception" reason:@"unhandled enemy type" userInfo:nil];
                break;
        }
        NSMutableArray* enemiesOfType = [NSMutableArray arrayWithCapacity:capacity];
        [enemies addObject:enemiesOfType];
        for (NSUInteger j =0; j < capacity; j++)
        {
            Enemy* enemy = [Enemy enemyWithType:i];
            [batch addChild:enemy z:0 tag:i];
            [enemiesOfType addObject:enemy];
        }
    }
}

-(void) spawnEnemyOfType:(EnemyTypes)enemyType
{
    NSMutableArray* enemiesOfType = [enemies objectAtIndex:enemyType];
    for (Enemy* enemy in enemiesOfType)
    {
        // Find the first free enemy and respawn it
        if (enemy.visible == NO)
        {
            CCLOG(@"Spawn enemy type %i", enemyType);
            [enemy spawn];
            break;
        }
    }
}

-(void) update:(ccTime)delta
{
    updateCount++;
    
    for (int i = (EnemyType_MAX -1); i >= 0; i--)
    {
        int spawnFrequecy = [Enemy getSpawnFrequecyForEnemyType:i];
        
        if(updateCount % spawnFrequecy == 0)
        {
            [self spawnEnemyOfType:i];
            break;
        }
    }
    [self checkForBulletCollisions];
}

-(void) checkForBulletCollisions
{
    for (Enemy* enemy in batch.children)
    {
        if (enemy.visible)
        {
            BulletCache* bulletCache = [GameLayer sharedGameLayer].bulletCache;
            CGRect bbox = enemy.boundingBox;
            if ([bulletCache isPlayerBulletCollidingWithRect:bbox])
            {
                // This enemy got hit...
                [enemy gotHit];
            }
        }
    }
}
@end
