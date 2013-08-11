//
//  PunchBag.h
//  PunchGame
//
//  Created by Abhineet Prasad on 16/02/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//
#import "Foundation/Foundation.h"
#import "cocos2d.h"
#import "GameObject.h"

@interface PunchBag : GameObject {

  //  CCSprite* objImage;
}
//@property(nonatomic,retain)CCSprite* objImage;
-(void) showPunchReaction;
-(id) initWithFile:(NSString*)_fileName;
@end
