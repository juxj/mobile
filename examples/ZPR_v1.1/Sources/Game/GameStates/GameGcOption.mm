/*
 *  GameGcOption.cpp
 *  ZPR
 *
 *  Created by Neo Lin on 9/24/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "GameGcOption.h"

#import "Canvas2D.h"
#import "Image.h"

#import "GameRes.h"
#import "GameOption.h"
#import "GamePlay.h"
#import "GameState.h"
#import "GameAudio.h"
#import "Utilities.h"
#import "GameHouse.h"
#import "GameNews.h"
#import "GameAchieve.h"


float btnGcOptionStartPos[2] = 
{
	0.0f, 0.0f
};
bool  btnGcOptionPress[GCOP_BTN_MAX] = 
{
	false, 
	false, 
	false, 
};
float mBtnRectGcOption[GCOP_BTN_DATA_LENGTH] = 
{//	x0,		x1,				y0,		y1
    320.0f,	320.0f+48.0f,	112.0f,	112.0f+48.0f,	// Quit
	132.0f,	132.0f+216.0f,	116.0f+48.0f,				116.0f+48.0f+44.0f,				// Leaderboard of Game Center
	132.0f,	132.0f+216.0f,	116.0f+48.0f+44.0f+1.0f,	116.0f+48.0f+44.0f+1.0f+44.0f,	// Achievements of Game Center
};
char *gcopTitle = (char *)"GAMECENTER";
char *gcopItems[2] = {
	(char *)"LEADERBOARD", 
	(char *)"ACHIEVEMENTS"
};

void GameGcOptionBegin()
{
}

void GameGcOptionUpdate(float dt)
{
}

void GameGcOptionRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	GameCommonFrame(120.0f, 120.0f, 240.0f, 150.0f, 1.0f);
	
	// Back Button
	float btnQuitScale = btnGcOptionPress[GCOP_BTN_QUIT]?BTN_QUIT_PRESSED_SCALE:BTN_QUIT_NORMAL_SCALE;
	canvas->drawImage(mNewsImg[12], 340.0f, 136.f, 0.0f, btnQuitScale, btnQuitScale);
	
	// Title
	DrawString(gcopTitle, (canvas->getCanvasWidth() - GetStringWidth(gcopTitle, 0.6f)) * 0.5f, 135.0f, 0.6f, 1.0f, 1.0f, 1.0f, 1.0f, FONT_TYPE_SLACKEY);
	
	// Options
	if (btnGcOptionPress[GCOP_BTN_GCLB])
	{
		canvas->setColor(0.0f, 0.0f, 0.5f, 0.5f);
		//canvas->setColor(0.2f, 0.2f, 0.2f, 1.0f);//canvas->setColor(0.0f, 0.0f, 0.5f, 0.5f);
		canvas->fillRect(132.0f, 116.0f+48.0f+2.0f, 216.0f, 40.0f);
		canvas->flush();
		canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
	}
	else if (btnGcOptionPress[GCOP_BTN_GCAS])
	{
		canvas->setColor(0.0f, 0.0f, 0.5f, 0.5f);
		//canvas->setColor(0.2f, 0.2f, 0.2f, 1.0f);//canvas->setColor(0.0f, 0.0f, 0.5f, 0.5f);
		canvas->fillRect(132.0f, 116.0f+48.0f+44.0f+1.0f+2.0f, 216.0f, 40.0f);
		canvas->flush();
		canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
	}
	
	canvas->drawImage(mGcIcons[0], 147.0f, 170.0f);
	canvas->drawImage(mGcIcons[1], 147.0f, 170.0f+44.0f+1.0f);
	
	DrawString(gcopItems[0], 196.0f, 116.0f+48.0f+11.0f, 
			   0.5f, 0.0f, 0.0f, 0.0f, 1.0f, FONT_TYPE_SLACKEY);
	DrawString(gcopItems[1], 196.0f, 116.0f+48.0f+44.0f+1.0f+11.0f, 
			   0.5f, 0.0f, 0.0f, 0.0f, 1.0f, FONT_TYPE_SLACKEY);
	
#if 0//DEBUG
	canvas->flush();
	for (int i = 0; i < GCOP_BTN_DATA_LENGTH; i += GCOP_BTN_DATA_ELEM)
	{
		canvas->strokeRect(mBtnRectGcOption[i], mBtnRectGcOption[i+2], 
						   mBtnRectGcOption[i+1] - mBtnRectGcOption[i], 
						   mBtnRectGcOption[i+3] - mBtnRectGcOption[i+2]);
	}
#endif
}

void GameGcOptionTouchEvent(int touchStatus, float fX, float fY)
{
	int btnIdx;
	if (touchStatus == 1)
	{
		btnGcOptionStartPos[0] = fX;
		btnGcOptionStartPos[1] = fY;
		
		for (int i = 0; i < GCOP_BTN_DATA_LENGTH; i += GCOP_BTN_DATA_ELEM)
		{
			btnIdx = i / GCOP_BTN_DATA_ELEM;
			if (fX > mBtnRectGcOption[i] && fX < mBtnRectGcOption[i+1] && 
				fY > mBtnRectGcOption[i+2] && fY <mBtnRectGcOption[i+3])
			{
				btnGcOptionPress[btnIdx] = true;
			}
		}
	}
	else if (touchStatus == 2)
	{
		for (int i = 0; i < GCOP_BTN_DATA_LENGTH; i += GCOP_BTN_DATA_ELEM)
		{
			btnIdx = i / GCOP_BTN_DATA_ELEM;
			btnGcOptionPress[btnIdx] = false;
		}
		for (int i = 0; i < GCOP_BTN_DATA_LENGTH; i += GCOP_BTN_DATA_ELEM)
		{
			btnIdx = i / GCOP_BTN_DATA_ELEM;
			if (fX > mBtnRectGcOption[i] && fX < mBtnRectGcOption[i+1] && 
				fY > mBtnRectGcOption[i+2]  && fY <mBtnRectGcOption[i+3] && 
				(btnGcOptionStartPos[0] > mBtnRectGcOption[i]   && btnGcOptionStartPos[0] < mBtnRectGcOption[i+1] && 
				 btnGcOptionStartPos[1] > mBtnRectGcOption[i+2] && btnGcOptionStartPos[1] < mBtnRectGcOption[i+3]))
			{
				btnGcOptionPress[btnIdx] = true;
			}
		}
	}
	else if (touchStatus == 3)
	{
		for (int i = 0; i < GCOP_BTN_MAX; i++)
		{
			btnGcOptionPress[i] = false;
		}
		for (int i = 0; i < GCOP_BTN_DATA_LENGTH; i += GCOP_BTN_DATA_ELEM)
		{
			btnIdx = i / GCOP_BTN_DATA_ELEM;
			if (fX > mBtnRectGcOption[i]    && fX < mBtnRectGcOption[i+1] && 
				fY > mBtnRectGcOption[i+2]  && fY <mBtnRectGcOption[i+3] && 
				(btnGcOptionStartPos[0] > mBtnRectGcOption[i]   && btnGcOptionStartPos[0] < mBtnRectGcOption[i+1] && 
				 btnGcOptionStartPos[1] > mBtnRectGcOption[i+2] && btnGcOptionStartPos[1] < mBtnRectGcOption[i+3]))
			{
				btnGcOptionPress[btnIdx] = false;
				switch(btnIdx)
				{
					case GCOP_BTN_QUIT_INDEX:
						playSE(SE_BUTTON_CANCEL);
						g_nGameState = GAME_STATE_OPTION;
						SwitchGameState();
						break;
					case GCOP_BTN_GCLB:
						playSE(SE_BUTTON_CANCEL);
						g_nGameState = GAME_STATE_TITLE;
						SwitchGameState();
						LaunchGameCenterLeaderboards();
						break;
					case GCOP_BTN_GCAS:
						playSE(SE_BUTTON_CANCEL);
						g_nGameState = GAME_STATE_TITLE;
						SwitchGameState();
						LaunchGameCenterAchievements();
						break;
				}
			}
			else if (fX > mBtnRectGcOption[i]   && fX < mBtnRectGcOption[i+1] && 
					 fY > mBtnRectGcOption[i+2] && fY <mBtnRectGcOption[i+3] && 
					 !(btnGcOptionStartPos[0] > mBtnRectGcOption[i]   && btnGcOptionStartPos[0] < mBtnRectGcOption[i+1] && 
					   btnGcOptionStartPos[1] > mBtnRectGcOption[i+2] && btnGcOptionStartPos[1] < mBtnRectGcOption[i+3]))
			{
				btnGcOptionPress[btnIdx] = false;
			}
		}
	}
}

void GameCommonFrame(float x, float y, float w, float h, float alpha)
{
	int i;
	float dx = x;
	float dy = y;
	float sx, sy, tw, th;
	Canvas2D* canvas = Canvas2D::getInstance();
	
	if (w < 36.0f) w = 36.0f;//return;
	if (h < 84.0f) h = 84.0f;//return;
	
	tw = w - 32.0f;
	th = h - 80.0f;
	sx = tw / 4.0f;
	sy = th / 4.0f;
	
	if (alpha < 1.0f)
	{
		canvas->enableColorPointer(true);
		for (i = 0; i < 13; i++)
		{
			mNewsImg[i]->SetColor(1.0f, 1.0f, 1.0f, alpha);
		}
	}
	
	canvas->drawImage(mNewsImg[0], dx,			dy);
	canvas->drawImage(mNewsImg[1], dx+16.0f,	dy, 0.0f, sx, 1.0f);
	canvas->drawImage(mNewsImg[2], dx+16.0f+tw,	dy);
	
	dy += 48.0f;
	
	canvas->drawImage(mNewsImg[3], dx,			dy, 0.0f, 1.0f,	sy);
	canvas->drawImage(mNewsImg[4], dx+16.0f,	dy, 0.0f, sx,   sy);
	canvas->drawImage(mNewsImg[5], dx+16.0f+tw,	dy, 0.0f, 1.0f,	sy);
	
	dy += th;
	
	canvas->drawImage(mNewsImg[6], dx,			dy);
	canvas->drawImage(mNewsImg[7], dx+16.0f,	dy, 0.0f, sx, 1.0f);
	canvas->drawImage(mNewsImg[8], dx+16.0f+tw,	dy);
	
//	canvas->drawImage(mNewsImg[9], dx,					y+46.0f);
//	canvas->drawImage(mNewsImg[10], dx+32.0f+tw-10.0f,	dy+32.0f-12.0f);
	
	if (alpha < 1.0f)
	{
		canvas->enableColorPointer(false);
		for (i = 0; i < 13; i++)
		{
			mNewsImg[i]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
		}
	}
}
