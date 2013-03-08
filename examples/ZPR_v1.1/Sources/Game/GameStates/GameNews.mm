/*
 *  GameNews.mm
 *  ZPR
 *
 *  Created by Neo Lin on 9/20/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "GameNews.h"

#import "ZPRAppDelegate.h"

#import "Canvas2D.h"
#import "Image.h"

#import "GameRes.h"
#import "GameOption.h"
#import "GamePlay.h"
#import "GameState.h"
#import "GameAudio.h"
#import "Utilities.h"
#import "GameHouse.h"

#import "GameData.h"

#import "ZPRAppDelegate.h"

#import "CheckNetwork.h"


int  newsFlag = NEWS_NONE;
bool newsChecked = false;
int  newsNoti = 0;
char newsData[1024] = {0};

float btnNewsStartPos[2] = 
{
	0.0f, 0.0f
};
bool  btnNewsPress[NEWS_BTN_MAX] = 
{
	false, 
	false, 
	false
};
float mBtnRectNews[NEWS_BTN_DATA_LENGTH] = 
{//	x0,		x1,				y0,		y1
#ifdef VERSION_IPAD
    450.0f,	450.0f+48.0f,	180.0f,	180.0f+48.0f,	// Quit
	0.0f,	48.0f,			270.0f,	270.0f+48.0f,	// Page Up (Left)
	450.0f,	450.0f+48.0f,	270.0f,	270.0f+48.0f	// Page Down (Right)
#else
	432.0f,	432.0f+48.0f,	110.0f,	110.0f+48.0f,	// Quit
	0.0f,	48.0f,			200.0f,	200.0f+48.0f,	// Page Up (Left)
	432.0f,	432.0f+48.0f,	200.0f,	200.0f+48.0f	// Page Down (Right)
#endif
};
char newsTitle[] = "BREAK MEDIA NEWS";
char newsRefresh[] = "Checking...";
char newsFailure[] = "No Internet connection available. Please make sure your device is connected to the network .";

int nRetryToGetNews = 0;

void GameNewsBegin()
{
	GameNewsDownload();
}

void GameNewsUpdate(float dt)
{
	GameNewsCheck();
    if (newsFlag == NEWS_NONE)
	{
        if ([CheckNetwork checkNetwork])
        {
            GameNewsDownload();
        }
	}
//	if (newsNoti)
//	{
//		GameNewsHaveRead();
//	}
}

void GameNewsRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
#ifdef VERSION_IPAD
	float offsetX = (canvas->mScreenWidth/GLOBAL_CANVAS_SCALE - 474.0f) * 0.5f - 3.0f;
	float offsetY = (canvas->mScreenHeight/GLOBAL_CANVAS_SCALE - 200.0f) - 120.0f;
#else
	float offsetX = 0.0f;
	float offsetY = 0.0f;
#endif
	
	// Panel
//	canvas->enableColorPointer(true);
//	RenderTileBG(TYPE_SUCC_INFO_BG, 
//				 (canvas->getCanvasWidth()-TILE_SUCC_INFO_COL*29)/2, 
//				 128.0f, 
//				 1.0f, 0.58f);
//	canvas->enableColorPointer(false);
	GameNewsFrame((canvas->mScreenWidth/GLOBAL_CANVAS_SCALE - 474.0f) * 0.5f, 
				  120.0f + offsetY,//(canvas->mScreenHeight/GLOBAL_CANVAS_SCALE - 200.0f), 
				  474.0f, 192.0f, 1.0f);
//	GameNewsFrame(3.0f, 120.0f, 474.0f, 192.0f, 1.0f);
	
	// Back Button
	float btnQuitScale = btnNewsPress[NEWS_BTN_QUIT]?BTN_QUIT_PRESSED_SCALE:BTN_QUIT_NORMAL_SCALE;
	canvas->drawImage(mNewsImg[12], 
					  456.0f + offsetX, 
					  136.f + offsetY, 
					  0.0f, btnQuitScale, btnQuitScale);
//	canvas->drawImage(mNewsImg[12], 456.0f, 136.f, 0.0f, btnQuitScale, btnQuitScale);
	
	// Title
	DrawString(newsTitle, 
			   (canvas->mScreenWidth/GLOBAL_CANVAS_SCALE - GetStringWidth(newsTitle, 0.6f)) * 0.5f, 
			   135.0f + offsetY, 
			   0.6f, 1.0f, 1.0f, 1.0f, 1.0f, FONT_TYPE_SLACKEY);
	
	// Contents
	if (newsFlag == NEWS_NONE || 
		newsFlag == NEWS_CHECK
//        || 
//		newsFlag == NEWS_REFRESH
        )
	{
		DrawMultiLineString(newsRefresh, 
							48.0f, 
							146.0f + offsetY, 
							NEWS_FONT_SIZE_SCALE, 
							384.0f, 24.0f, 
							0.0f, 0.0f, 0.0f, 1.0f);
	}
    else if (newsFlag == NEWS_DONE)
    {
        DrawMultiLineString(newsFailure, 
							48.0f, 
							146.0f + offsetY, 
							NEWS_FONT_SIZE_SCALE, 
							384.0f, 24.0f, 
							0.0f, 0.0f, 0.0f, 1.0f);
    }
	else
	{
		DrawMultiLineString(newsData, 
							48.0f, 
							146.0f + offsetY, 
							NEWS_FONT_SIZE_SCALE, 
							384.0f, 24.0f, 
							0.0f, 0.0f, 0.0f, 1.0f);
	}
	
#if 0//DEBUG
	canvas->flush();
	for (int i = 0; i < NEWS_BTN_DATA_LENGTH; i += NEWS_BTN_DATA_ELEM)
	{
		canvas->strokeRect(mBtnRectNews[i], mBtnRectNews[i+2], 
						   mBtnRectNews[i+1] - mBtnRectNews[i], 
						   mBtnRectNews[i+3] - mBtnRectNews[i+2]);
	}
#endif
}

void GameNewsTouchEvent(int touchStatus, float fX, float fY)
{
	if (touchStatus == 1)
	{
		BtnOptionStartPos[0] = fX;
		BtnOptionStartPos[1] = fY;
		
		for (int i = 0; i < NEWS_BTN_DATA_LENGTH; i += NEWS_BTN_DATA_ELEM)
		{
			if (fX > mBtnRectNews[i] && fX < mBtnRectNews[i+1] && 
				fY > mBtnRectNews[i+2] && fY <mBtnRectNews[i+3])
			{
				btnNewsPress[i] = true;
			}
		}
	}
	else if (touchStatus == 2)
	{
		for (int i = 0; i < NEWS_BTN_DATA_LENGTH; i += NEWS_BTN_DATA_ELEM)
		{
			btnNewsPress[i] = false;
		}
		for (int i = 0; i < NEWS_BTN_DATA_LENGTH; i += NEWS_BTN_DATA_ELEM)
		{
			if (fX > mBtnRectNews[i] && fX < mBtnRectNews[i+1] && 
				fY > mBtnRectNews[i+2]  && fY <mBtnRectNews[i+3] && 
				(BtnOptionStartPos[0] > mBtnRectNews[i] && BtnOptionStartPos[0] < mBtnRectNews[i+1] && 
				 BtnOptionStartPos[1] > mBtnRectNews[i+2] && BtnOptionStartPos[1] <mBtnRectNews[i+3]))
			{
				btnNewsPress[i] = true;
			}
		}
	}
	else if (touchStatus == 3)
	{
		for (int i = 0; i < NEWS_BTN_DATA_LENGTH; i += NEWS_BTN_DATA_ELEM)
		{
			int btnIdx = i/NEWS_BTN_DATA_ELEM;
			if (fX > mBtnRectNews[i] && fX < mBtnRectNews[i+1] && 
				fY > mBtnRectNews[i+2]  && fY <mBtnRectNews[i+3] && 
				(BtnOptionStartPos[0] > mBtnRectNews[i] && BtnOptionStartPos[0] < mBtnRectNews[i+1] && 
				 BtnOptionStartPos[1] > mBtnRectNews[i+2] && BtnOptionStartPos[1] <mBtnRectNews[i+3]))
			{
				btnNewsPress[btnIdx] = false;
				switch(btnIdx)
				{
					case NEWS_BTN_QUIT_INDEX:
						playSE(SE_BUTTON_CANCEL);
                        if (newsNoti)
                        {
                            GameNewsHaveRead();
                        }
						g_nGameState = GAME_STATE_TITLE;
						SwitchGameState();
						break;
				}
			}
			else if (fX > mBtnRectNews[i] && fX < mBtnRectNews[i+1] && 
					 fY > mBtnRectNews[i+2]  && fY <mBtnRectNews[i+3] && 
					 !(BtnOptionStartPos[0] > mBtnRectNews[i] && BtnOptionStartPos[0] < mBtnRectNews[i+1] 
					   && BtnOptionStartPos[1] > mBtnRectNews[i+2] && BtnOptionStartPos[1] <mBtnRectNews[i+3]))
			{
				btnNewsPress[btnIdx] = false;
			}
		}
	}
}

void GameNewsDownload()
{
	if (newsFlag != NEWS_CACHED)
	{
		[app downloadNews];
	}
}

void GameNewsHaveRead()
{
	newsNoti = 0;
	SaveFile();
}

int GameNewsCheck()
{
	switch(newsFlag)
	{
		case NEWS_NONE:
			if (!newsChecked)
			{
                nRetryToGetNews = 0;
				newsFlag = NEWS_CHECK;
			}
			break;
		case NEWS_CACHED:
			break;
		case NEWS_DLD:
			break;
		case NEWS_CHECK:
			if (!newsChecked)
			{
				if ([app nNews])
				{
                    char tempData[1024];
                    memset(tempData, '\0', sizeof(tempData));
                    strcpy(tempData, [app getNewsData]);
                    if ((strcmp((const char*)newsData, (const char*)tempData)))
                    {
                        char savedData[1024];
                        strcpy(savedData, (const char*)newsData);
//                        printf("%s\n%s\n", savedData, tempData);
                        if (!(strcmp((const char*)savedData, (const char*)tempData)))
                        {
                            newsChecked = true;
                            newsFlag = NEWS_CACHED;
                            ///newsNoti = 0;
//#ifdef DEBUG
//                            printf("Keeping cached news...\n");
//#endif
                            break;
                        }
                        else if (!(strcmp((const char*)tempData, (const char*)(""))))
                        {
                            if (strlen((const char*)newsData) > 1)
                            {
                                newsChecked = true;
                                newsFlag = NEWS_CACHED;
                                ///newsNoti = 0;
                                break;
                            }
                            else
                            {
                                newsFlag = NEWS_DONE;
                            }
                        }
                        
                        strcpy(newsData, tempData);
                        [app setNNews:0];
                        
                        newsChecked = true;
                        newsFlag = NEWS_REFRESH;
                        newsNoti = 1;
                        break;
                    }
					else if (newsNoti == 0)
					{
						newsChecked = true;
						newsFlag = NEWS_CACHED;
						///newsNoti = 0;
                        break;
					}
				}
                
                ++nRetryToGetNews;
                if (nRetryToGetNews > 120)
                {
                    if (!(strcmp((const char*)newsData, (const char*)"")))
                    {
                        newsFlag = NEWS_DONE;
                    }
                    else
                    {
                        newsChecked = true;
						newsFlag = NEWS_CACHED;
						///newsNoti = 0;
                    }
                }
			}
			break;
		case NEWS_REFRESH:
			SaveFile();
			newsFlag = NEWS_CACHED;
			break;
		case NEWS_DONE:
			break;
		default:
			break;
	}
	return newsFlag;
}

void GameNewsCheckManually()
{
    nRetryToGetNews = 0;
	newsFlag = NEWS_NONE;
	newsChecked = false;
}

void GameNewsFrame(float x, float y, float w, float h, float alpha)
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
	
	canvas->drawImage(mNewsImg[9], dx,					y+46.0f);
	canvas->drawImage(mNewsImg[10], dx+32.0f+tw-10.0f,	dy+32.0f-12.0f);
	
	if (alpha < 1.0f)
	{
		canvas->enableColorPointer(false);
		for (i = 0; i < 13; i++)
		{
			mNewsImg[i]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
		}
	}
}
