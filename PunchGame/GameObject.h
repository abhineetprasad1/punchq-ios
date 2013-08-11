//
//  GameObject.h
//  PunchGame
//
//  Created by Abhineet Prasad on 16/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//
#import "Foundation/Foundation.h"
#import "cocos2d.h"
#import "CommonProtocols.h"

@interface GameObject : CCSprite {
    BOOL isActive;
    CGSize screenSize;
    GameObjectType gameObjectType;
}

@property(readwrite) BOOL isActive;
@property(readwrite) CGSize screenSize;
@property(readwrite) GameObjectType gameObjectType;
-(id) initWithFile:(NSString*)_fileName;
-(void) changeState:(CharacterStates)newState;
-(void) updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray*) listOfGameObjects;
@end
