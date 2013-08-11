//
//  Board.h
//  PunchGame
//
//  Created by Abhineet Prasad on 19/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "GameObject.h"
#import "Constants.h"
#import "cocos2d.h"
#import "Foundation/Foundation.h"



@interface Board : GameObject{
    
    CCSprite* numberOne;
    CCSprite* numberTwo;
    CharacterStates characterState; 
    NSMutableArray* numberSequence;
    int boardNumberIndex;
     int totalRoundCount;   //stores the number of rounds in one Category
    int totalMatchesCount;  //stores the overall total number of matches
    int roundLimit;
}
@property(readwrite) CharacterStates characterState;
@property(readwrite) int boardNumberIndex;
@property(readwrite)  int totalRoundCount;
@property(readwrite) int totalMatchesCount;
@property(readwrite) int roundLimit;
-(NSMutableArray*) getNumberSequenceArray;
-(CCSprite*) getBoardSprite:(int)spriteNumber;
-(int) getPunchesPerBoardCount;

@end
