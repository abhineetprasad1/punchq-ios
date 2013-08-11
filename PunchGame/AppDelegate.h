//
//  AppDelegate.h
//  PunchGame
//
//  Created by Abhineet Prasad on 16/02/13.
//  Copyright abhineetpr@gmail.com 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookScorer.h"
#import "MenuScene.h"
#import "cocos2d.h"
#import "GCHelper.h"
#import "ObjectivesManager.h"


@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
