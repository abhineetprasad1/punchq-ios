//
//  Rule.h
//  PunchGame
//
//  Created by Abhineet Prasad on 11/04/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//
#import "CommonProtocols.h"
#import <Foundation/Foundation.h>

@interface Rule : NSObject{
    RuleType ruleType;
    double limit;
    bool isUpperBound;
}
@property(readwrite) RuleType ruleType;
@property (readwrite) double limit;
@property (readwrite) bool isUpperBound;
-(bool) isSatisfied:(double)forData;
@end
