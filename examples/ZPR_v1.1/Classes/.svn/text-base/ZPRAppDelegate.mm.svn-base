//
//  ZPRAppDelegate.m
//  ZPR
//
//  Created by Neo01 on 5/27/11.
//  Copyright 2011 Break Media. All rights reserved.
//

#import "ZPRAppDelegate.h"
#import "ZPRViewController.h"

#import <GameKit/GameKit.h>

// Common App
#import "app.h"
#import "FlurryAnalytics.h"
#ifdef OF_EMBEDED
	#import "OpenFeint/OpenFeint.h"
	#import "OpenFeint/OFControllerLoaderObjC.h"
	#import "OpenFeint/OFAnnouncement.h"
	#import "OpenFeint/OFBadgeView.h"

	#import "OpenFeint/OFCurrentUser.h"

	#import "OpenFeint/OFBadgeView.h"
	#import "OpenFeint/OFForumPost.h"
	#import "OpenFeint/OFDependencies.h"

	#import "OpenFeint/OFHighScoreService.h"

	#import "OpenFeint/OpenFeint+UserOptions.h"

	#import "OpenFeint/OpenFeint+NSNotification.h"
	#import "OpenFeint/UIButton+OpenFeint.h"
	#import "OpenFeint/OpenFeint+Private.h"
	#import "OpenFeint/OFSettings.h"
	#import "OpenFeint/OFDependencies.h"

	#import "GameNews.h"
#endif
#import "GameTitle.h"
#import "GameState.h"
#import "GameSection.h"
#import "GameData.h"
#import "GameOption.h"

#import "Appirater.h"
#import "TapjoyConnect.h"
#import <CommonCrypto/CommonDigest.h>

#import "CheckNetwork.h"

#import "Canvas2D.h"

#ifdef __IN_APP_PURCHASE__
#import "GameStore.h"
#import "GamePlay.h"
#endif


#define ENABLE_ADMOB_ADS		0
//replacing with your app's iTunes id (provided by Apple):
#define APPLE_ITUNES_ID			@"459924425"

#define ENABLE_TJC_ADS			1
#define TJC_CONNECT_ONCE		1
#define TJC_CONNECT_ID			@"68c4ebc3-c4c0-4bc9-9d8c-5459e01b5666"
#define TJC_CONNECT_KEY			@"07oWx0IEXQ82s03dJpiM"


#ifdef OF_EMBEDED
static NSArray		*appAnnouncementList = nil;
static NSArray		*devAnnouncementList = nil;

//@interface ZPRAppDelegate()
//- (void)setAnnouncementType:(AnnouncementType)requestedType;
//- (void)announcementIndexChange:(NSInteger)delta;
//- (void)postIndexChange:(NSInteger)delta;
//- (void)refreshStatusText:(OFAnnouncement*)announcement;
//@end
#endif

NSString *kScalingModeKey	= @"scalingMode";
NSString *kControlModeKey	= @"controlMode";
NSString *kBackgroundColorKey	= @"backgroundColor";

ZPRAppDelegate* app;

#ifdef FACEBOOK_TWITTER
static NSString* kAppId = @"233433116720395";//@"210849718975311";
#endif

@implementation ZPRAppDelegate

@synthesize window;
@synthesize viewController;


#ifdef OF_EMBEDED
@synthesize topNews;
//@synthesize topNewsTitle;
@synthesize nNews;
#endif
#ifdef ENABLE_MOVIE
@synthesize moviePlayer;
#endif

@synthesize bLockScreenOrient;

@synthesize showCheckGC;
@synthesize hasAccount;

#ifdef FACEBOOK_TWITTER
@synthesize facebook;
@synthesize userPermissions;
#endif

#ifdef __IN_APP_PURCHASE__
@synthesize iap;
@synthesize purchaseCounts;
#endif

#ifdef OF_EMBEDED
- (void)InitOpenFeint
{
	NSDictionary* settings = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight], OpenFeintSettingDashboardOrientation, 
							  @"ZPR", OpenFeintSettingShortDisplayName, 
							  [NSNumber numberWithBool:YES], OpenFeintSettingEnablePushNotifications, 
							  [NSNumber numberWithBool:NO], OpenFeintSettingDisableUserGeneratedContent, 
  							  [NSNumber numberWithBool:YES], OpenFeintSettingAlwaysAskForApprovalInDebug, 
//							  [NSNumber numberWithBool:YES], OpenFeintSettingRequireOnlineStatus, 
#ifdef LITE_VERSION
							  [NSNumber numberWithBool:NO], OpenFeintSettingPromptUserForLogin, 
#endif
#ifdef ENABLE_OFGAMECENTER
							  [NSNumber numberWithBool:YES], OpenFeintSettingGameCenterEnabled, 
#endif
#ifdef DEBUG_MY_OF
                              [NSNumber numberWithInt:OFDevelopmentMode_DEVELOPMENT], OpenFeintSettingDevelopmentMode,
#else
                              [NSNumber numberWithInt:OFDevelopmentMode_RELEASE], OpenFeintSettingDevelopmentMode,
#endif
							  window, OpenFeintSettingPresentationWindow, 
#ifdef DEBUG
							  [NSNumber numberWithInt:OFDevelopmentMode_DEVELOPMENT], OpenFeintSettingDevelopmentMode,
#else
							  [NSNumber numberWithInt:OFDevelopmentMode_RELEASE], OpenFeintSettingDevelopmentMode,
#endif
							  nil
							  ];
	
	OFDelegatesContainer* delegates = [OFDelegatesContainer containerWithOpenFeintDelegate:self
																	  andChallengeDelegate:nil
																   andNotificationDelegate:self];
	
	[OpenFeint initializeWithProductKey:@"A20VsYCydO8Ju79F2JIihQ"
							  andSecret:@"x9PHM5Ycr8acAf1d4GdaMWX5j98wp524R9tKUPy8U0"
						 andDisplayName:@"Zombie Parkour Runner"
							andSettings:settings
						   andDelegates:delegates];
}
#endif

void uncaughtExceptionHandler(NSException *exception) {
#if DEBUG
    NSLog(@"Exception: address@@hidden",exception);
#else
    [FlurryAnalytics logError:@"Uncaught" message:@"Crash!" exception:exception];
#endif
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef FACEBOOK_TWITTER
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter addObserver:self selector:@selector(facebookLogout:) name:@"LOGOUT" object:nil];
#endif
	
	NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
	[FlurryAnalytics startSession:@"HHXY1IM15JVN6QYWSU84"];
	[Appirater appLaunched:YES];
	
	app = (ZPRAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [self.window addSubview:self.viewController.view];
//	appInit();
#ifdef __IN_APP_PURCHASE__
    iap = [[ZPR_IAP alloc] init];
    [iap requestProducts];
    purchaseCounts = [[PurchaseCounts alloc]init];
#endif
#if (ENABLE_TJC_ADS&&TJC_CONNECT_ONCE)
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if (![userDefaults boolForKey:@"TapjoyConnect"]) 
	{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tjcConnectSuccess:) name:TJC_CONNECT_SUCCESS object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tjcConnectFail:) name:TJC_CONNECT_FAILED object:nil];

		[TapjoyConnect requestTapjoyConnect:TJC_CONNECT_ID secretKey:TJC_CONNECT_KEY];
	}
#else
	[TapjoyConnect requestTapjoyConnect:TJC_CONNECT_ID secretKey:TJC_CONNECT_KEY];
#endif
	
#if ENABLE_ADMOB_ADS
	[self performSelectorInBackground:@selector(reportAppOpenToAdMob) withObject:nil];
#endif
    
#ifdef __IPHONE_4_1
	gameCenterCommonDelegate = [[GameCenterCommonDelegate alloc] init];
#endif
	
#ifdef OF_EMBEDED
	[self InitOpenFeint];
	[OpenFeint respondToApplicationLaunchOptions:launchOptions];
#endif
    
#ifdef _AD_ADCOLONY_EMBEDDED_
    if (![iap hasUnlockComicInLocalStore]) {
       [AdColony initAdColonyWithDelegate:self];
    }
#endif
    
#ifdef FACEBOOK_TWITTER
	facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
#endif
    
//	NSLog(@"===%d", [CheckNetwork isExistenceNetwork]);
	
	if([self isGameCenterAvailable])
	{
///		[self authenticateLocalUser];///
	}
	else
	{
		UIAlertView* alert= [[[UIAlertView alloc] initWithTitle: @"Game Center Support Required!" 
														message: @"The current device does not support Game Center, which this sample requires." 
													   delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL] autorelease];
		[alert show];
	}
    
#ifdef __IN_APP_PURCHASE__
//    if ([app.iap hasLocalStore] == NO)
//    {
//        iap.restoreSuccessCallback = GameStoreRestoreSuccessHandler;
//        iap.restoreFailedCallback = GameStoreRestoreFailedHandler;
//        [app.iap restoreLocalStore];
//       
//    }
    updateItemCounts();
#endif
    
    appInit();
    
    return YES;
}

//- (BOOL)showCustomOpenFeintApprovalScreen
//{
//	return true;
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self.viewController stopAnimation];
	GameSuspend();
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	GameResume();
    [self.viewController startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	NSString *tmpString = [NSString stringWithFormat:@"Level:%d", ActiveLevel, nil];
	[FlurryAnalytics logEvent:tmpString timed:YES];
    [self.viewController stopAnimation];
	appQuit();
#ifdef OF_EMBEDED
	[OpenFeint shutdown];
#endif
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	[self.viewController stopAnimation];
	GameSuspend();
	
#ifdef OF_EMBEDED
    if (isUpdate) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:newsNoti+1];
    }else{
	    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:newsNoti];
    }
#endif
	
///	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:[OFCurrentUser OpenFeintBadgeCount]];//	application.applicationIconBadgeNumber = 3;
    // Handle any background procedures not related to animation here.
//	NSLog(@"Enter Background");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	GameResume();
    
#ifdef OF_EMBEDED
    if (isUpdate) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:newsNoti+1];
    }else{
	    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:newsNoti];
    }
#endif
    
    
    [self.viewController startAnimation];

	[Appirater appEnteredForeground:YES];
    
    GameNewsCheckManually();
    GameNewsCheck();
    GameNewsCheck();
    GameNewsCheckManually();
	//Handle any foreground procedures not related to animation here.
//	NSLog(@"Enter Foreground");
}

#ifdef FACEBOOK_TWITTER
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.facebook handleOpenURL:url];
}
#endif

- (void)dealloc
{
#ifdef __IN_APP_PURCHASE__
    [iap release];
    [purchaseCounts release];
#endif
#ifdef OF_EMBEDED
#ifdef __IPHONE_4_1
	OFSafeRelease(gameCenterCommonDelegate);
#endif
#endif
    [viewController release];
    [window release];
    [super dealloc];
}


#pragma mark -
#pragma mark Game Center View Controllers

- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self.viewController dismissModalViewControllerAnimated:YES];
}

- (void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	[self.viewController dismissModalViewControllerAnimated:YES];
}


#pragma -
#pragma Functions for the lite version
- (BOOL) isPad
{
    if ([[UIDevice currentDevice].model rangeOfString:@"iPad"].location != NSNotFound)
    {
#ifdef DEBUG
        NSLog(@"This is an iPad!");
#endif
        return YES;
    }
    else
    {
#ifdef DEBUG
        NSLog(@"This is an iPhone/iPod touch!");
#endif
        return NO;
    }
}

- (void) openLink:(NSString *)theUrl
{
    NSString *_url = [NSString stringWithString:theUrl];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}


#pragma -
#pragma mark Game Center Delegates

- (BOOL) isGameCenterAvailable
{
	// check for presence of GKLocalPlayer API
	Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
	
	// check if the device is running iOS 4.1 or later
	NSString *reqSysVer = @"4.1";
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//	NSString *currSysMod = [[UIDevice currentDevice] localizedModel];
//	NSLog(@"%@", currSysMod);
	BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
	
	return (gcClass && osVersionSupported);
}

- (void) callDelegate:(SEL)selector withArg:(id)arg error:(NSError*)err
{
	assert([NSThread isMainThread]);
	if ([app respondsToSelector: selector])
	{
		if (arg != NULL)
		{
			[app performSelector:selector withObject:arg withObject:err];
		}
		else
		{
			[app performSelector:selector withObject:err];
		}
	}
	else
	{
		NSLog(@"Missed Method");
	}
}

- (void) callDelegateOnMainThread: (SEL) selector withArg: (id) arg error: (NSError*) err
{
	dispatch_async(dispatch_get_main_queue(), ^(void)
				   {
					   [self callDelegate: selector withArg: arg error: err];
				   });
}

- (BOOL) authenticateLocalUser
{
	if ([GKLocalPlayer localPlayer].authenticated == NO)
	{
		[[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) 
		 {
			 [self callDelegateOnMainThread: @selector(processGameCenterAuth:) withArg: NULL error: error];
		 }];
		return NO;	///
	}
	return YES;		///
}

- (void) processGameCenterAuth: (NSError*) error
{
	if (error == NULL)
	{
//		[self.gameCenterManager reloadHighScoresForCategory: self.currentLeaderBoard];
	}
	else if (showCheckGC)	//else
	{
		showCheckGC = false;
//		UIAlertView* alert= [[[UIAlertView alloc] initWithTitle: @"Game Center Account Required" 
//									message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]] 
//									delegate: self cancelButtonTitle: @"Try Again..." otherButtonTitles: NULL] autorelease];
		UIAlertView* alert= [[[UIAlertView alloc] initWithTitle: @"Game Center Disabled" 
								message: [NSString stringWithString: @"Sign in with the Game Center application to enable."] 
								delegate: self cancelButtonTitle: @"OK" otherButtonTitles: NULL] autorelease];
		[alert show];
	}
}


- (void) registerForAuthenticationNotification
{
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self
		   selector:@selector(authenticationChanged)
			   name:GKPlayerAuthenticationDidChangeNotificationName
			 object:nil];
}

- (void) authenticationChanged
{
	if ([GKLocalPlayer localPlayer].isAuthenticated)
	{
		// Insert code here to handle a successful authentication.
	}
	else
	{
		// Insert code here to clean up any outstanding Game Center-related classes.
	}
}

- (void) reportScore: (int64_t) score forCategory: (NSString*) category
{
	GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
	scoreReporter.value = score;
	
	[scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
		if (error != nil)
		{
			NSLog(@"Commit Score Failed!");
		} else {
			NSLog(@"Commit Score Success!");
		}
		
	}];
}

- (void) retrieveTopTenScores
{
	GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] init];
	if (leaderboardRequest != nil)
	{
		leaderboardRequest.playerScope = GKLeaderboardPlayerScopeGlobal;
		leaderboardRequest.timeScope = GKLeaderboardTimeScopeAllTime;
		leaderboardRequest.range = NSMakeRange(1,10);
		leaderboardRequest.category = @"TS_LB";
		[leaderboardRequest loadScoresWithCompletionHandler: ^(NSArray *scores, NSError *error) {
			if (error != nil){
				// handle the error.
				NSLog(@"Download Fail!");
			}
			if (scores != nil){
				// process the score information.
				NSLog(@"Download Success!");
				NSArray *tempScore = [NSArray arrayWithArray:leaderboardRequest.scores];
				for (GKScore *obj in tempScore) {
				}
			}
		}];
	}
}

//检索已登录用户好友列表
- (void) retrieveFriends
{
	GKLocalPlayer *lp = [GKLocalPlayer localPlayer];
	if (lp.authenticated)
	{
		[lp loadFriendsWithCompletionHandler:^(NSArray *friends, NSError *error) {
			if (error == nil)
			{
//				[self loadPlayerData:friends];
			}
			else
			{
				// report an error to the user.
			}
			
		}];
	}
}

- (void) loadPlayerData: (NSArray *) identifiers
{
	[GKPlayer loadPlayersForIdentifiers:identifiers withCompletionHandler:^(NSArray *players, NSError *error) {
		if (error != nil)
		{
			// Handle the error.
		}
		if (players != nil)
		{
			NSLog(@"Get Friend List!");
//			GKPlayer *friend1 = [players objectAtIndex:0];
		}
	}];
}
- (void) reportAchievementIdentifier: (NSString*) identifier percentComplete: (float) percent
{
	GKAchievement *achievement = [[[GKAchievement alloc] initWithIdentifier: identifier] autorelease];
	if (achievement)
	{
		achievement.percentComplete = percent;
		[achievement reportAchievementWithCompletionHandler:^(NSError *error)
		{
			if (error != nil)
			{
				NSLog(@"Report Achievement Fail, Error: \n %@",error);
			}else {
				//对用户提示,已经完成XX%进度
			}
		}];
	}
}
- (void) loadAchievements
{
	NSMutableDictionary *achievementDictionary = [[NSMutableDictionary alloc] init];
	[GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements,NSError *error)
	{
		if (error == nil) {
			NSArray *tempArray = [NSArray arrayWithArray:achievements];
			for (GKAchievement *tempAchievement in tempArray) {
				[achievementDictionary setObject:tempAchievement forKey:tempAchievement.identifier];
			}
		}
	}];
}
- (GKAchievement*) getAchievementForIdentifier: (NSString*) identifier
{
	NSMutableDictionary *achievementDictionary = [[NSMutableDictionary alloc] init];
	GKAchievement *achievement = [achievementDictionary objectForKey:identifier];
	if (achievement == nil)
	{
		achievement = [[[GKAchievement alloc] initWithIdentifier:identifier] autorelease];
		[achievementDictionary setObject:achievement forKey:achievement.identifier];
	}
	return [[achievement retain] autorelease];
}
- (NSArray*)retrieveAchievmentMetadata
{
	//读取成就的描述
	[GKAchievementDescription loadAchievementDescriptionsWithCompletionHandler:
	 ^(NSArray *descriptions, NSError *error) {
		 if (error != nil)
		 {
			 NSLog(@"Read Achievement Profile Error!");
		 }
		 if (descriptions != nil)
		 {
			 // use the achievement descriptions.
			 for (GKAchievementDescription *achDescription in descriptions) 
			 {
				 /*
				  [achDescription loadImageWithCompletionHandler:^(UIImage *image, NSError *error) {
				  if (error == nil)
				  {
				  // use the loaded image. The image property is also populated with the same image.
				  NSLog(@"Success");
				  UIImage *aImage = image;
				  UIImageView *aView = [[UIImageView alloc] initWithImage:aImage];
				  aView.frame = CGRectMake(50, 50, 200, 200);
				  aView.backgroundColor = [UIColor clearColor];
				  [[[CCDirector sharedDirector] openGLView] addSubview:aView];
				  }else {
				  NSLog(@"Faile");
				  }
				  }];
				  */
			 }
		 }
	 }];
	return nil;
}

#pragma mark -
#pragma mark Movie

#ifdef ENABLE_MOVIE
//mp4
- (void) initAndPlayMovie:(NSURL *)movieURL
{
	// Initialize a movie player object with the specified URL
	MPMoviePlayerController *mp = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
	if (mp)
	{
		// save the movie player object
		self.moviePlayer = mp;
		[mp release];
		
		// Apply the user specified settings to the movie player object
		
		moviePlayer.scalingMode=MPMovieScalingModeFill;
		[moviePlayer setControlStyle:MPMovieControlStyleNone];
		
		moviePlayer.view.transform = CGAffineTransformMakeRotation(M_PI/2.0);
		[[moviePlayer view] setFrame:[self.viewController.view bounds]];
		
		// Play the movie!
		[self.moviePlayer play];
	}
}

- (void) PlayMp4
{	
	NSURL *movieURL = nil;
	NSBundle *bundle = [NSBundle mainBundle];
	if (bundle) 
	{
		NSString *moviePath = [bundle pathForResource:@"video_start" ofType:@"mp4"];
		if (moviePath)
		{
			movieURL = [NSURL fileURLWithPath:moviePath];
		}
	}
    	
	// initialize a new MPMoviePlayerController object with the specified URL, and
	// play the movie
	[self initAndPlayMovie:movieURL];
	
	// now display an overlay window with some controls above the playing movie

	[viewController.view addSubview:moviePlayer.view];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackDidFinish) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];

}
- (void) playbackDidFinish
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];  
	[self.moviePlayer stop];
	moviePlayer.initialPlaybackTime = -1.0;
	[moviePlayer release];
	moviePlayer = nil;
	g_nGameState = GAME_STATE_GAME_PLAY;
	SwitchGameState();
}
#endif

#pragma mark -

#pragma mark OpenFeint

- (BOOL)checkLoginGameCenter
{
	if ([self isGameCenterAvailable])
	{
		return [self authenticateLocalUser];
	}
	else
	{
		return NO;
	}
}

- (void)dashboardWillAppear
{
//	NSLog(@"dashboardWillAppear");
}

- (void)dashboardDidAppear
{
//	NSLog(@"dashboardDidAppear");
}

- (void)dashboardWillDisappear
{
}

- (void)dashboardDidDisappear
{
}

- (void)offlineUserLoggedIn:(NSString*)userId
{
	NSLog(@"User logged in, but OFFLINE. UserId: %@", userId);
	if (userId > 0)
	{
		hasAccount = 1;
	}
	else
	{
		hasAccount = 0;
	}
}

- (void)userLoggedIn:(NSString*)userId
{
	NSLog(@"User logged in. UserId: %@", userId);
}

- (BOOL)showCustomOpenFeintApprovalScreen
{
	return NO;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
#ifdef OF_EMBEDED
	[OpenFeint applicationDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
#endif
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
#ifdef OF_EMBEDED
	[OpenFeint applicationDidFailToRegisterForRemoteNotifications];
#endif
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
#ifdef OF_EMBEDED
	[OpenFeint applicationDidReceiveRemoteNotification:userInfo];
#endif
}

//- (BOOL)isOpenFeintNotificationAllowed:(OFNotificationData*)notificationData
//{
//	if (notificationData.notificationCategory == kNotificationCategoryAchievement &&
//		notificationData.notificationType == kNotificationTypeSuccess)
//	{
//		return NO;
//	}
//	
//	return YES;
//}
//
//- (void)handleDisallowedNotification:(OFNotificationData*)notificationData
//{
//	NSString* message = @"We're overriding the achievement unlocked notification. Check out SampleOFNotificationDelegate.mm!";
//	[[[[UIAlertView alloc] initWithTitle:@"Achievement Unlocked!" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease] show];
//}
//
//- (void)notificationWillShow:(OFNotificationData*)notificationData
//{
//	OFLog(@"An OpenFeint notification is about to pop-up: %@", notificationData.notificationText);
//}

#pragma mark OpenFeint Leaderboard
- (void)ofSubmitScore:(NSString*)identifier withScore:(NSInteger)score
{
#ifdef OF_EMBEDED
	[OFHighScoreService setHighScore:score forLeaderboard:identifier 
		onSuccessInvocation:[OFInvocation invocationForTarget:self selector:@selector(onSetHighScoreSuccess:)] 
		onFailureInvocation:[OFInvocation invocationForTarget:self selector:@selector(onSetHighScoreFailure:)]];
#endif
}

- (void)onSetHighScoreSuccess
{
}

- (void)onSetHighScoreFailure
{
}

#pragma mark OpenFeint Announcements
#ifdef OF_EMBEDED
///////////////////////////////////////////////////////////////////
// traverse announcements and posts
///////////////////////////////////////////////////////////////////

- (void)setAnnouncementType:(AnnouncementType)requestedType
{
	currentAnnouncementType = requestedType;
	
	switch (currentAnnouncementType)
	{
		case AnnouncementType_App:{
			curAnnouncementList = appAnnouncementList;
		}	break;
		case AnnouncementType_Dev:{
			curAnnouncementList = devAnnouncementList;
		}	break;
		default:
			curAnnouncementList = nil;
			break;
	}
	
	announcementIndex = 0;
	[self announcementIndexChange:0];
}

- (void)announcementIndexChange:(NSInteger)delta
{
	announcementIndex += delta;
	if (announcementIndex < 0)
	{
		announcementIndex = 0;
	}
	postIndex = 0;
	
	[self postIndexChange:0];
}


- (void)postIndexChange: (NSInteger) delta
{
	NSInteger announcementCount = [curAnnouncementList count];
	
	// Set some display values using defaults where not yet known.
	//	announcementCountText.text = [NSString stringWithFormat: @"%d", announcementCount];
	//	announcementIndexText.text =  @"0";
	//	announcementText.text = @"";
	//	postCountText.text = @"0";
	//	postIndexText.text = @"0";
	//	postText.text = @"";
	
	if (announcementCount > 0)
	{
		if ((announcementIndex < 0) || (announcementCount <= announcementIndex)){
			announcementIndex = 0;
		}
//		announcementIndexText.text = [NSString stringWithFormat: @"%d", announcementIndex + 1];
		
		postIndex += delta;
		if (postIndex < 0)
		{
			postIndex = 0;
		}
		
		OFAnnouncement *curAnnouncement = (OFAnnouncement*)[curAnnouncementList objectAtIndex:announcementIndex];
		[curAnnouncement retain];
		
		topNews = [NSString stringWithString:[curAnnouncement body]];
		nNews = 1;
		
//		announcementText.text = [NSString stringWithString:curAnnouncement.body];
		OFRequestHandle* handle = [curAnnouncement getPosts];
//		[self refreshStatusText: curAnnouncement];
		[curAnnouncement release];
		
		if (!handle)
		{
			OFLog(@"Did not get request handle from OFAnnouncement's getPost");
		}
	}
	else
	{
		announcementIndex = 0;
		postIndex = 0;
//		statusTextBox.text = @"";
	}
}


- (void)refreshStatusText: (OFAnnouncement*) announcement
{
	//	NSString *importanceText = @"";
	//	
	//	if(announcement.isImportant){
	//		importanceText = @"important and ";
	//	}
	//	
	//	if(announcement.isUnread){
	//		statusTextBox.text =[NSString stringWithFormat: @"%@unread", importanceText];
	//	}else{
	//		statusTextBox.text =[NSString stringWithFormat: @"%@has been read", importanceText];
	//	}
}

- (void)downloadNews
{
	[OFAnnouncement setDelegate:self];
	//OFSafeRelease(postList);
	if (!devAnnouncementList && !appAnnouncementList)
	{
		OFRequestHandle* handle = [OFAnnouncement downloadAnnouncementsAndSortBy:EAnnouncementSortType_CREATION_DATE];
		
		if (!handle)
		{
			OFLog(@"Did not get request handle from OFAnnouncement's downloadAnnouncementsAndSortBy:");
		}
	}
	else
	{
		[self setAnnouncementType: AnnouncementType_App];
	}
}

- (const char*)getNewsData
{
	if (nNews == 1)
	{
		nNews = 2;
		return [topNews UTF8String];
	}
	else
	{
		return "";
	}
}

///////////////////////////////////////////////////////////////////
#pragma mark OFAnnouncementDelegate protocol
///////////////////////////////////////////////////////////////////

- (void)didDownloadAnnouncementsAppAnnouncements:(NSArray*)appAnnouncements devAnnouncements:(NSArray*)devAnnouncements;
{
	OFSafeRelease(appAnnouncementList);
	OFSafeRelease(devAnnouncementList);
	
	appAnnouncementList = [appAnnouncements retain];
	devAnnouncementList = [devAnnouncements retain];
	
	[self setAnnouncementType:AnnouncementType_App];
}

- (void)didFailDownloadAnnouncements
{
	NSLog(@"Failed to download Announcements");
}

- (void)didGetPosts:(NSArray*)posts OFAnnouncement:(OFAnnouncement*)announcement
{
	NSInteger postCount = [posts count];
	
	if (postCount > 0) {
		if ((postIndex < 0) || (postCount <= postIndex)){
			postIndex = 0;
		}
		//		OFForumPost *curPost = (OFForumPost*)
		//		[posts objectAtIndex:postIndex];
		
		//		postText.text = [NSString stringWithString:curPost.body];
		//		postIndexText.text = [NSString stringWithFormat: @"%d", postIndex + 1];
	}else{
		//		postText.text = @"";
	}
	
	//	postCountText.text = [NSString stringWithFormat: @"%d", postCount];
}


- (void)didFailGetPostsOFAnnouncement:(OFAnnouncement*)announcement
{
	//	postText.text = @"";
}
#endif


#pragma mark TapjoyConnect Observer methods
#if (ENABLE_TJC_ADS&&TJC_CONNECT_ONCE)
-(void) tjcConnectSuccess:(NSNotification*)notifyObj
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setBool:YES forKey:@"TapjoyConnect"];
	
	NSLog(@"Tapjoy Connect Succeeded");
	
	//statusLabel.text = @"Tapjoy Connect Succeeded";
}

-(void) tjcConnectFail:(NSNotification*)notifyObj
{
	NSLog(@"Tapjoy Connect Failed");
	
	//statusLabel.text = @"Tapjoy Connect Failed";
}
#endif

#if ENABLE_ADMOB_ADS
// This method requires adding #import <CommonCrypto/CommonDigest.h> to your source file.
- (NSString *)hashedISU {
	NSString *result = nil;
	NSString *isu = [UIDevice currentDevice].uniqueIdentifier;
	
	if(isu) {
		unsigned char digest[16];
		NSData *data = [isu dataUsingEncoding:NSASCIIStringEncoding];
		CC_MD5([data bytes], [data length], digest);
		
		result = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				  digest[0], digest[1], 
				  digest[2], digest[3],
				  digest[4], digest[5],
				  digest[6], digest[7],
				  digest[8], digest[9],
				  digest[10], digest[11],
				  digest[12], digest[13],
				  digest[14], digest[15]];
		result = [result uppercaseString];
	}
	return result;
}

- (void)reportAppOpenToAdMob {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; // we're in a new thread here, so we need our own autorelease pool
	// Have we already reported an app open?
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
																		NSUserDomainMask, YES) objectAtIndex:0];
	NSString *appOpenPath = [documentsDirectory stringByAppendingPathComponent:@"admob_app_open"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if(![fileManager fileExistsAtPath:appOpenPath]) {
		// Not yet reported -- report now
		NSString *appOpenEndpoint = [NSString stringWithFormat:@"http://a.admob.com/f0?isu=%@&md5=1&app_id=%@",
									 [self hashedISU], APPLE_ITUNES_ID];//@"<APPLE ITUNES ID>"
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:appOpenEndpoint]];
		NSURLResponse *response;
		NSError *error = nil;
		NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
		if((!error) && ([(NSHTTPURLResponse *)response statusCode] == 200) && ([responseData length] > 0)) {
			[fileManager createFileAtPath:appOpenPath contents:nil attributes:nil]; // successful report, mark it as such
		}
	}
	[pool release];
}
#endif

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(isClearData)
    {
        if(buttonIndex == 0){
            NSLog(@"the first############")  ;   
            ResetData();
            SaveFile();
        }
        else if(buttonIndex == 1){
            NSLog(@"the first@@@@@@@@@@@@@@@")  ; 
        }
        isClearData=false;
        g_nGameState = GAME_STATE_OPTION;
        SwitchGameState();
        
    }
}


#ifdef _AD_ADCOLONY_EMBEDDED_
//use the app id provided by adcolony.com
- (NSString *)adColonyApplicationID
{
    return ADCOLONY_APP_ID;
}

//use the zone numbers provided by adcolony.com
- (NSDictionary *)adColonyAdZoneNumberAssociation
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            ADCOLONY_ZONE_ID1, [NSNumber numberWithInt:1], // Break Ad
            ADCOLONY_ZONE_ID3, [NSNumber numberWithInt:2], 
            ADCOLONY_ZONE_ID4, [NSNumber numberWithInt:3], 
            ADCOLONY_ZONE_ID1, [NSNumber numberWithInt:4], // Break Ad
//            ADCOLONY_ZONE_ID2, [NSNumber numberWithInt:4], // Break Ad
            ADCOLONY_ZONE_ID5, [NSNumber numberWithInt:5], 
            ADCOLONY_ZONE_ID6, [NSNumber numberWithInt:6], 
            ADCOLONY_ZONE_ID7, [NSNumber numberWithInt:7], 
            ADCOLONY_ZONE_ID8, [NSNumber numberWithInt:8], 
            nil];
}

// play the ad by the zone number
- (void)playVideoAdSlot:(NSInteger)slotIdx
{
    if ([app.iap hasUnlockComicInLocalStore]){
        return;
    }
    
#ifdef DEBUG
    NSString* adId;
    switch (slotIdx) {
        case 1:
            adId= ADCOLONY_ZONE_ID1;
            break;
        case 2:
            adId= ADCOLONY_ZONE_ID2;
            break;
        case 3:
            adId= ADCOLONY_ZONE_ID3;
            break;
        case 4:
            adId= ADCOLONY_ZONE_ID4;
            break;
        case 5:
            adId= ADCOLONY_ZONE_ID5;
            break;
        case 6:
            adId= ADCOLONY_ZONE_ID6;
            break;
        case 7:
            adId= ADCOLONY_ZONE_ID7;
            break;
        case 8:
            adId= ADCOLONY_ZONE_ID8;
            break;
        default:
            
            break;
    }
    NSLog(@"AdColony Play: level %d, id %@",slotIdx,adId);
    [adId release];
#endif
    [AdColony playVideoAdForSlot:slotIdx];
}


#endif


//#ifdef __DOWNLOAD_RES__
//- (void)downloadFromURL:(NSString *)theUrl
//{
//    NSURL * url = [NSURL URLWithString:theUrl];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *file = [NSString stringWithFormat:@"%@/test.mp3", documentsDirectory];
//    
//    [data writeToFile:file atomically:YES];
//}
//#endif

#ifdef FACEBOOK_TWITTER
-(void)facebookShare
{
    if(![CheckNetwork isNetworkAvailable]){
        return;
    }
    SBJSON *jsonWriter = [[SBJSON new] autorelease];
    
    // The action links to be shown with the post in the feed
    NSArray* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
													  @"Get Started",@"name",@"http://m.facebook.com/",@"link", nil], nil];
	
    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
    // Dialog parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"I'm using the ZPR for iOS app", @"name",
                                   @"ZPR for iOS.", @"caption",
                                   @"Run like your brains depend on it! I’ve been playing Zombie Parkour Runner. http://www.runzombies.com/", @"description",
                                   @"http://www.runzombies.com/", @"link",
                                   @"http://breakassets.break.com/breakassets/zpr/ZPR_Screen.png", @"picture",
                                   actionLinksStr, @"actions",
                                   nil];
    [[self facebook] dialog:@"feed"
					  andParams:params
					andDelegate:self];
}

-(void)facebookLogout:(NSNotification *)notification{
	[facebook logout:self];
}
#endif

#ifdef FACEBOOK_TWITTER
-(void)twitterShare
{
    if(![CheckNetwork isNetworkAvailable]){
        return;
    }
	SBJSON *jsonWriter = [[SBJSON new] autorelease];
	NSArray* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
													  @"Get Started",@"name",@"http://m.facebook.com/apps/hackbookios/",@"link", nil], nil];
	
    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"", @"name",
                                   @"", @"caption",
                                   @"", @"description",
                                   @"", @"link",
                                   @"", @"picture",
                                   actionLinksStr, @"actions",
                                   nil];
	[[self facebook] twitterDialog:@"Run like your brains depend on it! I’ve been playing Zombie Parkour Runner. http://www.runzombies.com/"
							 andParams:params
						   andDelegate:self];
}
#endif
@end


#ifdef __IPHONE_4_1
@implementation GameCenterCommonDelegate

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController 
{
    [viewController dismissModalViewControllerAnimated:YES];
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController 
{
    [viewController dismissModalViewControllerAnimated:YES];
}
@end

#endif
