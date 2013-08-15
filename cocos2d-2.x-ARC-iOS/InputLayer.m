//
//  InputLayer.m
//  PlaneGame
//
//  Created by Martin on 13-8-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "InputLayer.h"
#import "BulletCache.h"


@implementation InputLayer

- (id) init
{
    if (self = [super init])
    {
        [self addFireButton];
        [self addJoystick];
        [self scheduleUpdate];
    }
    return self;
}

- (void) addFireButton
{
    float buttonRadius = 50;
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    CCSprite *idle = [CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"];
    CCSprite *press = [CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"];
    
    fireButton = [[SneakyButton alloc] initWithRect:CGRectZero];
    fireButton.isHoldable = YES;
    
    SneakyButtonSkinnedBase *skinFireButton = [[SneakyButtonSkinnedBase alloc] init];
    skinFireButton.button = fireButton;
    skinFireButton.defaultSprite = idle;
    skinFireButton.pressSprite = press;
    skinFireButton.position = CGPointMake(screenSize.width - buttonRadius, buttonRadius);
    
    [self addChild:skinFireButton];
}

- (void) addJoystick
{
    float stickRadius = 50;
    
    joystick = [[SneakyJoystick alloc] initWithRect:CGRectMake(0, 0, stickRadius, stickRadius)];
    joystick.autoCenter = YES;
    
    // Now with fewer directions
    joystick.isDPad = YES;
    joystick.numberOfDirections = 8;
    
    CCSprite *back = [CCSprite spriteWithSpriteFrameName:@"joystick-back.png"];
    CCSprite *thumb = [CCSprite spriteWithSpriteFrameName:@"joystick-stick.png"];
    
    SneakyJoystickSkinnedBase *skinStick = [[SneakyJoystickSkinnedBase alloc] init];
    skinStick.joystick = joystick;
    skinStick.backgroundSprite.color = ccYELLOW;
    skinStick.backgroundSprite = back;
    skinStick.thumbSprite = thumb;
    skinStick.position = CGPointMake(stickRadius * 1.5f, stickRadius * 1.5f);
    [self addChild:skinStick];
}

- (void) update:(ccTime) delta
{
    totalTime += delta;
    
    GameLayer *game = [GameLayer sharedGameLayer];
    Ship* ship = game.defaultShip;
    BulletCache* bulletCache = game.bulletCache;
    
    if (fireButton.active && totalTime > nextShotTime)
    {
        nextShotTime = totalTime + 0.4f;
        
        // Set the position, velocity and spriteFrame before shooting
        CGPoint shotPos = CGPointMake(ship.position.x + 45, ship.position.y - 19);
        float spread = (CCRANDOM_0_1() - 0.5f)* 0.5f;
        CGPoint velocity = CGPointMake(200, spread * 50);
        [bulletCache shootBulletFrom:shotPos velocity:velocity frameName:@"bullet.png" isPlayerBullet:YES];
    }
    
    // Allow faster shooting by quickly tapping the fire button
    if (fireButton.active == NO)
    {
        nextShotTime = 0;
    }
    
    // Velocity must be scaled up by a factor that feels right
    CGPoint velocity = ccpMult(joystick.velocity,  7000 * delta);
    ship.position = CGPointMake(ship.position.x + velocity.x * delta, ship.position.y + velocity.y * delta);
}
@end
