//
//  ObjectivesManager.h
//  PunchGame
//
//  Created by Abhineet Prasad on 04/05/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Objectives.h"

@interface ObjectivesManager : NSObject{
    NSArray* objectivesMonitored;

}

@property (nonatomic,retain) NSArray* objectivesMonitored;
+ (ObjectivesManager*) sharedObjectiveManager;

-(NSString* )objectiveFilePath;
-(void) loadObjectives;
-(void) createFile;


@end

