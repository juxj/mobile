/*
 *  GameState.cpp
 *  ZPR
 *
 *  Created by Neo01 on 5/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "GameState.h"

#import "app.h"

#import "ZPRAppDelegate.h"

//#include "BasicGraphics.h"
#import "GameRes.h"
#import "Sprite.h"
#import "GameData.h"

#include "neoRes.h"
#include "Canvas2D.h"
#include "Texture2D.h"
#include "Image.h"

//#import "GameLogo.h"
#import "GameTitle.h"
#import "GameSection.h"
#import "GameSuc.h"
#import "GameAchieve.h"
#import "GameOption.h"
#import "GameBedroom.h"
#import "GamePlay.h"
#import "Runner.h"
#import "Giant.h"
#import "GameOver.h"
#import "GameOverCaught.h"
#import "GameCredits.h"
#import "GamePause.h"
#import "GameNews.h"
#import "GameGcOption.h"
#ifdef __IN_APP_PURCHASE__
#import "GameStore.h"
#import "GameRunnerMode.h"
#import "GameTrampoline.h"
#endif

#import "GameStory.h"
#import "GameStore.h"
///#import "GameAchieve.h"
#import "Rain.h"

#import "Wrapper.h"
#import "GameRes.h"

#import "GameAudio.h"
#import "GameHouse.h"
#import "GameLevel.h"
#import "GameLevelTwelve.h"
#import "GameLoading.h"

#import "Stage.h"

#import "imgResData.h"

#import "PromoteADS.h"
#import "ZPRViewController.h"

#ifdef V_1_1_0
#import "GameAchieve.h"
#import "GameTips.h"
#endif
//using namespace neolib;


// Keep the code simple in the earlier versions.
// Wait for the new versions.

#pragma mark Global
int g_nGameState = GAME_STATE_INIT;
int g_nPrevGameState;
int g_nNextGameState = -1;
int mStoryIndex=0;
int g_nButtonPress;
float g_fButtonXY[2];
bool isPurchase=false;
int g_nFrameCount;

int accessPath = READ_DIR_BUNDLE;

#ifdef V_1_1_0
int totalScoreForGameCenter = -1;
#endif

#ifdef _AD_ADCOLONY_EMBEDDED_
int gsCountGameOver = 0;
int tabAdPlayList[8] = {
    0, 0, 0, 0, 
    0, 0, 0, 0
};
void resetCountGameOver()
{
    gsCountGameOver = 0;
}
void setCountGameOver()
{
    ++gsCountGameOver;
}
int getCountGameOver()
{
    return gsCountGameOver;
}
void resetTabAdPlayList()
{
    for (int i = 0; i < 8; i++)
    {
        tabAdPlayList[i] = 0;
    }
}
#endif

NeoRes* g_MenuResMgr = NULL;
NeoRes*	g_UiResMgr = NULL;
NeoRes*	g_GcResMgr = NULL;
NeoRes* g_GcOverResMgr = NULL;
NeoRes* g_HouseResMgr = NULL;
NeoRes* g_StoryResMgr = NULL;
#ifdef __IN_APP_PURCHASE__
NeoRes* g_StoreResMgr = NULL;
#endif

// Canvas
int g_canvas_state;
float g_alpha = 0.0f;
float g_alpha_delta = 0.0f;

char* Name[ALL_NAME_MAX] = {
	(char*)LEVEL_NAME1, 
	(char*)LEVEL_NAME2, 
	(char*)LEVEL_NAME3,
#ifdef V_1_1_0
    (char*)LEVEL_NAME4,
#endif
	(char*)REPlAY, 
	(char*)QUIT,
	(char*)SOUND, 
	(char*)MUSIC, 
#ifdef V_1_1_0
    (char*)RESETDATA,
#endif
	(char*)OPENFEINT, 
	(char*)GAMECENTER,
	(char*)BACK
};

bool bSuspend = false;
bool bResume = false;

int props_order[24]= //hourse order
{
  19,23,8,13,12,14,22,18,0,3,7,15,9,16,1,11,20,4,6,2,21,10,5,17
};

#pragma mark -
#pragma mark Resource Initialization
void initGameData()
{
	g_UiResMgr = new NeoRes();
	
	InitGameTextures();
	InitMenuRes();
	Canvas2D* canvas = Canvas2D::getInstance();
	canvas->setOrientation(Canvas2D::ORIENTATION_LEFT);
	canvas->setCanvasWidthAndHeight(PORTRAIT_SCREEN_WIDTH, PORTRAIT_SCREEN_HEIGHT);
	canvas->setCanvasScale(GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->SwitchTo2D();
	
	g_nGameState = GAME_STATE_TITLE;//GAME_STATE_SPLASH;//GAME_STATE_INIT;
	SwitchGameState();
	
	if(!LoadFile()){
		SaveFile();
	};
    
#ifdef ENABLE_ACHIEVEMENTS
	ResetTempAchievements();
#endif
	
	objAudioInit();
}

void freeGameData()
{
	RelMenuRes();
	RelGcRes();
	ReleaseGameTextures();
}

#pragma mark -

void initResGame()
{
//	int  i = 0;
//	char temp[8] = {0};
//	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA8888;
//	g_GcResMgr->loadRes("bigprops.xml", NULL);
//	for (i = 0; i < 24; i++)
//	{
//		memset(temp, '\0', sizeof(temp));
//		sprintf(temp, "big%d", i);
//		mAchieveInfo[i] = g_GcResMgr->getImage(temp);
//	}
//	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA4444;
}

void freeResGame()
{
}

void initResHouse()
{
	if (g_HouseResMgr == NULL)
	{
		g_HouseResMgr = new NeoRes();
	}
	else
	{
		return;
	}
	
	// House
	g_HouseResMgr->createImage("House", "emptyroom.png",STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX,STORY_TEX_OY);
	mHouse = g_HouseResMgr->getImage("House");
#ifdef V_1_1_0
    g_HouseResMgr->createImage("emptybedroom", "emptybedroom.png",STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX,STORY_TEX_OY);
	mBedroom = g_HouseResMgr->getImage("emptybedroom");
    
#endif
	//backbrand
	g_HouseResMgr->loadRes("houseprops.xml", NULL,IMG_RES_SCALE);
	mHouseBackBrand= g_HouseResMgr->getImage("backbrand1");
	mHouseBackBrand->SetAnchor(42.0f * IMG_RES_SCALE, 7.0f * IMG_RES_SCALE);
    mBedroomBackBrand= g_HouseResMgr->getImage("backbrand2");
	mBedroomBackBrand->SetAnchor(33.0f * IMG_RES_SCALE, 6.0f * IMG_RES_SCALE);
    mCutRoomBtn= g_HouseResMgr->getImage("backbrand3");
    mCutRoomBtn->SetAnchor(48.0f * IMG_RES_SCALE, 25.0f * IMG_RES_SCALE);
   
    
	// Achievements
	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA8888;
	
	//Achievements	Information
	char tempinfo[24] = {0};
    char igiteminfo[24] = {0};

	
	g_HouseResMgr->loadRes("houseprops.xml", NULL,IMG_RES_SCALE);
	for (int i=0; i<24; i++) {
		memset(tempinfo, '\0', sizeof(tempinfo));
		sprintf(tempinfo, "m%d", i);
		mAchieve[i] = g_HouseResMgr->getImage(tempinfo);
	}
    
    g_HouseResMgr->loadRes("bedroomprops.xml", NULL,IMG_RES_SCALE/2);
	for (int i=0; i<12; i++) {
		memset(tempinfo, '\0', sizeof(tempinfo));
		sprintf(tempinfo, "bed%d", i);
		mBedroomProps[i] = g_HouseResMgr->getImage(tempinfo);
	}
    for (int i=0; i<24; i++) 
    {
		memset(tempinfo, '\0', sizeof(tempinfo));
		sprintf(tempinfo, "props%d.png", i);
        sprintf(igiteminfo, "props%d", i);
        g_HouseResMgr->createImage(igiteminfo, tempinfo, 0, 0, 128, 128, 0, 0);
		mAchieveInfo[i] = g_HouseResMgr->getImage(igiteminfo);
        
	}
    for (int i=0; i<12; i++) 
    {
		memset(tempinfo, '\0', sizeof(tempinfo));
		sprintf(tempinfo, "bedprops%d.png", i);
        sprintf(igiteminfo, "bedprops%d", i);
        g_HouseResMgr->createImage(igiteminfo, tempinfo, 0, 0, 128, 128, 0, 0);
		mBedroomPropsInfo[i] = g_HouseResMgr->getImage(igiteminfo);
        
	}
    
	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA4444;
}

void freeResHouse()
{
	if (g_HouseResMgr)
	{
		delete g_HouseResMgr;
		g_HouseResMgr = NULL;
	}
}

void initResStory(int index1)
{
	g_StoryResMgr = new NeoRes();
	
	switch(index1)
	{
		case 0:
		{
			g_StoryResMgr->createImage("firststory0", "firststory0.png", STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[0] = g_StoryResMgr->getImage("firststory0");
			g_StoryResMgr->createImage("firststory1", "firststory1.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[1] = g_StoryResMgr->getImage("firststory1");
#ifdef VERSION_IPAD
			g_StoryResMgr->createImage("firststory2", "firststory2.png", 0, 0, 506, 768, 0, 0);
			mStory[2] = g_StoryResMgr->getImage("firststory2");	
			g_StoryResMgr->createImage("firststory21", "firststory2.png", 420, 0, 604, 768, 0, 0);
			mStory[3] = g_StoryResMgr->getImage("firststory21");
#else
			g_StoryResMgr->createImage("firststory2", "firststory2.png", 0 * IMG_RES_SCALE, 0 * IMG_RES_SCALE, 235 * IMG_RES_SCALE, 320 * IMG_RES_SCALE, 0, 0);
			mStory[2] = g_StoryResMgr->getImage("firststory2");	
			g_StoryResMgr->createImage("firststory21", "firststory2.png", 282 * IMG_RES_SCALE, 0 * IMG_RES_SCALE, 282 * IMG_RES_SCALE, 320 * IMG_RES_SCALE, 0, 0);
			mStory[3] = g_StoryResMgr->getImage("firststory21");
#endif
			g_StoryResMgr->createImage("firststory3", "firststory3.png", STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[4] = g_StoryResMgr->getImage("firststory3");
			break;
		}
		case 5:
		{
			g_StoryResMgr->createImage("citytofactory0", "citytofactory0.png", STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[5] = g_StoryResMgr->getImage("citytofactory0");
#ifdef VERSION_IPAD
			g_StoryResMgr->createImage("citytofactory1", "citytofactory1.png", 0, 0, 758, 768, 0, 0);
			mStory[6] = g_StoryResMgr->getImage("citytofactory1");
			g_StoryResMgr->createImage("citytofactory11", "citytofactory1.png", 666, 0, 358, 768, 0, 0);
			mStory[7] = g_StoryResMgr->getImage("citytofactory11");
#else
			g_StoryResMgr->createImage("citytofactory1", "citytofactory1.png", 0 * IMG_RES_SCALE, 0 * IMG_RES_SCALE, 340 * IMG_RES_SCALE, 320 * IMG_RES_SCALE, 0, 0);
			mStory[6] = g_StoryResMgr->getImage("citytofactory1");
			g_StoryResMgr->createImage("citytofactory11", "citytofactory1.png", 384 * IMG_RES_SCALE, 0 * IMG_RES_SCALE, 180 * IMG_RES_SCALE, 320 * IMG_RES_SCALE, 0, 0);
			mStory[7] = g_StoryResMgr->getImage("citytofactory11");
#endif
			g_StoryResMgr->createImage("citytofactory2", "citytofactory2.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[8] = g_StoryResMgr->getImage("citytofactory2");	
			g_StoryResMgr->createImage("citytofactory3", "citytofactory3.png", STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[9] = g_StoryResMgr->getImage("citytofactory3");
			break;
		}
		case 10:
		{
			g_StoryResMgr->createImage("factorytopark0", "factorytopark0.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[10] = g_StoryResMgr->getImage("factorytopark0");
			g_StoryResMgr->createImage("factorytopark1", "factorytopark1.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[11] = g_StoryResMgr->getImage("factorytopark1");
			g_StoryResMgr->createImage("factorytopark2", "factorytopark2.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[12] = g_StoryResMgr->getImage("factorytopark2");
		break;
		}
//		case 13:
//		{
//			g_StoryResMgr->createImage("last0", "last0.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
//			mStory[13] = g_StoryResMgr->getImage("last0");
//			g_StoryResMgr->createImage("last1", "last1.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
//			mStory[14] = g_StoryResMgr->getImage("last1");
//			g_StoryResMgr->createImage("last2", "last2.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
//			mStory[15] = g_StoryResMgr->getImage("last2");
//			g_StoryResMgr->createImage("last3", "last3.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
//			mStory[16] = g_StoryResMgr->getImage("last3");
//			break;
//		}
        case 13:
		{
            g_StoryResMgr->createImage("four_begin1", "four_begin1.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[13] = g_StoryResMgr->getImage("four_begin1");
			g_StoryResMgr->createImage("four_begin2", "four_begin2.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[14] = g_StoryResMgr->getImage("four_begin2");
			g_StoryResMgr->createImage("four_begin3", "four_begin3.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[15] = g_StoryResMgr->getImage("four_begin3");
			g_StoryResMgr->createImage("four_begin4", "four_begin4.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[16] = g_StoryResMgr->getImage("four_begin4");
			g_StoryResMgr->createImage("four_begin5", "four_begin5.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[17] = g_StoryResMgr->getImage("four_begin5");
			break;
		}
        case 18:
        {
            g_StoryResMgr->createImage("four_end1", "four_end1.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[18] = g_StoryResMgr->getImage("four_end1");
			g_StoryResMgr->createImage("four_end2", "four_end2.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[19] = g_StoryResMgr->getImage("four_end2");
			g_StoryResMgr->createImage("four_end3", "four_end3.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
			mStory[20] = g_StoryResMgr->getImage("four_end3");
        }
		default:
			break;
	}
}

void freeResStory()
{
	if (g_StoryResMgr)
	{
		delete g_StoryResMgr;
		g_StoryResMgr = NULL;
	}
}

#pragma mark -
#pragma mark Suspend/Resume

void GameSuspend()
{
	if (bSuspend) return;
	bSuspend = true;
	bResume = false;
//	printf("suspend!!!--------------------_start\n");
	if (g_nGameState == GAME_STATE_GAME_PLAY)
	{
		if (GetPlayerAction() != PLAYER_STATE_STAND)
		{
			g_nGameState = GAME_STATE_PAUSE;
			SwitchGameState();
			m_fPauseOffset = 0;
		}
	}
//	objAudioStop(EVENT_TYPE_BACKGROUND, SOUND_TYPE_INDEX_BACKGROUND, !m_bBgm);
	objAudioSuspend();
//	printf("suspend!!!--------------------_end\n");
}

void GameResume()
{
	if (bResume) return;
	bResume = true;
	bSuspend = false;
//	printf("--------------------resume!!!_start\n");
	if (g_nGameState == GAME_STATE_GAME_PLAY)
	{
		if (GetPlayerAction() != PLAYER_STATE_STAND)
		{
			g_nGameState = GAME_STATE_PAUSE;
			SwitchGameState();
			m_fPauseOffset = 0;
		}
	}
	objAudioResume();
	playBGM(currentBgmId);	//objAudioPlay(EVENT_TYPE_BACKGROUND, SOUND_TYPE_INDEX_BACKGROUND, (m_bSounds && m_bBgm));
//	printf("--------------------resume!!!_end\n");
#ifdef __DOWNLOAD_RES__
    [app.viewController downloadVersion:YES ];
#endif
}

void setLockScreenOrientation(bool flag)
{
    if (app)
    {
        [app setBLockScreenOrient:flag];
    }
}

#pragma mark -
#pragma mark Game Processing

// Call it when switching the state
int SwitchGameState()
{
    if (g_nGameState == GAME_STATE_GAME_PLAY)
    {
        setLockScreenOrientation(true);
    }
    else
    {
        setLockScreenOrientation(false);
    }
	switch(g_nGameState)
	{
		case GAME_STATE_INIT:
			g_nGameState = GAME_STATE_SPLASH;
			break;
		case GAME_STATE_SPLASH:
///			objAudioInit(ALL_AUDIO, ALL_AUDIO_TYPE, true);
			break;
		case GAME_STATE_TITLE:
			freeResHouse();
			GameTitleBegin();
			break;
		case GAME_STATE_ACHIEVE:
			break;
		case GAME_STATE_MISSION_SELECT:
			freeResStory();
			GameSectionBegin();
			break;
		case GAME_STATE_LEVEL_SELECT:
			GameLevelBegin();
			break;
        case GAME_STATE_LEVELTWL_SELECT:
			GameLevelTwlBegin();
			break;
		case GAME_STATE_GAME_PLAY:
			//coin
			
			mGetCoin = 0;
			mGetScore = 0;
			
			InitializePlayer();
			PlayerJumpTo();//replay..
			
			InitializeGiant();
			
			playBGM(BGM_GAME);		//objAudioPlay(EVENT_TYPE_BACKGROUND, SOUND_TYPE_INDEX_BACKGROUND, (m_bSounds && m_bBgm));
            GamePlayBegin();
			break;

		case GAME_STATE_PAUSE:
			GamePauseBegin();
			break;
		case GAME_STATE_SUC:
			GameSucBegin();
			break;
		//case GAME_STATE_SUC_INFO:
//			GameSucInfoBegin();
//			break;
		case GAME_STATE_OVER:
			GameOverBegin();
			break;
		case GAME_STATE_CAUGHT_OVER:
			GameOverCaughtBegin();
			break;
		case GAME_STATE_CREDIT:
			freeResStory();
			GameCreditsBegin();
			break;
		case GAME_STATE_STORY:
			GameStoryBegin();
			initResStory(mStoryIndex);
			break;
		case GAME_STATE_OPTION:
			GameOptionBegin();
			break;
		case GAME_STATE_HOUSE:
			initResHouse();
            GameHouseBegin();
			break;
        case GAME_STATE_BEDROOM:
			initResHouse();
            GameBedroomBegin();
			break;
		case GAME_STATE_LOADING:
			freeResStory();
			GameLoadingBegin();
			loadStep = 0;
			break;
		case GAME_STATE_NEWS:
			GameNewsBegin();
			break;
		case GAME_STATE_GCOP:
			GameGcOptionBegin();
			break;
#ifdef __IN_APP_PURCHASE__
        case GAME_STATE_STORE:
            GameStoreBegin();
            break;
        case GAME_STATE_RUNNERMODE:
            GameRunnerModeBegin();
            break;
        case GAME_STATE_TRAMPOLINE:
            GameTrampolineBegin();
            break;

#endif
		case GAME_STATE_ADS:
			GameDrawBuyImageBegin();
			break;
#ifdef V_1_1_0
        case GAME_STATE_TIPS:
            GameTipsBegin();
            break;
#endif
		default:
			break;
	}
	return 1;
}

// Game processing
int UpdateGameState(float dt)
{
	switch (g_nGameState)
	{
		case GAME_STATE_INIT:
		{
			Canvas2D* canvas = Canvas2D::getInstance();
			canvas->setOrientation(Canvas2D::ORIENTATION_LEFT);
			canvas->SwitchTo2D();
			SwitchGameState();
		}
			break;
//		case GAME_STATE_SPLASH:
//			GameLogoUpdate(dt);
//			break;
		case GAME_STATE_TITLE:
			GameTitleUpdate(dt);
			break;
//		case GAME_STATE_ACHIEVE:
//			GameAchieveUpdate(dt);
//			break;
		case GAME_STATE_MISSION_SELECT:
			GameSectionUpdate(dt);
			break;
		case GAME_STATE_GAME_PLAY:
			GamePlayUpdate(dt);
			break;
		case GAME_STATE_FAILD:
			break;
		case GAME_STATE_PAUSE:
			GamePauseUpdate(dt);
			break;
		case GAME_STATE_SUC:
			GameSucUpdate();
			break;
		//case GAME_STATE_SUC_INFO:
//			break;
		case GAME_STATE_CREDIT:
			GameCreditsUpdate(dt);
			break;
		case GAME_STATE_OPTION:
			GameTitleUpdate(dt);
			GameOptionUpdate(dt);
			break;
		case GAME_STATE_HOUSE:
			GameHouseUpdate(dt);
			break;
        case GAME_STATE_BEDROOM:
			GameBedroomUpdate(dt);
			break;
		case GAME_STATE_LEVEL_SELECT:
			break;
        case GAME_STATE_LEVELTWL_SELECT:
			GameLevelTwlUpdate(dt);
			break;
		case GAME_STATE_LOADING:
			GameLoadingUpdate(dt);
			break;
		case GAME_STATE_NEWS:
			GameTitleUpdate(dt);
			GameNewsUpdate(dt);
			break;
		case GAME_STATE_GCOP:
			GameTitleUpdate(dt);
			GameGcOptionUpdate(dt);
			break;
#ifdef __IN_APP_PURCHASE__
        case GAME_STATE_STORE:
            GameStoreUpdate(dt);
            break;
        case GAME_STATE_RUNNERMODE:
            GameRunnerModeUpdate(dt);
            break;
        case GAME_STATE_TRAMPOLINE:
            GameTrampolineUpdate(dt);
            break;
#endif
		case GAME_STATE_ADS:
		//	drawBuyImage();
			break;
#ifdef V_1_1_0
        case GAME_STATE_TIPS:
            GameTipsUpdate(dt);
            break;
#endif
		default:
			break;
	}
	
	updateCanvasMask(dt);
	
	return 1;
}

// Game rendering
int RenderGameState(float dt)
{
	switch (g_nGameState)
	{
		case GAME_STATE_INIT:
			break;
//		case GAME_STATE_SPLASH:
//			GameLogoRender(dt);
//			break;
		case GAME_STATE_TITLE:
			GameTitleRender(dt);
			break;
//		case GAME_STATE_ACHIEVE:
//			GameAchieveRender(dt);
//			break;
		case GAME_STATE_MISSION_SELECT:
			GameSectionRender(dt);
			break;
		case GAME_STATE_GAME_PLAY:
			GamePlayRender(dt);
			break;

		case GAME_STATE_SUC:
			GameSucRender(dt);
			break;
		//case GAME_STATE_SUC_INFO:
//			GameSucInfoRender(dt);
//			break;
		case GAME_STATE_PAUSE:
			GamePlayRender(dt);
			GamePauseRender(dt);
			break;
		case GAME_STATE_CREDIT:
			GameCreditsRender(dt);
			break;
		case GAME_STATE_OPTION:
			GameTitleRender(dt);
			GameOptionRender(dt);
			break;
		case GAME_STATE_HOUSE:
            GameBedroomRender(dt);
            GameHouseRender(dt);
			break;
        case GAME_STATE_BEDROOM:
            GameHouseRender(dt);
			GameBedroomRender(dt);
			break;
		case GAME_STATE_LEVEL_SELECT:
			GameLevelRender(dt);
			break;
        case GAME_STATE_LEVELTWL_SELECT:
			GameLevelTwlRender(dt);
			break;
		case GAME_STATE_LOADING:
			GameLoadingRender(dt);
			break;
		case GAME_STATE_STORY:
			GameStoryRender(dt);
			break;
		case GAME_STATE_OVER:
			GameOverRender(dt);
			break;
		case GAME_STATE_CAUGHT_OVER:
			GameOverCaughtRender(dt);
			break;
		case GAME_STATE_NEWS:
			GameTitleRender(dt);
			GameNewsRender(dt);
			break;
		case GAME_STATE_GCOP:
			GameTitleRender(dt);
			GameGcOptionRender(dt);
			break;
		case GAME_STATE_ADS:
			GameDrawBuyImageRender(dt);
			break;
#ifdef __IN_APP_PURCHASE__
        case GAME_STATE_STORE:
            GameStoreRender(dt);
            break;
        case GAME_STATE_RUNNERMODE:
            GameRunnerModeRender(dt);
            break;
        case GAME_STATE_TRAMPOLINE:
            GameTrampolineRender(dt);
            break;
#endif
#ifdef V_1_1_0
        case GAME_STATE_TIPS:
            GameTipsRender(dt);
            break;
#endif
		default:
			break;
	}
	
	renderCanvasMask(dt);
	
#ifdef DBG_MEM_MONITOR
	if (mFont0)
	{
		Canvas2D *canvas = Canvas2D::getInstance();
		double free, total;
		getMem(free, total);
		char temp[32];
		canvas->setColor(1.0f, 0.0f, 0.0f, 1.0f);
		sprintf(temp, "%0.1fM", free/(1024*1024));
		mFont0->drawString(temp, 50, 32);
		sprintf(temp, "= %0.1fM", total/(1024*1024));
		mFont0->drawString(temp, 50, 48);
		canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
	}
#endif
	
	return 1;
}
  
// Process touch info.
int UpdateTouches(int nOption, float fX, float fY)
{
#ifdef VERSION_IPAD
	fX *= 0.5f;
	fY *= 0.5f;
#endif
#if DEBUG
	printf("%f, %f\n", fX, fY);
#endif
	switch (g_nGameState)
	{

		case GAME_STATE_INIT:
			break;
//		case GAME_STATE_SPLASH:
//			GameLogoOnTouchEvent(nOption, fX, fY);
//			break;
		case GAME_STATE_TITLE:
			GameTitleOnTouchEvent(nOption, fX, fY);
			break;
//		case GAME_STATE_ACHIEVE:
//			GameAchieveOnTouchEvent(nOption, fX, fY);
//			break;
		case GAME_STATE_MISSION_SELECT:
			GameSectionOnTouchEvent(nOption, fX, fY);
			break;
		case GAME_STATE_GAME_PLAY:
			GamePlayOnTouchEvent(nOption, fX, fY);
			break;

		case GAME_STATE_PAUSE:
			GamePauseOnTouchEvent(nOption, fX, fY);
			break;
		case GAME_STATE_CREDIT:
			GameCreditsOnTouchEvent(nOption, fX, fY);
			break;
		case GAME_STATE_STORY:
			GameStoryOnTouchEvent(nOption,fX,fY);
			break;
		case GAME_STATE_OPTION:
			GameOptionOnTouchEvent(nOption, fX, fY);
			break;
		case GAME_STATE_HOUSE:
			GameHouseOnTouchEvent(nOption, fX, fY);
			break;
        case GAME_STATE_BEDROOM:
            GameBedroomOnTouchEvent(nOption, fX, fY);
			break;
		case GAME_STATE_LEVEL_SELECT:
			GameLevelOnTouchEvent(nOption, fX, fY);
			break;
        case GAME_STATE_LEVELTWL_SELECT:
			GameLevelTwlOnTouchEvent(nOption, fX, fY);
			break;
		case GAME_STATE_SUC:
		  GameSucOnTouchEvent(nOption, fX, fY);
			break;
		//case GAME_STATE_SUC_INFO:
//			GameSucInfoOnTouchEvent(nOption, fX, fY);
//			break;
		case GAME_STATE_OVER:
			GameOverTouchEvent(nOption, fX, fY);
			break;
		case GAME_STATE_CAUGHT_OVER:
			GameOverCaughtTouchEvent(nOption, fX, fY);
			break;
		case GAME_STATE_LOADING:
			break;
		case GAME_STATE_NEWS:
			GameNewsTouchEvent(nOption, fX, fY);
			break;
		case GAME_STATE_GCOP:
			GameGcOptionTouchEvent(nOption, fX, fY);
			break;
        case GAME_STATE_ADS:
		    GameAdsOnTouchEvent(nOption, fX, fY);
			break;
#ifdef __IN_APP_PURCHASE__
        case GAME_STATE_STORE:
            GameStoreTouchEvent(nOption, fX, fY);
            break;
        case GAME_STATE_RUNNERMODE:
            GameRunnerModeTouchEvent(nOption, fX, fY);
            break;
        case GAME_STATE_TRAMPOLINE:
            GameTrampolineTouchEvent(nOption, fX, fY);
            break;
#endif
#ifdef V_1_1_0
        case GAME_STATE_TIPS:
            GameTipsTouchEvent(nOption, fX, fY);
            break;
#endif
		default:
			return 0;
	}
	return 1;
}

#pragma mark -
#pragma mark Global Fading

void setGlobalFadeInAndGoTo(int nextState)
{
	g_canvas_state = CANVAS_FADE_IN;
	g_alpha = 1.0f;
	g_alpha_delta = -0.05f;
	g_nGameState = nextState;
	SwitchGameState();
}

void setGlobalFadeOutAndGoTo(int nextState)
{
	g_canvas_state = CANVAS_FADE_OUT;
	g_alpha = 0.0f;
	g_alpha_delta = 0.05f;
	g_nGameState = nextState;
	SwitchGameState();
}

void setGlobalFadeInThenGoTo(int nextState)
{
	g_canvas_state = CANVAS_FADE_IN;
	g_alpha = 1.0f;
	g_alpha_delta = -0.05f;
	g_nNextGameState = nextState;
}

void setGlobalFadeOutThenGoTo(int nextState)
{
	g_canvas_state = CANVAS_FADE_OUT;
	g_alpha = 0.0f;
	g_alpha_delta = 0.05f;
	g_nNextGameState = nextState;
}

void setCanvasMaskNormal()
{
	if (g_nNextGameState > 0)
	{
		g_nGameState = g_nNextGameState;
		g_nNextGameState = -1;
		
		
		if (g_nGameState == GAME_STATE_SUC || g_nGameState == GAME_STATE_OVER|| g_nGameState == GAME_STATE_CAUGHT_OVER)
		{
			// Stop the rain SE
			if (stages && stages->rain)
			{
				stages->rain->stopSe();
			}
			
//			RelGcRes();
//			InitGcOverRes((g_nGameState == GAME_STATE_SUC));
			if (g_nGameState == GAME_STATE_OVER || g_nGameState == GAME_STATE_CAUGHT_OVER)
			{
//#ifdef V_1_1_0
//                InitGcOverRes((g_nGameState - GAME_STATE_OVER) + 100);
//#else
				InitGcOverRes((g_nGameState - GAME_STATE_OVER));
//#endif
			}
			else
			{
//#ifdef V_1_1_0
//                InitGcOverRes(ParkourStatistics[ACH_STA_ITEM]);
//#else
				InitGcOverRes(-1);
//#endif
			}
			
			// Get the score and stars
			if (stages && g_nGameState == GAME_STATE_SUC)
			{
				if(levelStageScore[LevelIndex][ActiveLevel] < mGetScore)
				{
					levelStageScore[LevelIndex][ActiveLevel] = mGetScore;
				}
				
                if (LevelIndex < STAGE_SECTION_V001 && ActiveLevel < STAGE_LEVEL_V001)
                {
                    setScore(STAGE_LEVEL_V001*LevelIndex+ActiveLevel, levelStageScore[LevelIndex][ActiveLevel]);
                }
                else if (LevelIndex >= STAGE_SECTION_V001 && ActiveLevel < STAGE_LEVEL_V002)
                {
                    setScore((STAGE_LEVEL_V001*STAGE_SECTION_V001)+ActiveLevel, levelStageScore[LevelIndex][ActiveLevel]);
                }
//				setScore(STAGE_IN_LV_MAX*LevelIndex+ActiveLevel, levelStageScore[LevelIndex][ActiveLevel]);
                
//#ifdef V_1_1_0
//    #ifdef V_FREE
//                if (LevelIndex < STAGE_SECTION_V001 && ActiveLevel < STAGE_LEVEL_V001)
//                {
//                    totalScoreForGameCenter = -1;///int totalScore = 0;
//                    for (int i = 0; i < STAGE_SECTION_V001; i++)
//                    {
//                        levelTotalScore[i] = 0;
//                        for (int j = 0; j < STAGE_LEVEL_V001; j++)
//                        {
//                            levelTotalScore[i] += levelStageScore[i][j];
//                        }
//                        totalScoreForGameCenter += levelTotalScore[i];  ///totalScore += levelTotalScore[i];
//                    }
//                    totalScoreForGameCenter += 1;
//                    ///submitScore(TARGET_OPENFEINT, GC_ID_ALL_LEVELS, totalScore);
//                }
//    #endif
//#endif
			
				if (mGetScore >= stages->star1 && mGetScore < stages->star2)
				{
					levelRating = 1;
				}
				else if (mGetScore >= stages->star2 && mGetScore < stages->star3)
				{
					levelRating = 2;
				}
				else if (mGetScore >= stages->star3)
				{
					levelRating = 3;
				}
				else
				{
					levelRating = 0;
				}
				
				if (mLevelStar[LevelIndex][ActiveLevel] < levelRating)
				{
					mLevelStar[LevelIndex][ActiveLevel] = levelRating;
				}
			}
			else if(stages)
			{
				stages->lastCheckPoint = stages->currentCheckPoint;
				stages->currentCheckPoint = -1;

#ifdef ENABLE_ACHIEVEMENTS
				if (stages->lastCheckPoint < 0)
				{
					ResetTempAchievements();
				}
#endif
			}

#if 0
			mLevelStar[LevelIndex][ActiveLevel] = (int)((float)mGetCoin / (float)nCoinsInCurrentLevel * 3.0f);
#endif
		}

		SwitchGameState();
	}
	
	g_canvas_state = CANVAS_NORMAL;
	g_alpha = 0.0f;
	g_alpha_delta = 0.0f;
}

void updateCanvasMask(float dt)
{
	if (g_canvas_state == CANVAS_FADE_IN)
	{
		g_alpha += g_alpha_delta;
		if (g_alpha <= 0.0f)
		{
			setCanvasMaskNormal();
			g_alpha = 0.0f;
		}
	}
	else if (g_canvas_state == CANVAS_FADE_OUT)
	{
		g_alpha += g_alpha_delta;
		if (g_alpha >= 1.0f)
		{
			setCanvasMaskNormal();
			g_alpha = 1.0f;
		}
	}
}

void renderCanvasMask(float dt)
{
	if (g_canvas_state > 0)
	{
		Canvas2D* canvas = Canvas2D::getInstance();
		canvas->setColor(0.0f, 0.0f, 0.0f, g_alpha);
#ifdef VERSION_IPAD
		canvas->fillRect(0.0f, 0.0f, 0.5f * canvas->mScreenWidth, 0.5f * canvas->mScreenHeight);
#else
		canvas->fillRect(0.0f, 0.0f, canvas->getCanvasWidth(), canvas->getCanvasHeight());
#endif
		canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
	}
}

bool isInFadingProcess()
{
	return (g_canvas_state != CANVAS_NORMAL);
}
