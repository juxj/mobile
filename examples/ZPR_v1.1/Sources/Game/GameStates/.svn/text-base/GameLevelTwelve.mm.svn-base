/*
 *  GameLevelTwl.mm
 *  ZPR
 *
 *  Created by Linda Li on 7/21/11.isLevelBtn
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "GameLevelTwelve.h"
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
#import "GameAchieve.h"

#define BTN_BACK_GAMELEVEL_X0	373.0f*IPAD_X
#define BTN_BACK_GAMELEVEL_X1	480.0f*IPAD_X
#define BTN_BACK_GAMELEVEL_Y0	0.0f*IPAD_X
#define BTN_BACK_GAMELEVEL_Y1	40.0f*IPAD_X

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

#define LV_TAG_1_Y0	50.0f*IPAD_X+IPAD_Y
#define LV_TAG_1_Y1	134.0f*IPAD_X+IPAD_Y
#define LV_TAG_2_Y0	134.0f*IPAD_X+IPAD_Y
#define LV_TAG_2_Y1	218.0f*IPAD_X+IPAD_Y
#define LV_TAG_3_Y0	218.0f*IPAD_X+IPAD_Y
#define LV_TAG_3_Y1	302.0f*IPAD_X+IPAD_Y


float startLevelTwlXY[2] = {0.0f, 0.0f};

//bool isLevelBtn=false;

float mLevelTwlTags[NUM_BTN_IN_GAME_LEVELTWL][4] = {
	{LV_TAG_1_X0, LV_TAG_1_X1, LV_TAG_1_Y0, LV_TAG_1_Y1}, 
	{LV_TAG_2_X0, LV_TAG_2_X1, LV_TAG_1_Y0, LV_TAG_1_Y1}, 
	{LV_TAG_3_X0, LV_TAG_3_X1, LV_TAG_1_Y0, LV_TAG_1_Y1}, 
	{LV_TAG_4_X0, LV_TAG_4_X1, LV_TAG_1_Y0, LV_TAG_1_Y1}, 
	{LV_TAG_1_X0, LV_TAG_1_X1, LV_TAG_2_Y0, LV_TAG_2_Y1}, 
	{LV_TAG_2_X0, LV_TAG_2_X1, LV_TAG_2_Y0, LV_TAG_2_Y1}, 
	{LV_TAG_3_X0, LV_TAG_3_X1, LV_TAG_2_Y0, LV_TAG_2_Y1}, 
	{LV_TAG_4_X0, LV_TAG_4_X1, LV_TAG_2_Y0, LV_TAG_2_Y1}, 
    {LV_TAG_1_X0, LV_TAG_1_X1, LV_TAG_3_Y0, LV_TAG_3_Y1}, 
	{LV_TAG_2_X0, LV_TAG_2_X1, LV_TAG_3_Y0, LV_TAG_3_Y1}, 
	{LV_TAG_3_X0, LV_TAG_3_X1, LV_TAG_3_Y0, LV_TAG_3_Y1}, 
	{LV_TAG_4_X0, LV_TAG_4_X1, LV_TAG_3_Y0, LV_TAG_3_Y1}, 
	{BTN_BACK_GAMELEVEL_X0, BTN_BACK_GAMELEVEL_X1, 
	 BTN_BACK_GAMELEVEL_Y0, BTN_BACK_GAMELEVEL_Y1}
};
//int mLevelPlayCount_[STAGE_IN_LV_MAX] = 
//{
//    0,0,0,0,0,0,0,0,0,0,0,0
//};
bool mLevelTwlTagsFlag[NUM_BTN_IN_GAME_LEVELTWL] = 
{
	false, false, false, false, 
	false, false, false, false, 
    false, false, false, false, 
	false
};

void GameLevelTwlBegin()
{
	RelGcRes();
    InitMenuRes();
	playBGM(BGM_MENU);
}

void GameLevelTwlEnd()
{
}

void GameLevelTwlUpdate(float dt)
{
}

void GameLevelTwlRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	// Background
	canvas->drawImage(mSelectPlay[LEVEL_NUM_MAX + LevelIndex], 0.0f, 0.0f, 0.0f, 1.2f, 1.2f);//1.065f
	
	// Pane
	RenderTileBG(TYPE_LEVEL_BG, 
				 (canvas->getCanvasWidth()*IPAD_X - TILE_LEVEL_COL*BG_UINIT_WIDTH*1.1)/2, 
				   30*IPAD_X+IPAD_ONE_Y, 
				 1.1, 1.1);
	
	// Back Button
	float colorbg = mLevelTwlTagsFlag[12]?BACK_COLOR:0;//isLevelBtn?BACK_COLOR:0;
	canvas->setColor(colorbg, colorbg, colorbg, 1);
	canvas->fillRect(387*IPAD_X, 0.0f, 160*IPAD_X, 28*IPAD_X);
	canvas->setColor(1, 1, 1, 1);
	
	int color = mLevelTwlTagsFlag[12]?0:1;//isLevelBtn?0:1;
	DrawString((char*)"BACK", 418.f*IPAD_X, 4.0f*IPAD_X, 0.35f, 1,1,color,1,0);
	

	
	// Level Buttons
	char temp[4] = {0};
   
	for (int m = 0; m <NUM_BTN_IN_GAME_LEVELTWL-1; m++)
	{
         
		memset(temp, '\0', sizeof(temp));
		sprintf(temp, "%d", m + 1);
        
        if ((LevelIndex*8+m)>=availableLevels) {
           canvas->drawImage(mActivebg, (100+m%4*93)*IPAD_X,(93+(m/4)*79)*IPAD_X+IPAD_TWO_Y, 0.0f, 1.4f, 1.2f);         
           canvas->drawImage(mFreeLock,  (90+(m%4)*93)*IPAD_X,(68+(m/4)*79)*IPAD_X+IPAD_TWO_Y, 0.0f, 0.6f, 0.6f);
            continue;
        }
		if (mLevelLock[LevelIndex][m]) 
        {
				canvas->drawImage(mActivebg, (100+m%4*93)*IPAD_X,(93+(m/4)*79)*IPAD_X+IPAD_TWO_Y, 0.0f, 1.4f, 1.2f);
		}
        else if (mLevelTwlTagsFlag[m])
		{   
            canvas->drawImage(mActivebg,  (100+m%4*93)*IPAD_X,(93+(m/4)*79)*IPAD_X+IPAD_TWO_Y, 0.0f, 1.3f, 1.1f);
			DrawString(temp, ((100-GetStringWidth(temp)/2)+m%4*93)*IPAD_X,(64+(m/4)*79)*IPAD_X+IPAD_TWO_Y, 0.9f, 1,1,0,1, FONT_TYPE_SLACKEY);
		}
		else
		{   
			canvas->drawImage(mActivebg, (100+m%4*93)*IPAD_X,(93+(m/4)*79)*IPAD_X+IPAD_TWO_Y, 0.0f, 1.4f, 1.2f);
			DrawString(temp,(100-GetStringWidth(temp)/2+m%4*93)*IPAD_X,(64+(m/4)*79)*IPAD_X+IPAD_TWO_Y, 0.9f, 1,1,1,1, FONT_TYPE_SLACKEY);
            
		}
		
	}

	for (int i = 0; i < NUM_BTN_IN_GAME_LEVELTWL-1; i++)	// levels
	{
		int nStars = mLevelStar[LevelIndex][i];
		for (int j = 0; j < 3; j++)	// stars
		{
			canvas->drawImage(mOptionStar[nStars>0?0:1], (71+j*21+i%4*93)*IPAD_X, (98+(i/4)*79)*IPAD_X+IPAD_TWO_Y,0,1.3,1.3);
			--nStars;
		}
	}
	for (int i = 0; i <  NUM_BTN_IN_GAME_LEVELTWL-1; i++)
	{ 
        
	    if (mLevelLock[LevelIndex][i]&&((LevelIndex*8+i)<availableLevels) ) {
			canvas->drawImage(mLock,(90+(i%4)*93)*IPAD_X,(68+(i/4)*79)*IPAD_X+IPAD_TWO_Y, 0.0f, 0.6f, 0.6f);
		}
       else  if (mObjFlag[24+i]) 
       {
           canvas->drawImage(mProps[24+i],(120+(i%4)*93)*IPAD_X, (55+(i/4)*79)*IPAD_X+IPAD_TWO_Y, 0.0f, 0.7f, 0.7f);
       }
	}
	
#if 0//DEBUG
	canvas->flush();
	for (int i = 0; i <  NUM_BTN_IN_GAME_LEVELTWL; i++)
	{
		canvas->strokeRect(mLevelTwlTags[i][0], mLevelTwlTags[i][2], 
						   mLevelTwlTags[i][1] - mLevelTwlTags[i][0], 
						   mLevelTwlTags[i][3] - mLevelTwlTags[i][2]);
	}
#endif
}

void GameLevelTwlOnTouchEvent(int touchStatus, float fX, float fY)
{
	int idx = 0;
	
	if (touchStatus == 1)
	{  
		startLevelTwlXY[0] = fX;
		startLevelTwlXY[1] = fY;
		for (int i = 0; i <  NUM_BTN_IN_GAME_LEVELTWL; i++)
		{
			if ((fX > mLevelTwlTags[i][0]) && (fX < mLevelTwlTags[i][1]) && 
				(fY > mLevelTwlTags[i][2]) && (fY < mLevelTwlTags[i][3]))
			{
				mLevelTwlTagsFlag[i] = true;
			}
		}
	}
	else if (touchStatus == 2)
	{
		while (!((fX > mLevelTwlTags[idx][0]) && (fX < mLevelTwlTags[idx][1]) && 
				 (fY > mLevelTwlTags[idx][2]) && (fY < mLevelTwlTags[idx][3])) && 
			   (idx < NUM_BTN_IN_GAME_LEVELTWL))
		{
			++idx;
		}
		if (idx > NUM_BTN_IN_GAME_LEVELTWL)
		{
			for (int i = 0; i < NUM_BTN_IN_GAME_LEVELTWL; i++)
			{
				mLevelTwlTagsFlag[i] = false;
			}
		}
		if ((startLevelTwlXY[0] > mLevelTwlTags[idx][0]) && 
			(startLevelTwlXY[0] < mLevelTwlTags[idx][1]) && 
			(startLevelTwlXY[1] > mLevelTwlTags[idx][2]) && 
			(startLevelTwlXY[1] < mLevelTwlTags[idx][3]))
		{
			mLevelTwlTagsFlag[idx] = true;
		}
		else
		{
			for (int i = 0; i < NUM_BTN_IN_GAME_LEVELTWL; i++)
			{
				mLevelTwlTagsFlag[i] = false;
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
		for (int i = 0; i < NUM_BTN_IN_GAME_LEVELTWL; i++)
		{
			mLevelTwlTagsFlag[i] = false;
		}
		
		while (!((fX > mLevelTwlTags[idx][0]) && (fX < mLevelTwlTags[idx][1]) && 
				 (fY > mLevelTwlTags[idx][2]) && (fY < mLevelTwlTags[idx][3])) && 
			   (idx < NUM_BTN_IN_GAME_LEVELTWL))
		{
			++idx;
		}
		if (idx >= NUM_BTN_IN_GAME_LEVELTWL)
		{
			return;
		}
		if ((startLevelTwlXY[0] > mLevelTwlTags[idx][0]) && 
			(startLevelTwlXY[0] < mLevelTwlTags[idx][1]) && 
			(startLevelTwlXY[1] > mLevelTwlTags[idx][2]) && 
			(startLevelTwlXY[1] < mLevelTwlTags[idx][3]))
		{
			if (idx < 12&&!mLevelLock[LevelIndex][idx]&&(LevelIndex*8+idx)<availableLevels)	// Levels
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
					if (LevelIndex == 3)
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
