/*
 *  GamePause.cpp
 *  ZPR
 *
 *  Created by Linda Li on 6/23/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "GamePause.h"
#include "GameOption.h"
#import "GameAudio.h"
#import "GameState.h"
#import "GameRes.h"

#import "Stage.h"
#import "Runner.h"
#import "Rain.h"

#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"
#import "GamePlay.h"
#include "neoRes.h"
#import "Utilities.h"
//#import "GameLoading.h"

Image* mResume;
Image* mRestart;
Image* mPauseBG;

bool BtnPausePress[5] = {false, false, false, false, false};
float m_fPauseOffset = -250.0f;
 #ifdef VERSION_IPAD
    float PausePicPos[8] = 
    {	
        293.0f*IPAD_X,  87.0f*IPAD_X+IPAD_THREE_Y,	// volume
        293.0f*IPAD_X, 130.0f*IPAD_X+IPAD_THREE_Y,	// music
        291.0f*IPAD_X, 172.0f*IPAD_X+IPAD_THREE_Y,	// openfeit
        288.0f*IPAD_X, 213.0f*IPAD_X+IPAD_THREE_Y,	// gamecenter
    };
#else
    float PausePicPos[8] = 
    {	
        293.0f*IPAD_X,  82.0f*IPAD_X+IPAD_THREE_Y,	// volume
        295.0f*IPAD_X, 128.0f*IPAD_X+IPAD_THREE_Y,	// music
        291.0f*IPAD_X, 172.0f*IPAD_X+IPAD_THREE_Y,	// openfeit
        290.0f*IPAD_X, 214.0f*IPAD_X+IPAD_THREE_Y,	// gamecenter
    };
#endif
float PauseWordPos[8] = 
{	
	-10.f,  87.f,	// volume
	-12.f, 128.f,	// music
	-12.f, 174.f,	// openfeit
	-12.f, 219.f	// gamecenter
};
float mBtnRectPause[BTN_ELE_MAX_OPTIONS] = 
{//	x0,		x1,		y0,		             y1
    140.0f*IPAD_X, 340.0f*IPAD_X, (73.0f+45.0f*0.0f)*IPAD_X+IPAD_TWO_Y, (73.0f+45.0f*0.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: sound(fX > 154 && fX < 325  && fY > 76 && fY < 119)
    140.0f*IPAD_X, 340.0f*IPAD_X, (73.0f+45.0f*1.0f)*IPAD_X+IPAD_TWO_Y, (73.0f+45.0f*1.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: music if(fX > 151 && fX < 326  && fY > 119 && fY < 164)
    140.0f*IPAD_X, 340.0f*IPAD_X, (73.0f+45.0f*2.0f)*IPAD_X+IPAD_TWO_Y, (73.0f+45.0f*2.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: openfeintif(fX > 152 && fX < 329  && fY > 165 && fY < 208)
    140.0f*IPAD_X, 340.0f*IPAD_X, (73.0f+45.0f*3.0f)*IPAD_X+IPAD_TWO_Y, (73.0f+45.0f*3.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: gamecenter 150 && fX < 325  && fY > 210 && fY < 252)
    340.0f*IPAD_X, 388.0f*IPAD_X, 32.0f*IPAD_X+IPAD_TWO_Y, 80.0f*IPAD_X+IPAD_TWO_Y			// UI Button if(fX > 315 && fX < 365  && fY > 43 && fY < 79)
};

void GamePauseBegin()
{
	m_fPauseOffset = -250.0f;
	if (stages && stages->rain)
	{
		stages->rain->stopSe();
	}
}

void GamePauseEnd()
{
}

void GamePauseUpdate(float dt)
{
}

void GamePauseRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	canvas->enableColorPointer(true);

	RenderTileBG(TYPE_PAUSE_BG,(canvas->getCanvasWidth()*IPAD_X-TILE_PAUSE_COL*BG_OPTIOH_UINIT_WIDTH)/2, (canvas->getCanvasHeight()*IPAD_X+IPAD_Y-TILE_PAUSE_ROW*BG_OPTIOH_UINIT_WIDTH)/2,1,1);

	canvas->enableColorPointer(false);
	if (BtnPausePress[4]) 
    {
		canvas->drawImage(mClose, 350.f*IPAD_X, 52.f*IPAD_X+IPAD_TWO_Y, 0.0f, 1.5f, 1.5f);
	} else {
		canvas->drawImage(mClose, 350.f*IPAD_X, 52.f*IPAD_X+IPAD_TWO_Y,0.0f, 1.2f, 1.2f);
	}
	for (int i = 0; i < 16; i += 4)
	{
		if (BtnPausePress[i/4]) {
			canvas->drawImage(optionBtnImg[OPTION_BTN_BG], 
							  canvas->getCanvasWidth()*IPAD_X/2, 
                              96.0*IPAD_X+IPAD_TWO_Y+i/4*(optionBtnImg[OPTION_BTN_BG]->getHeight() * (2.0f / GLOBAL_CANVAS_SCALE)), 
							  0.0f, 1.1f, 1.1f);
		} else {
			canvas->drawImage(optionBtnImg[OPTION_BTN_BG], 
							  canvas->getCanvasWidth()*IPAD_X/2, 
                              96.0*IPAD_X+IPAD_TWO_Y+i/4*(optionBtnImg[OPTION_BTN_BG]->getHeight() * (2.0f / GLOBAL_CANVAS_SCALE)), 
							  0.0f, BAR_SCALEX, BAR_SCALEY);
		}
	}
	int btnOffset = 0;
	for (int i = 0; i < 16; i += 4)
	{
//		btnOffset = (((i>>2==0)&&(m_bSounds))?0:1);
		if (i == 8) {
#ifdef V_1_1_0
            btnOffset = m_bSounds?0:5;
#else
			btnOffset = m_bSounds?0:4;
#endif
		} else if (i == 12) {
#ifdef V_1_1_0
            btnOffset = m_bBgm?0:5;
#else
			btnOffset = m_bBgm?0:4;
#endif
		} else {
			btnOffset = 0;
		}
		
		if (BtnPausePress[i/4]) {
			DrawString(Name[LEVEL_NUM_MAX+i/4], 
					   (canvas->getCanvasWidth()*IPAD_X-optionBtnImg[OPTION_BTN_BG]->getWidth())*0.5f, PauseWordPos[(i/2)+1]+IPAD_ONE_Y, 
					   WORD_SCALE, 1.0f, 1.0f, 0.0f, 1.0f, FONT_TYPE_SLACKEY);
			canvas->drawImage(optionBtnImg[i/4+btnOffset], PausePicPos[i/2], PausePicPos[(i/2)+1]);
		} else {
			DrawString(Name[LEVEL_NUM_MAX+i/4], 
					   (canvas->getCanvasWidth()*IPAD_X-optionBtnImg[OPTION_BTN_BG]->getWidth())*0.5f, PauseWordPos[(i/2)+1]+IPAD_ONE_Y, 
					   0.5f, 1.0f, 1.0f, 1.0f, 1.0f, FONT_TYPE_SLACKEY);
			canvas->drawImage(optionBtnImg[i/4+btnOffset], PausePicPos[i/2], PausePicPos[(i/2)+1]);
		}
	}
	
#if 0//DEBUG
	canvas->flush();
	for (int i = 0; i < 20; i += 4)
	{
		canvas->strokeRect(mBtnRectPause[i], mBtnRectPause[i+2], 
						   mBtnRectPause[i+1] - mBtnRectPause[i], 
						   mBtnRectPause[i+3] - mBtnRectPause[i+2]);
	}
#endif
}

void GamePauseOnTouchEvent(int touchStatus, float fX, float fY)
{
	if (stages == NULL)
	{
		return;
	}
	if (touchStatus == 1)
	{
		BtnOptionStartPos[0] = fX;
		BtnOptionStartPos[1] = fY;
		
		for (int i = 0; i < 20; i += 4)
		{
			if (fX > mBtnRectPause[i] && fX < mBtnRectPause[i+1] && fY > mBtnRectPause[i+2] && fY <mBtnRectPause[i+3])
			{
				BtnPausePress[i/4] = true;
			}
		}
	}
	else if (touchStatus == 2)
	{
		for (int i = 0; i < 20; i += 4)
		{
			BtnPausePress[i/4] = false;
		}
		for (int i = 0; i < 20; i += 4)
		{
			if ((fX > mBtnRectPause[i] && fX < mBtnRectPause[i+1] && fY > mBtnRectPause[i+2] && fY <mBtnRectPause[i+3]) && 
				(BtnOptionStartPos[0] > mBtnRectPause[i] && BtnOptionStartPos[0] < mBtnRectPause[i+1] && BtnOptionStartPos[1] > mBtnRectPause[i+2] && BtnOptionStartPos[1] < mBtnRectPause[i+3]))
			{
				BtnPausePress[i/4] = true;
			}
		}
	}
	else if (touchStatus == 3)
	{
		for (int i = 0; i < 20; i += 4)
		{
			if ((fX > mBtnRectPause[i] && fX < mBtnRectPause[i+1] && fY > mBtnRectPause[i+2] && fY <mBtnRectPause[i+3]) && 
				(BtnOptionStartPos[0] > mBtnRectPause[i] && BtnOptionStartPos[0] < mBtnRectPause[i+1] && BtnOptionStartPos[1] > mBtnRectPause[i+2] && BtnOptionStartPos[1] < mBtnRectPause[i+3]))
			{
				BtnPausePress[i/4] = false;
				switch(i)
				{
					case 0:
					{
						ClickPauseRestart();
						DisableShadow();//runner mode.
					}
						break;
					case 4:
					{
						ClickPauseMain();
						
				    	DisableShadow();//runner mode.
						
						//release stages
						if (stages)
						{
							stages->clearBG();
							stages->clearLevelData();
							delete stages;
							stages = NULL;
						}
					}
						break;
					case 8:
						ClickVolume();
						break;
					case 12:
						ClickBGM();
						break;
					case 16:
                    {
						ClickPauseResume();
				    }
						break;
				}
			}
			else if ((fX > mBtnRectPause[i]   && fX < mBtnRectPause[i+1] && 
					  fY > mBtnRectPause[i+2] && fY < mBtnRectPause[i+3]) && 
					 !(BtnOptionStartPos[0] > mBtnRectPause[i]   && BtnOptionStartPos[0] < mBtnRectPause[i+1] && 
					   BtnOptionStartPos[1] > mBtnRectPause[i+2] && BtnOptionStartPos[1] < mBtnRectPause[i+3]))
			{
				BtnPausePress[i/4] = false;
			}
		}
	}
}

void ClickPauseResume()
{
	g_nGameState = GAME_STATE_GAME_PLAY;
	playSE(SE_BUTTON_CANCEL);
    setLockScreenOrientation(true);
}

void ClickPauseRestart()
{
	//m_IsLeavePause = 2;
	playSE(SE_BUTTON_CONFIRM);
	
	if (stages)
	{
#ifdef ENABLE_CHECKPOINT
		stages->resetCheckPoint();
#endif
		stages->reset();
	}
	setGlobalFadeInAndGoTo(GAME_STATE_GAME_PLAY);
#ifdef ENABLE_ACHIEVEMENTS
	ResetTempAchievements();
#endif
	//m_IsLeavePause = 0;
}

void ClickPauseMain()
{
//	objAudioStop(ALL_GAME_PLAY, ALL_GAME_PLAY_AUDIO, true);
	playSE(SE_BUTTON_CONFIRM);
//	setGlobalFadeOutThenGoTo(GAME_STATE_MISSION_SELECT);
    if (LevelIndex<3) 
    {
       setGlobalFadeOutThenGoTo(GAME_STATE_LEVEL_SELECT);
        
    }
    else 
        setGlobalFadeOutThenGoTo(GAME_STATE_LEVELTWL_SELECT);
	
	
#ifdef ENABLE_ACHIEVEMENTS
	ResetTempAchievements();
#endif
//	g_nGameState = GAME_STATE_MISSION_SELECT; 
//	SwitchGameState();
}
