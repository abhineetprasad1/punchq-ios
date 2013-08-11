//
//  GamePlayLayer.h
//  PunchGame
//
//  Created by Abhineet Prasad on 17/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//
#import "Foundation/Foundation.h"
#import "cocos2d.h"
#import "PunchBag.h"
#import "SimpleAudioEngine.h"
#import "CCTouchDispatcher.h"
#import "Board.h"
#import "BackgroundLayer.h"
#import "Constants.h"
#import "CCProgressTimer.h"
#import "GameOverLayer.h"
#import "CommonProtocols.h"


@interface GamePlayLayer : CCLayer
{
    CCSprite* fighter;
    Board* board;
    CCLabelTTF* scoreLabel;
    int score;
    ccTime roundTime;
    ccTime timeDecrementRate;
    CCProgressTimer* timeLeftbar;
    PunchBag* punchBag;
}

@property(nonatomic,retain)CCProgressTimer* timeLeftBar;
@property(nonatomic,retain)CCLabelTTF* scoreLabel;
//@property(nonatomic,retain)Board* board;
@property(readwrite) int score;

-(void) showPauseLayer:(BOOL)withInvisibleNumbers;
@end

