//
//  Board.m
//  PunchGame
//
//  Created by Abhineet Prasad on 19/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "Board.h"
#import "GameOverScene.h"

@implementation Board
@synthesize characterState;
@synthesize boardNumberIndex;
@synthesize totalRoundCount;
@synthesize totalMatchesCount;
@synthesize roundLimit;

static int punchesPerBoardCount=2;

-(void) dealloc {
    punchesPerBoardCount =2;
    totalRoundCount =0 ;
    totalMatchesCount =0;
    [numberSequence release];
    [numberOne release];
    [numberTwo release];
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup:YES];
    CCLOG(@"Board dealloc was called");
    [super dealloc];
}


-(id) init {
    self = [super init];
    
    //numberOne =[CCSprite spriteWithFile:@"numberOne.png"] ;
    //numberTwo =[CCSprite spriteWithFile:@"numberTwo.png"];
    totalRoundCount = 0;
    totalMatchesCount = 0;
    punchesPerBoardCount =2;
    roundLimit =10;
    gameObjectType = kBoardType;
    characterState = kBoardStateInvisible;
    numberSequence = [[NSMutableArray alloc] initWithCapacity:punchesPerBoardCount];
    //[self changeState:kBoardStateSpawn];
    return self;
}

-(void) generateNumberSequence{
    [numberSequence removeAllObjects];
    for(int i =0;i<punchesPerBoardCount;i++){
        int rand = arc4random_uniform(2) + 1;
        [numberSequence insertObject:[NSNumber numberWithInt:rand] atIndex:i];
    }
        
    
}
-(int) getPunchesPerBoardCount{
    return punchesPerBoardCount;
}

-(CCSprite*) getBoardSprite:(int) spriteNumber{
    switch (spriteNumber) {
        case 1:
            return  numberOne;
            break;
        case 2:
            return numberTwo;
        default:
            return nil;
            break;
    }
}
-(NSMutableArray*) getNumberSequenceArray{
    return  numberSequence;
}

-(void)changeState:(CharacterStates)newState{
    [self stopAllActions];
    [self setCharacterState:newState];
    
    switch (newState) {
        case kBoardStateSpawn:
            boardNumberIndex = 0;
            totalRoundCount++;
            totalMatchesCount++;
            //generate punch Sequence
            [self generateNumberSequence];
            break;
        case kBoardStateExecuting:
            //check correct/incorrect punch
            //if incorrect changeState to kBoardFailed
            break;
        case kBoardStateExecuted:
            
            if(totalRoundCount > roundLimit) {
                if(punchesPerBoardCount < 5){
                    punchesPerBoardCount++;
                    
                }
                totalRoundCount=0;
            }
            [self changeState:kBoardStateSpawn];//should go to kBoardStateSpawn
            break;
        case kBoardStateFailed:

            //GameOverScene* scene = [[GameOverScene alloc] init];
            [[CCDirector sharedDirector]replaceScene:[CCTransitionZoomFlipX transitionWithDuration:0.4f scene:[GameOverScene node]]]; 
            break;
            //show game over and score
            
        case kBoardStateFailing:
            [self stopAllActions];
        default:
            break;
    }
}



@end
