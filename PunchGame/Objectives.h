//
//  Objectives.h
//  PunchGame
//
//  Created by Abhineet Prasad on 11/04/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonProtocols.h"

@interface Objectives : NSObject{
    int objectiveId;
    NSString* objectiveName;    
    bool isComplete;
    RuleType ruleType;
    double limit;
    bool isUpperBound;    
}

@property (readwrite) int objectiveId;
@property (nonatomic,retain) NSString* objectiveName;
@property (readwrite)bool isComplete;
@property  (readwrite) RuleType ruleType;
@property (readwrite) double limit;
@property (readwrite) bool isUpperBound;

-(id) initWithObjectiveId:(int)objId Name:(NSString*)name RuleType:(RuleType) type LimitValue:(double) value UpperBound:(bool) isUpper;
-(bool)isAchieved:(double)forData;
@end
