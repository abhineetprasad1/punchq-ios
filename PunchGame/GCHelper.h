//
//  GCHelper.h
//  PunchGame
//
//  Created by Abhineet Prasad on 20/03/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//
#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>

@interface GCHelper : NSObject {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    UIViewController *myViewController;
}

@property (assign, readonly) BOOL gameCenterAvailable;

+ (GCHelper *)sharedInstance;
- (void)authenticateLocalUser;
- (void)showLeaderboardForCategory:(NSString *)category;
- (void)reportScore:(int64_t)score forCategory:(NSString *)category;
- (void)reportQScore:(float)score forCategory:(NSString *)category;

@end
