/*
 *  GameLoading.cpp
 *  ZPR
 *
 *  Created by Neo01 on 8/2/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "GameLoading.h"

#import "Canvas2D.h"
#import "neoRes.h"
#import "Wrapper.h"

#import "Utilities.h"
#import "GameRes.h"
#import "GameState.h"

#import "Stage.h"
#import "GameLevel.h"
#import "GameSection.h"
#import "GameAchieve.h"

#ifdef V_1_1_0
#import "GameTips.h"
#import "GameHouse.h"
#endif


int loadStep = 0;
float loadingStrWidth = 0.0f;
float loadCnt = 0;

void GameLoadingBegin()
{
    loadCnt = 0.0f;
	RelGcRes();
	RelGcOverRes();
    initResAds();
	char loadingStr[] = "Loading...";
	loadingStrWidth = GetStringWidth(loadingStr);
}

void GameLoadingEnd();

void GameLoadingUpdate(float dt)
{
	switch (loadStep) {
		case 0:
			++loadStep;
//			RelMenuRes();
//			InitGcRes();
//			g_GcResMgr = new NeoRes();
			break;
		case 1:
			++loadStep;
			RelMenuRes();
#ifdef V_1_1_0
            freeResTip();
#endif
			break;
		case 2:
			++loadStep;
			InitGcRes();
			nCoinsInCurrentLevel = 0;
			stages = new Stage(ActiveLevel);
#ifdef __DOWNLOAD_RES__
    #ifdef V_FREE
            if (LevelIndex >= 1)
            {
                accessPath = READ_DIR_DOCUMENT;
            }
            else
            {
                accessPath = READ_DIR_BUNDLE;
            }
    #else
            if (LevelIndex >= 3/* && ActiveLevel >= 4*/)
            {
                accessPath = READ_DIR_DOCUMENT;
            }
            else
            {
                accessPath = READ_DIR_BUNDLE;
            }
    #endif
    #ifdef CHEAT_UNLOCK_ALL_LEVELS
            accessPath = READ_DIR_BUNDLE;
    #endif
#endif
#ifdef VER_TEST
            accessPath = READ_DIR_BUNDLE;
#endif
			stages->initialize();
            
#ifdef V_1_1_0
            if (!(mObjFlag[0]) && (LevelIndex == 0) && (ActiveLevel == 0))
            {
                initResTip();
            }
#endif
            
#ifdef __DOWNLOAD_RES__
            accessPath = READ_DIR_BUNDLE;   // reset access path
#endif
            loadCnt += dt;
        case 3:
            loadCnt += dt;
            if (loadCnt >= LOADING_DURATION)
            {
                loadCnt = 0.0f;
                setGlobalFadeInAndGoTo(GAME_STATE_GAME_PLAY);
                SaveFile();
                freeResAds();
            }
			break;
		default:
			break;
	}
}

void GameLoadingRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
//	canvas->drawImage(mSelectPlay[LevelIndex+3], 0.0f, 0.0f, 0.0f, 1.2f, 1.2f);
	drawSky();
//	canvas->drawImage(mLevelbgsky, 0.0f, 0.0f, 0.0f, 3.1f, 3.1f);
	char loadingStr[] = "Loading...";
    
#ifdef __PROMOTE_ADS__
    switch (adsStyle)
    {
		case ADS_STATE_FREE_SHOE:
            
            canvas->drawImage(ads_shoes, 0.0f, 0.0f, 0.0f, 1.0f, 1.0f);
            
			break;
		case ADS_STATE_FREE_BED:
            
            canvas->drawImage(ads_bed, 0.0f, 0.0f, 0.0f, 1.0f, 1.0f);
            
			break;
		case ADS_STATE_FREE_BUY:
            
            canvas->drawImage(ads_buy, 0.0f, 0.0f, 0.0f, 1.0f, 1.0f);
            
			break;
		case ADS_STATE_FULL_SHOE:
            canvas->drawImage(ads_shoes, 0.0f, 0.0f, 0.0f, 1.0f, 1.0f);		
			break;
		case ADS_STATE_FULL_BED:
            canvas->drawImage(ads_bed, 0.0f, 0.0f, 0.0f, 1.0f, 1.0f);	
			break;
		default:
			break;
	}
#endif
#ifdef VERSION_IPAD
	DrawString(loadingStr, 
               (canvas->mScreenWidth / IMG_RES_SCALE - loadingStrWidth - 24), 
               (canvas->mScreenHeight / IMG_RES_SCALE - 52.0f), 
               1.0f, 1.0f, 1.0f, 1.0f, 1.0f);
#else
    DrawString(loadingStr, 
               (canvas->getCanvasWidth() - loadingStrWidth - 10), 
               (canvas->getCanvasHeight() - 40.0f), 
               1.0f, 1.0f, 1.0f, 1.0f, 1.0f);
//	DrawString(loadingStr, (canvas->getCanvasWidth()*IPAD_X - loadingStrWidth) * 0.5f, (canvas->getCanvasHeight()*IPAD_X - 40.0f) * 0.5f, 1.0f, 1.0f, 1.0f, 0.0f, 1.0f);
#endif

	
}

void GameLoadingOnTouchEvent(int touchStatus, float fX, float fY);
