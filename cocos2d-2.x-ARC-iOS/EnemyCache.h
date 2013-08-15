//
//  EnemyCache.h
//  PlaneGame
//
//  Created by Martin on 13-8-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EnemyCache : CCNode {
    CCSpriteBatchNode* batch;
    NSMutableArray* enemies;
    
    int updateCount;
}

@end
