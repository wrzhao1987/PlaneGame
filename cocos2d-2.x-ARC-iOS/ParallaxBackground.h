//
//  ParallaxBackground.h
//  PlaneGame
//
//  Created by Martin on 13-8-14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ParallaxBackground : CCNode {
    CCSpriteBatchNode *spriteBatch;
    int numSprites;
    
    NSMutableArray * speedFactors;
    float scrollSpeed;
}

@end
