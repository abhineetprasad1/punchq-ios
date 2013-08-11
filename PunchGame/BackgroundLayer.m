//
//  BackgroundLayer.m
//  PunchGame
//
//  Created by Abhineet Prasad on 16/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer

-(void) dealloc{
    
    CCLOG(@"Game Background deallocated");
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup:YES];
    [super dealloc];
}

-(id) init{
    
    self =[super init];
    CGSize screenSize = [[CCDirector sharedDirector]winSize];
    
    
    CCSprite* backgroundImage ;
    //PunchBag* punchBag = [CCSprite spriteWithFile:@"punchBag1.png"];
    //PunchBag* pbag = [[PunchBag alloc]init];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        backgroundImage =[CCSprite spriteWithFile:@"backgroundipad.png"];
    } else {
        backgroundImage =[CCSprite spriteWithFile:@"background.png"];
        //[punchBag setScaleX:screenSize.width/768];
        //[punchBag setScale:screenSize.height/1024];
        //[punchBag scaleForPhone];
    }
    
        
    [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
    [self addChild:backgroundImage z:0 tag:0];
   // [punchBag setPosition:CGPointMake(screenSize.width/2, screenSize.height * 0.75f)];
    //[self addChild:punchBag z:10 tag:10];
    return self;
}

@end
