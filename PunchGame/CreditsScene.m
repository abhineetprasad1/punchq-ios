
//
//  CreditsScene.m
//  PunchGame
//
//  Created by Abhineet Prasad on 15/03/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "CreditsScene.h"

@implementation CreditsScene

-(void) dealloc{
    [self removeAllChildrenWithCleanup:YES];
    CCLOG(@"Credit Scene dealloc was called");
    [super dealloc];
}


-(id) init{
    if(self = [super init]){
        
        CreditLayer* creditsLayer = [CreditLayer node];
        [self addChild:creditsLayer z:1   tag:1];
    }
    return self;
}


@end
