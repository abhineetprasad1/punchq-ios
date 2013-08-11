//
//  CreditLayer.m
//  PunchGame
//
//  Created by Abhineet Prasad on 15/03/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "CreditLayer.h"

@implementation CreditLayer

-(void) dealloc{
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup:YES];
    CCLOG(@"Stats Layer was deallcoated");
    [super dealloc];
    
}

-(id) init{
    if(self = [super init]){
        
        CCSprite* statsBackground = [CCSprite spriteWithFile:@"newmenubg.png"];
        CCSprite* statsSprite = [CCSprite spriteWithFile:@"credits.png"];
        CCSprite* backArrowSprite = [CCSprite spriteWithFile:@"backArrow.png"];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.isTouchEnabled = YES;
        
//        float punchQ = [[NSUserDefaults standardUserDefaults] floatForKey:@"punchQ"];
//        int bestStreak = [[NSUserDefaults standardUserDefaults] integerForKey:@"highestPunches"];
//        float averagePunches = [[NSUserDefaults standardUserDefaults] floatForKey:@"average"];
//        int totalPunches = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalPunches"];
//        double totalCoins = [[NSUserDefaults standardUserDefaults] doubleForKey:@"totalCoins"];
//        float multiplier = [[NSUserDefaults standardUserDefaults] floatForKey:@"multiplier"];
        
        int labelFontSize = 42;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            [statsBackground setScaleX:screenSize.width/768];
            [statsBackground setScaleY:screenSize.height/1024];
            [backArrowSprite setScaleY:screenSize.height/1024];
            [backArrowSprite setScaleX:screenSize.width/768];
            [statsSprite setScaleY:screenSize.height/1024];
            [statsSprite setScaleX:screenSize.width/768];
            labelFontSize = 30;
        }
        [statsSprite setPosition:ccp(screenSize.width/2, screenSize.height *  0.98 - [statsSprite boundingBox].size.height/2)];
        
        CCLabelBMFont* punchQLabel = [CCLabelTTF labelWithString:
                                      @"Concept : Rohit Sharan" fontName:@"Marker Felt" fontSize:labelFontSize];
        CCLabelBMFont* bestStreakLabel = [CCLabelTTF labelWithString:@"Art : Anupam Prasad" fontName:@"Marker Felt" fontSize:labelFontSize];
        CCLabelBMFont* averageLabel = [CCLabelTTF labelWithString:@"Music : Mark Koenig,\n Sumit Sen" fontName:@"Marker Felt" fontSize:labelFontSize];
        CCLabelBMFont* totalPunchesLabel = [CCLabelTTF labelWithString:@"Inspiration : Alka Prasad,\n Mukesh Prasad" fontName:@"Marker Felt" fontSize:labelFontSize];
        CCLabelBMFont* totalCoinsLabel = [CCLabelTTF labelWithString:@"BOSS : Anchal Sahni" fontName:@"Marker Felt" fontSize:labelFontSize];
        CCLabelBMFont* multiplierLabel = [CCLabelTTF labelWithString:@"Powered by Cocos2d" fontName:@"Marker Felt" fontSize:labelFontSize];
        
        
        [statsBackground setPosition:ccp(screenSize.width/2,screenSize.height/2)];
        [backArrowSprite setPosition:ccp(screenSize.width  * 0.01f + [backArrowSprite boundingBox].size.width/2 , screenSize.height * 0.99f - [backArrowSprite boundingBox].size.height/2)];
        
        [punchQLabel setPosition:ccp(screenSize.width/2,screenSize.height * 0.75f)];
        [bestStreakLabel setPosition:ccp(screenSize.width/2,screenSize.height * 0.65f)];
        [averageLabel setPosition:ccp(screenSize.width/2,screenSize.height * 0.55f)];
        [totalPunchesLabel setPosition:ccp(screenSize.width/2,screenSize.height * 0.40f)];
        [totalCoinsLabel setPosition:ccp(screenSize.width/2,screenSize.height * 0.25f)];
        [multiplierLabel setPosition:ccp(screenSize.width/2,screenSize.height * 0.15f)];
        
        
        [self addChild:statsBackground z :1 tag:1];
        [self addChild:statsSprite z:2 tag:20];
        [self addChild:backArrowSprite z:3 tag:4];
        [self addChild:punchQLabel z:3 tag:10];
        [self addChild:bestStreakLabel z:3 tag:11];
        [self addChild:averageLabel z:3 tag:12];
        [self addChild:totalPunchesLabel z:3 tag:13];
        [self addChild:totalCoinsLabel z:3 tag:14];
        [self addChild:multiplierLabel z:3 tag:15];
        
        
        id moveleftAction = [CCEaseBounce actionWithAction:[ CCMoveBy actionWithDuration:0.5f position:ccp(-screenSize.width * .02f, 0)]];
        [backArrowSprite runAction: [CCRepeatForever actionWithAction:[CCSequence actions:moveleftAction,[moveleftAction reverse], nil]]];
        
        
        
        
    }
    return self;
}

-(void) goToMenu{
    
    //MenuScene* menuScene = [MenuScene node];
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3f scene:menuScene]];
    [[CCDirector sharedDirector] popScene];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch* touch = [touches anyObject];
    CGPoint loc = [touch locationInView:[touch view]];
    loc =[[CCDirector sharedDirector] convertToGL:loc];
    
    if(CGRectContainsPoint([[self getChildByTag:4] boundingBox], loc)){
        
        [self goToMenu];
    }
}




@end
