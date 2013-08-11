//
//  ScoreLayer.m
//  PunchGame
//
//  Created by Abhineet Prasad on 03/03/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "ScoreLayer.h"

@implementation ScoreLayer

CGPoint touchStart;
CGPoint touchEnd;

-(void) dealloc{
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup:YES];
    CCLOG(@"ScoreLayer was deallcoated");
    [super dealloc];
    
}

-(void) slideToMenuScene{
 //slide to menu scene here
    MenuScene* menuScene = [MenuScene node];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.1f scene:menuScene]];
}

-(id) init{
    
    
    if(self = [super init]){
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCSprite* backgroundSprite = [CCSprite spriteWithFile:@"menuBgSprite_second.png"];
        [backgroundSprite setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
            [backgroundSprite setScaleX:screenSize.width/768];
            [backgroundSprite setScaleY:screenSize.height/1024];
        }
        self.isTouchEnabled =YES;
        
        [self addChild:backgroundSprite z:5 tag:5];
    }
    return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    //Swipe Detection Part 1
    touchStart= location;
}


-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    //Swipe Detection Part 2
    touchEnd = location;
    
    //Minimum length of the swipe
    float swipeLength = ccpDistance(touchStart, touchEnd);
    
    //Check if the swipe is a left swipe and long enough
    if (touchEnd.x > touchStart.x && swipeLength > 40) {
        [self slideToMenuScene];
    }

}
@end
