//
//  MenuLayer.m
//  PunchGame
//
//  Created by Abhineet Prasad on 23/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "MenuLayer.h"

@implementation MenuLayer



static bool isMute = NO;
CGPoint touchStart;
CGPoint touchEnd;
int sizzleId;
float menuOffset = 0.5f;
bool isTutorialOn;


-(void)dealloc{
    
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup:YES];
    CCLOG(@"MenuLayer was deallocated");
    [super dealloc];
}

-(void)reallyGo{
    GameScene* scene = [[[GameScene alloc] init]autorelease];
    if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]){
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
    [[CCDirector sharedDirector] replaceScene: scene];
}

-(void) goToGameScene{
    
    if(isTutorialOn){
        [self goToTutorialScene];
    }else{
         [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
        CCSprite* temp = [self getChildByTag:124];
        [temp runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(reallyGo)],nil]];
    }
    
}
-(void) goToTutorialScene{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    TutorialScene* scene = [TutorialScene node];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3f scene:scene]];
    CCLOG(@"should go to tutorial scene here");
}

-(void) goToStatsScene{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    StatsScene* scene = [StatsScene node];
   // [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3f scene:scene]];
    [[CCDirector sharedDirector] pushScene:scene];

    CCLOG(@"should go to stats scene here");
}
-(void) goToCreditsScene{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    CreditsScene* scene = [CreditsScene node];
    // [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3f scene:scene]];
    [[CCDirector sharedDirector] pushScene:scene];
    
    CCLOG(@"should go to credits scene here");
}


-(void) playMusic:(bool)isAllowed{
    
    if((isAllowed) && (![[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]) ){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"menuBackground2.mp3" loop:YES];
    }
}


-(void) toggleSound{
    CCLOG(@"disable sound here");
    
    
    if ([[SimpleAudioEngine sharedEngine] mute] == YES){
        [[SimpleAudioEngine sharedEngine] setMute:NO];
        [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
        isMute = NO;
        [self playMusic:YES];
        return;
    }
    if([[SimpleAudioEngine sharedEngine] mute] == NO){
        [[SimpleAudioEngine sharedEngine] setMute:YES];
        isMute= YES;
        return;
    }
}

-(void) toggleTutorial{
     [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    if(isTutorialOn){
        isTutorialOn = NO;
    }else{
        isTutorialOn = YES;
    }
}

-(void) playSizzle{
    sizzleId=[[SimpleAudioEngine sharedEngine] playEffect:@"sizzle.mp3"];
}
-(void) playBang{
    [[SimpleAudioEngine sharedEngine] stopEffect:sizzleId];
    [[SimpleAudioEngine sharedEngine] playEffect:@"bang.mp3"];
}

-(void) playBackground{
     [self playMusic:!isMute];
}

-(id) init {
    
    if(self = [super init]){
        
       
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"slide.mp3"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"bang.mp3"];
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"alreadyLaunched"]){
            isTutorialOn = YES;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"alreadyLaunched"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else{
            isTutorialOn = NO;
        }
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCSprite* menuBackgroundSprite = [CCSprite spriteWithFile:@"newmenubg.png"];
        [menuBackgroundSprite setPosition:ccp(screenSize.width/2,screenSize.height/2)];
        
        //experimenting with game name
        CCSprite* gameNameSprite = [CCSprite spriteWithFile:@"gameName.png"];
        CCSprite* qSprite = [CCSprite spriteWithFile:@"q.png"];
        
        
        CCSprite* pageIdentifierSprite1 = [CCSprite spriteWithFile:@"pageIdentifier1.png"];
        [pageIdentifierSprite1 setPosition:ccp(screenSize.width/2,screenSize.height * .02f)];
        CCSprite* pageIdentifierSprite2 = [CCSprite spriteWithFile:@"pageIdentifier2.png"];
        [pageIdentifierSprite2 setPosition:ccp(screenSize.width/2, screenSize.height * 0.02f)];
        [pageIdentifierSprite2 setVisible:NO];
        
        CCMenuItemImage* playButton;
        CCMenuItemImage* soundOn;
        CCMenuItemImage* soundOff;
        
        CCMenuItemImage* tutorialOn;
        CCMenuItemImage* tutorialOff;
        CCMenuItemToggle* tutorialButton;
        CCMenuItemImage* statsButton;
        CCMenuItemImage* creditsButton;
        
        float punchQ = [[NSUserDefaults standardUserDefaults] floatForKey:@"punchQ"];
        CCLabelTTF* punchQLabel = [CCLabelTTF labelWithString:@"PunchQ" fontName:@"Marker Felt" fontSize:64];
        [punchQLabel setString:[NSString stringWithFormat:@"%.02f",punchQ]];
        self.isTouchEnabled =YES;
        
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
            [menuBackgroundSprite setScaleX:screenSize.width/768];
            [menuBackgroundSprite setScaleY:screenSize.height/1024];
            [gameNameSprite setScaleX:screenSize.width/768];
            [gameNameSprite setScaleY:screenSize.height/1024];
            [qSprite setScaleX:screenSize.width/768];
            [qSprite setScaleY:screenSize.height/1024];
            [pageIdentifierSprite1 setScaleX:screenSize.width/768];
            [pageIdentifierSprite1 setScaleY:screenSize.height/1024];
            [pageIdentifierSprite2 setScaleX:screenSize.width/768];
            [pageIdentifierSprite2 setScaleY:screenSize.height/1024];
            [punchQLabel setScaleX:screenSize.width/768];
            [punchQLabel setScaleY:screenSize.height/1024];
            playButton = [CCMenuItemImage itemWithNormalImage:@"playButton1.png" selectedImage:@"playButton1Selected.png" target:self selector:@selector(goToGameScene)];
//            playButton = [CCMenuItemImage itemWithNormalImage:@"playButton1.png" selectedImage:@"playButton1Selected.png" target:self selector:@selector(goToTutorialScene)];
            
            tutorialButton = [CCMenuItemImage itemWithNormalImage:@"tutorialButton.png" selectedImage:@"tutorialButtonPressed.png" target:self selector:@selector(goToTutorialScene)];
            
            statsButton = [CCMenuItemImage itemWithNormalImage:@"statsButton.png" selectedImage:@"statsButtonPressed.png" target:self selector:@selector(goToStatsScene)];
            creditsButton = [CCMenuItemImage itemWithNormalImage:@"creditsButton.png" selectedImage:@"creditsButtonPressed.png" target:self selector:@selector(goToCreditsScene)];
            
            soundOn = [CCMenuItemImage itemWithNormalImage:@"soundOn.png" selectedImage:@"soundOn.png"];
            soundOff =[CCMenuItemImage itemWithNormalImage:@"soundOff.png" selectedImage:@"soundOff.png"];
            tutorialOn = [CCMenuItemImage itemFromNormalImage:@"tutorialButton.png" selectedImage:@"tutorialButton.png"];
            tutorialOff =[CCMenuItemImage itemWithNormalImage:@"tutorialButtonPressed.png" selectedImage:@"tutorialButtonPressed.png"];
            
        }else{
            playButton = [CCMenuItemImage itemWithNormalImage:@"playButton1-ipad.png" selectedImage:@"playButton1Selected-ipad.png" target:self selector:@selector(goToGameScene)];
//            playButton = [CCMenuItemImage itemWithNormalImage:@"playButton1-ipad.png" selectedImage:@"playButton1Selected-ipad.png" target:self selector:@selector(goToTutorialScene)];
            
            tutorialButton = [CCMenuItemImage itemWithNormalImage:@"tutorialButton-ipad.png" selectedImage:@"tutorialButtonPressed-ipad.png" target:self selector:@selector(goToTutorialScene)];
            
            statsButton = [CCMenuItemImage itemWithNormalImage:@"statsButton-ipad.png" selectedImage:@"statsButtonPressed-ipad.png" target:self selector:@selector(goToStatsScene)];
            creditsButton = [CCMenuItemImage itemWithNormalImage:@"creditsButton-ipad.png" selectedImage:@"creditsButtonPressed-ipad.png" target:self selector:@selector(goToCreditsScene)];
            
            soundOn = [CCMenuItemImage itemWithNormalImage:@"soundOn-ipad.png" selectedImage:@"soundOn-ipad.png"];
            soundOff =[CCMenuItemImage itemWithNormalImage:@"soundOff-ipad.png" selectedImage:@"soundOff-ipad.png"];
            tutorialOn = [CCMenuItemImage itemFromNormalImage:@"tutorialButton-ipad.png" selectedImage:@"tutorialButton-ipad.png"];
            tutorialOff =[CCMenuItemImage itemWithNormalImage:@"tutorialButtonPressed-ipad.png" selectedImage:@"tutorialButtonPressed-ipad.png"];
        }
        
        //ADD MENU 
        CCMenuItemToggle* soundButton;
        if(isMute){
            soundButton =[CCMenuItemToggle itemWithTarget:self selector:@selector(toggleSound) items:soundOff,soundOn, nil];
        }else {
            soundButton =[CCMenuItemToggle itemWithTarget:self selector:@selector(toggleSound) items:soundOn,soundOff, nil];
        };
        if(isTutorialOn){
            tutorialButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(toggleTutorial) items:tutorialOn,tutorialOff, nil];
        }else{
            tutorialButton = [CCMenuItemToggle itemWithTarget:self selector:@selector(toggleTutorial) items:tutorialOff,tutorialOn, nil];
        }
        
        CCMenu* myMenu = [CCMenu menuWithItems:playButton,soundButton, nil];
        
        
        [myMenu setPosition:CGPointMake(screenSize.width * menuOffset, screenSize.height * 0.12f)];
        [myMenu setAnchorPoint:ccp(1,0)];
        [myMenu alignItemsVertically];
        [myMenu setOpacity:0];
        [self addChild:myMenu z:20 tag:20];

        
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sizzle.mp3"];
        [gameNameSprite setPosition:ccp(screenSize.width/2,screenSize.height - [gameNameSprite boundingBox].size.height/2)];
        [qSprite setPosition:ccp(screenSize.width/2,screenSize.height - [gameNameSprite boundingBox].size.height/2 - [qSprite boundingBox].size.height/2)];
        [qSprite setOpacity:0];
        [gameNameSprite setOpacity:0];
        //[gameNameSprite setPosition:ccp(screenSize.width/2 , screenSize.height/2)];
        [self addChild:gameNameSprite z:21 tag:123];
        [self addChild:qSprite z:21 tag:124];
        id playSizzleAction = [CCCallFunc actionWithTarget:self selector:@selector(playSizzle)];
        id playBangAction =[CCCallFunc actionWithTarget:self selector:@selector(playBang)];
        id playBackGroundAction = [CCCallFunc actionWithTarget:self selector:@selector(playBackground)];
        
        [gameNameSprite runAction:[CCSpawn actions:[CCFadeIn actionWithDuration:1.25],playSizzleAction, nil]];
        [qSprite runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.25],playBangAction,[CCFadeIn actionWithDuration:0.2],[CCDelayTime actionWithDuration:1],playBackGroundAction, nil]];
        
        [myMenu runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.5],[CCFadeIn actionWithDuration:0.2f], nil]];
        
        
        CCMenu* anotherMenu = [CCMenu menuWithItems:tutorialButton,statsButton,creditsButton, nil];
        [anotherMenu setAnchorPoint:ccp(0,0.5f)];
        [anotherMenu setPosition:CGPointMake(screenSize.width * menuOffset + screenSize.width, screenSize.height * 0.15f)];
        [anotherMenu alignItemsVertically];
        
        
        [punchQLabel setPosition:ccp(screenSize.width * 0.5, screenSize.height * 0.3f)];
        [punchQLabel setOpacity:0];
        [punchQLabel setColor:ccc3(94,38,18)];
        id punchQAction = [CCEaseBounce actionWithAction:[CCScaleBy actionWithDuration:1 scale:1.1f]];
        //id punchQSeq = [CCSequence actions:punchQAction,[punchQAction reverse], nil];
    
        [punchQLabel runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.5],[CCFadeIn actionWithDuration:0.2f], nil]];
        [self addChild:menuBackgroundSprite z:10 tag:10];
        [self addChild:pageIdentifierSprite1 z:11 tag:11];
        [self addChild:pageIdentifierSprite2 z:11 tag:12];
        
        [self addChild:anotherMenu z:20 tag:21];
        [self addChild:punchQLabel z:20 tag:22];
        
    }
    return self;
}


-(void) slideActionWithDistance:(CGPoint)distance{
    
    [self stopAllActions];
    [[SimpleAudioEngine sharedEngine]playEffect:@"slide.mp3"];
    [[self getChildByTag:20] runAction:[CCMoveBy actionWithDuration:0.4 position:ccp(distance.x,distance.y)]];
    //bring another menu in
    [[self getChildByTag:21] runAction:[CCMoveBy actionWithDuration:0.4 position:ccp(distance.x,distance.y)]];

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
    CGSize screenSize = [[CCDirector sharedDirector]winSize];
    //Swipe Detection Part 2
    touchEnd = location;
    
    //Minimum length of the swipe
    float swipeLength = ccpDistance(touchStart, touchEnd);
    
    //Check if the swipe is a right swipe and long enough
    if (touchEnd.x < touchStart.x && swipeLength > 40 && ([[self getChildByTag:11] visible])) {
        //move main menu away
        [[SimpleAudioEngine sharedEngine]playEffect:@"slide.mp3"];
        [[self getChildByTag:20] runAction:[CCMoveTo actionWithDuration:0.3 position:ccp(screenSize.width * menuOffset - screenSize.width, screenSize.height * 0.12f)]];
        //bring another menu in
        [[self getChildByTag:21] runAction:[CCMoveTo actionWithDuration:0.3 position:ccp(screenSize.width * (menuOffset + 0.075), screenSize.height * 0.15f)]];
        //make second page sprite visible
        [[self getChildByTag:11] setVisible:NO];
        [[self getChildByTag:12] setVisible:YES];
    }
    
    if (touchEnd.x > touchStart.x && swipeLength > 40 && ([[self getChildByTag:12] visible])) {
        
        [[SimpleAudioEngine sharedEngine]playEffect:@"slide.mp3"];
        [[self getChildByTag:20] runAction:[CCMoveTo actionWithDuration:0.3 position:ccp(screenSize.width * menuOffset, screenSize.height * 0.12f)]];
        //bring another menu in
        [[self getChildByTag:21] runAction:[CCMoveTo actionWithDuration:0.3 position:ccp(screenSize.width * menuOffset + screenSize.width, screenSize.height * 0.15f)]];
        //make second page sprite visible
        [[self getChildByTag:11] setVisible:YES];
        [[self getChildByTag:12] setVisible:NO];
    }
    
}

@end
