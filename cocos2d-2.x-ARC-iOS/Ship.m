//
//  Ship.m
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

#import "Ship.h"
#import "Bullet.h"
#import "GameLayer.h"

#import "CCAnimationHelper.h"


@interface Ship (PrivateMethods)
-(id) initWithShipImage;
@end


@implementation Ship

+(id) ship
{
	return [[self alloc] initWithShipImage];
}

-(id) initWithShipImage
{
	// Loading the Ship's sprite using a sprite frame name (eg the filename)
	if ((self = [super initWithSpriteFrameName:@"ship.png"]))
	{
		// The whole shebang is now encapsulated into a helper method.
		NSString* shipAnimName = @"ship-anim";
		CCAnimation* anim = [CCAnimation animationWithFrame:shipAnimName frameCount:5 delay:0.08f];
		
		// run the animation by using the CCAnimate action
		CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
		CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
		[self runAction:repeat];
    
	}
	return self;
}

- (void) setPosition:(CGPoint)position
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    float halfWidth = contentSize_.width * 0.5f;
    float halfHeight = contentSize_.height * 0.5f;
    
    // Cap the position so the ship's sprite stays on the screen
    if (position.x < halfWidth)
    {
        position.x = halfWidth;
    }
    else if (position.x > (screenSize.width - halfWidth))
    {
        position.x = screenSize.width - halfWidth;
    }
    
    if (position.y < halfHeight)
    {
        position.y = halfHeight;
    }
    else if (position.y > (screenSize.height - halfHeight))
    {
        position.y = screenSize.height - halfHeight;
    }
    // MUST call super with the new position
    [super setPosition:position];
}

@end
