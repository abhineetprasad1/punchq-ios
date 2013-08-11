//
//  GameOverLayer.m
//  PunchGame
//
//  Created by Abhineet Prasad on 22/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//
#import "GameScene.h"
#import "GameOverLayer.h"
#import "MenuLayer.h"


@implementation GameOverLayer

-(void)dealloc{
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup:YES];
    CCLOG(@"GameoverLayer was deallcoated");
    [super dealloc];
}

-(void) goToGame{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    GameScene* newScene = [GameScene node];
   // [[CCDirector sharedDirector] replaceScene: [CCTransitionCrossFade transitionWithDuration:1 scene:newScene]];
    [[CCDirector sharedDirector] replaceScene:newScene];
}
-(void) goToMenu{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    MenuScene* menuScene = [MenuScene node];
    //[[CCDirector sharedDirector] replaceScene: [CCTransitionCrossFade transitionWithDuration:1 scene:menuScene]];
    [[CCDirector sharedDirector] replaceScene:menuScene];
}

-(void) postToFacebook{
    int myPunches = [[NSUserDefaults standardUserDefaults] integerForKey:@"punches"];
    [[FacebookScorer sharedInstance] postToWallWithDialogNewHighscore:myPunches];
}

-(void) goToGameCenter{
     [[GCHelper sharedInstance] showLeaderboardForCategory:@"PunchQ_StreakScore"];
}
-(id) init{
    

    if( (self=[super init]) ) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"menuBackground2.mp3" loop:YES];
        CCSprite* bgSprite = [CCSprite spriteWithFile:@"gameOverBg.png"];
        [bgSprite setPosition:ccp(size.width/2, size.height/2)];
        
        //CCSprite* gameCenter =[CCSprite spriteWithFile:@"gamecenter.png"];
         self.isTouchEnabled = YES;
        
       
        CCLabelBMFont *gameOverLabel = [CCLabelTTF labelWithString:@"You weren't paying attention\n ..were you?" fontName:@"Marker Felt" fontSize:64];
        [gameOverLabel setColor:ccc3(200, 100, 50)];
        
        
        
         // create and initialize a Label
        CCMenuItemImage* playAgainButton = [CCMenuItemImage itemWithNormalImage:@"playAgainButton.png" selectedImage:@"playAgainButtonSelected.png" target:self selector:@selector(goToGame)]; 
        CCMenuItemImage* mainMenuButton = [CCMenuItemImage itemWithNormalImage:@"menuButton.png" selectedImage:@"menuButtonSelected.png" target:self selector:@selector(goToMenu)];
        
        
        
        CCMenu* myMenu = [CCMenu menuWithItems:mainMenuButton,playAgainButton, nil];
        
//        id playButtonAction  =
        
        double timeTaken = [[NSUserDefaults standardUserDefaults] doubleForKey:@"timetaken"];
        int myScore  = [[NSUserDefaults standardUserDefaults] integerForKey:@"coins"];
        float multiplier = [[NSUserDefaults standardUserDefaults] floatForKey:@"multiplier"];
        int myPunches = [[NSUserDefaults standardUserDefaults] integerForKey:@"punches"];
        double totalCoins = [[NSUserDefaults standardUserDefaults] doubleForKey:@"totalCoins"];
        int highestPunches = [[NSUserDefaults standardUserDefaults] integerForKey:@"highestPunches"];
        float punchQ = [[NSUserDefaults standardUserDefaults] floatForKey:@"punchQ"];
        
        CCMenuItemImage* gameCenterButton = [CCMenuItemImage itemWithNormalImage:@"gamecenter.png" selectedImage:@"gamecenter.png" target:self selector:@selector(goToGameCenter)];
        CCMenuItemImage* fbButton = [CCMenuItemImage itemWithNormalImage:@"facebook.png" selectedImage:@"facebook.png" target:self selector:@selector(postToFacebook)];
        
        [fbButton setPosition:ccp(size.width/2 - [fbButton boundingBox].size.width/4, size.height * 0.7f)];
        [gameCenterButton setPosition:ccp(size.width/2 +[gameCenterButton boundingBox].size.width/4, size.height * 0.7f)];
        
        CCMenu* bragMenu = [CCMenu menuWithItems:fbButton,gameCenterButton, nil];
        [bragMenu alignItemsHorizontally];
        
        
        [bragMenu setPosition:ccp(size.width/2,size.height * 0.175)];
        
        CCLabelTTF* scoreLabel = [CCLabelTTF labelWithString:@"Score      :  " fontName:@"Marker Felt" fontSize:48];
        CCLabelTTF* punchLabel = [CCLabelTTF labelWithString:@"Punches    :  "  fontName:@"Marker Felt" fontSize:48];
        CCLabelTTF* timeLabel = [CCLabelTTF labelWithString:@"Time Taken    :  "  fontName:@"Marker Felt" fontSize:48];
        CCLabelTTF* highestScoreLabel = [CCLabelTTF labelWithString:@"Top Score   :  "  fontName:@"Marker Felt" fontSize:48];
        CCLabelTTF* highestPunchesLabel = [CCLabelTTF labelWithString:@"Punch Streak:  "  fontName:@"Marker Felt" fontSize:48];
        CCLabelTTF* punchQLabel = [CCLabelTTF labelWithString:@"PunchQ" fontName:@"Marker Felt" fontSize:64];
               
        
        
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
            [bgSprite setScaleX:size.width/768];
            [bgSprite setScaleY:size.height/1024];
            [gameOverLabel setScaleX:size.width/768];
            [gameOverLabel setScaleY:size.height/1024];
            [myMenu setScaleX:size.width/768];
            [myMenu setScaleY:size.height/1024];
            [myMenu setPosition:ccp(size.width * 0.23f, size.height * 0.35f)];
            [myMenu alignItemsHorizontallyWithPadding:5];
            [scoreLabel setScaleX:size.width/768];
            [scoreLabel setScaleY:size.height/1024];
            [punchLabel setScaleX:size.width/768];
            [punchLabel setScaleY:size.height/1024];
            [highestPunchesLabel setScaleX:size.width/768];
            [highestPunchesLabel setScaleY:size.height/1024];
            [highestScoreLabel setScaleX:size.width/768];
            [highestScoreLabel setScaleY:size.height/1024];
            [punchQLabel setScaleX:size.width/768];
            [punchQLabel setScaleY:size.height/1024];
            [timeLabel setScaleX:size.width/768];
            [timeLabel setScaleY:size.height/1024];
            [fbButton setScaleX:size.width/768];
            [fbButton setScaleY:size.height/1024];
            [gameCenterButton setScaleX:size.width/768];
            [gameCenterButton setScaleY:size.height/1024];
           
        }
        else{
            [myMenu setPosition:ccp(size.width/2, size.height * 0.65f)];
            [myMenu alignItemsHorizontallyWithPadding: size.width * 0.035f];
        }
        
        [self addChild:bgSprite z:1 tag:1];
        
        gameOverLabel.position =  ccp( size.width /2 , size.height * 0.85f );
        [self addChild:gameOverLabel z:2    tag:2];

        
        
        [self addChild:myMenu z:3 tag:4];
        
        [scoreLabel setPosition: ccp(size.width/2, size.height * 0.46f)];
        [highestScoreLabel setPosition: ccp(size.width/2, size.height * 0.41f)];
        
        [punchLabel setPosition: ccp(size.width/2, size.height * 0.36f)];
        [highestPunchesLabel setPosition: ccp(size.width/2, size.height * 0.31f)];
        [timeLabel setPosition: ccp(size.width/2, size.height * 0.26f)];
        [punchQLabel setPosition: ccp(size.width/2,size.height * 0.08f)];
       // [bragMenu setPosition:ccp(size.width * .5, size.height * 0.20)];
        
        [scoreLabel setHorizontalAlignment:kCCTextAlignmentLeft];
        [punchLabel setHorizontalAlignment:kCCTextAlignmentLeft];
        [highestScoreLabel setHorizontalAlignment:kCCTextAlignmentLeft];
        [highestPunchesLabel setHorizontalAlignment:kCCTextAlignmentLeft];
        [punchQLabel setHorizontalAlignment:kCCTextAlignmentCenter];
        [punchQLabel setColor:ccc3(255, 50 ,0)];
        
        [scoreLabel setString:[NSString stringWithFormat:@"Coins  X  %0.1f:  %d",multiplier,myScore]];
        [punchLabel setString:[NSString stringWithFormat:@"Punches     :  %d",myPunches]];
        [highestScoreLabel setString:[NSString stringWithFormat:@"Total Coins :  %.f",totalCoins]];
        [highestPunchesLabel setString:[NSString stringWithFormat:@"Best StreaQ :  %d",highestPunches]];
        [punchQLabel setString:[NSString stringWithFormat:@"PunchQ - %.02f",punchQ]];
        [timeLabel setString:[NSString stringWithFormat:@"Time Taken   :  %.02f secs",timeTaken]];
        
        [[GCHelper sharedInstance]reportScore:myPunches forCategory:@"PunchQ_StreakScore"];
        [[GCHelper sharedInstance]reportQScore:punchQ*100 forCategory:@"PunchQ_Qscore"];
        
        [self addChild:scoreLabel z:3 tag:313];
        [self addChild:punchLabel z:3 tag:314];
        [self addChild:highestScoreLabel z:3 tag:315];
        [self addChild:highestPunchesLabel z:3 tag:316];
        [self addChild:punchQLabel z:4 tag:317];
        [self addChild:timeLabel z:4 tag:410];
        [self addChild:bragMenu z:4 tag:320];
       
//        id scaleAction = [CCEaseBounceInOut actionWithAction:[ CCScaleBy actionWithDuration:0.8f scale:1.15f]];
//        [punchQLabel runAction:[CCRepeatForever actionWithAction:[CCSequence actions:scaleAction,[scaleAction reverse], nil]]];
        
        
        id playAction  = [CCEaseBounce actionWithAction:[CCMoveBy actionWithDuration:0.6f position:ccp(-size.width * 0.035f,0)]];
        id playSeqAction = [CCSequence actions:playAction,[playAction reverse], nil];
        id playRepeatAction = [CCRepeatForever actionWithAction:playSeqAction];
        [playAgainButton runAction:playRepeatAction];
//        id menuAction = [CCEaseBounce actionWithAction:[CCMoveBy actionWithDuration:0.6f position:ccp(-size.width * 0.03f,0)]];
//        id menuSeqAction = [CCSequence actions:menuAction,[menuAction reverse], nil];
//        [mainMenuButton runAction:[CCRepeatForever actionWithAction:menuSeqAction]];

        
    }
    return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSSet *allTouches = [event allTouches];
//    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
//    CGPoint location = [touch locationInView: [touch view]];
//    location = [[CCDirector sharedDirector] convertToGL:location];
//    
//    //Swipe Detection Part 1
//    CCSprite* gameCenterTemp = [self getChildByTag:320];
//    CGRect gcRect = [gameCenterTemp boundingBox];
//    if(CGRectContainsPoint(gcRect, location)){
//        [[GCHelper sharedInstance] showLeaderboardForCategory:@"PunchQ_StreakScore"];
//    }
}

@end
