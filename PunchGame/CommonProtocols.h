//
//  CommonProtocols.h
//  PunchGame
//
//  Created by Abhineet Prasad on 19/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#ifndef PunchGame_CommonProtocols_h
#define PunchGame_CommonProtocols_h

typedef  enum {
    kBoardStateInvisible,
    kBoardStateSpawn,
    kBoardSateSpawning,
    kBoardStateExecuting,
    kBoardStateExecuted,
    kBoardStateFailed,
    kBoardStateResume,
    kBoardStateBegging,
    kBoardStateFailing,
    
    kFighterStateIdle,
    kFighterStateFighting,
    kFighterStateFought
} CharacterStates; 

typedef enum {
    kObjectTypeNone,
    kPunchBagType,
    kFighterType,
    kBoardType
    
} GameObjectType;


typedef enum {
    kPunchNumberType,
    kPunchTimerType,
    kTotalPunchNumberType
} RuleType;

typedef enum{
    kLeftMistake,
    kRightMistake,
    kTimeMistake
} MistakeType;
#endif
