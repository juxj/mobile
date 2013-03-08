/*
 *  GameSection.cpp
 *  MonsterWar
 *
 *  Created by Neo Lin on 5/31/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "GameSection.h"
#import "GameState.h"
#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"
#import "GameRes.h"
#import "GameAudio.h"
#import "Utilities.h"
#import "GamePlay.h"
#import "GameLevel.h"
#import "GameSuc.h"
#import "GameAchieve.h"
#import "GameHouse.h"
#import "GameData.h"


#define SECTION_BTN_NUM			2

#define FADE_TO_START			1
#define FADE_IN_VALUE			0.9
#define FADE_OUT_VALUE			0.3

#ifdef  VERSION_IPAD
#define SCENE_WIDTH			417
#define SCOREX			    90.0f*IPAD_X
#else
#define SCENE_WIDTH			446
#define SCOREX			    74.0f
#endif

#define SCENE_OFFX			75*IPAD_X
#define SCENE_GAP			150

#define COINX			    159.0f*IPAD_X
#define PERCENTX			312.0f*IPAD_X//292.0
#define COMPLETEX			319.0f*IPAD_X
#define Y_SCORE_PROGRESS_1	(249.0f*IPAD_X+IPAD_FOUR_Y)
#define Y_SCORE_PROGRESS_2	(249.0f*IPAD_X+IPAD_FOUR_Y)
#define GAME_SEL_FONT_SCALE_1	0.55f
#define GAME_SEL_FONT_SCALE_2	0.55f
#define SCALE_OPTION_WIDTH  1.05f
#define SCALE_OPTION_HIGHT  1.1f

#define SCROLL_LENGTH	60*IPAD_X
#ifdef V_FREE
int availableLevels = 8;
#else
int availableLevels = 24;
#endif

float g_xScrollOffset = 0.0f;
float offset = 0.0f;
float ScrollPos[2] = {0,0};
int movedir = 0;
bool isMove = false;
bool isSectionBtn[SECTION_BTN_NUM]={false,false};
int ActiveLevel = -1;
int LevelIndex = 0;

float selectBtnScope[SECTION_BTN_NUM*4]=
{    373*IPAD_X,480*IPAD_X ,0,40*IPAD_X,
     53*IPAD_X,436*IPAD_X, 41*IPAD_X, 288*IPAD_X,
   //  194*IPAD_X,294*IPAD_X ,284*IPAD_X,350*IPAD_X
};

float tapAlpha=FADE_IN_VALUE;
bool isAppear=true;
bool  isMainMenu=false;

#if UNLOCKED_LEVEL//DEBUG
bool mSectionLock[LEVEL_NUM_MAX] = {false, false, false, false};
#else
bool mSectionLock[LEVEL_NUM_MAX] = {false, true, true, true};
#endif

int nLevelCleared[LEVEL_NUM_MAX] = {0, 0, 0, 0};
int levelTotalScore[LEVEL_NUM_MAX] = {0, 0, 0, 0};
int levelAverageStars[LEVEL_NUM_MAX] = {0, 0, 0, 0};
int itemStatus[LEVEL_NUM_MAX] = {0, 0, 0, 0};
int mSelectStar[LEVEL_NUM_MAX] = {0, 0, 0, 0};


void GameSectionBegin()
{
    freeResAds();
    InitMenuRes();
    
	tapAlpha=FADE_IN_VALUE;
	isAppear=true;
	
	movedir=0;
    if (isMainMenu)
    {
        g_xScrollOffset=0.0f;
        LevelIndex = 0;
        isMainMenu=false;
    }
	else 
    {
    g_xScrollOffset=(-LevelIndex)*SCENE_WIDTH;
    }
	
	playBGM(BGM_MENU);
#ifdef ENABLE_ACHIEVEMENTS
//	AchCheckStars();
//	AchHighScoreCheck();
#endif
//  mSelectStar[0] =0;
//  mSelectStar[1] =0;
//  mSelectStar[2] =0;
    for (int i = 0; i < LEVEL_NUM_MAX; i++)
    {
        mSelectStar[i] = 0;
    }
	int tempCount = 0;
	for (int i = 0; i < LEVEL_NUM_MAX; i++)
	{
		tempCount = 0;
        if (i < 3)
        {
            for (int j = 0; j < 8; j++)
            {
                if (mObjFlag[8*i + j] > 0)
                {
                    ++tempCount;
                }
                mSelectStar[i] += mLevelStar[i][j];
            }
        }
        else
        {
            for (int j = 0; j < 12; j++)
            {
                if (mObjFlag[24 + j] > 0)
                {
                    ++tempCount;
                }
                mSelectStar[i] += mLevelStar[i][j];
            }
        }
		itemStatus[i] = tempCount;
#if DEBUG
		printf("Level %d, itemStatus = %d\n", i, itemStatus[i]);
#endif
	}
	
#ifdef _AD_ADCOLONY_EMBEDDED_
    resetTabAdPlayList();
#endif
    
    if (availableLevels>24) 
    {
        mSectionLock[3]=false;
        mLevelLock[3][0]=false;
    }
}

void GameSectionEnd()
{
}

void GameSectionUpdate(float dt)
{
	if (!isMove)
    {
		if (movedir == 1) 
		{
			//if (SCENE_GAP +LevelIndex*SCENE_WIDTH + g_xScrollOffset > SCENE_GAP)
			if (-g_xScrollOffset < LevelIndex * SCENE_WIDTH)
            {
				g_xScrollOffset -= 5.0f;
            }
			else
            {
				g_xScrollOffset = -LevelIndex * SCENE_WIDTH;
			}
			
		}
		else if (movedir == 2)
		{
			//if (SCENE_GAP + LevelIndex*SCENE_WIDTH + g_xScrollOffset < SCENE_GAP)
			if (-g_xScrollOffset > LevelIndex * SCENE_WIDTH)
            {
				g_xScrollOffset += 5.0f;
            }
			else
            {
				g_xScrollOffset =- LevelIndex * SCENE_WIDTH;
			}
		}
	}
}

void GameSectionRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	drawSky();  //canvas->drawImage(mLevelbgsky, 0.0f, 0.0f, 0.0f, 3.1f, 3.1f);
	
	// Back button
	float colorbg=isSectionBtn[0]?BACK_COLOR:0;
	canvas->setColor(colorbg, colorbg, colorbg, 1);
	canvas->fillRect(387*IPAD_X, 0.0f, 160*IPAD_X, 28*IPAD_X);
	canvas->setColor(1, 1, 1, 1);
	
	int color=isSectionBtn[0]?0:1;
	DrawString((char*)"MAIN MENU",398.f*IPAD_X,4.0f*IPAD_X,0.35,1,1,color,1,0);
	
	 
	float Screen_offX=(canvas->getCanvasWidth()*IPAD_X-(TILE_SELECT_COL*BG_UINIT_WIDTH*SCALE_OPTION_WIDTH))/2.0f;
	float Level_offX=(canvas->getCanvasWidth()*IPAD_X-(mSelectPlay[0]->getWidth())*0.90 * (2.0f / GLOBAL_CANVAS_SCALE))/2;
	int levelIdx, starIdx;
	char str[16] = {'\0'};

	
	for (levelIdx = 0; levelIdx < LEVEL_NUM_MAX; levelIdx++)
	{
		RenderTileBG(TYPE_SELECT_BG, 
					 Screen_offX + SCENE_WIDTH * levelIdx + g_xScrollOffset, 
					 (canvas->getCanvasHeight()*IPAD_X+IPAD_Y  - (TILE_SELECT_ROW * BG_UINIT_WIDTH*SCALE_OPTION_HIGHT))/ 2.0f, 
					 SCALE_OPTION_WIDTH, SCALE_OPTION_HIGHT);
		canvas->drawImage(mSelectPlay[levelIdx], 
						  Level_offX + (SCENE_WIDTH * levelIdx) + g_xScrollOffset, 
						  (canvas->getCanvasHeight()*IPAD_X+IPAD_Y-(mSelectPlay[levelIdx]->getHeight()*0.9 * (2.0f / GLOBAL_CANVAS_SCALE)))/ 2.0f,0.0,0.9f,0.9f);
		DrawString(Name[levelIdx], 
				   (canvas->getCanvasWidth()*IPAD_X- GetStringWidth(Name[levelIdx], 0.60f)) / 2.0f + (SCENE_WIDTH * levelIdx) + g_xScrollOffset, 
				   50.0f*IPAD_X+IPAD_ONE_Y, 
				   0.6f);

		// Score
		memset(str, '\0', sizeof(str));
		sprintf(str, "Score:");
		DrawString(str, SCOREX + (SCENE_WIDTH * levelIdx) + g_xScrollOffset, 
				   Y_SCORE_PROGRESS_1, GAME_SEL_FONT_SCALE_1);
		
		memset(str, '\0', sizeof(str));
		sprintf(str, "%d", levelTotalScore[levelIdx]);
		DrawString(str, COINX + (SCENE_WIDTH * levelIdx) + g_xScrollOffset, 
				   Y_SCORE_PROGRESS_2, GAME_SEL_FONT_SCALE_2, 1.0f, 1.0f, 1.0f, 1.0f, FONT_TYPE_SCHOOLBELL);
		
		// Progress
		memset(str, '\0', sizeof(str));
        if (levelIdx < STAGE_SECTION_V001)
        {
            sprintf(str, "%d%%", (int)((((float)(nLevelCleared[levelIdx]) / STAGE_LEVEL_V001) + ((float)(itemStatus[levelIdx]) / STAGE_LEVEL_V001)) * 50.0f));
        }
        else
        {
            sprintf(str, "%d%%", (int)((((float)(nLevelCleared[levelIdx]) / STAGE_LEVEL_V002) + ((float)(itemStatus[levelIdx]) / STAGE_LEVEL_V002)) * 50.0f));
        }
		DrawString(str ,PERCENTX + (SCENE_WIDTH * levelIdx) + g_xScrollOffset - GetStringWidth(str, GAME_SEL_FONT_SCALE_2, FONT_TYPE_SCHOOLBELL), 
				   Y_SCORE_PROGRESS_2, GAME_SEL_FONT_SCALE_2, 1.0f, 1.0f, 1.0f, 1.0f, FONT_TYPE_SCHOOLBELL);
		
		memset(str, '\0', sizeof(str));
		sprintf(str, "COMPLETE");
		DrawString(str ,COMPLETEX + (SCENE_WIDTH * levelIdx) + g_xScrollOffset, 
				   Y_SCORE_PROGRESS_2, GAME_SEL_FONT_SCALE_2, 1.0f, 1.0f, 1.0f, 1.0f, FONT_TYPE_SCHOOLBELL);
	}
	if (mLevelLock[0][1]) 
	{
#if FADE_TO_START
		if (!isAppear) 
		{
			if (tapAlpha<0.9) 
			{
				tapAlpha+=0.01;
			}
			else 
			{
				//tapAlpha=1;
				isAppear=true;	
			}
		}
		else{
			if (tapAlpha>0.1) 
			{
				tapAlpha-=0.005;
			}
			else 
			{
				//tapAlpha=0;
				isAppear=false;
			}
		}
#endif
#if 0
		DrawString((char*)"Tap to Start", 
				   (canvas->getCanvasWidth()*IPAD_X - GetStringWidth((char*)"Tap to Start", 0.80f,2)) / 2.0f + g_xScrollOffset, 
				   190.0f*IPAD_X+IPAD_TWO_Y, 
				   0.80f,1,1,1,tapAlpha,2);	
#else
		DrawString((char*)"Tap to Start", 
				   (canvas->getCanvasWidth()*IPAD_X - GetStringWidth((char*)"Tap to Start", 0.60f,0)) / 2.0f + g_xScrollOffset, 
				   100.0f*IPAD_X+IPAD_TWO_Y, 
				   0.60f,1,1,1,tapAlpha,0);
#endif
		
	}
	
     
   int idx=0;  
       
    for (levelIdx = 0; levelIdx < LEVEL_NUM_MAX; levelIdx++)
	{   
        bool  isAvailable=false;
        if (levelIdx<3)
        {
            isAvailable=availableLevels<=8?false:true;
        }
        else
        {
            isAvailable=availableLevels<=24?false:true;
        }
        if (levelIdx>0 &&!isAvailable )
        {
             DrawString((char*)"Unlock In The Store!", 
                           (canvas->getCanvasWidth()*IPAD_X- GetStringWidth((char*)"Unlock In The Store!", 0.60f)) / 2.0f + (SCENE_WIDTH * levelIdx) + g_xScrollOffset, 
                           90.0f*IPAD_X+IPAD_ONE_Y, 
                           0.60f,1,0,0);
            canvas->setColor(SEC_LOCK_ALPHA);
            canvas->fillRect( Level_offX + (SCENE_WIDTH * levelIdx) + g_xScrollOffset, 
                            (canvas->getCanvasHeight()*IPAD_X+IPAD_Y-(mSelectPlay[levelIdx]->getHeight()*0.9*(2.0f/GLOBAL_CANVAS_SCALE)))/ 2.0f-2,
                             mSelectPlay[levelIdx]->getWidth()*0.9*(2.0f/GLOBAL_CANVAS_SCALE)+2,
                             mSelectPlay[levelIdx]->getHeight()*0.9*(2.0f/GLOBAL_CANVAS_SCALE)+2);
            canvas->setColor(1, 1, 1, 1);
             canvas->drawImage(mFreeLock, 
                                  SCENE_WIDTH * levelIdx + 219*IPAD_X+g_xScrollOffset, 123.0f*IPAD_X+IPAD_TWO_Y,0.0f,1.2f,1.2f);
        }
        else if (mSectionLock[levelIdx])
		{
            canvas->setColor(SEC_LOCK_ALPHA);
            canvas->fillRect(Level_offX + (SCENE_WIDTH * levelIdx) + g_xScrollOffset, 
                            (canvas->getCanvasHeight()*IPAD_X+IPAD_Y-(mSelectPlay[levelIdx]->getHeight()*0.9*(2.0f/GLOBAL_CANVAS_SCALE)))/ 2.0f-2,
                             mSelectPlay[levelIdx]->getWidth()*0.9*(2.0f/GLOBAL_CANVAS_SCALE)+2,
                             mSelectPlay[levelIdx]->getHeight()*0.9*(2.0f/GLOBAL_CANVAS_SCALE)+2);
            canvas->setColor(1, 1, 1, 1);
            canvas->drawImage(mLock, 
                              SCENE_WIDTH * levelIdx + 219*IPAD_X+g_xScrollOffset, 123.0f*IPAD_X+IPAD_TWO_Y,0.0f,1.2f,1.2f);
            
        }
		else
		{
            float starRating = 0;
            if (levelIdx < STAGE_SECTION_V001)
            {
                starRating = (float)(((float)(mSelectStar[levelIdx]) / STAGE_LEVEL_V001));//(float) ((float)(mSelectStar[levelIdx]*3.0f)/24.0f);
            }
            else
            {
                starRating = (float)(((float)(mSelectStar[levelIdx]) / STAGE_LEVEL_V002));
            }
			float imgIdxOffset = starRating;
			for (starIdx = 0; starIdx < 3; starIdx++)
			{
				imgIdxOffset -= 1.0f;
				if (imgIdxOffset < 0.0f)
				{
//					imgIdxOffset = starRating;
				}
				else
				{
					imgIdxOffset = starRating - imgIdxOffset;
				}
				
				if (imgIdxOffset >= 1.0f)//if (imgIdxOffset>0.0f&&imgIdxOffset<=(1.0f/2.0f))
				{
					idx = 2;
				}
				else if (imgIdxOffset >= -0.5f)//else if (imgIdxOffset>(1.0f/2.0f))
				{
					idx = 1;
				}
				else if (imgIdxOffset <= 0.0f)
				{
					idx = 0;
				}
				canvas->drawImage(mStars[0], 
								  
								  SCENE_WIDTH * levelIdx + 150*IPAD_X+66*IPAD_X*starIdx+g_xScrollOffset, 133.0f*IPAD_X+IPAD_TWO_Y,0.0f,1.2f,1.2f);
				canvas->drawImage(mStars[idx], 
								  SCENE_WIDTH * levelIdx + 150*IPAD_X+66*IPAD_X*starIdx+g_xScrollOffset, 133.0f*IPAD_X+IPAD_TWO_Y,0.0f,1.2f,1.2f);
				starRating -= 1.0f;
				imgIdxOffset = starRating;//--imgIdxOffset;
			}
		}
	}

#ifdef LITE_VERSION
    drawAppLink(0, 240.0f, 300.0f);
#endif
}

void GameSectionOnTouchEvent(int touchStatus, float fX, float fY)
{
#ifdef LITE_VERSION
    if (onTouchAppLink(APPLINK_SCENE_LEVEL, touchStatus, fX, fY))
    {
        return;
    }
#endif
	if (touchStatus == 1)
	{
        for (int i=0; i<SECTION_BTN_NUM*4; i+=4) 
        {
          if (fX > selectBtnScope[i] && fX <selectBtnScope[i+1] && fY > selectBtnScope[i+2] && fY <selectBtnScope[i+3])
          {
            isSectionBtn[i/4] = true;
          
          }
        }
		
		ScrollPos[0] = fX;
		ScrollPos[1] = fY;
		offset = g_xScrollOffset;
	}
	else if (touchStatus == 2)
	{   
        
        for (int i=0; i<SECTION_BTN_NUM*4; i+=4) 
        {
            if (fX > selectBtnScope[i] && fX <selectBtnScope[i+1] && fY > selectBtnScope[i+2] && fY <selectBtnScope[i+3]
                &&(ScrollPos[0] > selectBtnScope[i] && ScrollPos[0] <selectBtnScope[i+1] && ScrollPos[1] > selectBtnScope[i+2] && ScrollPos[1] <selectBtnScope[i+3]))
            {
                isSectionBtn[i/4] = true;
            }
            else  isSectionBtn[i/4] = false;
        }    
        if (fX > 0 && fX <480 && fY > selectBtnScope[4+2] && fY <selectBtnScope[4+3])          
        {
            isMove = true;
            float dis = fX - ScrollPos[0];	
            if (g_xScrollOffset+ dis > SCENE_GAP
                || g_xScrollOffset+dis < -(SCENE_WIDTH * (LEVEL_NUM_MAX - 1) + SCENE_GAP))
            {
                return;
            }
            g_xScrollOffset = offset + dis;
        }
        
    }
	else if (touchStatus == 3)
	{  
		isSectionBtn[0] = false;
     //  isSectionBtn[2] = false;
        if (!isMove)
		{
            for (int i=0; i<SECTION_BTN_NUM*4; i+=4) 
            {
                if (fX > selectBtnScope[i] && fX <selectBtnScope[i+1] && fY > selectBtnScope[i+2] && fY <selectBtnScope[i+3]
                    &&(ScrollPos[0] > selectBtnScope[i] && ScrollPos[0] <selectBtnScope[i+1] && ScrollPos[1] > selectBtnScope[i+2] && ScrollPos[1] <selectBtnScope[i+3]))
                { 
                    switch (i/4) 
                    {
                        case 0:
                            playSE(SE_BUTTON_CANCEL);	//objAudioPlay(EVENT_TYPE_UI_CLICK, SOUND_TYPE_INDEX_UI_CLICK, m_bSounds);
                            g_nGameState = GAME_STATE_TITLE;
                            SwitchGameState();
                            break;
                        case 1:
                        {
                            if (LevelIndex>=3 && availableLevels<=24)
                            { 
                                g_nGameState=GAME_STATE_ADS;
                                adsStyle=ADS_STATE_FOUTH_BUY;
                                break;
                            }
                            if (LevelIndex>=1 && availableLevels<=8)break;
							
                            if(mSectionLock[LevelIndex]) break;
                            
                            ActiveLevel = 0;
                            
                            if (LevelIndex==0)
                            {
                                mStoryIndex=0;
                                g_nGameState =GAME_STATE_LEVEL_SELECT;
                            }
                            else if (LevelIndex==1)
                            {
                                mStoryIndex=5;
                                g_nGameState =GAME_STATE_LEVEL_SELECT;
                            }
                            else if(LevelIndex==2)
                            {
                                mStoryIndex=10;
                                g_nGameState =GAME_STATE_LEVEL_SELECT;
                            }
                            else if(LevelIndex==3)
                            {
                                mStoryIndex=0;
                                g_nGameState =GAME_STATE_LEVELTWL_SELECT;
                            }
                         }
                            break;   
                        default:
                            break;
                       
                    }
                    SwitchGameState();
                }
            }
            
        }
		else
		{
			if (ScrollPos[0] - fX > 0)		
            {
				movedir = 2;
				if (ScrollPos[0] - fX > SCROLL_LENGTH && LevelIndex < (LEVEL_NUM_MAX - 1))
				{
					movedir = 1;
					LevelIndex += 1;
				}
			}
			
			else if (fX - ScrollPos[0] > 0)
			{
				movedir = 1;
				if (fX - ScrollPos[0] > SCROLL_LENGTH && LevelIndex > 0)
				{
					movedir = 2;
					LevelIndex -= 1;
				}
			}
			isMove = false;
		}
	}
}
