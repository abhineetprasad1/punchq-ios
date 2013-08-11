//
//  Objectives.m
//  PunchGame
//
//  Created by Abhineet Prasad on 11/04/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "Objectives.h"

@implementation Objectives
@synthesize objectiveId,objectiveName;
@synthesize isComplete;
@synthesize ruleType;
@synthesize limit;
@synthesize isUpperBound;

-(id)init{
    [super init];
    return self;
}


-(id) initWithObjectiveId:(int)objId Name:(NSString*)name RuleType:(RuleType) type LimitValue:(double) value UpperBound:(bool) isUpper{
    [super init];
    self.objectiveId = objId;
    self.objectiveName = name;
    self.ruleType = type;
    isComplete =false;
    self.limit = value;
    self.isUpperBound = isUpper;
    return self;
}



 
-(bool)isAchieved:(double)forData{
    
    if(isUpperBound){
        if(forData >= limit){
            isComplete = YES;
        }
    } else if(!isUpperBound){
        if(forData <= limit){
            isComplete = YES;
        }
    }
    
    return isComplete;
}
@end
