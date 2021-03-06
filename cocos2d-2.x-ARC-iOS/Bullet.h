//
//  Bullet.h
//  SpriteBatches
//
//  Created by Steffen Itterheim on 04.08.10.
//
//  Updated by Andreas Loew on 20.06.11:
//  * retina display
//  * framerate independency
//  * using TexturePacker http://www.texturepacker.com
//
//  Copyright Steffen Itterheim and Andreas Loew 2010-2011. 
//  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Ship;

@interface Bullet : CCSprite 
{
	CGPoint velocity;
	float outsideScreen;
    BOOL isPlayerBullet;
}

@property (readwrite, nonatomic) CGPoint velocity;
@property (readwrite, nonatomic) BOOL isPlayerBullet;

+(id) bullet;
-(void) shootBulletFromShip:(CGPoint)startPosition velocity:(CGPoint)vel frameName:(NSString*)framename isPlayerBullet:(BOOL)playerBullet;

@end
