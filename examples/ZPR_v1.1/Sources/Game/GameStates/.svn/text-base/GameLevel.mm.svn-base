/*
 *  GameLevel.mm
 *  ZPR
 *
 *  Created by Linda Li on 7/21/11.isLevelBtn
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "GameLevel.h"
#import "GameState.h"
#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"
#import "GameRes.h"
#import "GameAudio.h"
#import "GameSection.h"
#import "Stage.h"
#import "GameSuc.h"
#import "GameOption.h"
#include "neoRes.h"
#import  "Utilities.h"
#import  "GameHouse.h"
#import "GamePlay.h"
#import "ZPRAppDelegate.h"
#ifdef __PROMOTE_ADS__
#import "PromoteADS.h"
#import "GameAchieve.h"
#endif

#define BTN_BACK_GAMELEVEL_X0	373.0f*IPAD_X
#define BTN_BACK_GAMELEVEL_X1	480.0f*IPAD_X
#define BTN_BACK_GAMELEVEL_Y0	0.0f*IPAD_X
#define BTN_BACK_GAMELEVEL_Y1	48.0f*IPAD_X

#define SCALE_LEVEL_WIDTH  1.05f
#define SCALE_LEVEL_HIGHT  1.1f

#define LV_TAG_1_X0	39.0f*IPAD_X
#define LV_TAG_1_X1	140.0f*IPAD_X
#define LV_TAG_2_X0	140.0f*IPAD_X
#define LV_TAG_2_X1	242.0f*IPAD_X
#define LV_TAG_3_X0	242.0f*IPAD_X
#define LV_TAG_3_X1	343.0f*IPAD_X
#define LV_TAG_4_X0	343.0f*IPAD_X
#define LV_TAG_4_X1	444.0f*IPAD_X

#define LV_TAG_1_Y0	52.0f*IPAD_X+IPAD_Y
#define LV_TAG_1_Y1	154.0f*IPAD_X+IPAD_Y
#define LV_TAG_5_Y0	162.0f*IPAD_X+IPAD_Y
#define LV_TAG_5_Y1	276.0f*IPAD_X+IPAD_Y

Image* mSmallOption;
Image* mStar[4];
Image* mLock;
Image* mFreeLock;
Image* mProps[36];
Image* mActivebg;

#ifdef __PROMOTE_ADS__
int adsStyle;
#endif

#if UNLOCKED_LEVEL//DEBUG
bool mLevelLock[LEVEL_NUM_MAX][STAGE_IN_LV_MAX] = 
{
	{false,false,false,false,false,false,false,false,false,false,false,false},
	{false,false,false,false,false,false,false,false,false,false,false,false},
	{false,false,false,false,false,false,false,false,false,false,false,false},
    #ifdef V_1_1_0
    {false,false,false,false,false,false,false,false,false,false,false,false}
    #endif
};
#else
bool mLevelLock[LEVEL_NUM_MAX][STAGE_IN_LV_MAX] = 
{
	{false,true,true,true,true,true,true,true,true,true,true,true},
	{true,true,true,true,true,true,true,true,true,true,true,true},
	{true,true,true,true,true,true,true,true,true,true,true,true},
    #ifdef V_1_1_0
    {true,true,true,true,true,true,true,true,true,true,true,true}
    #endif
};
#endif


float startActiveXY[2] = {0.0f, 0.0f};

//bool isLevelBtn=false;

int mLevelStar[LEVEL_NUM_MAX][STAGE_IN_LV_MAX] = 
{
	{0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0}
};

int levelStageScore[LEVEL_NUM_MAX][STAGE_IN_LV_MAX] = 
{
	{0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0}
};

int mLevelPlayCount[LEVEL_NUM_MAX][STAGE_IN_LV_MAX] = 
{
	{0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0}
};


float mLevelTags[NUM_BTN_IN_GAME_LEVEL][4] = {
	{LV_TAG_1_X0, LV_TAG_1_X1, LV_TAG_1_Y0, LV_TAG_1_Y1}, 
	{LV_TAG_2_X0, LV_TAG_2_X1, LV_TAG_1_Y0, LV_TAG_1_Y1}, 
	{LV_TAG_3_X0, LV_TAG_3_X1, LV_TAG_1_Y0, LV_TAG_1_Y1}, 
	{LV_TAG_4_X0, LV_TAG_4_X1, LV_TAG_1_Y0, LV_TAG_1_Y1}, 
	{LV_TAG_1_X0, LV_TAG_1_X1, LV_TAG_5_Y0, LV_TAG_5_Y1}, 
	{LV_TAG_2_X0, LV_TAG_2_X1, LV_TAG_5_Y0, LV_TAG_5_Y1}, 
	{LV_TAG_3_X0, LV_TAG_3_X1, LV_TAG_5_Y0, LV_TAG_5_Y1}, 
	{LV_TAG_4_X0, LV_TAG_4_X1, LV_TAG_5_Y0, LV_TAG_5_Y1}, 
	{BTN_BACK_GAMELEVEL_X0, BTN_BACK_GAMELEVEL_X1, 
	 BTN_BACK_GAMELEVEL_Y0, BTN_BACK_GAMELEVEL_Y1}
};

bool mLevelTagsFlag[NUM_BTN_IN_GAME_LEVEL] = 
{
	false, false, false, false, 
	false, false, false, false, 
	false
};

void GameLevelBegin()
{
	RelGcRes();
    InitMenuRes();
	playBGM(BGM_MENU);
#ifdef _AD_ADCOLONY_EMBEDDED_
    resetTabAdPlayList();
#endif
}

void GameLevelEnd()
{
}

void GameLevelUpdate(float dt)
{
}

void GameLevelRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	// Background
	canvas->drawImage(mSelectPlay[LEVEL_NUM_MAX + LevelIndex], 0.0f, 0.0f, 0.0f, 1.2f, 1.2f);//1.065f
	
	// Pane
	RenderTileBG(TYPE_LEVEL_BG, 
				 (canvas->getCanvasWidth()*IPAD_X - TILE_LEVEL_COL*BG_UINIT_WIDTH*1.1)/2, 
				   35*IPAD_X+IPAD_ONE_Y, 
				 1.1, 1.0);
	
	// Back Button
	float colorbg = mLevelTagsFlag[8]?BACK_COLOR:0;//isLevelBtn?BACK_COLOR:0;
	canvas->setColor(colorbg, colorbg, colorbg, 1);
	canvas->fillRect(387*IPAD_X, 0.0f, 160*IPAD_X, 28*IPAD_X);
	canvas->setColor(1, 1, 1, 1);
	
	int color = mLevelTagsFlag[8]?0:1;//isLevelBtn?0:1;
	DrawString((char*)"BACK", 418.f*IPAD_X, 4.0f*IPAD_X, 0.35f, 1,1,color,1,0);
	

	
	// Level Buttons
	char temp[4] = {0};
	for (int m = 0; m < 8; m++)
	{
		memset(temp, '\0', sizeof(temp));
		sprintf(temp, "%d", m + 1);

        if ((LevelIndex*8+m)>=availableLevels) {
            canvas->drawImage(mActivebg, (89+m%4*100)*IPAD_X, (114+(m/4)*100)*IPAD_X+IPAD_TWO_Y, 0.0f, 1.3f, 1.3f);
//          DrawString(temp, (80+m%4*100)*IPAD_X,(83+(m/4)*100)*IPAD_X+IPAD_TWO_Y, 1.1f, 0,0,0,1, FONT_TYPE_SLACKEY);
            canvas->drawImage(mFreeLock, (74+(m%4)*100)*IPAD_X,(84+(m/4)*100)*IPAD_X+IPAD_TWO_Y, 0.0f, 0.7f, 0.7f);
            continue;
        }

		if (mLevelLock[LevelIndex][m]) {
				canvas->drawImage(mActivebg, (89+m%4*100)*IPAD_X,(114+(m/4)*100)*IPAD_X+IPAD_TWO_Y, 0.0f, 1.4f, 1.4f);
		}
        else if (mLevelTagsFlag[m])
		{   
			canvas->drawImage(mActivebg, (89+m%4*100)*IPAD_X, (114+(m/4)*100)*IPAD_X+IPAD_TWO_Y, 0.0f, 1.3f, 1.3f);
			DrawString(temp, (80+m%4*100)*IPAD_X,(83+(m/4)*100)*IPAD_X+IPAD_TWO_Y, 1.1f, 1,1,0,1, FONT_TYPE_SLACKEY);
		}
		else
		{    
			canvas->drawImage(mActivebg, (89+m%4*100)*IPAD_X, (114+(m/4)*100)*IPAD_X+IPAD_TWO_Y, 0.0f, 1.4f, 1.4f);
			DrawString(temp, (80+m%4*100)*IPAD_X,(83+(m/4)*100)*IPAD_X+IPAD_TWO_Y, 1.1f, 1,1,1,1, FONT_TYPE_SLACKEY);
		}
		
	}

	for (int i = 0; i < 8; i++)	// levels
	{
		int nStars = mLevelStar[LevelIndex][i];
		for (int j = 0; j < 3; j++)	// stars
		{
			canvas->drawImage(mOptionStar[nStars>0?0:1], (59+j*21+i%4*100)*IPAD_X, (125+(i/4)*100)*IPAD_X+IPAD_TWO_Y,0,1.3,1.3);
			--nStars;
		}
	}
	
	for (int i = 0; i < 8; i++)
	{
		int index = LevelIndex*8+i;
		
	    if (mLevelLock[LevelIndex][i] && index < availableLevels) 
        {
			canvas->drawImage(mLock,(74+(i%4)*100)*IPAD_X,(84+(i/4)*100)*IPAD_X+IPAD_TWO_Y, 0.0f, 0.7f, 0.7f);
		}
		else if (mObjFlag[index]) 
        {
            canvas->drawImage(mProps[index],(105+(i%4)*100)*IPAD_X,(68+(i/4)*100)*IPAD_X+IPAD_TWO_Y, 0.0f, 0.7f, 0.7f);
        }
		
	}
	
#if 0//DEBUG
	canvas->flush();
	for (int i = 0; i < NUM_BTN_IN_GAME_LEVEL; i++)
	{
		canvas->strokeRect(mLevelTags[i][0], mLevelTags[i][2], 
						   mLevelTags[i][1] - mLevelTags[i][0], 
						   mLevelTags[i][3] - mLevelTags[i][2]);
	}
#endif
}

void GameLevelOnTouchEvent(int touchStatus, float fX, float fY)
{
	int idx = 0;
	
	if (touchStatus == 1)
	{  
		startActiveXY[0] = fX;
		startActiveXY[1] = fY;
		for (int i = 0; i < NUM_BTN_IN_GAME_LEVEL; i++)
		{
			if ((fX > mLevelTags[i][0]) && (fX < mLevelTags[i][1]) && 
				(fY > mLevelTags[i][2]) && (fY < mLevelTags[i][3]))
			{
				mLevelTagsFlag[i] = true;
			}
		}
	}
	else if (touchStatus == 2)
	{
		while (!((fX > mLevelTags[idx][0]) && (fX < mLevelTags[idx][1]) && 
				 (fY > mLevelTags[idx][2]) && (fY < mLevelTags[idx][3])) && 
			   (idx < NUM_BTN_IN_GAME_LEVEL))
		{
			++idx;
		}
		if (idx > NUM_BTN_IN_GAME_LEVEL)
		{
			for (int i = 0; i < NUM_BTN_IN_GAME_LEVEL; i++)
			{
				mLevelTagsFlag[i] = false;
			}
		}
		if ((startActiveXY[0] > mLevelTags[idx][0]) && 
			(startActiveXY[0] < mLevelTags[idx][1]) && 
			(startActiveXY[1] > mLevelTags[idx][2]) && 
			(startActiveXY[1] < mLevelTags[idx][3]))
		{
			mLevelTagsFlag[idx] = true;
		}
		else
		{
			for (int i = 0; i < NUM_BTN_IN_GAME_LEVEL; i++)
			{
				mLevelTagsFlag[i] = false;
			}
		}
//		if (fX > 373 && fX < 480 && fY > 0 && fY <40) {
//			isLevelBtn=true;
//		}
//		else {
//			isLevelBtn=false;
//		}
	}
	else if (touchStatus == 3)
	{
//		isLevelBtn=false;
		for (int i = 0; i < NUM_BTN_IN_GAME_LEVEL; i++)
		{
			mLevelTagsFlag[i] = false;
		}
		
		while (!((fX > mLevelTags[idx][0]) && (fX < mLevelTags[idx][1]) && 
				 (fY > mLevelTags[idx][2]) && (fY < mLevelTags[idx][3])) && 
			   (idx < NUM_BTN_IN_GAME_LEVEL))
		{
			++idx;
		}
		if (idx >= NUM_BTN_IN_GAME_LEVEL)
		{
			return;
		}
		if ((startActiveXY[0] > mLevelTags[idx][0]) && 
			(startActiveXY[0] < mLevelTags[idx][1]) && 
			(startActiveXY[1] > mLevelTags[idx][2]) && 
			(startActiveXY[1] < mLevelTags[idx][3]))
		{

			if (idx < 8&&!mLevelLock[LevelIndex][idx]&&(LevelIndex*8+idx)<availableLevels)	// Levels
			{

				
				if (idx > 0)
				{   
					playSE(SE_BUTTON_CONFIRM);
					ActiveLevel = idx;
					g_nGameState = GAME_STATE_LOADING;
//					SwitchGameState();
					
				}
				else
				{
					playSE(SE_BUTTON_CONFIRM);
					ActiveLevel = idx;
					if (LevelIndex == 0)
					{
						mStoryIndex = 0;
					}
					else if (LevelIndex == 1)
					{
						mStoryIndex = 5;
					}
					else if (LevelIndex == 2)
					{
						mStoryIndex = 10;
					}
                    else if (LevelIndex == 3)
					{
						mStoryIndex = 13;
					}
					g_nGameState = GAME_STATE_STORY;
//					SwitchGameState();
				}
#ifdef V_FREE
                if ([app.iap hasUnlockComicInLocalStore])
                {
                    
                    if (mLevelPlayCount[LevelIndex][ActiveLevel] == 0) {
                      
                        int random_ = arc4random() % 2;
                        
                        if (random_ == 0) {
                            adsStyle = ADS_STATE_FULL_SHOE;
                        }
                        else {
                            adsStyle = ADS_STATE_FULL_BED;
                        }
                    }
                    else if (mLevelCLear[LevelIndex][ActiveLevel]) {
                        
                        adsStyle = ADS_STATE_FREE_SHOE;
                        
                    }
                    else{
                        
                        adsStyle = ADS_STATE_FREE_BED;
                        
                    }
                }
                else    // locked
                {
                    
                    if (mLevelPlayCount[LevelIndex][ActiveLevel] == 0) {
                        
                        adsStyle = ADS_STATE_FREE_BUY;
                    }
                    else if (mLevelCLear[LevelIndex][ActiveLevel]) {
                        
                        adsStyle = ADS_STATE_FREE_SHOE;
                    }
                    else{
                        
                        adsStyle = ADS_STATE_FREE_BED;
                    }
                }
#else
                
                if (mLevelPlayCount[LevelIndex][ActiveLevel] == 0) {
                    
                    int random_ = arc4random() % 2;
                    
                    if (random_ == 0) {
                        adsStyle = ADS_STATE_FULL_SHOE;
                    }
                    else {
                        adsStyle = ADS_STATE_FULL_BED;
                    }
                }
                else if (mLevelCLear[LevelIndex][ActiveLevel]) {
                    
                    adsStyle = ADS_STATE_FREE_SHOE;
                    
                }
                else{
                    
                    adsStyle = ADS_STATE_FREE_BED;
                    
                }
                
#endif           

				mLevelPlayCount[LevelIndex][ActiveLevel] ++;
                SwitchGameState();
			}
			else if((fX > 373*IPAD_X && fX < 480*IPAD_X && fY > 0 && fY <40*IPAD_X))			// Back
			{
				playSE(SE_BUTTON_CANCEL);
				g_nGameState = GAME_STATE_MISSION_SELECT;
				SwitchGameState();
			}
			
		}
	}
}
