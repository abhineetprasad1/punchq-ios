//
//  GamePlayLayer.m
//  PunchGame
//
//  Created by Abhineet Prasad on 17/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "MenuScene.h"
#import "GamePlayLayer.h"


@implementation GamePlayLayer

@synthesize timeLeftBar;
@synthesize scoreLabel;
@synthesize score;
//@synthesize board;

NSMutableArray* array;
int anotherPunchCounter=0;
static int totalMatchCount=0;
//static int roundCategory =0;
int totalPunchCounter = 0;
int points =10;
int bellSoundId;
int continuationCost = 0;
bool isPausePressed = NO;
bool letBuyLife = YES;
int deathCount = 0;
int highestStreaq;
int fontSize;
double elapsedTime;
NSDate* startDate;

-(void) dealloc{
    array = nil;
    scoreLabel = nil;
    [timeLeftbar release];
    [board release];
    [startDate release];
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup:YES];
    
    CCLOG(@"game play layer was deallocated");
    [super dealloc];
}


-(void) initBellAnim{
    
    if([[CCAnimationCache sharedAnimationCache] animationByName:@"bellRing"] == nil){
        
        CCAnimation* bellAnim =[CCAnimation animation];
        [bellAnim addSpriteFrameWithFilename:@"bell3.png"];
        [bellAnim addSpriteFrameWithFilename:@"bell2.png"];
        [bellAnim addSpriteFrameWithFilename:@"bell1.png"];
        [[CCAnimationCache sharedAnimationCache] addAnimation:bellAnim name:@"bellRing"];
    }
}

-(void) playBell{
    bellSoundId=[[SimpleAudioEngine sharedEngine] playEffect:@"Bell Sound.mp3"];
}

-(void) playPunch{
   [[SimpleAudioEngine sharedEngine] playEffect:@"Punch.mp3"];
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

-(float) getTimeDecrementRate{
     
    
    float maxTime = 0.075;
    float minTime = 0.033;
    maxTime = maxTime - ([board totalMatchesCount]/[board roundLimit]) * 0.015;
    minTime = minTime + ([board totalMatchesCount]/[board roundLimit]) * 0.006;
    float roundChangeFactor =((maxTime-minTime)/[board roundLimit]) * [board totalRoundCount];
    //int roundChangeFactor = [board totalRoundCount]/3;
    float temp = maxTime - roundChangeFactor;
    //float temp  = .1 - roundChangeFactor * 0.032;
    if (temp <minTime) {
        return minTime;
    }else {
        return temp;  //replace with a constant UPPER BOUND ON TIME DECREMENT RATE LIMIT
    }
    
}

-(void) resumeGame{
   
    for(int i = 0; i<5;i++){
        if([self getChildByTag:(40 +i)]){
            [[self getChildByTag:(40 +i)] setVisible:YES];
        }
    }
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    isPausePressed = NO;
    [self removeChildByTag:210 cleanup:YES];
    if(board.characterState != kBoardStateBegging){
        [[CCDirector sharedDirector] resume];
    }
}


-(void) quitGame{
    [self resumeGame];
    MenuScene *scene = [MenuScene node];
    [[CCDirector sharedDirector] replaceScene:scene];
}



-(void) showPauseLayer{
    
    [self showPauseLayer:YES];
                                
}

-(void) makeNumbersInvisible{
    for(int i = 0; i<5;i++){
        if([self getChildByTag:(40 +i)]){
            [[self getChildByTag:(40 +i)] setVisible:NO];
        }
    }

}

-(void) showPauseLayer:(BOOL)withInvisibleNumbers{
//    if(board.characterState!=kBoardStateBegging){
//        [board changeState:kBoardStateResume];
//    }
    if (withInvisibleNumbers) {
        [self makeNumbersInvisible];
    }
        
    [[CCDirector sharedDirector] pause];
    CGSize size = [[CCDirector sharedDirector] winSize] ;
    
    CCMenuItemImage* resumeItem = [CCMenuItemImage itemWithNormalImage:@"resumeButton.png" selectedImage:@"resumeButton.png" target:self selector:@selector(resumeGame)];
    CCMenuItem* quitItem = [CCMenuItemImage itemWithNormalImage:@"tiredButton.png" selectedImage:@"tiredButton.png" target:self selector:@selector(quitGame)];
    CCMenu *pauseMenu = [CCMenu menuWithItems:resumeItem,quitItem, nil];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
        [pauseMenu setScaleY:size.height/1024];
        [pauseMenu setScaleX:size.width/768];
        [pauseMenu alignItemsVerticallyWithPadding:45];
        [pauseMenu setPosition:ccp(size.width * 0.22f, size.height * 0.08f)];
    }
    else{
        [pauseMenu alignItemsVerticallyWithPadding:50];
        [pauseMenu setPosition:ccp(size.width/2,size.height * 0.3f)];
    }
    if(![self getChildByTag:210]){
        [self addChild:pauseMenu z:510 tag:210];
    }
}

-(float) calculatePunchQ:(float)forAverage :(int)withTotalPunches{
    
    float punchQ = 80;
    
    if (forAverage > 300) {
        punchQ = 200;
    }
    else if(forAverage <20){
        punchQ = 80;
    }
    else {
        float k = (300 -forAverage)/(forAverage - 20);
        punchQ =  (200 + 80 * k)/(1 + k);
    }
    
    punchQ = punchQ + withTotalPunches * 0.001;
    return punchQ;
    
}

-(void) syncScore{
    
    [[NSUserDefaults standardUserDefaults] setDouble:elapsedTime forKey:@"timetaken"];
    float multiplier  = [[NSUserDefaults standardUserDefaults] integerForKey:@"multiplier"];
    int matches = [[NSUserDefaults standardUserDefaults] integerForKey:@"matches"];
    matches++;
    [[NSUserDefaults standardUserDefaults] setInteger:matches forKey:@"matches"];
    if(multiplier==0){
        multiplier = 0.5;
        [[NSUserDefaults standardUserDefaults] setFloat:multiplier forKey:@"multiplier"];
    }
    
    int totalPunches  = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalPunches"];
    totalPunches= totalPunches + totalPunchCounter;
    [[NSUserDefaults standardUserDefaults] setInteger:totalPunchCounter forKey:@"punches"];
    [[NSUserDefaults standardUserDefaults] setInteger:totalPunches forKey:@"totalPunches"];
    
    float average = totalPunches/matches;
    
    float punchQ = [self calculatePunchQ:average :totalPunches];
    
    [[NSUserDefaults standardUserDefaults] setFloat:average forKey:@"average"];
    
    [[NSUserDefaults standardUserDefaults] setFloat:punchQ forKey:@"punchQ"];
    
    int coins= totalPunchCounter * multiplier;
    [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:@"coins"];
    double totalCoins = [[NSUserDefaults standardUserDefaults] doubleForKey:@"totalCoins"];
    totalCoins = totalCoins + coins;
    [[NSUserDefaults standardUserDefaults] setInteger:totalCoins forKey:@"totalCoins"];
    
    int highestPunches = [[NSUserDefaults standardUserDefaults] integerForKey:@"highestPunches"];
    if(totalPunchCounter > highestPunches){
        [[NSUserDefaults standardUserDefaults] setInteger:totalPunchCounter forKey:@"highestPunches"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)continueGameForCost{
    
    [board changeState:kBoardStateExecuting];
    double money = [[NSUserDefaults standardUserDefaults] doubleForKey:@"totalCoins"];
    money= money- continuationCost;
    [[NSUserDefaults standardUserDefaults] setDouble:money forKey:@"totalCoins"];
    [self removeChildByTag:390 cleanup:YES];
    [self removeChildByTag:395 cleanup:YES];
    //letBuyLife = NO;
    [[CCDirector sharedDirector] resume];
    //[self showPauseLayer:NO];
    
}
-(void)failGame{
    
    for(int i = 0; i<5;i++){
        if([self getChildByTag:(40 +i)]){
            [self removeChildByTag:(40 +i) cleanup:YES];
        }
    }
    [[CCDirector sharedDirector] resume];
    [self syncScore];
    [board changeState:kBoardStateFailed];

}

-(void) failBoardForMistake:(MistakeType)mistake{
    [board changeState:kBoardStateFailing];
    if(mistake !=kTimeMistake){
        //[board changeState:kBoardStateFailing];
        [timeLeftBar stopAllActions];
        CCSprite* numberSprite =  (CCSprite*)[self getChildByTag:(40 + ++anotherPunchCounter)];
        [[SimpleAudioEngine sharedEngine] playEffect:@"bellShot.mp3"];
        [numberSprite runAction:[CCSequence actions:[CCSpawn actionOne:[CCScaleBy actionWithDuration:1.35 scale:5] two:[CCFadeOut actionWithDuration:1.2]],[CCCallFunc actionWithTarget:self selector:@selector(failBoard)],nil]];
    } else if(mistake == kTimeMistake){
        [[SimpleAudioEngine sharedEngine] playEffect:@"bellShot.mp3"];
        [timeBarBorder runAction:[CCSequence actions:[CCBlink actionWithDuration:1.35 blinks:4],[CCCallFunc actionWithTarget:self selector:@selector(failBoard)], nil]];
        
    }else{
        [self failBoard];
    }
        
}
-(void)failBoard{
    double money = [[NSUserDefaults standardUserDefaults] doubleForKey:@"totalCoins"];
    continuationCost = continuationCost + PriceOfLife;
    //limit = 10;
    if(money > continuationCost && letBuyLife){
        //ask if user wants to buy life
        
        [board changeState:kBoardStateBegging];
        [[CCDirector sharedDirector] pause];
        CGSize size = [[CCDirector sharedDirector] winSize] ;
        CCLabelTTF* continueLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Continue for %d coins?",continuationCost] fontName:@"Marker Felt" fontSize:72];
        
        CCMenuItem* yesButton= [CCMenuItemImage itemWithNormalImage:@"tick.png" selectedImage:@"tick.png" target:self selector:@selector(continueGameForCost:)];
        CCMenuItem* noButton = [CCMenuItemImage itemWithNormalImage:@"cross.png" selectedImage:@"cross.png" target:self   selector:@selector(failGame)];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
            [continueLabel setScaleX:size.width/768];
            [continueLabel setScaleY:size.height/1024];
            [yesButton setScaleX:size.width/768];
            [yesButton setScaleY:size.height/1024];
            [noButton setScaleX:size.width/768];
            [noButton setScaleY:size.height/1024];
        }
        //set position
        [continueLabel setPosition:ccp(size.width/2,size.height * 0.45f)];
        continueLabel.horizontalAlignment = kCCTextAlignmentCenter;
        [continueLabel setColor:ccc3(205,102,0)];
        
        CCMenu* continueMenu = [CCMenu menuWithItems:yesButton,noButton, nil];
        [continueMenu alignItemsHorizontallyWithPadding:size.width * .025f];
        [continueMenu setPosition:ccp(size.width * 0.5f, size.height * 0.27f)];
        continueMenu.isTouchEnabled = YES;
        
        
        [self addChild:continueLabel z:400 tag:390];
        [self addChild:continueMenu z:400 tag:395];
        
        
    }else{
        [self failGame];
    }

}



-(void) timeUp{
    [self failBoardForMistake:kTimeMistake];
}


-(void) showBoard {
    if ([board characterState] == kBoardStateInvisible) {
        [[SimpleAudioEngine sharedEngine] stopEffect:bellSoundId];
        [self removeChildByTag:100  cleanup:YES];
        [board changeState:kBoardStateSpawn];
    }
    [timeLeftBar stopAllActions];
    int punchCounter=0;
    totalMatchCount++;
    [board changeState: kBoardSateSpawning];
    
    float multiplyingFactor =0.4f;
    float incrementNumber = 0.2f;
    roundTime = MaxRoundTime;
    //timeDecrementRate = 6;
    
    switch([board getPunchesPerBoardCount]){
        case 2:
            break;
        case 3:
            multiplyingFactor = 0.35f;
            incrementNumber = 0.15f;
            break;
        case 4:
            multiplyingFactor = 0.33f;
            incrementNumber = 0.10f;
            break;
        case 5:
            multiplyingFactor = 0.28f;
            incrementNumber = 0.10f;
        default:
            break;
    }
   
    array = [board getNumberSequenceArray];
    for(int i=0;i<[array count];i++){
        CCSprite* tempSprite=nil;
    
        switch ([[array objectAtIndex:i] intValue]) {
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
        punchCounter++;
        //Position the number sprite
        if(tempSprite != nil){
            [tempSprite setPosition:CGPointMake([board screenSize].width * multiplyingFactor, [board screenSize].height * 0.8f) ];
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
                [tempSprite setScaleX:[board screenSize].width/768];
                [tempSprite setScaleY:[board screenSize].height/1024];
            }
            
            [self addChild:tempSprite z:30 tag: (40 + punchCounter)];
            multiplyingFactor = multiplyingFactor + incrementNumber;
        }
        if(i==0){
            [tempSprite runAction:[CCScaleBy actionWithDuration:0.01f scale:1.35f]];
        }
   
        
    }
    [board changeState:kBoardStateExecuting]; 
    timeDecrementRate = [self getTimeDecrementRate] * MaxRoundTime;
    NSLog(@"time for round is: %.02f",timeDecrementRate);
    [timeBarBorder setVisible:YES];
    CCProgressFromTo* progressTo = [CCProgressFromTo actionWithDuration:timeDecrementRate from:100 to:0];
    id timeCheckAction = [CCSequence actions:progressTo,[CCCallFunc actionWithTarget:self selector:@selector(timeUp)]  , nil];
    if(board.characterState == kBoardStateExecuting){
        [timeLeftBar runAction: timeCheckAction];
    }
    
}


-(void) runBellAnim   {
    
    if([CCAnimationCache sharedAnimationCache]!=nil){ 
        CCAnimation* tempBell = [[CCAnimationCache sharedAnimationCache] animationByName:@"bellRing"];
        
        id bellAction = [CCAnimate actionWithDuration:3
                                            animation:tempBell
                                 restoreOriginalFrame:NO];
        
        id playBellAction =[CCCallFunc actionWithTarget:self selector:@selector(playBell)];
        
        id nextAction =[CCSpawn actions:playBellAction,bellAction, nil];
        id sequenceActions = [CCSequence actions:nextAction,[CCCallFunc actionWithTarget:self selector:@selector(showBoard)], nil];
        
        [[self getChildByTag:100] runAction:sequenceActions];
        
    }
    
    
}
CCSprite* timeBarBorder;

-(id) init{
    
    self = [super init];
    if(self != nil){
        if([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]){
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
        CGSize screenSize = [[CCDirector sharedDirector]winSize];
        self.isTouchEnabled=YES;
        roundTime =MaxRoundTime;
        timeDecrementRate=0.1;
        anotherPunchCounter = 0;
        totalMatchCount = 0;
        score = 0;
        elapsedTime = 0;
        totalPunchCounter=0;
        letBuyLife = YES;
        highestStreaq = [[NSUserDefaults standardUserDefaults] integerForKey:@"highestPunches"];
        //Add Fighter
        fighter =[CCSprite spriteWithFile:@"character_anim1.png"];
        [fighter setPosition:CGPointMake(screenSize.width/2, screenSize.height * 0.35f )];
        
        //Add punch bag
        //punchBag = [CCSprite spriteWithFile:@"punchBag1.png"];
        punchBag = [[PunchBag alloc]initWithFile:@"punchBag1.png"];
        [punchBag setPosition:CGPointMake(screenSize.width/2, screenSize.height * 0.75f)];
        
        //Add pause button
        CCSprite* pauseSprite = [CCSprite spriteWithFile:@"pauseButton.png"];
        
        
        //Add round start bell
        CCSprite* bellSprite =[CCSprite spriteWithFile:@"bell3.png"];
        [bellSprite setPosition:ccp(screenSize.width/2, screenSize.height *0.85f)];
        
        //Add Time Left Bar
        timeBarBorder = [CCSprite spriteWithFile:@"timeBarBorder.png"];
                
       
        
        //Add score
        scoreLabel =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",score] fontName:@"Times New Roman" fontSize:36];
        [scoreLabel setPosition:ccp(screenSize.width * 0.05f,screenSize.height * 0.98f )];
        [scoreLabel setHorizontalAlignment:kCCTextAlignmentRight];
        //Add time label
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
            [fighter setScaleX:screenSize.width/768];
            [fighter setScaleY:screenSize.height/1024];
            [punchBag setScaleX:screenSize.width/768];
            [punchBag setScale:screenSize.height/1024];
       
            [timeBarBorder setScaleX:screenSize.width/768];
            [timeBarBorder setScale:screenSize.height/1024];
            [timeLeftBar setScaleX:screenSize.width/768];
            [timeLeftBar setScale:screenSize.height/1024];
            [scoreLabel setScaleX:screenSize.width/768];
            [scoreLabel setScaleY:screenSize.height/1024];
            [bellSprite setScaleX:screenSize.width/768];
            [bellSprite setScale:screenSize.height/1024];
            [pauseSprite setScaleX:screenSize.width/768];
            [pauseSprite setScale:screenSize.height/1024];
            fontSize = 24;
            
        }
        else{
            fontSize = 32;
        }
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
        [self addChild:scoreLabel];      
        [self addChild:bellSprite z:30 tag:100];
        [self addChild:fighter z:20 tag:20];

        [self addChild:punchBag z:10 tag:10];
        [self addChild:timeBarBorder z:30 tag:31];
        [timeBarBorder setVisible:NO];
        [timeBarBorder addChild:timeLeftBar z:30];
        [self initBellAnim];
        [self initPunchAnim];
        //[self initPunchBagAnim];

        //[punchBag showPunchReaction];
        board = [[Board alloc]init] ;
        [self runBellAnim];
        [self schedule:@selector(tick:) interval:0.1];
        
    }
    
    return self;
}



-(void) tick: (ccTime) dt {
    if([board characterState]==kBoardStateExecuting){
        elapsedTime += dt;
    }
}

-(void) updateLabel{
    [scoreLabel setString:[NSString stringWithFormat:@"%d", totalPunchCounter]];
    CCLabelBMFont* movingLabel;
    if(totalPunchCounter%10 == 0 || (((totalPunchCounter - highestStreaq) == 1) && highestStreaq != 0) ){
        if((totalPunchCounter - highestStreaq) == 1){
            movingLabel = [CCLabelTTF labelWithString:@"New Best StreaQ" fontName:@"Marker Felt" fontSize:fontSize];

        }else{
         movingLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d punches",totalPunchCounter] fontName:@"Marker Felt" fontSize:fontSize];
            [[SimpleAudioEngine sharedEngine]playEffect:@"punchq_milestone.mp3"];
        }
        [movingLabel setPosition:ccp([board screenSize].width * 0.24f, [board screenSize].height*0.75f)];
        [self addChild:movingLabel z:500 tag:500];
        [movingLabel runAction:[CCSpawn actions:[CCMoveBy actionWithDuration:1 position:ccp(0,[board screenSize].height * 0.1f)],[CCFadeOut actionWithDuration:1], nil]];
    }
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGSize screenSize = [[CCDirector sharedDirector]winSize];
    UITouch* touch = [touches anyObject];
    CGPoint loc = [touch locationInView:[touch view]];
    loc =[[CCDirector sharedDirector] convertToGL:loc];
    //PunchBag* punchSprite = (PunchBag*)[self getChildByTag:10];
    CCSprite* pause = (CCSprite*)[self getChildByTag:5];
    
    //Retrieve the punchBag animation and create action
//    id tempPunchAction;
//    if([CCAnimationCache sharedAnimationCache]!=nil){
//        CCAnimation* tempPunchAnim = [[CCAnimationCache sharedAnimationCache] animationByName:@"punchBag"];
//        tempPunchAction = [CCAnimate actionWithDuration:0.4f
//                                                 animation: tempPunchAnim
//                                      restoreOriginalFrame:NO];
//    [punchSprite showPunchReaction];
 //   [punchBag showPunchReaction];
 //   }
   
    //Check if pause button is pressed
    CGRect pauseButtonRect = CGRectMake((pause.position.x-(pause.contentSize.width)/2), (pause.position.y-(pause.contentSize.height)/2), (pause.contentSize.width), (pause.contentSize.height));
    if (CGRectContainsPoint(pauseButtonRect, loc) && ![[CCDirector sharedDirector] isPaused]) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
        isPausePressed = YES;
        [self showPauseLayer];
        
    }
    
    //React to touches only after board has spawned 
    if([board characterState] == kBoardStateExecuting)
    {
        [fighter stopAllActions];
        //IF RIGHT PUNCH
        if((loc.x > screenSize.width/2) && ![[CCDirector sharedDirector] isPaused]) {
            
            
            //Run Right Punch Animation    
            if([CCAnimationCache sharedAnimationCache]!=nil){ 
                CCAnimation* temp = [[CCAnimationCache sharedAnimationCache] animationByName:@"rightPunch"];
                
                id rightPunchAction = [CCAnimate actionWithDuration:0.4f
                                                          animation:temp
                                               restoreOriginalFrame:NO];
                id rightPunchReverse =[rightPunchAction reverse];
                
                [fighter runAction:rightPunchAction];
                //[punchSprite runAction:tempPunchAction];
                [punchBag showPunchReaction];
                [[SimpleAudioEngine sharedEngine] playEffect:@"Punch.mp3"];
                [fighter runAction:rightPunchReverse];   
            }
            //Check if correct
            // NSMutableArray* tempArray= [board getNumberSequenceArray];
            if([[array objectAtIndex:[board boardNumberIndex]]intValue] == 2){
                board.boardNumberIndex = board.boardNumberIndex +1;
                //[[self getChildByTag:(40 + punchCounter-1)] cleanup];
                [self removeChildByTag:(40 + ++anotherPunchCounter) cleanup:YES];
                if(([board boardNumberIndex])==[board getPunchesPerBoardCount]){
                    anotherPunchCounter=0;
                    [board changeState:kBoardStateExecuted];
                    [self showBoard];
                }
                else {
                    CCSprite* zoom = [self getChildByTag:(40 + anotherPunchCounter + 1)];
                    [zoom runAction:[CCScaleBy actionWithDuration:0.01f scale:1.35f]];
                }
                score = score + points;
                totalPunchCounter++;
                [self updateLabel];
                
            }
            else {
                [self failBoardForMistake:kLeftMistake];
            }
            
            CCLOG(@"did right punch animation");
        } else if(loc.x < screenSize.width/2 && ![[CCDirector sharedDirector] isPaused]) {
            //RUN LEFT PUNCH ANIMATION
            if ([CCAnimationCache sharedAnimationCache]!=nil) {
                CCAnimation* lTemp = [[CCAnimationCache sharedAnimationCache] animationByName:@"leftPunch"];
                id leftPunchAction =[CCAnimate actionWithDuration:0.4f
                                                        animation:lTemp restoreOriginalFrame:NO];
                id leftPunchReverse =[leftPunchAction reverse];
                [fighter runAction:leftPunchAction];
                [[SimpleAudioEngine sharedEngine]playEffect:@"Punch.mp3"];
                //[punchSprite runAction:tempPunchAction];
                [punchBag showPunchReaction];
                [fighter runAction:leftPunchReverse];
            }
            //CHECK IF CORRECT
            if([[array objectAtIndex:[board boardNumberIndex]]intValue] == 1){
                board.boardNumberIndex = board.boardNumberIndex +1;
                //[[[self parent]getChildByTag:(40 + punchCounter-1)]cleanup];
                [self removeChildByTag:(40 + ++anotherPunchCounter) cleanup:YES];
                if(([board boardNumberIndex])==[board getPunchesPerBoardCount]){
                    anotherPunchCounter=0;
                    [board changeState:kBoardStateExecuted];
                    [self showBoard];
                }
                else {
                    CCSprite* zoom = [self getChildByTag:(40 + anotherPunchCounter + 1)];
                    [zoom runAction:[CCScaleBy actionWithDuration:0.01f scale:1.35f]];
                }
                score = score + points; 
                totalPunchCounter++;
                [self updateLabel];
                
            }
            else {
                [self failBoardForMistake:kRightMistake];
            }
            CCLOG(@"did left punch animation");
        }
    }
    
    
       // [punchSprite runAction:tempPunchAction];
    
        
    
}

@end
