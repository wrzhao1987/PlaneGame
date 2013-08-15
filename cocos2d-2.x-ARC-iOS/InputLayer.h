//
//  InputLayer.h
//  PlaneGame
//
//  Created by Martin on 13-8-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameLayer.h"
#import "Ship.h"

//SneakyInput headers
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"

@interface InputLayer : CCLayer {
    SneakyButton *fireButton;
    SneakyJoystick *joystick;
    
    ccTime totalTime;
    ccTime nextShotTime;
}

@end
