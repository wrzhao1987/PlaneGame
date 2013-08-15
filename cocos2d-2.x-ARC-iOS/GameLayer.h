//
//  GameScene.h
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
@class BulletCache;

typedef enum
{
    GameSceneLayerTagGame = 1,
    GameSceneLayerTagInput,
    
} GameSceneLayerTags;

typedef enum
{
	GameSceneNodeTagBullet = 1,
    GameSceneNodeTagBulletCache,
    GameSceneNodeTagEnemyCache,
    GameSceneNodeTagShip,
	
} GameSceneNodeTags;

@interface GameLayer : CCLayer 
{
    NSUInteger nextInactiveBullet;
}

@property (readonly) Ship* defaultShip;
@property (readonly) BulletCache* bulletCache;
@property (readonly) CGRect screenRect;

+(id) scene;
+(GameLayer*) sharedGameLayer;
-(Ship*) defaultShip;
@end
