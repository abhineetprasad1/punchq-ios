//
//  GCHelper.m
//  PunchGame
//
//  Created by Abhineet Prasad on 20/03/13.
//  Copyright (c) 2013 abhineetpr@gmail.com. All rights reserved.
//
#import "cocos2d.h"
#import "GCHelper.h"

@implementation GCHelper

@synthesize gameCenterAvailable;


#pragma mark Initialization

static GCHelper *sharedHelper = nil;
+ (GCHelper *) sharedInstance {
    if (!sharedHelper) {
        sharedHelper = [[GCHelper alloc] init];
    }
    return sharedHelper;
}

- (BOOL)isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

- (id)init {
    if ((self = [super init])) {
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc =
            [NSNotificationCenter defaultCenter];
            [nc addObserver:self
                   selector:@selector(authenticationChanged)
                       name:GKPlayerAuthenticationDidChangeNotificationName
                     object:nil];
        }
    }
    return self;
}

- (void)authenticationChanged {
    
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = TRUE;
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = FALSE;
    }
}
- (void)authenticateLocalUser {
    
    if (!gameCenterAvailable) return;
    
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
    } else {
        NSLog(@"Already authenticated!");
    }
}

- (void)showLeaderboardForCategory:(NSString *)category
{
 
    // Only execute if OS supports Game Center & player is logged in
  
    if (gameCenterAvailable)
    {
    
        // Create leaderboard view w/ default Game Center style
   
        GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
  
        // If view controller was successfully created...
 
        if (leaderboardController != nil)
        {
       
            // Leaderboard config
     
            leaderboardController.leaderboardDelegate = self;   // The leaderboard view controller will send messages to this object
       
            leaderboardController.category = category;  // Set category here
         
            leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;    // GKLeaderboardTimeScopeToday, GKLeaderboardTimeScopeWeek, GKLeaderboardTimeScopeAllTime
       
            
      
            // Create an additional UIViewController to attach the GKLeaderboardViewController to
         
            myViewController = [[UIViewController alloc] init];
       
           
        
            // Add the temporary UIViewController to the main OpenGL view
       
            [[[CCDirector sharedDirector] openGLView] addSubview:myViewController.view];
       
            
       
            // Tell UIViewController to present the leaderboard
       
            [myViewController presentModalViewController:leaderboardController animated:YES];
     
        }
   
    }

}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	[myViewController dismissModalViewControllerAnimated:YES];
	[myViewController release];
}

- (void)reportScore:(int64_t)score forCategory:(NSString *)category
{
	// Only execute if OS supports Game Center & player is logged in
	if (gameCenterAvailable)
	{
		// Create score object
		GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
		
		// Set the score value
		scoreReporter.value = score;
		
		// Try to send
		[scoreReporter reportScoreWithCompletionHandler:nil];
    }
}

- (void)reportQScore:(float)score forCategory:(NSString *)category
{
	// Only execute if OS supports Game Center & player is logged in
	if (gameCenterAvailable)
	{
		// Create score object
		GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
		
		// Set the score value
		scoreReporter.value = score;
		
		// Try to send
		[scoreReporter reportScoreWithCompletionHandler:nil];
    }
}


@end
