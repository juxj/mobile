/*
 *  GameTitle.cpp
 *  ZPR
 *
 *  Created by Neo Lin on 5/31/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "ZPRAppDelegate.h"

#import "FlurryAnalytics.h"

#import "GameTitle.h"
#import "GameState.h"
#import "GameRes.h"
#import "GameAudio.h"
#import "GameOption.h"
#import "GameNews.h"

#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"
#import "Utilities.h"
#import "neoRes.h"

#import "zprUIButton.h"
#import "CheckNetwork.h"

#ifdef __IN_APP_PURCHASE__
#import "ZPR_IAP.h"
#import "GameStore.h"
#endif

Image* mFree;
Image* mWheel;
Image* mLight;
Image* mBtnStartBg;

#define UI_BTN_TITLE_NUM_MAX		(6)
#define UI_BTN_TITLE_DATA_ELEM		(4)
#define UI_BTN_TITLE_DATA_LENGTH	(20)
#ifdef  VERSION_IPAD
  #define IPAD_TITLE_Y  54.0f
  #define IPAD_TITLE_X   18.0f
  #define IPAD_TITLE_XOffset    0.0f
#else 
  #define IPAD_TITLE_Y  0.0f
  #define IPAD_TITLE_X   0.0f
  #define IPAD_TITLE_XOffset  26.5
#endif

int mUiBtnNextTitle[UI_BTN_TITLE_NUM_MAX] = 
{
	GAME_STATE_OPTION,
	GAME_STATE_CREDIT,
	GAME_STATE_NEWS,
    GAME_STATE_STORE,
    GAME_STATE_HOUSE, 
	GAME_STATE_MISSION_SELECT
};

ZprUIButton *btnFacebookAtTitle = NULL;
ZprUIButton *btnTwitterAtTitle = NULL;
ZprUIButton *btnStartIcon[11] = {NULL};

float startAlpha=0.0;
BOOL isUpdate = NO;
BOOL isServiceBusy=NO;
float  rotation =0.0f;
void GameTitleBegin()
{
    freeResStore();
    freeResAds();
	InitMenuRes();
	playBGM(BGM_MENU);

#ifdef CHEAT_UNLOCK_ALL_LEVELS
    availableLevels = 36;
#endif
    
    GameNewsCheckManually();
    startAlpha=0.0f;
}

void GameTitleEnd()
{
#ifdef __IN_APP_PURCHASE__
    app.iap.restoreSuccessCallback = NULL;
    app.iap.restoreFailedCallback = NULL;
#endif
}

void GameTitleUpdate(float dt)
{
	mStartGiant->update(dt);
	if (newsFlag == NEWS_NONE)
	{
		GameNewsDownload();
	}
    else if (newsFlag == NEWS_DONE)
    {
        if ([CheckNetwork checkNetwork])
        {
            GameNewsCheckManually();
        }
    }
	GameNewsCheck();
}

void GameTitleRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	canvas->drawImage(mTitleBG2, 0.0f, 0.0f);
    if (rotation<2*3.14)
    {
        rotation+=3.14*0.1/180;
    }
    else
    {
        rotation=0.0f;
    }
//    canvas->flush();
//    canvas->enableColorPointer(TRUE);
 //   glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
//    if (startAlpha <1.0f)
//    {
//        startAlpha +=0.08;
//    }
//    else
//    {
//        startAlpha =0.0f;
//    }
//    mLight->SetColor(1.0f, 1.0f, 1.0f, startAlpha);
#ifdef VERSION_IPAD
  #ifdef V_FREE
    if (availableLevels<=8) 
    {
        canvas->drawImage(mFree, 181.0f*IPAD_X, 122.0f*IPAD_X,1/3.14);
    }
   #endif
    
//  canvas->drawImage(mLight,396.0f/2, 447.0f/2);
//  canvas->enableColorPointer(FALSE);
//  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
//  canvas->flush();  

     canvas->drawImage(mBtnStartBg, 700/2, 71/2);
     canvas->drawImage(mWheel, 14.0f/2, 157.0f/2,rotation);
     mStartGiant->render(243.0f, 272.0f);
     
    for (int i=0; i<4; i++) 
    {
        btnStartIcon[i]->setBtnPos(854/2,(153+i*91)/2);
        btnStartIcon[i]->render();
    }
    btnStartIcon[4]->setBtnPos(164/2,686/2);
    btnStartIcon[4]->render();
    btnStartIcon[5]->setBtnPos(803/2,686/2);
    btnStartIcon[5]->render();    
    if (newsNoti)
	{
		char badgeNum[4];
		float badgeNumX;
		float badgeNumY;
		float strW;
		sprintf(badgeNum, "%d", newsNoti);
		strW = GetStringWidth(badgeNum, 0.5f, FONT_TYPE_SLACKEY);
		badgeNumX = 493 - 0.5f * strW;
		badgeNumY =( 148 - 11.0f);
		
		canvas->drawImage(mNewsImg[13], 493, 148, 0.0f, 1.0f, 1.0f);
		DrawString(badgeNum, badgeNumX, badgeNumY, 0.5f, 1.0f, 1.0f, 1.0f, 1.0f, FONT_TYPE_SLACKEY);
     }
    if (isUpdate)
    {
        canvas->drawImage(mNewsImg[13], 492.0f, 202.0f, 0.0f, 1.0f, 1.0f);
        DrawString((char* )"1",  489.0f, 192.0, 0.5f, 1.0f, 1.0f, 1.0f, 1.0f, FONT_TYPE_SLACKEY);
	}
   
#else
   #ifdef V_FREE
    if (availableLevels<=8) 
    {
        canvas->drawImage(mFree, 178.0f*IPAD_X, 112.0f*IPAD_X,1/3.14);
    }
   #endif
    
//  canvas->drawImage(mLight,191, 186);
//  canvas->enableColorPointer(FALSE);
//  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
//  canvas->flush();
    
    canvas->drawImage(mBtnStartBg, 322, 29);
    canvas->drawImage(mWheel, 42.0f, 67.0f,rotation);
    mStartGiant->render(229.0f, 218.0f);
     for (int i=0; i<4; i++) 
    {
        btnStartIcon[i]->setBtnPos(386*IPAD_X,(60+i*40)*IPAD_X);
        btnStartIcon[i]->render();
    }
    btnStartIcon[4]->setBtnPos(92*IPAD_X,288*IPAD_X);
    btnStartIcon[4]->render();
    btnStartIcon[5]->setBtnPos(365*IPAD_X,288*IPAD_X);
    btnStartIcon[5]->render();         
    if (newsNoti)
	{
		char badgeNum[4];
		float badgeNumX;
		float badgeNumY;
		float strW;
		sprintf(badgeNum, "%d", newsNoti);
		strW = GetStringWidth(badgeNum, 0.5f, FONT_TYPE_SLACKEY);
		badgeNumX = 445.0f+IPAD_TITLE_X - 0.5f * strW;
		badgeNumY =( 137 - 11.0f)+IPAD_TITLE_Y;
		
		canvas->drawImage(mNewsImg[13], 446.0f+IPAD_TITLE_X, 137.0f+IPAD_TITLE_Y, 0.0f, 1.0f, 1.0f);
		DrawString(badgeNum, badgeNumX, badgeNumY, 0.5f, 1.0f, 1.0f, 1.0f, 1.0f, FONT_TYPE_SLACKEY);
	}
    if (isUpdate)
    {
        canvas->drawImage(mNewsImg[13], 446.0f+IPAD_TITLE_X, 177.0+IPAD_TITLE_Y, 0.0f, 1.0f, 1.0f);
		DrawString((char* )"1",  443.0f+IPAD_TITLE_X, 166.0+IPAD_TITLE_Y, 0.5f, 1.0f, 1.0f, 1.0f, 1.0f, FONT_TYPE_SLACKEY);
	}

#endif                                                        
    

    
#ifdef FACEBOOK_TWITTER
   #ifdef VERSION_IPAD
    if (btnFacebookAtTitle)
    {
        btnFacebookAtTitle->setBtnPos(96/2, 555.0/2);
        btnFacebookAtTitle->render();
    }
    if (btnTwitterAtTitle)
    {
        btnTwitterAtTitle->setBtnPos(225/2, 555.0f/2);
        btnTwitterAtTitle->render();
    }
   #else
    if (btnFacebookAtTitle)
    {
        btnFacebookAtTitle->setBtnPos(65.0f*IPAD_X, 231.0f*IPAD_X);
        btnFacebookAtTitle->render();
    }
    if (btnTwitterAtTitle)
    {
         btnTwitterAtTitle->setBtnPos(118.0f*IPAD_X, 231.0f*IPAD_X);
        btnTwitterAtTitle->render();
    }
   #endif
#endif
}

void GameTitleOnTouchEvent(int touchStatus, float fX, float fY)
{
#ifdef FACEBOOK_TWITTER
    if (btnFacebookAtTitle->onTouch(touchStatus, fX, fY))
    {
        if (btnFacebookAtTitle->getButtonState() == ZPR_UI_BTN_RELEASED)
        {
            btnFacebookAtTitle->setButtonState(ZPR_UI_BTN_NORMAL);
            [app facebookShare];
			
			[FlurryAnalytics logEvent:@"FaceBook Button"];//facebook
            return;
        }
    }
    else if (btnTwitterAtTitle->onTouch(touchStatus, fX, fY))
    {
        if (btnTwitterAtTitle->getButtonState() == ZPR_UI_BTN_RELEASED)
        {
            btnTwitterAtTitle->setButtonState(ZPR_UI_BTN_NORMAL);
            [app twitterShare];
			
			[FlurryAnalytics logEvent:@"Twitter Button"];//twitter
            return;
        }
    }
#endif
    for (int i=0; i<6; i++) {
        if (btnStartIcon[i]->onTouch(touchStatus,fX,fY)) 
        {
            if (btnStartIcon[i]->getButtonState()== ZPR_UI_BTN_RELEASED  )
            {
                btnStartIcon[i]->setButtonState(ZPR_UI_BTN_NORMAL);
                
                if (i ==5)
                {
                    playSE(SE_GAME_START);
                }
                else
                {
                    playSE(SE_BUTTON_CONFIRM);
                }
				
                if (i==3) 
                {
                    if (![app.iap readyToPurchases]) {
                        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"IAP store is not ready, please wait." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        return;
                    }
                    
                }
                else if(i==5)
                {
                    isMainMenu=true;
                }
                
				if(i == 2){
					[FlurryAnalytics logEvent:@"News"];//news
				}if(i == 3){
					[FlurryAnalytics logEvent:@"Store"];//store
				}else if(i == 4){
					[FlurryAnalytics logEvent:@"Kara's House"];//hourse
				}
				
                g_nGameState = mUiBtnNextTitle[i];
                SwitchGameState();
            } 
        }
    }

}
