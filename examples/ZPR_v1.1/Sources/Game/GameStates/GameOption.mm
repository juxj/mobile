/*
 *  GameOption.m
 *  ZPR
 *
 *  Created by Linda Li on 7/14/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "GameOption.h"
#import "GameAudio.h"
#import "GameData.h"

#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"

#import "ZPRAppDelegate.h"	// for getting *app

#import "OpenFeint/OpenFeint.h"
#import "OpenFeint/OFTimeStamp.h"
#import "OpenFeint/OFHighScoreService.h"
#import "OpenFeint/OFAnnouncement.h"
#import "OpenFeint/OFAchievementService.h"
#import "OpenFeint/OFAchievement.h"
#import "OpenFeint/OpenFeint+Dashboard.h"

#import "GameRes.h"
#import "GameState.h"
#import "GamePause.h"
#import "Utilities.h"
#import "GameAchieve.h"
#import "GamePlay.h"
#import "GameNews.h"

#import "CheckNetwork.h"
#import "GameHouse.h"
#import "GameLevel.h"
#import "Runner.h"

int TitleLevelIndex = 1;//normal
//#define IPAD_LEVEL_Y  
bool m_bBgm = true;
bool m_bSounds = true;
bool m_b4iPod = false;
bool m_b4sSnd = false;
bool isClearData=false;

float BtnOptionStartPos[2] = {0.0f, 0.0f};

#ifdef V_1_1_0
    bool BtnPress[BTN_NUM_MAX_OPTIONS] = {false, false, false, false, false, false};
 #ifdef VERSION_IPAD
    float PicPos[10] = {
        291.0f*IPAD_X,  67.0f*IPAD_X+IPAD_THREE_Y,	// volume
        289.0f*IPAD_X, 107.0f*IPAD_X+IPAD_THREE_Y,	// music
        294.0f*IPAD_X, 150.0f*IPAD_X+IPAD_THREE_Y,	// reset data
        291.0f*IPAD_X, 193.0f*IPAD_X+IPAD_THREE_Y,	// open feint 
        291.0f*IPAD_X, 234.0f*IPAD_X+IPAD_THREE_Y,	// game center
    };
 #else
    float PicPos[10] = {
        294.0f*IPAD_X,  63.0f*IPAD_X+IPAD_THREE_Y,	// volume
        294.0f*IPAD_X, 105.0f*IPAD_X+IPAD_THREE_Y,	// music
        298.0f*IPAD_X, 152.0f*IPAD_X+IPAD_THREE_Y,	// reset data
        294.0f*IPAD_X, 195.0f*IPAD_X+IPAD_THREE_Y,	// open feint 
        295.0f*IPAD_X, 240.0f*IPAD_X+IPAD_THREE_Y,	// game center
    };
 #endif
    float WordPos[10] = {
        20.f,  63.0f+IPAD_ONE_Y,	// volume
        15.f, 109.0f+IPAD_ONE_Y,	// music
        0.0f, 154.0f+IPAD_ONE_Y,	// open feint
        -11.0, 199.0f+IPAD_ONE_Y,	// game center
        -11.0, 244.0f+IPAD_ONE_Y	// reset data
    };
    float mBtnRectOption[BTN_ELE_MAX_OPTIONS] = 
    {//	x0,		x1,		y0,		             y1
        140.0f*IPAD_X, 340.0f*IPAD_X, (50.0f+45.0f*0.0f)*IPAD_X+IPAD_TWO_Y, (50.0f+45.0f*0.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: se
        140.0f*IPAD_X, 340.0f*IPAD_X, (50.0f+45.0f*1.0f)*IPAD_X+IPAD_TWO_Y, (50.0f+45.0f*1.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: music
        140.0f*IPAD_X, 340.0f*IPAD_X, (50.0f+45.0f*2.0f)*IPAD_X+IPAD_TWO_Y, (50.0f+45.0f*2.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: openfeint
        140.0f*IPAD_X, 340.0f*IPAD_X, (50.0f+45.0f*3.0f)*IPAD_X+IPAD_TWO_Y, (50.0f+45.0f*3.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: gamecenter
        140.0f*IPAD_X, 340.0f*IPAD_X, (50.0f+45.0f*4.0f)*IPAD_X+IPAD_TWO_Y, (50.0f+45.0f*4.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: reset data
        340.0f*IPAD_X, 388.0f*IPAD_X, 10.0f*IPAD_X+IPAD_TWO_Y, 55.0f*IPAD_X+IPAD_TWO_Y			// UI Button: back
    };
#else
    bool BtnPress[BTN_NUM_MAX_OPTIONS] = {false, false, false, false, false};
    float PicPos[8] = {
        292.0f*IPAD_X,  85.0f*IPAD_X+IPAD_THREE_Y,	// volume
        288.0f*IPAD_X, 126.0f*IPAD_X+IPAD_THREE_Y,	// music
        289.0f*IPAD_X, 171.0f*IPAD_X+IPAD_THREE_Y,	// open feint
        291.0f*IPAD_X, 213.0f*IPAD_X+IPAD_THREE_Y,	// game center
    };
    float WordPos[8] = {
          20.f,  85.0f+IPAD_ONE_Y,	// volume
          15.f, 130.0f+IPAD_ONE_Y,	// music
          0.0f, 172.0f+IPAD_ONE_Y,	// open feint
        -11.0, 219.0f+IPAD_ONE_Y	// game center
    };
    float mBtnRectOption[BTN_ELE_MAX_OPTIONS] = 
    {//	x0,		x1,		y0,		             y1
        140.0f*IPAD_X, 340.0f*IPAD_X, (73.0f+45.0f*0.0f)*IPAD_X+IPAD_TWO_Y, (73.0f+45.0f*0.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: sound(fX > 154 && fX < 325  && fY > 76 && fY < 119)
        140.0f*IPAD_X, 340.0f*IPAD_X, (73.0f+45.0f*1.0f)*IPAD_X+IPAD_TWO_Y, (73.0f+45.0f*1.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: music if(fX > 151 && fX < 326  && fY > 119 && fY < 164)
        140.0f*IPAD_X, 340.0f*IPAD_X, (73.0f+45.0f*2.0f)*IPAD_X+IPAD_TWO_Y, (73.0f+45.0f*2.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: openfeintif(fX > 152 && fX < 329  && fY > 165 && fY < 208)
        140.0f*IPAD_X, 340.0f*IPAD_X, (73.0f+45.0f*3.0f)*IPAD_X+IPAD_TWO_Y, (73.0f+45.0f*3.0f+44.0f)*IPAD_X+IPAD_TWO_Y,	// UI Button: gamecenter 150 && fX < 325  && fY > 210 && fY < 252)
        340.0f*IPAD_X, 388.0f*IPAD_X, 32.0f*IPAD_X+IPAD_TWO_Y, 80.0f*IPAD_X+IPAD_TWO_Y			// UI Button if(fX > 315 && fX < 365  && fY > 43 && fY < 79)
    };
#endif

Image* optionBtnImg[OPTION_IMG_MAX];


int GetLevelMode()
{
	return TitleLevelIndex;
}

void GameOptionBegin()
{
}

void GameOptionEnd()
{
}

void GameOptionUpdate(float dt)
{
}

void GameOptionRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	// Panel
	canvas->enableColorPointer(true);
	RenderTileBG(TYPE_OPTION_BG, 
                 (canvas->getCanvasWidth() * IPAD_X - TILE_OPTION_COL * BG_OPTIOH_UINIT_WIDTH) * 0.5f, 
                 (canvas->getCanvasHeight() * IPAD_X + IPAD_Y - TILE_OPTION_ROW * BG_OPTIOH_UINIT_WIDTH) * 0.5f, 
                 1.0f, 1.0f);
	canvas->enableColorPointer(false);
	
	// Back Button
	if (BtnPress[BTN_IDX_BK_OPTIONS]) {
		canvas->drawImage(mClose, 362.f*IPAD_X, 32.f*IPAD_X+IPAD_TWO_Y, 0.0f, 1.5f, 1.5f);
	} else {
		canvas->drawImage(mClose, 362.f*IPAD_X, 32.f*IPAD_X+IPAD_TWO_Y, 0.0f, 1.2f, 1.2f);
	}
	
	// Buttons
	for (int i = 0; i < BTN_ELE_BK_OPTIONS; i += 4)
	{
		if (BtnPress[i/4]) {
			canvas->drawImage(optionBtnImg[OPTION_BTN_BG], 
                              canvas->getCanvasWidth()*IPAD_X * 0.5f, 
                              76.0f*IPAD_X+IPAD_TWO_Y + i/4*optionBtnImg[OPTION_BTN_BG]->getHeight() * (2.0f / GLOBAL_CANVAS_SCALE), 
                              0.0f, 1.1f, 1.0f);
		} else {
			canvas->drawImage(optionBtnImg[OPTION_BTN_BG], 
                              canvas->getCanvasWidth()*IPAD_X * 0.5f, 
                              76.0f*IPAD_X+IPAD_TWO_Y + i/4*optionBtnImg[OPTION_BTN_BG]->getHeight() * (2.0f / GLOBAL_CANVAS_SCALE), 
                              0.0f, BAR_SCALEX, BAR_SCALEY);
		}
	}
	
	int btnOffset = 0;
	for (int i = 0; i < BTN_ELE_BK_OPTIONS; i += 4)
	{
//		btnOffset = (((i>>2==0)&&(m_bSounds))?0:1);
		if (i == BTN_ELE_SE_OPTIONS)
		{
#ifdef V_1_1_0
            btnOffset = m_bSounds?0:5;
#else
			btnOffset = m_bSounds?0:4;
#endif
		}
		else if (i == BTN_ELE_BGM_OPTIONS)
		{
#ifdef V_1_1_0
            btnOffset = m_bBgm?0:5;
#else
			btnOffset = m_bBgm?0:4;
#endif
		}
		else
		{
			btnOffset = 0;
		}
		
		if (BtnPress[i/4]) {
			DrawString(Name[LEVEL_NUM_MAX+2+i/4], 
                       (canvas->getCanvasWidth()*IPAD_X-optionBtnImg[OPTION_BTN_BG]->getWidth() * (2.0f / GLOBAL_CANVAS_SCALE))/2, 
                       WordPos[(i/2)+1], 
                       WORD_SCALE,1,1,0,1,0);
			canvas->drawImage(optionBtnImg[i/4+btnOffset+2],PicPos[i/2],PicPos[(i/2)+1]);
		} else {
			DrawString(Name[LEVEL_NUM_MAX+2+i/4], 
                       (canvas->getCanvasWidth()*IPAD_X-optionBtnImg[OPTION_BTN_BG]->getWidth() * (2.0f / GLOBAL_CANVAS_SCALE))/2, 
                       WordPos[(i/2)+1], 
                       0.5,1,1,1,1,0);
			canvas->drawImage(optionBtnImg[i/4+btnOffset+2],PicPos[i/2],PicPos[(i/2)+1]);
		}
	}
	
#if 0
	canvas->flush();
	for (int i = 0; i < BTN_ELE_MAX_OPTIONS; i += 4)
	{
		canvas->strokeRect(mBtnRectOption[i], mBtnRectOption[i+2], 
						   mBtnRectOption[i+1] - mBtnRectOption[i], 
						   mBtnRectOption[i+3] - mBtnRectOption[i+2]);
	}
#endif
}

void GameOptionOnTouchEvent(int touchStatus, float fX, float fY)
{
	if (touchStatus == 1)
	{
		BtnOptionStartPos[0] = fX;
		BtnOptionStartPos[1] = fY;
		
		for (int i = 0; i < BTN_ELE_MAX_OPTIONS; i += 4)
		{
			if (fX > mBtnRectOption[i] && fX < mBtnRectOption[i+1] && 
				fY > mBtnRectOption[i+2] && fY <mBtnRectOption[i+3])
			{
				BtnPress[i/4] = true;
			}
		}
	}
	else if (touchStatus == 2)
	{
		for (int i = 0; i < BTN_ELE_MAX_OPTIONS; i += 4)
		{
			BtnPress[i/4] = false;
		}
		for (int i = 0; i < BTN_ELE_MAX_OPTIONS; i += 4)
		{
			if (fX > mBtnRectOption[i]   && fX < mBtnRectOption[i+1] && 
				fY > mBtnRectOption[i+2] && fY < mBtnRectOption[i+3] && 
				(BtnOptionStartPos[0] > mBtnRectOption[i]   && BtnOptionStartPos[0] < mBtnRectOption[i+1] && 
				 BtnOptionStartPos[1] > mBtnRectOption[i+2] && BtnOptionStartPos[1] < mBtnRectOption[i+3]))
			{
				BtnPress[i/4] = true;
                break;  ///
			}
//            else
//            {
//                BtnPress[i/4] = false;
//            }
		}
	}
	else if (touchStatus == 3)
	{
		for (int i = 0; i < BTN_ELE_MAX_OPTIONS; i += 4)
		{
			if (fX > mBtnRectOption[i]   && fX < mBtnRectOption[i+1] && 
				fY > mBtnRectOption[i+2] && fY < mBtnRectOption[i+3] && 
				(BtnOptionStartPos[0] > mBtnRectOption[i]   && BtnOptionStartPos[0] < mBtnRectOption[i+1] && 
				 BtnOptionStartPos[1] > mBtnRectOption[i+2] && BtnOptionStartPos[1] < mBtnRectOption[i+3]))
			{
				BtnPress[i/4] = false;
				BtnOptionStartPos[0] = -1;
				BtnOptionStartPos[1] = -1;
				switch(i)
				{
					case BTN_ELE_SE_OPTIONS:
						ClickVolume();
						break;
					case BTN_ELE_BGM_OPTIONS:
						ClickBGM();
						break;
					case BTN_ELE_OF_OPTIONS:
						//playSE(SE_BUTTON_CONFIRM);
						if (app.hasAccount || [CheckNetwork isExistenceNetwork])
						LaunchOpenFeint();
						break;
					case BTN_ELE_GC_OPTIONS:
						app.showCheckGC = true;
						if ([app checkLoginGameCenter] == YES && [CheckNetwork isNetworkAvailable])
						{
							app.showCheckGC = false;
							playSE(SE_BUTTON_CONFIRM);
							g_nGameState = GAME_STATE_GCOP;
							SwitchGameState();
						}
						else
						{
							playSE(SE_BUTTON_CANCEL);
						}
						break;
#ifdef V_1_1_0
                    case BTN_ELE_RD_OPTIONS:
                    {
                        isClearData=true;
                        UIAlertView* alert= [[[UIAlertView alloc] initWithTitle: @"Do you want to RESET your profile?" 
                                                                        message: @"Doing so will erase all your progress." 
                                                                       delegate: [UIApplication sharedApplication].delegate 
                                                                       cancelButtonTitle: @"OK" 
                                                                       otherButtonTitles: @"NO", nil] autorelease];
                        [alert show];                  
                    }
                        break;
#endif
					case BTN_ELE_BK_OPTIONS:
						playSE(SE_BUTTON_CANCEL);
						g_nGameState = GAME_STATE_TITLE;
						SwitchGameState();
						break;
				}
			}
			else if (fX > mBtnRectOption[i]   && fX < mBtnRectOption[i+1] && 
					 fY > mBtnRectOption[i+2] && fY < mBtnRectOption[i+3] && 
					 !(BtnOptionStartPos[0] > mBtnRectOption[i]   && BtnOptionStartPos[0] < mBtnRectOption[i+1] && 
                       BtnOptionStartPos[1] > mBtnRectOption[i+2] && BtnOptionStartPos[1] < mBtnRectOption[i+3]))
			{
				BtnPress[i/4] = false;
			}
		}
        BtnOptionStartPos[0] = -1;
        BtnOptionStartPos[1] = -1;
	}
}

void ClickBGM()
{
//	if (m_bSounds && !(m_bBgm ^ m_b4iPod))
#ifndef SND_BTN_AS_SE_BTN
	if (m_bSounds)
#endif
	{
		m_bBgm = !m_bBgm;
		m_b4iPod = m_bBgm;
		if (m_bBgm)
		{
			playBGM(currentBgmId, true);
		}
		else
		{
			stopBGM();
		}
	}
	
	SaveFile();
}

void ClickVolume()
{
	m_bSounds = !m_bSounds;
#ifndef SND_BTN_AS_SE_BTN
	if (m_bSounds)
	{
		playSE(SE_BUTTON_CONFIRM);
		
//		if (m_bBgm ^ m_b4sSnd)
//		{
			m_bBgm = m_b4sSnd;
//		}
//		else if (m_bBgm)
//		{
//			m_bBgm = false;
//		}
		if (m_bBgm)
		{
			playBGM(currentBgmId, true);
		}
	}
	else
	{
		m_b4sSnd = m_bBgm;
		if (m_bBgm)
		{
			m_bBgm = false;
		}
//		m_b4iPod = m_bBgm;
		stopBGM();
	}
#else
	playSE(SE_BUTTON_CONFIRM);
#endif
	SaveFile();
}

void ClickCredit()
{
	g_nGameState = GAME_STATE_CREDIT;
	SwitchGameState();
}

void ClickAppStore()
{
	//g_nGameState = GAME_STATE_ACHIEVE;
	SwitchGameState();
}

void ClickDifficulty()
{
	TitleLevelIndex ++;
	if (TitleLevelIndex > 2)
		TitleLevelIndex -= 3;
}
