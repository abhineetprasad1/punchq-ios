//
//  Rule.m
//  PunchGame
//
//  Created by Abhineet Prasad on 11/04/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "Rule.h"

@implementation Rule

@synthesize limit;
@synthesize isUpperBound;
@synthesize ruleType;

-(void)dealloc{
    [super dealloc];
}

-(id) initForRuleType:(RuleType)type:(double)boundaryValue :(bool)isCeilingCondition {
    self = [super init];
    self.ruleType = type;
    limit = boundaryValue;
    isUpperBound = isCeilingCondition;
    return self;
}

-(bool) isSatisfied:(double)forData{
    if(isUpperBound) {
        if(forData < limit){
            return false;
        } else return true;
    }else {
        if(forData >= limit){
            return false;
        } else return true;
    }
}

@end
