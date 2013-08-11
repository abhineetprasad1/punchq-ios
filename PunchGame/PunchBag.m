//
//  PunchBag.m
//  PunchGame
//
//  Created by Abhineet Prasad on 16/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//

#import "PunchBag.h"

@implementation PunchBag
//@synthesize objImage;

-(id)init{
    if(self = [super init])
    [self initialize];
    
    return self;
}

-(id) initWithFile:(NSString*)_fileName{
    if(self = [super initWithFile:_fileName]){
        //[super init];
        //objImage = [CCSprite spriteWithFile:@"punchBag1.png"];
        gameObjectType = kPunchBagType;
        [self initPunchBagAnim];
        //[self addChild:objImage];
    }
    return self;
}

-(void) initialize{
    gameObjectType = kPunchBagType;
    [self initPunchBagAnim];
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

-(void) scaleForPhone{
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
       // [objImage setScaleX:screenSize.width/768];
       // [objImage setScaleY:screenSize.height/1024];
    }
}

-(void) showPunchReaction{
    if([CCAnimationCache sharedAnimationCache]!=nil){
        CCAnimation* tempPunchAnim = [[CCAnimationCache sharedAnimationCache] animationByName:@"punchBag"];
        id tempPunchAction = [CCAnimate actionWithDuration:0.4f
                                              animation: tempPunchAnim
                                   restoreOriginalFrame:NO];
        [self runAction:tempPunchAction];
    }
}


@end
