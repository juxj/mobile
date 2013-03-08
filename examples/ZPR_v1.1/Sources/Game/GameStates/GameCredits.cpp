/*
 *  GameCredits.cpp
 *  ZPR
 *
 *  Created by Linda Li on 6/23/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "GameCredits.h"

#import "GameState.h"
#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"
#import "GameRes.h"
#import "GamePlay.h"
#import "GameAudio.h"
#import "Utilities.h"

Image* mCredits;
float g_fCredit = 0.0f;
float startCredits[2]={0.0,0.0};
bool isMoveScreen=true;
float dis=0.0f;
bool isBtnPress=false;


#define GAME_VERSION	"v1.1.1"

NAMEOBJECT g_NameObj[MAX_NAME_OBJECT]
={
    {(char*)"",false},
    {(char*)"ZOMBIE PARKOUR RUNNER",true},
	{(char*)GAME_VERSION,false},
	{(char*)"",false},
	{(char*)"Creative Director",true},
	{(char*)"Chris Pasley",false},   
	{(char*)"Technical Director"   ,true},
	{(char*)"Jerome Chen",false},
	{(char*)"General Manager, Greater China",true},
	{(char*)"Alex Lien",false},
	{(char*)"Mobile Direction",true},
	{(char*)"Jerome Chen",false},
	{(char*)"Producer",true},
	{(char*)"Mills Tsao",false},
	{(char*)"HuiMing Lv",false},
	{(char*)"Game Designer & Original Concept",true},
	{(char*)"Christopher Kao",false},
	{(char*)"Additional Design",true},
	{(char*)"QiMing Xu",false},
	{(char*)"Lead Programmer",true},
	{(char*)"FuTao Huang",false},
	{(char*)"Programmers",true},
	{(char*)"Yin Lin",false},
	{(char*)"XiaoQing Yan",false},
	{(char*)"Lei Xiao",false},
	{(char*)"Kaimo Guo",false},
	{(char*)"Ling Li",false},
	{(char*)"Lead Artist",true},
	{(char*)"Cheng Wang",false},
	{(char*)"UI Artist",true},
	{(char*)"Ravuth Vann",false},
	{(char*)"Artists",true},
	{(char*)"XiaoLu Chen",false},
	{(char*)"Qi Zhang",false},
	{(char*)"JingJing Guan",false},
	{(char*)"Jie Yin",false},
	{(char*)"Lin Fang",false},
	{(char*)"JiaYu Zhao",false},
	{(char*)"Animators",true},
	{(char*)"TianLong Wang",false},
	{(char*)"YaoLiang Zhong",false},
	{(char*)"Music",true},
	{(char*)"Jesse Holt",false},
	{(char*)"Sound Effects",true},
	{(char*)"Barry Dowcett",false},
	{(char*)"Lead Mobile QA",true},
	{(char*)"Raven Zeng",false},
	{(char*)"QA",true},
	{(char*)"XuFeng Li",false},
	{(char*)"GuoLei Zhao",false},
	{(char*)"JiaYin Xie",false},
	{(char*)"Special Thanks",true},
	{(char*)"Keith Richman",false},
	{(char*)"Andrew Doyle",false},
	{(char*)"Jonathan Soon",false},
	{(char*)"Matt Arsulich",false},
};

void GameCreditsBegin()
{
	g_fCredit=0.0f;
	dis=0.0f;

}

void GameCreditsEnd();

void GameCreditsUpdate(float dt)
{
    if(!isMoveScreen) return;
    
    if (dis<=0.0f)
    {
        g_fCredit -= 1.0f;
        
    }
    else 
    {
        g_fCredit += 1.0f;
    
    }
    
    float y =(MAX_NAME_OBJECT*30 -320*IPAD_24);
    if (g_fCredit <= -y -25) 
    {
        g_fCredit = -y -25; 
    }
    else if (g_fCredit > 0) 
    {
        g_fCredit = 0;
    }
}

void GameCreditsRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	drawSky();

	for (int i=0; i<MAX_NAME_OBJECT; i++)
	{
		float scale= g_NameObj[i].isLeder?0.6f:0.4f;
		int fonttype= g_NameObj[i].isLeder?1.0f:0;
		DrawString(g_NameObj[i].name,40,25+30*i+g_fCredit,scale,1,1,1,1,fonttype);	
	}
	
	float colorbg=isBtnPress?BACK_COLOR:0;
	canvas->setColor(colorbg, colorbg, colorbg, 1);
	canvas->fillRect(387*IPAD_X, 0.0f, 160*IPAD_X, 28*IPAD_X);
	int color=isBtnPress?0:1;
	DrawString((char*)"MAIN MENU",398.f*IPAD_X,4.0f*IPAD_X,0.35,1,1,color,1,0);
	canvas->setColor(1, 1, 1, 1);
}

void GameCreditsOnTouchEvent(int touchStatus, float fX, float fY)
{ 
	if (touchStatus==1) {
		if (fX > 373*IPAD_X && fX < 480*IPAD_X && fY > 0 && fY <40*IPAD_X) 
		{
			isBtnPress=true;
		}
		
		if(isMoveScreen)
			isMoveScreen=false;
		startCredits[1]=fY;
	}
	if (touchStatus == 2)
	{  if(isMoveScreen)
		isMoveScreen=false;
		dis=fY-startCredits[1];
        
		if (dis<=0) g_fCredit-=4.0f;
		else g_fCredit+=4.0f;
        
		if (fX > 373*IPAD_X && fX < 480*IPAD_X && fY > 0 && fY <40*IPAD_X)
		{ 
			isBtnPress=true;
		}
		else {
			isBtnPress=false;
		}

	}
	if (touchStatus==3) {
		isBtnPress=false;
		isMoveScreen=true;
		if (fX > 373*IPAD_X && fX < 480*IPAD_X && fY > 0 && fY <40*IPAD_X)
		{ 
			playSE(SE_BUTTON_CANCEL);	//objAudioPlay(EVENT_TYPE_UI_CLICK, SOUND_TYPE_INDEX_UI_CLICK, m_bSounds);
			
//			RelCreditRes();
			
			g_nGameState = GAME_STATE_TITLE;
			SwitchGameState();
			return;
		}
	}
	
}
