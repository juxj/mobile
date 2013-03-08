//
//  ZPRAppDelegate.h
//  ZPR
//
//  Created by Neo01 on 5/27/11.
//  Copyright 2011 Break Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef FACEBOOK_TWITTER
#import "Facebook.h"
#import "FBConnect.h"
#endif

#ifdef OF_EMBEDED
#import "OpenFeint/OpenFeint.h"
#import "OpenFeint/OpenFeintDelegate.h"
#endif

#ifdef __IPHONE_4_1
#import "GameKit/GKLeaderboardViewController.h"
#import "GameKit/GKAchievementViewController.h"

@class GameCenterCommonDelegate;
#endif

#ifdef OF_EMBEDED
#import "OpenFeint/OFAnnouncement.h"

enum AnnouncementType {
	AnnouncementType_App = 0,
	AnnouncementType_Dev,
	//
	AnnouncementType_None = -1
};
#endif

#ifdef _AD_ADCOLONY_EMBEDDED_
#import "AdColonyPublic.h"
#endif

#ifdef __IN_APP_PURCHASE__
#import "ZPR_IAP.h"
#import "PurchaseCounts.h"
#endif

#ifdef ENABLE_MOVIE
#import <MediaPlayer/MediaPlayer.h>
#endif

@class ZPRViewController;

@interface ZPRAppDelegate : NSObject <UIApplicationDelegate, 
#ifdef OF_EMBEDED
									OpenFeintDelegate, OFNotificationDelegate, OFAnnouncementDelegate, 
#endif
									GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, UIAlertViewDelegate
#ifdef _AD_ADCOLONY_EMBEDDED_
    , AdColonyDelegate
#endif
#ifdef FACEBOOK_TWITTER
    , FBDialogDelegate, FBSessionDelegate
#endif

>
{
    UIWindow *window;
    ZPRViewController *viewController;
    UIView *overlayView;
	
#ifdef OF_EMBEDED
	AnnouncementType	currentAnnouncementType;
	//
	NSArray		*curAnnouncementList;
	NSArray		*postList;
	//
	NSInteger	announcementIndex;
	NSInteger	postIndex;
	//
	NSString	*topNews;
//	NSString	*topNewsTitle;
	NSInteger	nNews;
	
	
	NSInteger	showCheckGC;
	
	NSInteger   hasAccount;
#endif
    
    BOOL        bLockScreenOrient;
	
#ifdef ENABLE_MOVIE
	MPMoviePlayerController *moviePlayer;
#endif
	
#ifdef __IPHONE_4_1
	GameCenterCommonDelegate* gameCenterCommonDelegate;
#endif

#ifdef FACEBOOK_TWITTER
	Facebook *facebook;
	NSMutableDictionary *userPermissions;
#endif
    
#ifdef __IN_APP_PURCHASE__
    ZPR_IAP *iap;
    PurchaseCounts* purchaseCounts;
#endif

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ZPRViewController *viewController;
#ifdef ENABLE_MOVIE
@property (readwrite, retain) MPMoviePlayerController *moviePlayer;
#endif

#ifdef FACEBOOK_TWITTER
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) NSMutableDictionary *userPermissions;

-(void)facebookShare;
-(void)twitterShare;
#endif

#ifdef __IN_APP_PURCHASE__
//@property (readwrite, retain) ZPRInAppPurchaseDelegate *iapDelegate;
@property (nonatomic, readonly, retain) ZPR_IAP *iap;
@property (nonatomic, readonly, retain) PurchaseCounts *purchaseCounts;
#endif

@property (nonatomic) NSInteger showCheckGC;
@property (nonatomic) NSInteger hasAccount;

- (BOOL) isPad;
- (void) openLink:(NSString *)theUrl;

#ifdef OF_EMBEDED
- (void) InitOpenFeint;
#endif
- (BOOL) isGameCenterAvailable;
- (BOOL) authenticateLocalUser;

// report achievement for Game Center
- (void) reportAchievementIdentifier:(NSString*)identifier percentComplete:(float)percent;
- (void) reportScore:(int64_t)score forCategory:(NSString*)category;

#ifdef ENABLE_MOVIE
- (void)PlayMp4;
- (void)initAndPlayMovie:(NSURL *)movieURL;
- (void) playbackDidFinish;
#endif

#ifdef OF_EMBEDED
- (BOOL)checkLoginGameCenter;

- (void)dashboardWillAppear;
- (void)dashboardDidAppear;
- (void)dashboardWillDisappear;
- (void)dashboardDidDisappear;
- (void)userLoggedIn:(NSString*)userId;
- (BOOL)showCustomOpenFeintApprovalScreen;

- (void)ofSubmitScore:(NSString*)identifier withScore:(NSInteger)score;
- (void)onSetHighScoreSuccess;
- (void)onSetHighScoreFailure;

- (void)downloadNews;
- (const char*)getNewsData;

- (void)setAnnouncementType:(AnnouncementType)requestedType;
- (void)announcementIndexChange:(NSInteger)delta;
- (void)postIndexChange:(NSInteger)delta;
- (void)refreshStatusText:(OFAnnouncement*)announcement;

@property (readwrite, retain) NSString *topNews;
//@property (readwrite, retain) NSString *topNewsTitle;
@property (readwrite) NSInteger nNews;
#endif

@property (readwrite) BOOL bLockScreenOrient;

#ifdef _AD_ADCOLONY_EMBEDDED_
- (void)playVideoAdSlot:(NSInteger)slotIdx;
#endif

//#ifdef __DOWNLOAD_RES__
//- (void)downloadFromURL:(NSString *)theUrl;
//#endif

@end

#ifdef __IPHONE_4_1
@interface GameCenterCommonDelegate : NSObject<GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate>
@end
#endif

extern ZPRAppDelegate* app;
