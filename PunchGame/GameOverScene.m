//
//  GameOverScene.m
//  PunchGame
//
//  Created by Abhineet Prasad on 27/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "GameOverScene.h"

@implementation GameOverScene
-(void) dealloc{
    [self removeAllChildrenWithCleanup:YES];
    CCLOG(@"GameOverScene dealloc was called");
    [super dealloc];
}


-(id) init{
    if(self = [super init]){
        
        GameOverLayer* gameOverLayer = [GameOverLayer node];
        [self addChild:gameOverLayer z:1   tag:111];
    }
    return self;
}

@end
