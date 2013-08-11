//
//  GameScene.m
//  PunchGame
//
//  Created by Abhineet Prasad on 17/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void) dealloc{
    [self removeAllChildrenWithCleanup:YES];
    CCLOG(@"game scene dealloc called");
    [super dealloc];
}
-(void)pauseGame{
    
    [[self getChildByTag:21] showPauseLayer:NO];
}
-(id) init{
    self = [super init];
    BackgroundLayer* background = [BackgroundLayer node];
    GamePlayLayer* gameLayer = [GamePlayLayer node];
    
    if(self != nil){
        [self addChild:background z:0 tag:11];
        [self addChild:gameLayer z:5 tag:21];
    }
    return self;    
}

@end
