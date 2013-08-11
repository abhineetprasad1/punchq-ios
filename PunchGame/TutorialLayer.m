//
//  TutorialLayer.m
//  PunchGame
//
//  Created by Abhineet Prasad on 05/03/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "TutorialLayer.h"

@implementation TutorialLayer

CCSprite* fighter;
CCProgressTimer* timeLeftBar;
int hitValue = 1;
CCLabelTTF* incorrect;
CCLabelBMFont* command;

-(void) dealloc{
  
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup:YES];
    fighter  = nil;
    timeLeftBar = nil;
    incorrect = nil;
    command = nil;
    CCLOG(@"Tutorial Layer was deallcoated");
    [super dealloc];
    
}


-(void)initPunchAnim{
    
    if([[CCAnimationCache sharedAnimationCache] animationByName:@"rightPunch"] == nil){
        CCAnimation* rightPunchAnim = [CCAnimation animation];
        [rightPunchAnim addSpriteFrameWithFilename:@"character_ranim1.png"];
        [rightPunchAnim addSpriteFrameWithFilename:@"character_ranim2.png"];
        [rightPunchAnim addSpriteFrameWithFilename:@"character_ranim3.png"];
        [rightPunchAnim addSpriteFrameWithFilename:@"character_anim4.png"];
        [[CCAnimationCache sharedAnimationCache] addAnimation:rightPunchAnim name:@"rightPunch"];
    }
    
    if([[CCAnimationCache sharedAnimationCache] animationByName:@"leftPunch"] == nil){
        CCAnimation* leftPunchAnim = [CCAnimation animation];
        [leftPunchAnim addSpriteFrameWithFilename:@"character1_lanim1.png"];
        [leftPunchAnim addSpriteFrameWithFilename:@"character1_lanim2.png"];
        [leftPunchAnim addSpriteFrameWithFilename:@"character1_lanim3.png"];
        [leftPunchAnim addSpriteFrameWithFilename:@"character1_lanim4.png"];
        // [leftPunchAnim addSpriteFrameWithFilename:@"character1_lanim3.png"];
        // [leftPunchAnim addSpriteFrameWithFilename:@"character1_lanim2.png"];
        // [leftPunchAnim addSpriteFrameWithFilename:@"character_anim1.png"];
        
        [[CCAnimationCache sharedAnimationCache]addAnimation:leftPunchAnim name:@"leftPunch"];
    }
}

-(void) initPunchBagAnim{
    
    if([[CCAnimationCache sharedAnimationCache] animationByName:@"punchBag"] == nil){
        CCAnimation* punchedAnim = [CCAnimation animation];
        [punchedAnim addSpriteFrameWithFilename:@"punchBag21.png"];
        [punchedAnim addSpriteFrameWithFilename:@"punchBag22.png"];
        [punchedAnim addSpriteFrameWithFilename:@"punchBag23.png"];
        [punchedAnim addSpriteFrameWithFilename:@"punchBag23.png"];
        [punchedAnim addSpriteFrameWithFilename:@"punchBag22.png"];
        [punchedAnim addSpriteFrameWithFilename:@"punchBag21.png"];
        [punchedAnim addSpriteFrameWithFilename:@"punchBag1.png"];
        [[CCAnimationCache sharedAnimationCache] addAnimation:punchedAnim name:@"punchBag"];
    }
}

-(void) showNumbersFirst:(int)a andSecond:(int)b {
    
    CGSize screenSize = [[CCDirector sharedDirector]winSize];
    float multiplyingFactor =0.4f;
    float incrementNumber = 0.2f;
    CCSprite* tempSprite;
    for(int i=1;i<3;i++){
        int num;
        tempSprite = nil;
        if(i==1){
            num = a;
        } else if(i==2){
            num = b;
        }
        switch (num) {
            case 1:
                tempSprite =[CCSprite spriteWithFile:@"numberOne.png"];
                CCLOG(@"I ADDED ONE");
                break;
            case 2:
                tempSprite =[CCSprite spriteWithFile:@"numberTwo.png"];
                CCLOG(@"I ADDED TWO");
                break;
                
            default:
                break;
        }
        
        //Position the number sprite
        if(tempSprite != nil){
            [tempSprite setPosition:CGPointMake(screenSize.width * multiplyingFactor,screenSize.height * 0.8f) ];
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
                [tempSprite setScaleX:screenSize.width/768];
                [tempSprite setScaleY: screenSize.height/1024];
            }
            
            [self addChild:tempSprite z:30 tag: (40 + num)];
            multiplyingFactor = multiplyingFactor + incrementNumber;
        }
        if(i==1){
            [tempSprite runAction:[CCScaleBy actionWithDuration:0.01f scale:1.2f]];
        }
        
        
    }
    
}



-(id) init{
    if(self = [super init]){
        hitValue = 1;
        self.isTouchEnabled =YES;
        CGSize screenSize = [[CCDirector sharedDirector]winSize];
        fighter =[CCSprite spriteWithFile:@"character_anim1.png"];
        [fighter setPosition:CGPointMake(screenSize.width/2, screenSize.height * 0.35f )];
        
        //Add punch bag
        PunchBag* punchBag = [CCSprite spriteWithFile:@"punchBag1.png"];
        [punchBag setPosition:CGPointMake(screenSize.width/2, screenSize.height * 0.75f)];
        
        //Add pause button
        CCSprite* pauseSprite = [CCSprite spriteWithFile:@"pauseButton.png"];
  
        //Add Time Left Bar
        CCSprite* timeBarBorder = [CCSprite spriteWithFile:@"timeBarBorder.png"];
        
          command = [CCLabelTTF labelWithString:@" '1' = LEFT PUNCH \n Tap anywhere on \n the left half \n of the screen \n to throw a left punch"  fontName:@"Marker Felt" fontSize:42];
        [command setColor:ccc3(255, 185, 15)];
        
        incorrect = [CCLabelTTF labelWithString:@"INCORRECT" fontName:@"Marker Felt" fontSize:64];
        CCLabelBMFont* greatLabel = [CCLabelTTF labelWithString:@"Great Job!" fontName:@"Marker Felt" fontSize:64];
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
            [fighter setScaleX:screenSize.width/768];
            [fighter setScaleY:screenSize.height/1024];
            [punchBag setScaleX:screenSize.width/768];
            [punchBag setScale:screenSize.height/1024];
            
            [timeBarBorder setScaleX:screenSize.width/768];
            [timeBarBorder setScale:screenSize.height/1024];
            [timeLeftBar setScaleX:screenSize.width/768];
            [timeLeftBar setScale:screenSize.height/1024];
            
            
            [pauseSprite setScaleX:screenSize.width/768];
            [pauseSprite setScale:screenSize.height/1024];
            [command setScaleX:screenSize.width/768];
            [command setScale:screenSize.height/1024];
            [incorrect setScaleX:screenSize.width/768];
            [incorrect setScale:screenSize.height/1024];
            [greatLabel setScaleX:screenSize.width/768];
            [greatLabel setScale:screenSize.height/1024];
            
        }
        [incorrect setColor:ccc3(205, 0, 0)];
        [incorrect setPosition:ccp(screenSize.width/2,screenSize.height* .35)];
        //[incorrect setOpacity:0];
        [incorrect setVisible:NO];
        [command setPosition:ccp(screenSize.width * 0.35, screenSize.height*0.6f)];
        [self addChild:command z:50 tag:100];
        [self addChild:incorrect z:50 tag:101];
        //command.alignment = kCCTextAlignmentCenter;
        [timeBarBorder setPosition:ccp(screenSize.width/2, screenSize.height * 0.98f)];
        [timeBarBorder setScaleY:[timeBarBorder scaleY]/2];
        
        [timeLeftBar setPosition:[timeBarBorder position]];
        timeLeftBar = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"timeBar.png"]];
        timeLeftBar.type = kCCProgressTimerTypeBar;
        timeLeftBar.midpoint= ccp(0,0);
        timeLeftBar.barChangeRate = ccp(1,0);
        timeLeftBar.percentage = 0;
        timeLeftBar.anchorPoint = ccp(0,0);
        
        [pauseSprite setPosition:ccp(pauseSprite.contentSize.width/2,pauseSprite.contentSize.height/2)];
        [self addChild:pauseSprite z:30 tag:5];
       
       
        [self addChild:fighter z:20 tag:20];
        
        [self addChild:punchBag z:10 tag:10];
        [self addChild:timeBarBorder z:30 tag:31];
        [timeBarBorder addChild:timeLeftBar z:30];
        
        [self initPunchAnim];
        [self initPunchBagAnim];
        [greatLabel setOpacity:0];
        [greatLabel setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:greatLabel z:30 tag:32];
        
        
        CCProgressFromTo* progressTo = [CCProgressFromTo actionWithDuration:2.2f from:100 to:0];
        [timeLeftBar runAction:[CCRepeatForever actionWithAction:progressTo]];
        
                
        [self showNumbersFirst:1 andSecond:2];
        

        
        
    }
    return self;
}

-(void) makeInvisible{
    [incorrect setVisible:NO];
}
-(void) goToMenu{
    
    MenuScene* menuScene = [MenuScene node];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3f scene:menuScene]];
}

-(void)removeTag:(int)tag AndSetMessage:(NSString*)message atPosition:(CGPoint) pos{
    CGSize screenSize = [[CCDirector sharedDirector]winSize];
    [self removeChildByTag:(tag) cleanup:YES];
    if([self getChildByTag:tag-1]){
        
        CCSprite* zoom = [self getChildByTag:(tag-1)];
        [zoom runAction:[CCScaleBy actionWithDuration:0.01f scale:1.35f]];
    }
    if ([self getChildByTag:(tag+1)]) {
        CCSprite* zoom = [self getChildByTag:(tag+1)];
        [zoom runAction:[CCScaleBy actionWithDuration:0.01f scale:1.35f]];
    }

    [command setOpacity:0];
    [command setPosition:pos];
    [command setColor:ccc3(255,255,255)];
    [command setString:message];
    [command setOpacity:255];
  
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGSize screenSize = [[CCDirector sharedDirector]winSize];
    UITouch* touch = [touches anyObject];
    CGPoint loc = [touch locationInView:[touch view]];
    loc =[[CCDirector sharedDirector] convertToGL:loc];
    CCSprite* punchSprite = [self getChildByTag:10];
  
    
    //Retrieve the punchBag animation and create action
    id tempPunchAction;
    if([CCAnimationCache sharedAnimationCache]!=nil){
        CCAnimation* tempPunchAnim = [[CCAnimationCache sharedAnimationCache] animationByName:@"punchBag"];
        tempPunchAction = [CCAnimate actionWithDuration:0.4f
                                              animation: tempPunchAnim
                                   restoreOriginalFrame:NO];
    }
    
   
    
    [fighter stopAllActions];
    //IF RIGHT PUNCH
    
    if(hitValue==5){
        GameScene* scene = [[[GameScene alloc] init]autorelease];
        if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]){
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
        [[CCDirector sharedDirector] replaceScene: scene];
        
    }

    if((loc.x > screenSize.width/2) ) {
        
        
        //Run Right Punch Animation
        if([CCAnimationCache sharedAnimationCache]!=nil){
            CCAnimation* temp = [[CCAnimationCache sharedAnimationCache] animationByName:@"rightPunch"];
            
            id rightPunchAction = [CCAnimate actionWithDuration:0.4f
                                                      animation:temp
                                           restoreOriginalFrame:NO];
            id rightPunchReverse =[rightPunchAction reverse];
            
            [fighter runAction:rightPunchAction];
            [punchSprite runAction:tempPunchAction];
            [[SimpleAudioEngine sharedEngine] playEffect:@"Punch.mp3"];
            [fighter runAction:rightPunchReverse];
            
            //Check if correct
            // NSMutableArray* tempArray= [board getNumberSequenceArray];
            if(hitValue==2){
                hitValue=3;
                CGPoint pos = ccp(screenSize.width/2,screenSize.height * .65);
                [self removeTag:42 AndSetMessage:@"Lets Try that again!" atPosition:pos];
                [self showNumbersFirst:2 andSecond:1];
                
            }
            else if(hitValue==3){
                hitValue=4;
                CGPoint pos = ccp(screenSize.width/2,screenSize.height * .65);
                [self removeTag:42 AndSetMessage:@"" atPosition:pos];
                
              
            }
                        else {
                //SHOW ERROR MESSAGE
                id makeInvisibleAction = [CCCallFunc actionWithTarget:self selector:@selector(makeInvisible)];
                [incorrect runAction:[CCSequence actions:[CCBlink actionWithDuration:2 blinks:4],makeInvisibleAction, nil]];
            }
            
            
        }
        
    } else if(loc.x < screenSize.width/2) {
        //RUN LEFT PUNCH ANIMATION
        if ([CCAnimationCache sharedAnimationCache]!=nil) {
            CCAnimation* lTemp = [[CCAnimationCache sharedAnimationCache] animationByName:@"leftPunch"];
            id leftPunchAction =[CCAnimate actionWithDuration:0.4f
                                                    animation:lTemp restoreOriginalFrame:NO];
            id leftPunchReverse =[leftPunchAction reverse];
            [fighter runAction:leftPunchAction];
            [[SimpleAudioEngine sharedEngine]playEffect:@"Punch.mp3"];
            [punchSprite runAction:tempPunchAction];
            [fighter runAction:leftPunchReverse];
        }
        //CHECK IF CORRECT
        if(hitValue== 1){

            hitValue = 2;
            CGPoint pos = ccp(screenSize.width * 0.65f, screenSize.height * 0.45f);
            [self removeTag:41 AndSetMessage:@"'2' = RIGHT PUNCH \n Tap anywhere on \n the right half \n of the screen \n to throw a right punch" atPosition:pos];
            
            
        } else if(hitValue ==4){
            hitValue=5;
            CGPoint pos = ccp(screenSize.width/2,screenSize.height * .75);
            [self removeTag:41 AndSetMessage:@"The blue bar on the top is the Timer... \n It gets refreshed for every \n new sequence of numbers.. \n Dont let it outrun you!! \n \n Tap to Start Playing" atPosition:pos];
            [[self getChildByTag:32] runAction:[CCSpawn actions:[CCScaleBy actionWithDuration:1.5 scale:1.5],[CCFadeOut actionWithDuration:1.5], nil]];
        }
        else {
            id makeInvisibleAction = [CCCallFunc actionWithTarget:self selector:@selector(makeInvisible)];
            [incorrect runAction:[CCSequence actions:[CCBlink actionWithDuration:2 blinks:4],makeInvisibleAction, nil]];
            
        }
        
    }
    
    
    
  
    
    
    
}
@end
