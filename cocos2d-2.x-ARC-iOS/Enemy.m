//
//  Enemy.m
//  PlaneGame
//
//  Created by Martin on 13-8-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "GameLayer.h"
#import "StandardMoveComponent.h"
#import "StandardShootComponent.h"
#import "HealthbarComponent.h"
#import "SimpleAudioEngine.h"

@implementation Enemy

@synthesize initialHitPoints, hitPoints;

-(id) initWithType:(EnemyTypes)enemyType
{
    type = enemyType;
    
    NSString* enemyFrameName;
    NSString* bulletFrameName;
    float shootFrequency = 6.0f;
    initialHitPoints = 1;
    
    switch (type)
    {
        case EnemyTypeUFO:
            enemyFrameName = @"monster-a.png";
            bulletFrameName = @"shot-a.png";
            break;
        case EnemyTypeCruiser:
            enemyFrameName = @"monster-b.png";
            bulletFrameName = @"shot-b.png";
            shootFrequency = 1.0f;
            initialHitPoints = 3;
            break;
        case EnemyTypeBoss:
            enemyFrameName = @"monster-c.png";
            bulletFrameName = @"shot-c.png";
            shootFrequency = 2.0f;
            initialHitPoints = 15;
        default:
            [NSException exceptionWithName:@"Enemy Exception" reason:@"unhandled enemy type" userInfo:nil];
    }
    
    if (self = [super initWithSpriteFrameName:enemyFrameName])
    {
        StandardShootComponent* shootComponent = [StandardShootComponent node];
        shootComponent.shootFrequency = shootFrequency;
        shootComponent.bulletFrameName = bulletFrameName;
        [self addChild:shootComponent];
        
        [self addChild:[StandardMoveComponent node]];
        
        if (type == EnemyTypeBoss) {
            HealthbarComponent* healthbar = [HealthbarComponent spriteWithSpriteFrameName:@"healthbar.png"];
            [self addChild:healthbar];
        }
        
        // Enemies start invisible
        self.visible = NO;
        
        [self initSpawnFrequecy];
    }
    return self;
}

+(id) enemyWithType:(EnemyTypes)enemyType
{
    return [[self alloc] initWithType:enemyType];
}

static NSMutableArray* spawnFrequecy = nil;
-(void) initSpawnFrequecy
{
    // Initialize how frequently the enemies will spawn
    if (spawnFrequecy == nil) {
        spawnFrequecy = [NSMutableArray arrayWithCapacity:EnemyType_MAX];
        [spawnFrequecy insertObject:[NSNumber numberWithInt:80] atIndex:EnemyTypeUFO];
        [spawnFrequecy insertObject:[NSNumber numberWithInt:260] atIndex:EnemyTypeCruiser];
        [spawnFrequecy insertObject:[NSNumber numberWithInt:1500] atIndex:EnemyTypeBoss];
    }
}

+(int) getSpawnFrequecyForEnemyType:(EnemyTypes)enemyType
{
    NSAssert(enemyType < EnemyType_MAX, @"Invalid enemy type");
    NSNumber* number = [spawnFrequecy objectAtIndex:enemyType];
    return number.intValue;
}

-(void) spawn
{
    // Select a spawn location just outside the right side of the screen
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CGSize spriteSize = self.contentSize;
    float xPos = screenSize.width + spriteSize.width * 0.5f;
    float yPos = CCRANDOM_0_1() * (screenSize.height - spriteSize.height) + spriteSize.height * 0.5f;
    self.position = CGPointMake(xPos, yPos);
    
    // Reset Health
    hitPoints = initialHitPoints;
    
    // Finally set yourself to be visible, this also flag the enemy as "in use"
    self.visible = YES;
    
    // Reset certain components
    for (CCNode* node in self.children) {
        if ([node isKindOfClass:[HealthbarComponent class]]) {
            HealthbarComponent* healthbar = (HealthbarComponent*) node;
            [healthbar reset];
        }
    }
}

-(void) gotHit
{
    hitPoints--;
    if (hitPoints <= 0) {
        self.visible = NO;
        // Play a particle effect when the enemy was destroyed
        CCParticleSystem* system;
        if (type == EnemyTypeBoss)
        {
            system = [CCParticleSystemQuad particleWithFile:@"fx-explosion2.plist"];
            [[SimpleAudioEngine sharedEngine] playEffect:@"explo1.wav" pitch:1.0f pan:0.0f gain:1.0f];
        }
        else
        {
            system = [CCParticleSystemQuad particleWithFile:@"fx-explosion.plist"];
            [[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav" pitch:1.0f pan:0.0f gain:1.0f];
        }
        // Set some parameters that can't be set in Particle Designer
        system.positionType = kCCPositionTypeFree;
        system.autoRemoveOnFinish = YES;
        system.position = self.position;
        
        [[GameLayer sharedGameLayer] addChild:system];
    }
    else{
        [[SimpleAudioEngine sharedEngine] playEffect:@"hit1.wav" pitch:1.0f pan:0.0f gain:1.0f];
    }
}

@end
