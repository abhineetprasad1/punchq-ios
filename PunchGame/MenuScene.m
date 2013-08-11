//
//  MenuScene.m
//  PunchGame
//
//  Created by Abhineet Prasad on 27/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "MenuScene.h"

@implementation MenuScene

-(void) dealloc{
    [self removeAllChildrenWithCleanup:YES];
    CCLOG(@"Menuscene dealloc was called");
    [super dealloc];
}


-(id) init{
    if(self = [super init]){
        
        MenuLayer* menuLayer = [MenuLayer node];
        [self addChild:menuLayer z:1   tag:1];
    }
    return self;
}

@end
