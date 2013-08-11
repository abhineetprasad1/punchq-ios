//
//  Fighter.h
//  PunchGame
//
//  Created by Abhineet Prasad on 19/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//
#import "Foundation/Foundation.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "GameObject.h"

typedef enum {
    kNoPunch,
    kLeftHook,
    kRightHook
} LastPunchType;

@interface Fighter : GameObject{
    
    //CCSprite* fighterSprite;
    CCAction* leftPunchAction;
    CCAction* rightPunchAction;
    int lives;
//    double score;
    //CCAnimation* breathingAnim <<to be added>>
}

@property(nonatomic,retain) CCAction *leftPunchAction;
@property(nonatomic,retain) CCAction *rightPunchAction;
@property(readwrite) int lives;
//@property(nonatomic,retain) double score;
@end
