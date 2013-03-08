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
#import "GameOver.h"
#import "Canvas2D.h"
#import "Image.h"

#import "neoRes.h"
#import "Utilities.h"
#import "GamePlay.h"

#ifdef V_1_1_0
#import "GameTips.h"
#endif

//Image* mOver;
//
//Image* mOver2;
//Image* mYesbg;
//Image* mNo;
//Image* mYes;
//Image* mNoWord;
//Image* mYesWord;
//Image* mTryAgain;
bool BtnOverCaughtPress[2]={false,false};
float BtnOverCaughtRange[8]=
{ 
   42,136,238+GAMEOVER_C_Y,291+GAMEOVER_C_Y,  //if ((fX > 49 && fX < 144) && ( fY > 250 && fY < 286))yes
  143,249,237+GAMEOVER_C_Y,291+GAMEOVER_C_Y//if ((fX > 147 && fX < 249) && ( fY > 245 && fY < 289))no
};

//int mOverType = 0;//1,2; 0 skip game over state.
float BtnOverCaughtStartPos[2] = {0.0f, 0.0f};

void GameOverCaughtBegin()
{
	playSE(SE_GAME_OVER_1 + mOverType - 1);
}

void GameOverCaughtRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
    
	canvas->drawImage(mOver2, 0.0f, 0.0f);
    
	RenderTileBG(TYPE_FAIL_CAUGHT_BG,20.f,161.0f+GAMEOVER_C_Y,1,1);
    
    canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
    DrawString((char*)"Try Again?", 62.0f,185.0f+GAMEOVER_C_Y ,0.75,1,1,1,1,0);
	
	if (BtnOverCaughtPress[0])
	{
        canvas->drawImage(mYesbg, 92.0,265.0+GAMEOVER_C_Y,0, 0.9f,0.9f);
        DrawString((char*)"YES", 70.0, 254.0+GAMEOVER_C_Y ,0.45,1,1,0,1,0);
	}
	else
    {
		canvas->drawImage(mYesbg, 92.0,265.0+GAMEOVER_C_Y,0, 1.0f,1.0f);
		DrawString((char*)"YES", 70.0, 254.0+GAMEOVER_C_Y ,0.45,1,1,1,1,0);
	}
    if (BtnOverCaughtPress[1])
    {
        canvas->drawImage(mYesbg, 193.0,265.0+GAMEOVER_C_Y,0, 0.9f,0.9f);
        DrawString((char*)"NO", 170.0, 254.0+GAMEOVER_C_Y,0.45,1,1,0,1,0);
    }
	else
    {
		canvas->drawImage(mYesbg,193.0,265.0+GAMEOVER_C_Y,0, 1.0f,1.0f);
		DrawString((char*)"NO", 170.0, 254.0+GAMEOVER_C_Y,0.45,1,1,1,1,0);
	}
    
	canvas->drawImage(mYes, 99.0,253.0+GAMEOVER_C_Y,0, 0.9f,0.9f);
	canvas->drawImage(mNo, 198.0,253.0+GAMEOVER_C_Y,0, 0.9f,0.9f);
}

void GameOverCaughtTouchEvent(int touchStatus, float fX, float fY)
{
	if (stages == NULL)
	{
		return;
	}
	if(touchStatus==1)
	{
		BtnOverCaughtStartPos[0]=fX;
		BtnOverCaughtStartPos[1]=fY;
		for (int i=0; i<8; i+=4) {
			if ((fX >BtnOverCaughtRange[i]  && fX <BtnOverCaughtRange[i+1] ) && ( fY >BtnOverCaughtRange[i+2]  && fY < BtnOverCaughtRange[i+3]))
			{
				BtnOverCaughtPress[i/4]=true;
			}
		}
		
	}
	else if (touchStatus == 2)
	{
		for (int i=0; i<8; i+=4) {
			if ((fX >BtnOverCaughtRange[i]  && fX <BtnOverCaughtRange[i+1] ) && (  fY > BtnOverCaughtRange[i+2] &&fY< BtnOverCaughtRange[i+3] )
				&&(BtnOverCaughtStartPos[0] > BtnOverCaughtRange[i]  && BtnOverCaughtStartPos[0]  < BtnOverCaughtRange[i+1] ) && ( BtnOverCaughtStartPos[1]> BtnOverCaughtRange[i+2]  && BtnOverCaughtStartPos[1] < BtnOverCaughtRange[i+3]))
			{
				BtnOverCaughtPress[i/4]=true;
			}
			else {
				BtnOverCaughtPress[i/4]=false;
			}

		}
		
	}
	else if (touchStatus == 3)
	{    BtnOverCaughtPress[0]=false;
		 BtnOverCaughtPress[1]=false;
       	for (int i=0; i<8; i+=4)
		{
			if ((fX >BtnOverCaughtRange[i]  && fX <BtnOverCaughtRange[i+1] ) && ( fY  > BtnOverCaughtRange[i+2] && fY< BtnOverCaughtRange[i+3] )
			&&(BtnOverCaughtStartPos[0] > BtnOverCaughtRange[i]  && BtnOverCaughtStartPos[0]  < BtnOverCaughtRange[i+1] ) && ( BtnOverCaughtStartPos[1]> BtnOverCaughtRange[i+2]  && BtnOverCaughtStartPos[1] < BtnOverCaughtRange[i+3] ))
			{
				switch(i)
				{
				case 0:
					{
						playSE(SE_BUTTON_CONFIRM);
						
						g_nGameState = GAME_STATE_GAME_PLAY;//retry
						
						DisableShadow();//runner mode.
						stages->reset();
						SwitchGameState();
						setGlobalFadeInAndGoTo(GAME_STATE_GAME_PLAY);
					}
					break;
			    case 4:
					{
						playSE(SE_BUTTON_CONFIRM);
						
#ifdef V_1_1_0
                        freeResTip();
#endif
                        
                        if (LevelIndex<3) 
                        {
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
					}
					break;
				
				}
			}
		}

	}
}
