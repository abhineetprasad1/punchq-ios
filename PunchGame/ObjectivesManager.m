//
//  ObjectivesManager.m
//  PunchGame
//
//  Created by Abhineet Prasad on 04/05/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "ObjectivesManager.h"

@implementation ObjectivesManager
@synthesize objectivesMonitored;
static ObjectivesManager* sharedManager = nil;
NSArray* allObjectives;
+(ObjectivesManager*) sharedObjectiveManager{
    if(!sharedManager){
        sharedManager = [[ObjectivesManager alloc] init];
    }
    return sharedManager;
}

-(NSString*) objectiveFilePath{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentPath = [paths objectAtIndex:0];
    NSString* filePath =  [documentPath stringByAppendingPathComponent:@"Objectives.plist"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError *error;
    if ([fileManager fileExistsAtPath:filePath]){
        
    }else{
        NSString* defaultPlistPath = [[NSBundle mainBundle] pathForResource:@"Objectives" ofType:@"plist"];
        if(![fileManager copyItemAtPath:defaultPlistPath toPath:filePath error:&error]){
            NSAssert1(0,@"Failed to copy objectives with error message: %@",[error localizedDescription]);
        }
    }
    return filePath;
}

-(void) loadObjectives{
    //Load 3 non completed objectives  from plist file into array
    objectivesMonitored = nil;
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:3];
    int count = 1;
    for (int i =0; i<[allObjectives count]; i++) {
        if(count >3)
            continue;
        NSDictionary* objective = [NSDictionary dictionaryWithDictionary:[allObjectives objectAtIndex:i]];
        if([[objective objectForKey:@"isComplete"] boolValue] == NO){
             [array addObject:objective];
            count++;
        }
        objective = nil;
    }
    objectivesMonitored = [[NSArray alloc] initWithArray:array];
}

-(id) init{
    //create objectives file if called for first time
    if(self = [super init]){
        objectivesMonitored = [[NSArray alloc] init];
        allObjectives = [[NSArray alloc] initWithContentsOfFile:[self objectiveFilePath]];
    }
    return self;
}

//-(void)dealloc{
//    [objectivesMonitored release];
//    [allObjectives release];
//}

@end

