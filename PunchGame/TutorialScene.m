//
//  TutorialScene.m
//  PunchGame
//
//  Created by Abhineet Prasad on 05/03/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "TutorialScene.h"

@implementation TutorialScene

-(void) dealloc{
    [self removeAllChildrenWithCleanup:YES];
    CCLOG(@"Tutorial Scene dealloc was called");
    [super dealloc];
}


-(id) init{
    if(self = [super init]){
        
        TutorialLayer* layer = [TutorialLayer node];
        [self addChild:layer z:1 tag:1];
      //  ScoreLayer* scoreLayer = [ScoreLayer node];
       // [self addChild:scoreLayer z:1   tag:1];
    }
    return self;
}


@end
