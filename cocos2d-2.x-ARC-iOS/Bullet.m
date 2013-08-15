//
//  Bullet.m
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

#import "Bullet.h"
#import "Ship.h"
#import "GameLayer.h"

@interface Bullet (PrivateMethods)

-(id) initWithShip:(Ship*)ship;
-(id) initWithBulletImage;

@end


@implementation Bullet

@synthesize velocity;


+(id) bullet
{
	return [[self alloc] initWithBulletImage];
}

-(id) initWithBulletImage
{
	if ((self = [super initWithSpriteFrameName:@"bullet.png"]))
	{
	}
	
	return self;
}

// Re-Uses the bullet
-(void) shootBulletFromShip:(CGPoint)startPosition velocity:(CGPoint)vel frameName:(NSString*)frameName
{
    self.velocity = vel;
    self.position = startPosition;
    self.visible = YES;
    
    // Change the bullet's texture by setting a different SpriteFrame to be displayed
    CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
    [self setDisplayFrame:frame];
    
    [self unscheduleUpdate];
    [self scheduleUpdate];
}


-(void) update:(ccTime)delta
{
    // update position of the bullet
    // multiply the velocity by the time since the last update was called
    // this ensures same bullet velocity even if frame rate drops
	self.position = ccpAdd(self.position, ccpMult(velocity, delta));
    
    // When the bullet leaves the screen, make it invisible
    // Unschedule the bullet if it leaves the screen, IMPORTANT!!
    
	if (CGRectIntersectsRect(self.boundingBox, [GameLayer sharedGameLayer].screenRect) == NO)
	{
		self.visible = NO;
		[self unscheduleUpdate];
        CCLOG(@"Bullet out of bound.");
	}
}

@end
