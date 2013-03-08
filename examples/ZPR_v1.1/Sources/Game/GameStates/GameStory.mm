/*
 *  GameStory.mm
 *  ZPR
 *
 *  Created by Linda Li on 7/6/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "GameStory.h"
#include "GameState.h"
#include "GameRes.h"
#include "Canvas2D.h"
#include "neoRes.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ZPRAppDelegate.h"
#import "Image.h"
#import "Utilities.h"
#import "GameSection.h"
#import "GameAudio.h"
#import "GameLevel.h"


float StartStoryPointXY[2]={0};
bool isSkipPress=false;
#define	TIME_WAIT_SHOW	3000
#define	MOVE_SPEED	4
#ifdef  VERSION_IPAD
#define IPAD_STORY_X   2.13/2.0 //42.66f
#define IPAD_STORY_Y  47.0f
#define IPAD_STORY_H   768*2/320
#else 
#define IPAD_STORY_X   1.0f
#define IPAD_STORY_Y    10.0f
#define IPAD_STORY_H    1.0f
#endif
static float k=0,j=0,l=0,m=0;
float  SkipPos[4]={ 365*IPAD_STORY_X ,452*IPAD_STORY_X ,260*IPAD_STORY_X+IPAD_STORY_Y ,300*IPAD_STORY_Y};
bool hasPlay=false;
bool hasTreeEndPlay=true;
static float alpha = 0.0f;

static float mStoryCount = 0;

void GameStoryBegin()
{
	RelMenuRes();
	playBGM(BGM_MENU);
}

void GameStoryEnd()
{
	//[app playbackDidFinish];
}

void GameStoryRender(float dt)
{
	GameStoryIndexRender(mStoryIndex,dt);
	int color=isSkipPress?0:1;
	//Canvas2D* canvas = Canvas2D::getInstance();
//	canvas->strokeRect( SkipPos[0],  SkipPos[2], 
//					   SkipPos[1]-SkipPos[0],SkipPos[3]-SkipPos[2]);
	DrawString((char*)"Skip", 380*IPAD_STORY_X, 266*IPAD_STORY_X+IPAD_STORY_Y,0.8,1,1,color);
}

void GameStoryOnTouchEvent(int touchStatus, float fX, float fY)
{
	if (touchStatus==1)
	{
		StartStoryPointXY[0]=fX;
		StartStoryPointXY[1]=fY;
		if ((fX > SkipPos[0] && fX < SkipPos[1]) && ( fY > SkipPos[2] && fY < SkipPos[3]))
		{
			isSkipPress=true;
		}
	}
	else if (touchStatus==2)
	{
		if ((fX > SkipPos[0] && fX < SkipPos[1]) && ( fY > SkipPos[2] && fY < SkipPos[3])
			&&(StartStoryPointXY[0] > SkipPos[0] && StartStoryPointXY[0] <  SkipPos[1]) && ( StartStoryPointXY[1]>  SkipPos[2] && StartStoryPointXY[1] <  SkipPos[3]))
		{//  NSLog(@"sdfasdf\n");
			isSkipPress=true;
		}
		else {
			isSkipPress=false;
		}
	}
	else if(touchStatus == 3)
	{
		isSkipPress=false;
		if ((fX > SkipPos[0] && fX < SkipPos[1]) && ( fY > SkipPos[2] && fY < SkipPos[3])
			&&(StartStoryPointXY[0] > SkipPos[0] && StartStoryPointXY[0] < SkipPos[1]) && ( StartStoryPointXY[1]> SkipPos[2] && StartStoryPointXY[1] < SkipPos[3]))
		{
		
			
			if (LevelIndex < LEVEL_NUM_MAX)
			{  

					if ((LevelIndex*8)+ActiveLevel>=availableLevels) 
                    {
                        if (LevelIndex==1) 
                        {
                            adsStyle=ADS_STATE_FREE_BUY;
                        }
                        else
                        {
                          adsStyle=ADS_STATE_FOUTH_BUY;
                        }
						g_nGameState = GAME_STATE_ADS;
                        
					}
					else 
                    {
						g_nGameState = GAME_STATE_LOADING;
					}

			}
			else
			{
				LevelIndex = 0;
				g_nGameState = GAME_STATE_CREDIT;
//				InitCreditRes();
			}
        
			SwitchGameState();
            j=0;
			l=0;
			k=0;
			m=0;
			
			alpha = 0.0f;
			mStoryCount=0;
		}
	}
}

void GameStoryIndexRender(int index, float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	switch (index)
	{
		case 0:
		case 5:
		case 10:
		case 12:
		case 13:
        case 17:
        case 18:
        case 20:
		{
			if (index==12||index==17||index==20)
			{
				canvas->drawImage(mStory[index-1],0,0);
			}
			canvas->enableColorPointer(TRUE);
			
			if (alpha <1.0f)
			{
				alpha +=(float) MOVE_SPEED/480;
				
			}
			else
			{
				alpha =1.0f;
				mStoryCount+= dt;
			}
			mStory[mStoryIndex]->SetColor(1.0f, 1.0f, 1.0f, alpha);
			canvas->drawImage(mStory[mStoryIndex],0,0);
			canvas->enableColorPointer(FALSE);
			
			if(mStoryCount>=TIME_WAIT_SHOW)
			{
				if (index==12)
				{
					mStoryIndex=50;
					mStoryCount=0;
				}
				else if (index==17)
				{
					mStoryIndex=51;
					mStoryCount=0;
				}
                else if(index==20)
                {
                    mStoryIndex=52;
					mStoryCount=0;
                }
                else
				{
					mStoryIndex++;
					mStoryCount=0;
				}
			}
			
		}
			break;
		case 1://?³ä?
		case 11:
	    case 14:
			MoveFromAngle(480, -320, index,-1,1,dt);
			break;
		case 8:
        
		{
			if (mStoryCount<TIME_WAIT_SHOW) 
			{
				mStoryCount+= dt;
				canvas->drawImage(mStory[mStoryIndex],0,0);
			}
			else 
			{
				if (j<=480*IPAD_X)
				{
					canvas->drawImage(mStory[mStoryIndex+1],0,0);
					j+=(float)MOVE_SPEED*(3/2);
					l+=MOVE_SPEED;
					canvas->drawImage(mStory[mStoryIndex],0-j,0+l);
				}
				else
				{
					canvas->drawImage(mStory[mStoryIndex+1],0,0);
						mStoryIndex++;
						mStoryCount=0;
						j=0;
						l=0;
					
				}
			}

			
		}
			break;
		case 2://ä¸??ä¸?????
		{
#ifdef    VERSION_IPAD
			if (k <= 768.0f) {
				canvas->drawImage(mStory[mStoryIndex-1], 0.0f, 0.0f);
				drawStoryPageSp1(0.0f,   768.0f - k);
				drawStoryPageSp2(420.0f, 768.0f - k);
				k += MOVE_SPEED * GLOBAL_CANVAS_SCALE;
			}
			else if (k >= 768.0f && mStoryCount < TIME_WAIT_SHOW)
			{
				drawStoryPageSp1(0.0f,   0.0f);
				drawStoryPageSp2(420.0f, 0.0f);
				mStoryCount += dt;
			}
			
			if (mStoryCount >= TIME_WAIT_SHOW)
			{
				if (m <=624)
				{
					canvas->drawImage(mStory[mStoryIndex+2],0,0);
					drawStoryPageSp1(0 - m, 0);
					drawStoryPageSp2(420.0f + m, 0);
					
					m += MOVE_SPEED * GLOBAL_CANVAS_SCALE;
				}
				else
				{
					canvas->drawImage(mStory[mStoryIndex+2],0,0);
					mStoryIndex+=2;
					mStoryCount=0;
					alpha =1.0f;
					k=0;
					m=0;
				}
			}
#else
            if (k <= 320.0f) {
				canvas->drawImage(mStory[mStoryIndex-1], 0.0f, 0.0f);
				drawStoryPageSp1(0.0f,   320.0f - k);
				drawStoryPageSp2(194.0f, 320.0f - k);
				k += MOVE_SPEED * GLOBAL_CANVAS_SCALE;
			}
			else if (k >= 320.0f && mStoryCount < TIME_WAIT_SHOW)
			{
				drawStoryPageSp1(0.0f,   0.0f);
				drawStoryPageSp2(194.0f, 0.0f);
				mStoryCount += dt;
			}
			
			if (mStoryCount >= TIME_WAIT_SHOW)
			{
				if (m <=624)
				{
					canvas->drawImage(mStory[mStoryIndex+2],0,0);
					drawStoryPageSp1(0 - m, 0);
					drawStoryPageSp2(194.0f + m, 0);
					
					m += MOVE_SPEED * GLOBAL_CANVAS_SCALE;
				}
				else
				{
					canvas->drawImage(mStory[mStoryIndex+2],0,0);
					mStoryIndex+=2;
					mStoryCount=0;
					alpha =1.0f;
					k=0;
					m=0;
				}
			}
#endif
		}
			break;
		case 4:
		case 9:
		case 50:
		case 51:
        case 52: 
		{   
			drawSky();
			if (index==50||index==51||index==52) {
				mStoryCount=TIME_WAIT_SHOW;
			}
			if(mStoryCount<TIME_WAIT_SHOW)
			{  
				canvas->drawImage(mStory[mStoryIndex],0,0);
				mStoryCount+= dt;
			}
			else
			{
				alpha -=(float)MOVE_SPEED/480;
				if (alpha>=0) 
				{
					canvas->enableColorPointer(TRUE);
					if (index==50) {
						mStory[12]->SetColor(1.0f, 1.0f, 1.0f, alpha);
						canvas->drawImage(mStory[12],0,0);
					}
					else if(index==51){
						mStory[17]->SetColor(1.0f, 1.0f, 1.0f, alpha);
						canvas->drawImage(mStory[17],0,0);
					}
					else if(index==52){
						mStory[20]->SetColor(1.0f, 1.0f, 1.0f, alpha);
						canvas->drawImage(mStory[20],0,0);
					}
					else 
					{
						mStory[mStoryIndex]->SetColor(1.0f, 1.0f, 1.0f, alpha);
						canvas->drawImage(mStory[mStoryIndex],0,0);
					}
					canvas->enableColorPointer(FALSE);	
					
					
				}
				else
				{  
					j=0;
					l=0;
					k=0;
					m=0;
					alpha = 0.0f;
					mStoryCount=0.0f;
					
					if (LevelIndex < 4)
					{  
                        if ((LevelIndex*8)+ActiveLevel>=availableLevels)
                        {
                            if (LevelIndex==1) 
                            {
                                adsStyle=ADS_STATE_FREE_BUY;
                            }
                            else 
                            {
                                adsStyle=ADS_STATE_FOUTH_BUY;
                            }
                            g_nGameState = GAME_STATE_ADS;
                        }
                        else {
                            g_nGameState = GAME_STATE_LOADING;
                      }
                        
					}
					else
					{
						LevelIndex = 0;
						g_nGameState = GAME_STATE_CREDIT;
						//					InitCreditRes();
					}
					
					SwitchGameState();
				}
				
			}
		}
			break;
		case 6:		// city -> factory
		{
#ifdef VERSION_IPAD
			if (k <= 768.0f) {
				canvas->drawImage(mStory[mStoryIndex-1], 0.0f, 0.0f);
				drawStoryPageSp3(0.0f,   768.0f - k);
				drawStoryPageSp4(666.0f, 768.0f - k);
				k += MOVE_SPEED * GLOBAL_CANVAS_SCALE;
			}
			else if (k >= 768.0f && mStoryCount < TIME_WAIT_SHOW)
			{
				drawStoryPageSp3(0.0f,   0.0f);
				drawStoryPageSp4(666.0f, 0.0f);
				mStoryCount += dt;
			}
			
			if (mStoryCount >= TIME_WAIT_SHOW)
			{
				if (m <= 770)
				{
					canvas->drawImage(mStory[mStoryIndex+2],0,0);
					drawStoryPageSp3(0.0f - m,   0.0f);
					drawStoryPageSp4(666.0f + m*374/770, 0.0f);
					m += MOVE_SPEED * GLOBAL_CANVAS_SCALE;
				}
				else
				{
					canvas->drawImage(mStory[mStoryIndex+2],0,0);
					mStoryIndex+=2;
					mStoryCount=0;
					alpha =1.0f;
					k=0;
					m=0;
				}
			}
#else
            if (k <= 320.0f) {
				canvas->drawImage(mStory[mStoryIndex-1], 0.0f, 0.0f);
				drawStoryPageSp3(0.0f,   320.0f - k);
				drawStoryPageSp4(298.0f, 320.0f - k);
				k += MOVE_SPEED * GLOBAL_CANVAS_SCALE;
			}
			else if (k >= 320.0f && mStoryCount < TIME_WAIT_SHOW)
			{
				drawStoryPageSp3(0.0f,   0.0f);
				drawStoryPageSp4(298.0f, 0.0f);
				mStoryCount += dt;
			}
			
			if (mStoryCount >= TIME_WAIT_SHOW)
			{
				if (m <= 770)
				{
					canvas->drawImage(mStory[mStoryIndex+2],0,0);
					drawStoryPageSp3(0.0f - m,   0.0f);
					drawStoryPageSp4(298.0f + m*374/770, 0.0f);
					m += MOVE_SPEED * GLOBAL_CANVAS_SCALE;
				}
				else
				{
					canvas->drawImage(mStory[mStoryIndex+2],0,0);
					mStoryIndex+=2;
					mStoryCount=0;
					alpha =1.0f;
					k=0;
					m=0;
				}
			}
#endif
		}
			break;
		case 15:
        case 19:
			MoveFromAngle(-480, -320, index,1,1,dt);
			break;
        case 16: 
			MoveFromAngle(-480, 320, index,1,-1,dt);
			break;
		default:
			break;
	}
}

void MoveFromAngle(float sx,float sy,int sIndex,int signX,int signY,float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();

	if (j<480&&l<320) {
		canvas->drawImage(mStory[sIndex-1],0,0);
		j+=(float)(MOVE_SPEED*3/2);
		l+=MOVE_SPEED;
		canvas->drawImage(mStory[sIndex],sx+(signX)*j,sy+(signY)*l);
	}
	else{
		canvas->drawImage(mStory[sIndex],0,0);
		mStoryCount+= dt;
		if(mStoryCount>=TIME_WAIT_SHOW){
			mStoryIndex++;
			mStoryCount=0;
			j=0;
			l=0;
			if (sIndex==11||sIndex==16||sIndex==19) {
				alpha=0.0;
			}
		}
	}
}

#ifdef VERSION_IPAD
void drawStoryPageSp1(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p1[] = {// 8
		0.0f,   0.0f,
		420.0f, 0.0f,
		0.0f,   768.0f,
		420.0f, 768.0f
	};
	const float t1[] = {// 12
		0.0f, 0.0f,
		(420.0f/1024.0f), 0.0f,
		0.0f, (768.0f/1024.0f),
		
		(420.0f/1024.0f), (768.0f/1024.0f),
		0.0f, (768.0f/1024.0f),
		(420.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[2], x + 0.0f, y + 0.0f, p1, t1);
	
	const float p2[] = {// 8
		0.0f,  0.0f,
		86.0f, 0.0f,
		0.0f,  768.0f,
		0.0f,  768.0f
	};
	const float t2[] = {// 12
		(420.0f/1024.0f), 0.0f,
		(506.0f/1024.0f), 0.0f,
		(420.0f/1024.0f), (768.0f/1024.0f),
		
		(506.0f/1024.0f), (768.0f/1024.0f),
		(420.0f/1024.0f), (768.0f/1024.0f),
		(506.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[2], x + 420.0f, y + 0.0f, p2, t2);
}
void drawStoryPageSp2(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p3[] = {// 8
		86.0f, 0.0f,
		86.0f, 0.0f,
		0.0f,  768.0f,
		86.0f, 768.0f
	};
	const float t3[] = {// 12
		(506.0f/1024.0f), 0.0f,
		(506.0f/1024.0f), 0.0f,
		(420.0f/1024.0f), (768.0f/1024.0f),
		
		(506.0f/1024.0f), (768.0f/1024.0f),
		(420.0f/1024.0f), (768.0f/1024.0f),
		(506.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[2], x + 0.0f, y + 0.0f, p3, t3);
	
	const float p4[] = {// 8
		0.0f,   0.0f,
		518.0f, 0.0f,
		0.0f,   768.0f,
		518.0f, 768.0f
	};
	const float t4[] = {// 12
		(506.0f/1024.0f), 0.0f,
		1.0f, 0.0f,
		(506.0f/1024.0f), (768.0f/1024.0f),
		
		1.0f, (768.0f/1024.0f),
		(506.0f/1024.0f), (768.0f/1024.0f),
		1.0f, 0.0f,
	};
	canvas->drawQuadImage(mStory[2], x + 86.0f, y + 0.0f, p4, t4);
}
void drawStoryPageSp3(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p5[] = {// 8
		0.0f,   0.0f,
		666.0f, 0.0f,
		0.0f,   768.0f,
		666.0f, 768.0f
	};
	const float t5[] = {// 12
		0.0f, 0.0f,
		(666.0f/1024.0f), 0.0f,
		0.0f, (768.0f/1024.0f),
		
		(666.0f/1024.0f), (768.0f/1024.0f),
		0.0f, (768.0f/1024.0f),
		(666.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[6], x + 0.0f, y + 0.0f, p5, t5);
	
	const float p6[] = {// 8
		0.0f,   0.0f,
		92.0f, 0.0f,
		0.0f,   768.0f,
		0.0f,   768.0f
	};
	const float t6[] = {// 12
		(666.0f/1024.0f), 0.0f,
		(758.0f/1024.0f), 0.0f,
		(666.0f/1024.0f), (768.0f/1024.0f),
		
		(758.0f/1024.0f), (768.0f/1024.0f),
		(666.0f/1024.0f), (768.0f/1024.0f),
		(758.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[6], x + 666.0f, y + 0.0f, p6, t6);
}
void drawStoryPageSp4(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p7[] = {// 8
		92.0f, 0.0f,
		92.0f, 0.0f,
		0.0f,  768.0f,
		92.0f, 768.0f
	};
	const float t7[] = {// 12
		(758.0f/1024.0f), 0.0f,
		(758.0f/1024.0f), 0.0f,
		(666.0f/1024.0f), (768.0f/1024.0f),
		
		(758.0f/1024.0f), (768.0f/1024.0f),
		(666.0f/1024.0f), (768.0f/1024.0f),
		(758.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[6], x + 0.0f, y + 0.0f, p7, t7);
	
	const float p8[] = {// 8
		0.0f,   0.0f,
		266.0f, 0.0f,
		0.0f,   768.0f,
		266.0f, 768.0f
	};
	const float t8[] = {// 12
		(758.0f/1024.0f), 0.0f,
		1.0f, 0.0f,
		(758.0f/1024.0f), (768.0f/1024.0f),
		
		1.0f, (768.0f/1024.0f),
		(758.0f/1024.0f), (768.0f/1024.0f),
		1.0f, 0.0f,
	};
	canvas->drawQuadImage(mStory[6], x + 92.0f, y + 0.0f, p8, t8);
}


#else


void drawStoryPageSp1(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p1[] = {// 8
		0.0f,   0.0f,
		194.0f, 0.0f,
		0.0f,   320.0f,
		194.0f, 320.0f
	};
	const float t1[] = {// 12
		0.0f, 0.0f,
		(194.0f/512.0f), 0.0f,
		0.0f, (320.0f/512.0f),
		
		(194.0f/512.0f), (320.0f/512.0f),
		0.0f, (320.0f/512.0f),
		(194.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[2], x + 0.0f, y + 0.0f, p1, t1);
	
	const float p2[] = {// 8
		0.0f,  0.0f,
		38.0f, 0.0f,
		0.0f,  320.0f,
		0.0f,  320.0f
	};
	const float t2[] = {// 12
		(194.0f/512.0f), 0.0f,
		(232.0f/512.0f), 0.0f,
		(194.0f/512.0f), (320.0f/512.0f),
		
		(232.0f/512.0f), (320.0f/512.0f),
		(194.0f/512.0f), (320.0f/512.0f),
		(232.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[2], x + 194.0f, y + 0.0f, p2, t2);
}
void drawStoryPageSp2(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p3[] = {// 8
		38.0f, 0.0f,
		38.0f, 0.0f,
		0.0f,  320.0f,
		38.0f, 320.0f
	};
	const float t3[] = {// 12
		(232.0f/512.0f), 0.0f,
		(232.0f/512.0f), 0.0f,
		(194.0f/512.0f), (320.0f/512.0f),
		
		(232.0f/512.0f), (320.0f/512.0f),
		(194.0f/512.0f), (320.0f/512.0f),
		(232.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[2], x + 0.0f, y + 0.0f, p3, t3);
	
	const float p4[] = {// 8
		0.0f,   0.0f,
		280.0f, 0.0f,
		0.0f,   320.0f,
		280.0f, 320.0f
	};
	const float t4[] = {// 12
		(232.0f/512.0f), 0.0f,
		(480.0f/512.0f), 0.0f,
		(232.0f/512.0f), (320.0f/512.0f),
		
		(480.0f/512.0f), (320.0f/512.0f),
		(232.0f/512.0f), (320.0f/512.0f),
		(480.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[2], x + 38.0f, y + 0.0f, p4, t4);
}
void drawStoryPageSp3(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p5[] = {// 8
		0.0f,   0.0f,
		298.0f, 0.0f,
		0.0f,   320.0f,
		298.0f, 320.0f
	};
	const float t5[] = {// 12
		0.0f, 0.0f,
		(298.0f/512.0f), 0.0f,
		0.0f, (320.0f/512.0f),
		
		(298.0f/512.0f), (320.0f/512.0f),
		0.0f, (320.0f/512.0f),
		(298.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[6], x + 0.0f, y + 0.0f, p5, t5);
	
	const float p6[] = {// 8
		0.0f,  0.0f,
		40.0f, 0.0f,
		0.0f,  320.0f,
		0.0f,  320.0f
	};
	const float t6[] = {// 12
		(298.0f/512.0f), 0.0f,
		(338.0f/512.0f), 0.0f,
		(298.0f/512.0f), (320.0f/512.0f),
		
		(338.0f/512.0f), (320.0f/512.0f),
		(298.0f/512.0f), (320.0f/512.0f),
		(338.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[6], x + 298.0f, y + 0.0f, p6, t6);
}
void drawStoryPageSp4(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p7[] = {// 8
		40.0f, 0.0f,
		40.0f, 0.0f,
		0.0f,  320.0f,
		40.0f, 320.0f
	};
	const float t7[] = {// 12
		(338.0f/512.0f), 0.0f,
		(338.0f/512.0f), 0.0f,
		(298.0f/512.0f), (320.0f/512.0f),
		
		(338.0f/512.0f), (320.0f/512.0f),
		(298.0f/512.0f), (320.0f/512.0f),
		(338.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[6], x + 0.0f, y + 0.0f, p7, t7);
	
	const float p8[] = {// 8
		0.0f,   0.0f,
		144.0f, 0.0f,
		0.0f,   320.0f,
		144.0f, 320.0f
	};
	const float t8[] = {// 12
		(336.0f/512.0f), 0.0f,
		(480.0f/512.0f), 0.0f,
		(336.0f/512.0f), (320.0f/512.0f),
		
		(480.0f/512.0f), (320.0f/512.0f),
		(336.0f/512.0f), (320.0f/512.0f),
		(480.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(mStory[6], x + 38.0f, y + 0.0f, p8, t8);
}

#endif
