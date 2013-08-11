//
//  GameObject.m
//  PunchGame
//
//  Created by Abhineet Prasad on 16/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

@synthesize isActive;
@synthesize screenSize;
@synthesize gameObjectType;
-(id) initWithFile:(NSString *)_filename{
    self =[super initWithFile:_filename];
    isActive = TRUE;
    screenSize =[[CCDirector sharedDirector] winSize];
    gameObjectType = kObjectTypeNone;
    return self;
}

-(void)intialize{
    isActive = TRUE;
    screenSize =[[CCDirector sharedDirector] winSize];
    gameObjectType = kObjectTypeNone;
}

-(id)init{
    if(self = [super init]){
        [self intialize];
    }
    return self;
}



-(void) changeState:(CharacterStates)newState{
    //modified by subclass
}
-(void) updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects{
    //to be implemented by subclass
}
@end
