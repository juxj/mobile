/*
 *  GamePlay.cpp
 *  ZPR
 *
 *  Created by Neo Lin on 5/31/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "GamePlay.h"
#import "GameState.h"
#import "GameAchieve.h"
#import "GameAudio.h"
#import "GameOver.h"

//#import "neoRes.h"
#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"
#import "Wrapper.h"

#import "GameRes.h"
#import "GameOption.h"
#import "Stage.h"
#import "Runner.h"
#import "Giant.h"
#import "Opponent.h"
#import "ZPRAppDelegate.h"
#import "zprUIButton.h"

#import "CCMath.h"

#import "Utilities.h"

//#import "Camera.h"
#include "GameSection.h"
#include "GameLevel.h"
#include <math.h>
#import "OpenFeint/OpenFeint.h"
#import "OpenFeint/OFAchievement.h"

#ifdef __IN_APP_PURCHASE__
#import "GameRunnerMode.h"
#import "GameTrampoline.h"
#endif

#ifdef V_1_1_0
#import "GameHouse.h"
#endif


bool btnPlayPress=false;
//float startPlayPointXY[2]={0.0,0.0};

Image* mPause;
Image* mTiledBg[8*8];

#ifdef V_1_1_0
ZprUIButton *inGameBtnRunnerMode;
ZprUIButton *inGameBtnTrampoline;

int extRunnerMode = ITEM_NONE;
int extTrampoline = ITEM_NONE;

Image *spdmTags[4] = {0, 0, 0, 0};

int nShowSpeedMeter = 0;

int spdmState = SPEEDMETER_HIDE;
int spdmLv = 0;
int spdmFadeCnt = 0;
float spdmAlpha = 1.0f;
#endif

Image* mCoin;
int mGetCoin = 0;
int mGetScore = 0;
int levelRating = 0;
int quantityShowRunnermodeN ;
int quantityShowTrampolineN; 

static const char* TitleStart[LEVEL_NUM_MAX][STAGE_IN_LV_MAX] = {
	{WELCOME_CITYS_00, WELCOME_CITYS_01, WELCOME_CITYS_02, WELCOME_CITYS_03, 
	 WELCOME_CITYS_04, WELCOME_CITYS_05, WELCOME_CITYS_06, WELCOME_CITYS_07, 
     "", "", "", ""},
	{WELCOME_SITES_00, WELCOME_SITES_01, WELCOME_SITES_02, WELCOME_SITES_03, 
	 WELCOME_SITES_04, WELCOME_SITES_05, WELCOME_SITES_06, WELCOME_SITES_07, 
     "", "", "", ""},
	{WELCOME_PARAD_00, WELCOME_PARAD_01, WELCOME_PARAD_02, WELCOME_PARAD_03, 
	 WELCOME_PARAD_04, WELCOME_PARAD_05, WELCOME_PARAD_06, WELCOME_PARAD_07, 
     "", "", "", ""},
#ifdef V_1_1_0
    {WELCOME_CITYS2_00, WELCOME_CITYS2_01, WELCOME_CITYS2_02, WELCOME_CITYS2_03, 
	 WELCOME_CITYS2_04, WELCOME_CITYS2_05, WELCOME_CITYS2_06, WELCOME_CITYS2_07, 
     WELCOME_CITYS2_08, WELCOME_CITYS2_09, WELCOME_CITYS2_10, WELCOME_CITYS2_11,}
#endif
};


bool CheckProps()
{
	float action = GetPlayerAction();
	if(action == PLAYER_STATE_STAND) return false;
	
	float tx = GetPlayerX();
	float ty = GetPlayerY();
	
	int th = PLAYER_SHIFT_H;
	if(action == PLAYER_STATE_SCROLL ||action == PLAYER_STATE_SLIDE ||action == PLAYER_STATE_CRAWL){
		th = 30;
	}
	
	if(action <PLAYER_STATE_FAIL 
	   || action >PLAYER_ATTAC_HIPPIE)
	{
		int type = stages->CheckZombie(CHECK_TYPE_HURT, tx -PLAYER_SHIFT_W, ty-th, th);
		if(type != ZOMBIE_TYPE_MAX){
			mOverType = 2;
			SetFailState();
			return true;
		}
	}
	
	if(CheckGiant(0)){
		mOverType = 1;
		SetFailState();
		return true;
	}
	
	// coin
	stages->CheckGettingCoin(tx, ty-th, PLAYER_SHIFT_W*2,th);

	return false;
}

void RenderStart()
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	if(GetPlayerAction() != PLAYER_STATE_STAND) return;
	if(IsAutoState()) return;
	//if(ActiveLevel != 0) return;
	
	char cBuffer[128];
	float x, y;
	
	canvas->setColor(0.0f, 0.0f, 0.0f, 0.8f);
#ifdef VERSION_IPAD
	canvas->fillRect(0.0f, 0.0f, 0.5f * canvas->mScreenWidth, 0.5f * canvas->mScreenHeight);
#else
	canvas->fillRect(0.0f, 0.0f, canvas->getCanvasWidth(), canvas->getCanvasHeight());
#endif
	canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
	
	memset(cBuffer, '\0', sizeof(cBuffer));
	sprintf(cBuffer, "Level %d-%d", (1 + LevelIndex),(1 +ActiveLevel));
	x = (canvas->getCanvasWidth()*IPAD_X - GetStringWidth(cBuffer, 1.2f, FONT_TYPE_SLACKEY)) * 0.5f;
	y = 50.0f*IPAD_X;
	DrawString(cBuffer, x, y, 1.2f, 1.0f, 1.0f, 1.0f, 1.0f);
	
	memset(cBuffer, '\0', sizeof(cBuffer));
	sprintf(cBuffer, "%s", TitleStart[LevelIndex][ActiveLevel]);
	x = (canvas->getCanvasWidth()*IPAD_X - GetStringWidth(cBuffer, WELCOME_FONT_SIZE, FONT_TYPE_SLACKEY)) * 0.5f;
	y = 100.0f*IPAD_X;
	DrawString(cBuffer, x, y, WELCOME_FONT_SIZE, 1.0f, 1.0f, 1.0f, 1.0f);
	
	memset(cBuffer, '\0', sizeof(cBuffer));
	sprintf(cBuffer, "%s", TAP_TO_START);
	x = (canvas->getCanvasWidth()*IPAD_X - GetStringWidth(cBuffer, 1.0f, FONT_TYPE_SCHOOLBELL)) * 0.5f;
	y = 220.0f*IPAD_X;
	DrawString(cBuffer, x, y, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, FONT_TYPE_SCHOOLBELL);
}

void RenderUI()
{
	char str[8] = {'\0'};
	Canvas2D* canvas = Canvas2D::getInstance();
	
#ifdef VERSION_IPAD
	canvas->setColor(0.0f, 0.0f, 0.0f, 1.0f);
	canvas->fillRect(0.0f, 0.0f, canvas->mScreenWidth * 0.5f, 64.0f * 0.5f);
	canvas->fillRect(0.0f, (canvas->mScreenHeight - 64.0f) * 0.5f, canvas->mScreenWidth * 0.5f, 64.0f * 0.5f);
	canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
#endif
	
	// UI
	//canvas->drawImage(mCoin, 10.0f, 8.0f);
	DrawString((char*)"score:", 20.0f, 2.0f, 0.8f, 1.0f, 1.0f, 1.0f, 1.0f);	
	sprintf(str, "%d", mGetScore);
	DrawString(str, 20+GetStringWidth((char*)"score:", 0.8f, 1), 2.0f, 0.8f, 1.0f, 1.0f, 0.0f, 1.0f);	
	
	// Pause Button
	if (g_nGameState != GAME_STATE_PAUSE && 
		g_nGameState != GAME_STATE_OVER&&GetPlayerAction()!=PLAYER_STATE_SUCC&&GetPlayerAction()!=PLAYER_STATE_FAIL)
	{
		if (btnPlayPress)
		{
#ifdef VERSION_IPAD
			canvas->drawImage(mPause, 0.5f * canvas->mScreenWidth - 26.0f, 18.0f, 0.0f, 1.1f, 1.1f);
#else
			canvas->drawImage(mPause, 454.0f, 20.0f, 0.0f, 1.1f, 1.1f);
#endif
		}
		else
		{
#ifdef VERSION_IPAD
			canvas->drawImage(mPause, 0.5f * canvas->mScreenWidth - 26.0f, 18.0f, 0.0f, 1.0f, 1.0f);
#else
			canvas->drawImage(mPause, 454.0f, 20.0f, 0.0f, 1.0f, 1.0f);
#endif
		}
	}
//#if DEBUG
//	canvas->strokeRect(380.0f, 0.0f, 100.0f, 50.0f);
//#endif
}




//tiledhouse
static int TileHouseBG[TILE_HOUSE_ROW][TILE_HOUSE_COL]={
	{
		48, 51, 49, 51,51 ,50, 52,
	},
	{
		57, 30, 30,30, 30, 30, 54,
	},
	{
		56, 30, 30,30, 30, 30, 53,
	},
	{
		56,30, 30, 30,30, 30, 54,
	},
	{
		57,30, 30, 30, 30,30, 54,
	},
	{
		56,30, 30, 30,30, 30, 53,
	},
	{
		58, 59, 59, 59,59, 60, 61,
	}
};

//tiledoption
static int TileOptionBG[TILE_OPTION_ROW][TILE_OPTION_COL]={
	{
		32, 34, 34, 33, 34,34,33,34, 35,
	},
	{
		40, 30, 30, 30, 30,30,30,30, 37,
	},
	{
		42, 30, 30, 30, 30,30,30,30, 36,
	},
	{
		42,30, 30, 30, 30,30,30,30, 37,
	},
	{
		42,30, 30, 30, 30,30,30,30, 37,
	},	
    {
		42,30, 30, 30, 30,30,30,30, 37,
	},
	{
		42,30, 30, 30, 30,30,30,30, 37,
	},
	{
		41,30, 30, 30, 30,30,30,30, 38,
	},
	{
		44, 45, 45, 45, 45,45,45,45, 46,
	}
};

static int TilePauseBG[TILE_OPTION_ROW][TILE_OPTION_COL]={
	{
		32, 34, 34, 33, 34,33,34, 35,
	},
	{
		40, 30, 30, 30, 30,30,30, 37,
	},
	{
		42, 30, 30, 30, 30,30,30, 36,
	},
	{
		42,30, 30, 30, 30,30,30, 37,
	},
	{
		42,30, 30, 30, 30,30,30, 37,
	},	
	{
		42,30, 30, 30, 30,30,30, 37,
	},
	{
		41,30, 30, 30, 30,30,30, 38,
	},
	{
		44, 45, 45, 45, 45,45,45, 46,
	}
};

//tiledselect
static int TileSelectBG[TILE_SELECT_ROW][TILE_SELECT_COL]={
	{
		0, 1, 2, 63, 63, 63, 63, 63,63,63, 63, 3,62,
	},
	{
		8, 30, 30, 30, 30,30, 30, 30,30, 30,30,30, 54,
	},                                           
	{
		15,30, 30, 30, 30,30, 30, 30,30,30, 30,30, 53,
	},
	{
		15,30, 30, 30, 30,30, 30, 30,30,30, 30,30, 54,
	},
	{
		15,30, 30, 30, 30,30, 30, 30,30,30, 30,30, 54,
	},
	{
		15,30, 30, 30, 30,30, 30, 30,30,30, 30,30, 54,
	},
	{
		10,30, 30, 30, 30,30, 30, 30,30,30, 30,30, 54,
	},
	{
		24, 28, 28, 28, 28, 28,28,28, 25,28,28,28,29,
	}
};

//tiledlevel
static int TileLevelBG[TILE_LEVEL_ROW][TILE_LEVEL_COL]={
	{
		0, 6, 63, 7, 63, 63, 63, 63,63,63, 7,63, 63,62,
	},
	{
		15, 30, 30, 30, 30,30, 30, 30,30,30, 30,30,30, 23,
	},
	{
		15,30, 30, 30, 30,30, 30, 30,30,30,30, 30,30, 23,
	},
	{
		15,30, 30, 30, 30,30, 30, 30,30,30,30, 30,30, 23,
	},
	{
		9,30, 30, 30, 30,30, 30, 30,30, 30,30,30,30, 17,
	},
	{
		15,30, 30, 30, 30,30, 30, 30,30,30,30, 30,30,23,
	},
	{
		15,30, 30, 30, 30,30, 30, 30,30,30,30, 30,30,23,
	},
	{
		10,30, 30, 30, 30,30, 30, 30,30,30,30,30,30, 16,
	},
	{
		24, 28, 27, 28, 28, 28,28, 28,28,28,28,28,28,29,
	}
};
//tiledsuc
static int TileSucBG[TILE_SUCC_ROW][TILE_SUCC_COL]={
	{
		0, 63, 3, 63, 63, 63, 63,63, 63,4, 63, 5,62
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30,30, 30,30, 23,
	},
	{
		10, 30, 30, 30, 30, 30,30, 30, 30,30,30,30, 21,
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30, 30,30,30, 23,
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30,30, 30,30, 23,
	},
	{
		11,30, 30, 30, 30,30,30, 30,30,30, 30,30, 23,
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30,30, 30,30, 23,
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30,30, 30,30, 23,
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30,30, 30,30, 22,
	},
	{
		24, 28, 28, 28, 28,28,28, 28,28,28,25,28,29,
	}
};

//tiledfail

static int TileFailBG[TILE_FAIL_ROW][TILE_FAIL_COL]={
	{
		0,63,63,63,63,63,63,63, 3, 63,4,63,62,
	},
	{
		12,30,30,30,30,30,30,30,30,30,30,30,21,
	},
	{
		24,28,28,28,28,28,28,28,28,28,28,28, 29,
	}
};
static int TileFailCaughtBG[TILE_FAIL_CAUGHT_ROW][TILE_FAIL_CAUGHT_COL]={
	{
		0, 63, 3, 63, 4, 5, 63, 62,
	},
	{
		12, 30, 30, 30, 30,30, 30, 21,
	},
	{
		15,30, 30, 30, 30,30, 30, 23,
	},
	{
		13,30, 30, 30, 30,30, 30, 20,
	},
	{
		24,28, 28, 28, 28,26, 28, 29,
	}
};
static int TileSuccInfolBG[TILE_SUCC_INFO_ROW][TILE_SUCC_INFO_COL]={
	{
		0, 63, 3, 63, 63, 63, 63,63, 63,4, 63,63,63,63, 5,62
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30,30, 30,30,30,30,30, 23,
	},
	{
		9, 30, 30, 30, 30, 30,30, 30, 30,30,30,30,30,30,30, 21,
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30, 30,30,30,30,30,30, 23,
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30,30, 30,30,30,30,30, 23,
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30,30, 30,30,30,30,30, 23,
	},
	{
		15,30, 30, 30, 30,30,30, 30,30,30, 30,30,30,30,30, 23,
	},
	{
		10,30, 30, 30, 30, 30,30, 30,30,30, 30,30,30,30,30, 23,
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30,30, 30,30,30,30,30, 23,
	},
	{
		15,30, 30, 30, 30, 30,30, 30,30,30, 30,30,30,30,30, 22,
	},
	{
		24, 28, 28, 28, 28,28,28, 28,28,28,25,28,28,28,28,29,
	}
};

void RenderTileBG(int type, int x, int y,float scaleX,float scaleY)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	switch (type) {
	case TYPE_HOUSE_BG:
			for (int i=0; i<TILE_HOUSE_ROW; i++) {
				for (int j=0; j<TILE_HOUSE_COL;j++) {
					int num = TileHouseBG[i][j];
					mTiledBg[num]->SetColor(1, 1, 1, 0.9);
					canvas->drawImage(mTiledBg[num], int( x+j*30*scaleX), int(y+i*30*scaleY),0,scaleX,scaleY);
					mTiledBg[num]->SetColor(1, 1, 1, 1);
				}
			}
		break;
	case TYPE_OPTION_BG:
			for (int i=0; i<TILE_OPTION_ROW; i++) {
				for (int j=0; j<TILE_OPTION_COL;j++) {
					int num = TileOptionBG[i][j];
					mTiledBg[num]->SetColor(1, 1, 1, 0.9);
				canvas->drawImage(mTiledBg[num], int( x+j*30*scaleX), int(y+i*30*scaleY),0,scaleX,scaleY);
					mTiledBg[num]->SetColor(1, 1, 1, 1);
				}
			}
		break;
    case TYPE_PAUSE_BG:
        for (int i=0; i<TILE_PAUSE_ROW; i++) {
            for (int j=0; j<TILE_PAUSE_COL;j++) {
                int num = TilePauseBG[i][j];
                mTiledBg[num]->SetColor(1, 1, 1, 0.9);
                canvas->drawImage(mTiledBg[num], int( x+j*30*scaleX), int(y+i*30*scaleY),0,scaleX,scaleY);
                mTiledBg[num]->SetColor(1, 1, 1, 1);
            }
        }
        break;
	case TYPE_SELECT_BG:
			for (int i=0; i<TILE_SELECT_ROW; i++) {
				for (int j=0; j<TILE_SELECT_COL;j++) {
					int num = TileSelectBG[i][j];
					canvas->drawImage(mTiledBg[num],int( x+j*29*scaleX), int(y+i*29*scaleY),0,scaleX,scaleY);
				}
			}
		break;
	case TYPE_LEVEL_BG:
			for (int i=0; i<TILE_LEVEL_ROW; i++) {
				for (int j=0; j<TILE_LEVEL_COL;j++) {
					int num = TileLevelBG[i][j];
					canvas->drawImage(mTiledBg[num],int( x+j*29*scaleX), int(y+i*29*scaleY),0,scaleX,scaleY);
				}
			}
		break;
    
	case TYPE_SUCC_BG:
			for (int i=0; i<TILE_SUCC_ROW; i++) {
				for (int j=0; j<TILE_SUCC_COL;j++) {
					int num = TileSucBG[i][j];
				canvas->drawImage(mTiledBg[num],int( x+j*29*scaleX), int(y+i*29*scaleY),0,scaleX,scaleY);
				}
			}
		break;
	case TYPE_FAIL_BG:
			for (int i=0; i<TILE_FAIL_ROW; i++){
				for (int j=0; j<TILE_FAIL_COL;j++) {
					int num = TileFailBG[i][j];
					canvas->drawImage(mTiledBg[num],int( x+j*29*scaleX), int(y+i*29*scaleY),0,scaleX,scaleY);
					
				}
			}
		break;
			
	case TYPE_FAIL_CAUGHT_BG:
		for (int i=0; i<TILE_FAIL_CAUGHT_ROW; i++) {
			for (int j=0; j<TILE_FAIL_CAUGHT_COL;j++) {
				int num = TileFailCaughtBG[i][j];
				mTiledBg[num]->SetColor(1, 1, 1, 0.9);
				canvas->drawImage(mTiledBg[num],int( x+j*30*scaleX), int(y+i*30*scaleY),0,scaleX,scaleY);
				mTiledBg[num]->SetColor(1, 1, 1, 1);
			}
		}
		break;
	case TYPE_SUCC_INFO_BG:
			for (int i=0; i<TILE_SUCC_INFO_ROW; i++) {
				for (int j=0; j<TILE_SUCC_INFO_COL;j++) {
					int num = TileSuccInfolBG[i][j];
					canvas->drawImage(mTiledBg[num],int( x+j*29*scaleX), int(y+i*29*scaleY),0,scaleX,scaleY);
					
				}
			}
			break;

	default:
		break;
   }	
}


//void GamePlayEnd();
void GamePlayUpdate(float dt)
{
	if (!stages) return;
	
	dt *= stages->currTimeRatio;
	
	stages->update(dt, mScrollWorld, 0.0f);
	
	float ax = GetPlayerX();
	UpdatePlayer(dt);
	float bx = GetPlayerX();
	UpdateWorld(dt);
	
	if ((g_nGameState != GAME_STATE_PAUSE) && 
        (GetPlayerAction() != PLAYER_STATE_STAND))
	{
		float dx = bx-ax;
		MoveGiant(dt,dx);
		UpdateGiant(dt);
	}
	
	UpdateShadow();
	CheckProps();
	
#ifdef __IN_APP_PURCHASE__
    // Speed Meter
    updateSpeedMeter(dt);
    
    checkRunnerModeIsUsable();
    checkTrampolineIsUsable();
#endif
    
//	Camera* camera = Camera::getInstance();
//	camera->update(dt);
}

void GamePlayRender(float dt)
{
//	Camera* camera = Camera::getInstance();
//	static float camY = 0.0f;
//	static float ang = 0.0f;
//	ang += 2.0f;
//	camY = 160.0f*sinf(3.1415926f/180.0f*ang);
//	camera->setCamera(0.0f, camY, 1.0f, 1.0f);
//	camera->setCamera(120.0f, 160.0f, 0.5f, 0.5f);
//	camera->setCamera(0.0f, 160.0f, 0.5f, 0.5f);
	
//	static float moveCamX = 0.0f;
//	static float moveDirX = 5.0f;
//	moveCamX += moveDirX;
//	if (moveCamX > 50.0f || moveCamX < -50.0f)
//	{
//		moveDirX *= -1.0f;
//	}
//	camera->setCamera(moveCamX, 0.0f, 1.0f, 1.0f);
	
	// camera test
//	if (1)
//	{
//		static float camY = 0.0f;
//		static float ang = 1.0f;
//		camY += ang;
//		if (camY * camY >= 100.0f)
//		{
//			ang = -ang;
//		}
//		panUpDnCamera(camY);
//		//return;
//	}
	
	//stage
	if (stages)
	{
		stages->render(dt);
		
		//player
		RenderGiant();
		RenderShadow();
		RenderPlayer();
		
#ifdef __IN_APP_PURCHASE__
        inGameBtnRunnerMode->render();
        inGameBtnTrampoline->render();
        
        char temp[6];
#ifndef CHEAT_UNLIMITED_ITMES
        if (quantityShowRunnermodeN > 0)
#endif
        {
            sprintf(temp ,"X%d",quantityShowRunnermodeN);
            DrawString(temp , 20.0f*IPAD_X, 76.0f, 0.5f);
        }
#ifndef CHEAT_UNLIMITED_ITMES
        if (quantityShowTrampolineN > 0)
#endif
        {
            sprintf(temp ,"X%d",quantityShowTrampolineN);
            DrawString(temp , 20.0f*IPAD_X, 140.0f, 0.5f);
        }
        // Speed Meter
        renderSpeedMeter(dt);
#endif
        
		stages->renderEffects(dt);
	}
	
	Canvas2D* canvas = Canvas2D::getInstance();
	canvas->flush();
	
//	camera->restore();
	
	RenderStart();
	RenderUI();
}

void GamePlayOnTouchEvent(int touchStatus, float fX, float fY)
{
#ifdef V_1_1_0
    if ((g_nGameState != GAME_STATE_PAUSE) && 
        (GetPlayerAction() != PLAYER_STATE_STAND))
	{
        if (inGameBtnRunnerMode->onTouch(touchStatus, fX, fY))
        {
            if (inGameBtnRunnerMode->getButtonState() == ZPR_UI_BTN_RELEASED)
            {
                inGameBtnRunnerMode->setButtonState(ZPR_UI_BTN_NORMAL);
                useItemRunnerMode();
                return;
            }
            return;
        }
        else if (inGameBtnTrampoline->onTouch(touchStatus, fX, fY))
        {
            if (inGameBtnTrampoline->getButtonState() == ZPR_UI_BTN_RELEASED)
            {
                inGameBtnTrampoline->setButtonState(ZPR_UI_BTN_NORMAL);
                useItemTrampoline();
                return;
            }
            return;
        }
    }
#endif
	if (touchStatus == 1)
	{
		if(GetPlayerAction()==PLAYER_STATE_SUCC||GetPlayerAction()==PLAYER_STATE_FAIL) 
		{ 
			return;
		}
#ifdef VERSION_IPAD
		Canvas2D* canvas = Canvas2D::getInstance();
		if (fX > (0.5f * canvas->mScreenWidth - 44.0f) && fX < (0.5f * canvas->mScreenWidth - 4.0f) && fY > 7.0f && fY < 46.0f)
#else
		if (fX > 436.0f && fX < 476.0f && fY > 7.0f && fY < 46.0f)
#endif
		{
			playSE(SE_BUTTON_CONFIRM);
			g_nGameState = GAME_STATE_PAUSE;
			SwitchGameState();
			return;
		}
//		startPlayPointXY[0]=fX;
//		startPlayPointXY[1]=fY;
//		if (fX > 380.0f && fX < 480.0f && fY > 0.0f && fY < 50.0f)
//		{
//			btnPlayPress=true;	
//		}
	}
//	else if (touchStatus == 2)
//	{
//		if ((fX > 380.0f && fX < 480.0f && fY > 0.0f && fY < 50.0f)&&
//			(startPlayPointXY[0] > 380.0f && startPlayPointXY[0] < 480.0f && startPlayPointXY[1] > 0.0f && startPlayPointXY[1] < 50.0f))
//		{
//			
//			btnPlayPress=true;
//			
//		}
//		else {
//			btnPlayPress=false;
//		}
//		
//	}
//	else if (touchStatus == 3)
//	{
//		btnPlayPress=false;
//		if ((fX > 380.0f && fX < 480.0f && fY > 0.0f && fY < 50.0f)&&
//			(startPlayPointXY[0] > 380.0f && startPlayPointXY[0] < 480.0f && startPlayPointXY[1] > 0.0f && startPlayPointXY[1] < 50.0f))
//		{
//			if (touchStatus != 3) return;
//			playSE(SE_BUTTON_CONFIRM);
//			
//			g_nGameState = GAME_STATE_PAUSE;
//			SwitchGameState();
//			return;
//		}
//	}
	if (!isInFadingProcess() && (g_nGameState != GAME_STATE_PAUSE))
	{
		TouchPlayer(touchStatus,fX,fY);
	}
}

#ifdef __IN_APP_PURCHASE__

void updateItemCounts(){
    quantityShowTrampolineN = [app.iap quantityTrampolineInLocalStore];
    quantityShowRunnermodeN=[app.iap quantityRunnerModeInLocalStore];
}
void GamePlayBegin(){

}


bool checkRunnerModeIsUsable()
{
    bool ret = true;
#ifndef CHEAT_UNLIMITED_ITMES
    if (quantityShowRunnermodeN <= 0)
    {
        ret = false;
    }
#endif
    if (mFastLevel == 3)
    {
        ret = false;
    }
    if (!isEnableTouchRm())
    {
        ret = false;
    }
    if (usingIgRm)
    {
        ret = false;
    }
    int action = GetPlayerAction();
	if (action == PLAYER_STATE_FAIL)
    {
        ret = false;
    }
    if (!ret)
    {
        inGameBtnRunnerMode->_isEnabled = false;
    }
    else
    {
        inGameBtnRunnerMode->_isEnabled = true;
    }
    return ret;
}

bool checkTrampolineIsUsable()
{
    bool ret = true;
#ifndef CHEAT_UNLIMITED_ITMES
    if (quantityShowTrampolineN <= 0)
    {
        ret = false;
    }
#endif
    if (stages->lastCheckPoint >= (stages->nCheckPoint - 1))
    {
        ret = false;
    }
    if (!isEnableTouchTr())
    {
        ret = false;
    }
    int action = GetPlayerAction();
	if (action == PLAYER_STATE_FAIL)
    {
        ret = false;
    }
    if (!ret)
    {
        inGameBtnTrampoline->_isEnabled = false;
    }
    else
    {
        inGameBtnTrampoline->_isEnabled = true;
    }
    return ret;
}


void useItemRunnerMode()
{
    if (!(inGameBtnRunnerMode->_isEnabled))
    {
		return;
	}
    
//#ifdef DEBUG
//    if (quantityShowRunnermodeN>0)
//    {
//        extRunnerMode = ITEM_READY;
//    }
//#endif
//    if ((extRunnerMode == ITEM_READY) && ((spdmLv <= 0) || (spdmLv > 0 && mFastLevel < spdmLv)))
//    if (extRunnerMode == ITEM_READY)
    {
        usingIgRm = true;
        igRmCnt = 0;
        stages->enteringSlowMotion();
        
        printf("Item RunnerMode is not ready.\n");
        {
			mFastFlag = true;
			mFastLevel = 3;
			stages->makeCollectingEffect(EFFECT_RUNNER_MODE, mEffect3, 
                                         GetPlayerX() - PLAYER_SHIFT_X - mScrollWorld - 24, GetPlayerY() - PLAYER_SHIFT_H);
//            setSpeedMeter(mFastLevel);
			playSE(SE_RUNNER_FASTER_3);//faster
			playSE(SE_RUNNER_RUN_MODE);	// activate runner mode
            ResetShadow();
            
            g_nGameState = GAME_STATE_RUNNERMODE;
            SwitchGameState();
            quantityShowRunnermodeN= [app.iap reduceRunnerModeInLocalStoreWithQuantity:1];
		}
          

#ifdef DEBUG
        printf("Use RunnerMode\n");
#endif
    }
//#ifdef DEBUG
//    else
//    {
//        printf("Item Runner Mode is not ready.\n");
//    }
//#endif
}

void useItemTrampoline()
{
    if (!(inGameBtnTrampoline->_isEnabled))
    {
		return;
	}
    
    stages->enteringSlowMotion();
//#ifdef DEBUG
//    if (quantityShowTrampolineN>0)
//    {
//        extTrampoline = ITEM_READY;
//    }
//#endif
//    if (stages->currentCheckPoint < (stages->nCheckPoint - 1))
    {
//        if (extTrampoline == ITEM_READY)
        {
            {
                playSE(SE_RUNNER_FASTER_3); // 
                playSE(SE_RUNNER_RUN_MODE);	// 
                
//                setGlobalFadeInAndGoTo(GAME_STATE_TRAMPOLINE);
                g_nGameState = GAME_STATE_TRAMPOLINE;
    			SwitchGameState();
                quantityShowTrampolineN=   [app.iap reduceTrampolineInLocalStoreWithQuantity:1];
            }
     
          
            
    #ifdef DEBUG
            printf("Use Trampoline\n");
    #endif
        }
//    #ifdef DEBUG
//        else
//        {
//            printf("Item Trampoline is not ready.\n");
//        }
//    #endif
    }
}

void updateItemUsage()
{
    if (extRunnerMode > ITEM_NOTALLOW)
    {
        if (extRunnerMode == ITEM_USE)
        {
            ;
        }
        else if (extRunnerMode == ITEM_IN_USE)
        {
            ;
        }
    }
    if (extTrampoline)
    {
        if (extTrampoline == ITEM_USE)
        {
            ;
        }
        else if (extTrampoline == ITEM_IN_USE)
        {
            ;
        }
    }
}



void setSpeedMeter(int level)
{
    if (mFastFlag)
    {
        spdmState = SPEEDMETER_SHOW;

//        switch (level)
//        {
//            case -1:
//                spdmLv = mFastLevel;
//                spdmState = SPEEDMETER_FADE_OUT;
//                break;
//            case 1:
//                spdmLv = mFastLevel;
//                spdmState = SPEEDMETER_SHOW;
//                nShowSpeedMeter = MAX_TIME_TO_SHOW_SPD_METER;
//
//                break;
//            case 2:
//                spdmLv = mFastLevel;
//                spdmState = SPEEDMETER_SHOW;
//                nShowSpeedMeter = MAX_TIME_TO_SHOW_SPD_METER;
//
//                break;
//            case 3:
//                spdmLv = mFastLevel;
//                spdmState = SPEEDMETER_SHOW;
//                nShowSpeedMeter = MAX_TIME_TO_SHOW_SPD_METER;
//                
//                break;
//            default:
//                break;
//        }
        
        igRmState = IG_RUNNERMODE_ANIM_0;
        igRmWordsCount = 0;
        
        igRmMeterAlpha = 1.0f;
        igRmWordsAlpha = 1.0f;
        igRmMeterScaleX = IG_RM_METER_SCALE_X_FINAL / 3.0f;
        igRmMeterScaleY = IG_RM_METER_SCALE_Y_FINAL / 3.0f;
        igRmWordsScaleX = IG_RM_WORDS_SCALE_X_FINAL / 3.0f;
        igRmWordsScaleY = IG_RM_WORDS_SCALE_Y_FINAL / 3.0f;
        igRmRhSel = 0;
    }
}

void updateSpeedMeter(float dt)
{
    if (mFastFlag)
    {
        switch (igRmState)
        {
            case IG_RUNNERMODE_ANIM_0:
                igRmMeterScaleX += 0.5f;
                if (igRmMeterScaleX >= IG_RM_METER_SCALE_X_FINAL)
                {
                    igRmMeterScaleX = IG_RM_METER_SCALE_X_FINAL;
                    
                    igRmRhSel = ++igRmRhSel % 4;
                }
                igRmMeterScaleY += 0.5f;
                if (igRmMeterScaleY >= IG_RM_METER_SCALE_Y_FINAL)
                {
                    igRmMeterScaleY = IG_RM_METER_SCALE_Y_FINAL;
                }
                
                igRmWordsScaleX += 0.2f;
                igRmWordsScaleY += 0.2f;
                
                igRmWordsAlpha -= 0.06f;
                if (igRmWordsAlpha <= 0.0f)
                {
                    igRmWordsAlpha = 0.0f;
                    igRmState = IG_RUNNERMODE_ANIM_1;
                }
                
                break;
            case IG_RUNNERMODE_ANIM_1:
                igRmRhSel = ++igRmRhSel % 4;
                ++igRmWordsCount;
                if (igRmWordsCount > (IG_RUNNERMODE_WORDS_STIME * 0.5f))
                {
                    igRmMeterAlpha -= 0.05f;
                    if (igRmMeterAlpha <= 0.0f)
                    {
                        igRmMeterAlpha = 0.0f;
                        igRmState = IG_RUNNERMODE_DONE;
                    }
                }
                break;
            case IG_RUNNERMODE_DONE:
                break;
            default:
                break;
        }
    }
//    if ((spdmState > SPEEDMETER_HIDE) && (nShowSpeedMeter > 0))
//    {
//        if (spdmState == SPEEDMETER_SHOW)
//        {
//            if (spdmPane->isLastMoveInAction() && (nShowSpeedMeter > 1))
//            {
//                spdmPane->setCurrentAction(2+mFastLevel);
//                spdmPane->restartAction();
//                --nShowSpeedMeter;
//            }
//        }
//        else if (spdmState == SPEEDMETER_FADE_OUT)
//        {
////            ++spdmFadeCnt;
////            if (spdmFadeCnt < SPEEDMETER_FADE_OUT_TIME)
////            {
//                spdmAlpha -= 1.0f/((float)SPEEDMETER_FADE_OUT_TIME);
////            }
//            if (spdmAlpha < 0.0f)
//            {
//                spdmAlpha = 0.0f;
//                spdmState = SPEEDMETER_HIDE;
//
//            }
//            else
//            {
//                spdmTags[SPEEDMETER_TAG]->SetColor(1.0f, 1.0f, 1.0f, spdmAlpha);
//                spdmTags[SPEEDMETER_TAG+spdmLv]->SetColor(1.0f, 1.0f, 1.0f, spdmAlpha);
//                spdmFire->mFrames[spdmFire->getCurrentActionStart() + spdmFire->getCurrentFrameIndex()].mImage->SetColor(1.0f, 1.0f, 1.0f, spdmAlpha);
//                spdmPane->mFrames[spdmPane->getCurrentActionStart() + spdmPane->getCurrentFrameIndex()].mImage->SetColor(1.0f, 1.0f, 1.0f, spdmAlpha);
//            }
//        }
//    }
}

void renderSpeedMeter(float dt)
{
    if (mFastFlag)
    {
        Canvas2D *canvas = Canvas2D::getInstance();
        switch (igRmState)
        {
            case IG_RUNNERMODE_ANIM_0:
                switch (mFastLevel)
            {
                case 1:
                    canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_0], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, igRmMeterScaleX, igRmMeterScaleY);
                    if (igRmWordsScaleX >= IG_RM_WORDS_SCALE_X_FINAL)
                    {
                        canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, IG_RM_WORDS_SCALE_X_FINAL, IG_RM_WORDS_SCALE_Y_FINAL);
                    }
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmWordsAlpha);
                    canvas->enableColorPointer(true);
                    canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, igRmWordsScaleX, igRmWordsScaleY);
                    canvas->enableColorPointer(false);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                    break;
                case 2:
                    canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_1], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, igRmMeterScaleX, igRmMeterScaleY);
                    if (igRmWordsScaleX >= IG_RM_WORDS_SCALE_X_FINAL)
                    {
                        canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, IG_RM_WORDS_SCALE_X_FINAL, IG_RM_WORDS_SCALE_Y_FINAL);
                    }
                    
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmWordsAlpha);
                    canvas->enableColorPointer(true);
                    canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, igRmWordsScaleX, igRmWordsScaleY);
                    canvas->enableColorPointer(false);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                    break;
                case 3:
                    canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_2], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, igRmMeterScaleX, igRmMeterScaleY);
                    if (igRmWordsScaleX >= IG_RM_WORDS_SCALE_X_FINAL)
                    {
                        if (igRmRhSel/2 == 0)
                        {
                            canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_1], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, IG_RM_WORDS_SCALE_X_FINAL, IG_RM_WORDS_SCALE_Y_FINAL);
                        }
                        else
                        {
                            canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, IG_RM_WORDS_SCALE_X_FINAL, IG_RM_WORDS_SCALE_Y_FINAL);
                        }
                    }
                    
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmWordsAlpha);
                    canvas->enableColorPointer(true);
                    canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, igRmWordsScaleX, igRmWordsScaleY);
                    canvas->enableColorPointer(false);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                    //                    canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_1], 240.0f, 68.0f, 0.0f, 1.48f, 1.0f);
                    break;
                default:
                    break;
            }
                break;
            case IG_RUNNERMODE_ANIM_1:
                switch (mFastLevel)
                {
                    case 1:
                        igRmMeter[IG_RUNNERMODE_METER_0]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                        igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                        canvas->enableColorPointer(true);
                        canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_0], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, 1.11f, 1.52f);
                        canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, 1.48f, 1.0f);
                        canvas->enableColorPointer(false);
                        igRmMeter[IG_RUNNERMODE_METER_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                        igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                        break;
                    case 2:
                        igRmMeter[IG_RUNNERMODE_METER_1]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                        igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                        canvas->enableColorPointer(true);
                        canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_1], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, 1.11f, 1.52f);
                        canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, 1.48f, 1.0f);
                        canvas->enableColorPointer(false);
                        igRmMeter[IG_RUNNERMODE_METER_1]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                        igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                        break;
                    case 3:
                        igRmMeter[IG_RUNNERMODE_METER_2]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                        igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                        igRmRHigh[IG_RUNNERMODE_RHIGH_1]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                        canvas->enableColorPointer(true);
                        canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_2], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, 1.11f, 1.52f);
                        if (igRmRhSel)
                        {
                            canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_1], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, 1.48f, 1.0f);
                        }
                        else
                        {
                            canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, 1.48f, 1.0f);
                        }
                        canvas->enableColorPointer(false);
                        igRmMeter[IG_RUNNERMODE_METER_2]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                        igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                        igRmRHigh[IG_RUNNERMODE_RHIGH_1]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                        
//                        canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_1], 240.0f, 68.0f, 0.0f, 1.48f, 1.0f);
                        break;
                    default:
                        break;
                }
                break;
            case IG_RUNNERMODE_DONE:
                break;
            default:
                break;
        }
    }
//    if ((spdmState > SPEEDMETER_HIDE) && (nShowSpeedMeter > 0))
//    {
//        Canvas2D *canvas = Canvas2D::getInstance();
//        
//        float baseX = (canvas->mScreenWidth - (SPEEDMETER_FIRE_W * IMG_RES_SCALE)) * 0.5f;
//        float baseY = SPEEDMETER_FIRE_Y;
//        
//        canvas->flush();
//        canvas->enableColorPointer(true);
//        
//        spdmFire->render(baseX, baseY);
//        spdmPane->render(baseX+SPEEDMETER_PANE_OFFX, baseY+SPEEDMETER_PANE_OFFY);
//        
//        canvas->drawImage(spdmTags[SPEEDMETER_TAG], baseX+SPEEDMETER_TAG_OFFX, baseY+SPEEDMETER_TAG_OFFY);
//        switch (spdmLv) {
//            case 1:
//                canvas->drawImage(spdmTags[SPEEDMETER_TAG1], 
//                                  baseX+SPEEDMETER_TAG_OFFX+SPEEDM_NUM_OFFX, 
//                                  baseY+SPEEDMETER_TAG_OFFY+SPEEDM_NUM_OFFY);
//                break;
//            case 2:
//                canvas->drawImage(spdmTags[SPEEDMETER_TAG2], 
//                                  baseX+SPEEDMETER_TAG_OFFX+SPEEDM_NUM_OFFX, 
//                                  baseY+SPEEDMETER_TAG_OFFY+SPEEDM_NUM_OFFY);
//                break;
//            case 3:
//                canvas->drawImage(spdmTags[SPEEDMETER_TAG3], 
//                                  baseX+SPEEDMETER_TAG_OFFX+SPEEDM_NUM_OFFX, 
//                                  baseY+SPEEDMETER_TAG_OFFY+SPEEDM_NUM_OFFY);
//                break;
//            default:
//                break;
//        }
//        
//        canvas->enableColorPointer(false);
//        canvas->flush();
//    }
}

#endif
