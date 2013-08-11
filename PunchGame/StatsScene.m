
//
//  StatsScene.m
//  PunchGame
//
//  Created by Abhineet Prasad on 06/03/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "StatsScene.h"

@implementation StatsScene


-(void) dealloc{
    [self removeAllChildrenWithCleanup:YES];
    CCLOG(@"Stats Scene dealloc was called");
    [super dealloc];
}


-(id) init{
    if(self = [super init]){
        
        StatsLayer* statsLayer = [StatsLayer node];
        [self addChild:statsLayer z:1   tag:1];
    }
    return self;
}

@end
