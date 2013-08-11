//
//  Fighter.m
//  PunchGame
//
//  Created by Abhineet Prasad on 19/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "Fighter.h"

@implementation Fighter

@synthesize leftPunchAction;
@synthesize rightPunchAction;
@synthesize lives;
//@synthesize score;

-(void) dealloc {
    leftPunchAction = nil;
    rightPunchAction =nil;
    CCLOG(@"fighter dealloc called");
    [super dealloc];
}

//-(void) hitBag{
//    //[[SimpleAudioEngine sharedEngine] playEffect:@"Punch.mp3"];
//    bagHit = YES;
//}

-(void)initPunchAction{
    

    CCAnimation* rightPunchAnim = [CCAnimation animation];
    [rightPunchAnim addSpriteFrameWithFilename:@"character_ranim1.png"];
    [rightPunchAnim addSpriteFrameWithFilename:@"character_ranim2.png"];
    [rightPunchAnim addSpriteFrameWithFilename:@"character_ranim3.png"];
    [rightPunchAnim addSpriteFrameWithFilename:@"character_anim4.png"];
    [[CCAnimationCache sharedAnimationCache] addAnimation:rightPunchAnim name:@"rightPunch"];

    id rightPunchActionFW = [CCAnimate actionWithDuration:0.3f
                                              animation:rightPunchAnim
                                   restoreOriginalFrame:NO];
    id rightPunchActionAndSet = [CCSequence actions:rightPunchActionFW,[CCCallFunc actionWithTarget:self
                                                                                            selector:@selector(hitBag)],nil];
    rightPunchAction = (CCAction*)[CCSequence actions:rightPunchActionAndSet,[rightPunchAction reverse], nil];
    
    
    CCAnimation* leftPunchAnim = [CCAnimation animation];
    [leftPunchAnim addSpriteFrameWithFilename:@"character1_lanim1.png"];
    [leftPunchAnim addSpriteFrameWithFilename:@"character1_lanim2.png"];
    [leftPunchAnim addSpriteFrameWithFilename:@"character1_lanim3.png"];
    [leftPunchAnim addSpriteFrameWithFilename:@"character1_lanim4.png"];
    
    id leftPunchActionFW = [CCAnimate actionWithDuration:0.3f
                                              animation:leftPunchAnim
                                   restoreOriginalFrame:NO];
    id leftPunchActionWithSound = [CCSequence actions:leftPunchActionFW,[CCCallFunc actionWithTarget:self
                                                                                            selector:@selector(playPunch)],nil];
    leftPunchAction = (CCAction*)[CCSequence actions:leftPunchActionWithSound,[leftPunchAction reverse], nil];
}

-(void) runLeftPunch{
    
    if ([CCAnimationCache sharedAnimationCache]!=nil) {
        CCAnimation* lTemp = [[CCAnimationCache sharedAnimationCache] animationByName:@"leftPunch"];
        id leftPunchAction =[CCAnimate actionWithDuration:0.3f
                                                animation:lTemp restoreOriginalFrame:NO];
        id leftPunchReverse =[leftPunchAction reverse];
        [self runAction:leftPunchAction];
        [[SimpleAudioEngine sharedEngine]playEffect:@"Punch.mp3"];
        //[punchSprite runAction:tempPunchAction];
        [self runAction:leftPunchReverse];
    }

}

-(id) init{
    
    if(self = [super init]){
        //bagHit = NO;
        lives = 1;
        self = [CCSprite spriteWithFile:@"character_anim1.png"];
        //[self setPosition:CGPointMake(screenSize.width/2, screenSize.height * 0.35f )];
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
            [self setScaleX:screenSize.width/768];
            [self setScaleY:screenSize.height/1024];
        }
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Punch.mp3"];
        [self initPunchAction];
        
    }
    return self;
}

@end
