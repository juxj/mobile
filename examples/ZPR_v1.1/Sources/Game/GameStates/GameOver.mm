//
//  GameOver.m
//  ZPR
//
//  Created by Xiao Qing Yan on 11-8-23.
//  Copyright 2011 Break Media. All rights reserved.
//
//

#import "GameOver.h"
#import "GameAudio.h"
#import "GameState.h"
#import "GameRes.h"
#import "Stage.h"
#import "Runner.h"
#import "GamePlay.h"

#import "Canvas2D.h"
#import "Image.h"
#import "neoRes.h"
#import "Utilities.h"

#ifdef V_1_1_0
#import "GameTips.h"
#endif

#define YESBG_X    320.0
#define NOBG_X     413.0
#define YESWORD_X  290.0 
#define NOWORD_X   385.0
#define YESPIC_X   325.0
#define NOPIC_X    415.0
#define BG_Y       54.0
#define WORD_Y     45.0
#define PIC_Y      43.0
Image* mOver;
Image* mOver2;

Image* mYesbg;
Image* mNo;
Image* mYes;

bool BtnOverPress[2] = {false, false};
float BtnOverRange[8] = 
{ 
	 258.0f*IPAD_X, 364.0f*IPAD_X, 28.0f, 86.0f,	// yes
	364.0f*IPAD_X, 463.0f*IPAD_X, 28.0f, 86.0f	// no
};

int mOverType = 0;	//1,2; 0 skip game over state.
float BtnOverStartPos[2] = {0.0f, 0.0f};

void GameOverBegin()
{
	playSE(SE_GAME_OVER_1 + mOverType - 1);
}

void GameOverRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
    canvas->drawImage(mOver, 0.0f, 0.0f);
    
    RenderTileBG(TYPE_FAIL_BG, 96.f*IPAD_X+GAMEOVER_BG_X, 10.0f, 0.99,1);//20,150
    
    DrawString((char*)"Try Again?", 114.0f*IPAD_X+GAMEOVER_STR_X,39.0f ,0.75f,1,1,1,1,0);
    
    if(BtnOverPress[0])
    {
        canvas->drawImage(mYesbg, YESBG_X*IPAD_X,BG_Y,0, 0.9f,0.9f);
        DrawString((char*)"YES", YESWORD_X*IPAD_X, WORD_Y ,0.45,1,1,0,1,0);
        
    }
    else {
        canvas->drawImage(mYesbg, YESBG_X*IPAD_X,BG_Y,0, 1.0f,1.0f);
        DrawString((char*)"YES", YESWORD_X*IPAD_X, WORD_Y ,0.45,1,1,1,1,0);
    }
    if (BtnOverPress[1]) {
        canvas->drawImage(mYesbg, NOBG_X*IPAD_X,BG_Y,0, 0.9f,0.9f);
        DrawString((char*)"NO", NOWORD_X*IPAD_X, WORD_Y,0.45,1,1,0,1,0);
        
    }
    else {
        
        canvas->drawImage(mYesbg,NOBG_X*IPAD_X,BG_Y,0, 1.0f,1.0f);
        DrawString((char*)"NO", NOWORD_X*IPAD_X, WORD_Y,0.45,1,1,1,1,0);
    }
    
    canvas->drawImage(mYes, YESPIC_X*IPAD_X,PIC_Y,0, 0.9f,0.9f);
    canvas->drawImage(mNo, NOPIC_X*IPAD_X,PIC_Y,0, 0.9f,0.9f);
}

void GameOverTouchEvent(int touchStatus, float fX, float fY)
{
	if (stages == NULL)
	{
		return;
	}
	if (touchStatus == 1)
	{
		BtnOverStartPos[0]=fX;
		BtnOverStartPos[1]=fY;
		for (int i=0; i<8; i+=4) {
			if ((fX >BtnOverRange[i]  && fX <BtnOverRange[i+1] ) && ( fY >BtnOverRange[i+2]  && fY < BtnOverRange[i+3]))
			{
				BtnOverPress[i/4]=true;
			}
		}
		
	}
	else if (touchStatus == 2)
	{
		for (int i=0; i<8; i+=4) {
			if ((fX >BtnOverRange[i]  && fX <BtnOverRange[i+1] ) && (  fY > BtnOverRange[i+2] &&fY< BtnOverRange[i+3] )
				&&(BtnOverStartPos[0] > BtnOverRange[i]  && BtnOverStartPos[0]  < BtnOverRange[i+1] ) && ( BtnOverStartPos[1]> BtnOverRange[i+2]  && BtnOverStartPos[1] < BtnOverRange[i+3]))
			{
				BtnOverPress[i/4]=true;
			}
			else {
				BtnOverPress[i/4]=false;
			}

		}
		
	}
	else if (touchStatus == 3)
	{
		BtnOverPress[0] = false;
		BtnOverPress[1] = false;
       	for (int i=0; i<8; i+=4)
		{
			if ((fX >BtnOverRange[i]  && fX <BtnOverRange[i+1] ) && ( fY  > BtnOverRange[i+2] && fY< BtnOverRange[i+3] )
			&&(BtnOverStartPos[0] > BtnOverRange[i]  && BtnOverStartPos[0]  < BtnOverRange[i+1] ) && ( BtnOverStartPos[1]> BtnOverRange[i+2]  && BtnOverStartPos[1] < BtnOverRange[i+3] ))
			{
				switch(i)
				{
				case 0:
					{
						playSE(SE_BUTTON_CONFIRM);
						
						g_nGameState = GAME_STATE_GAME_PLAY;//retry
						
						DisableShadow();//runner mode.
						if (stages)
						{
							stages->reset();
						}
						SwitchGameState();
						setGlobalFadeInAndGoTo(GAME_STATE_GAME_PLAY);
						
//#ifdef ENABLE_ACHIEVEMENTS
//						ResetTempAchievements();
//#endif
					}
					break;
			    case 4:
					{
						playSE(SE_BUTTON_CONFIRM);
                        
#ifdef V_1_1_0
                        freeResTip();
#endif
                        
						if (LevelIndex<3) {
                            g_nGameState = GAME_STATE_LEVEL_SELECT;//back to menu

                        }
                        else g_nGameState = GAME_STATE_LEVELTWL_SELECT;//back to menu
                        
						SwitchGameState();
						DisableShadow();//runner mode.
						
						//release stages
						if (stages)
						{
							stages->clearBG();
							stages->clearLevelData();
							delete stages;
							stages = NULL;
						}
						RelGcRes();
						InitMenuRes();
#ifdef ENABLE_ACHIEVEMENTS
						ResetTempAchievements();
#endif
					}
					break;
				
				}
			}
		}

	}
}
