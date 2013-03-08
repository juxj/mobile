//
//  GameStore.h
//  ZPR
//
//  Created by Neo01 on 11/2/11.
//  Copyright (c) 2011 Break Media. All rights reserved.
//

#ifndef __GAME_STORE_H__
#define __GAME_STORE_H__

#ifdef __IN_APP_PURCHASE__

#define STR_ALERT_TITLE_PURCHASE_FAILED @"Purchase Failed!"
#define FAIL1 @"Level Pack purchase failed."
#define FAIL2 @"Super Kicks purchase failed."
#define FAIL3 @"Trampolines purchase failed."
#define FAIL4 @"Combo Pack purchase failed."
#define STR_ALERT_TITLE_PURCHASE_SUCCESSFUL @"Purchase Successful!"
#define STR_ALERT_TITLE_DOWNLOAD_SUCCESSFUL @"Download Successful!"
#define STR_ALERT_TITLE_DOWNLOAD_FAILED @"Download Failed!"
#define STR_ALERT_TITLE_DOWNVERION_FAILED @"Version-Check Failed!"

#define SUCESS1_FREE @"Thanks for buying the Level Pack! You can find your new levels on the level select screen. Have fun!"
#define SUCESS1_PAID @"You can find your new levels on the level select screen. Have fun!"

//#define SUCESS1 @"Thanks for buying Comic Pack! Donwloading..."
#define SUCESS2 @"Thanks for buying Super Kicks! They will kick you straight up to Runner's High x3! Have fun!"
#define SUCESS3 @"Thanks for buying Super Trampolines! You can use them to skip to the next flag! Have fun!"
#define SUCESS4 @"Thanks for buying Combo Pack! Have fun!"
#define TIPWAIT @"Processing, please wait..."    //@"processing, please wait."

#ifdef __STORE_LEVEL_PACK__
    #define NO_NEW_LEVEL @"You have already purchased the Level Pack."
#else
    #define NO_NEW_LEVEL @"You have updated to the latest version."     //@"There is no update levels right now!"
#endif

#define TIME_OUT @"Please check your Internet connection and try again."    //@"Please check internet connection settings in your device!"
#define DOWNLOAD_FAIED @"Please check your Internet connection and you can try again for free."
#define SERVICE_BUSY_TIP @"Downloading failed, Please try later."

class ZprUIButton;
extern ZprUIButton *purchaseBtn1;
extern ZprUIButton *purchaseBtn2;
extern ZprUIButton *purchaseBtn3;
extern ZprUIButton *purchaseBtn4;
extern ZprUIButton *closeBtn;

extern ZprUIButton *buyItemBtn;
class Image;
extern Image *addRunnerModeAni;
extern Image *addTrampolinesAni;
extern Image *addComboPackAni;
extern Image *addUpgradeAni;
extern UIAlertView *waitView;
extern void GameStoreRestoreSuccessHandler ();
extern void GameStoreRestoreFailedHandler ();
extern bool isPurchasing;
void GameStoreBegin();
void GameStoreEnd();
void GameStoreUpdate(float dt);
void GameStoreRender(float dt);
void GameStoreTouchEvent(int touchStatus, float fX, float fY);

void sendPurchaseRequest();
void    drawItemDetail();

extern bool havePurchasedComic;

#endif

#endif  //__GAME_STORE_H__
