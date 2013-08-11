//
//  ScoreScene.m
//  PunchGame
//
//  Created by Abhineet Prasad on 03/03/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "ScoreScene.h"

@implementation ScoreScene


-(void) dealloc{
    [self removeAllChildrenWithCleanup:YES];
    CCLOG(@"Score Scene dealloc was called");
    [super dealloc];
}


-(id) init{
    if(self = [super init]){
        
        ScoreLayer* scoreLayer = [ScoreLayer node];
        [self addChild:scoreLayer z:1   tag:1];
    }
    return self;
}


@end
