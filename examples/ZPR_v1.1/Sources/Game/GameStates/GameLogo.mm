/*
 *  GameLogo.cpp
 *  MonsterWar
 *
 *  Created by Neo Lin on 5/31/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "GameLogo.h"
#import "GameState.h"
#import "neoRes.h"
#import "Canvas2D.h"

#import "Image.h"

Image* mSplash;

void GameLogoUpdate(float dt)
{
}

void GameLogoRender(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	canvas->setColor(0.0f, 0.0f, 0.0f, 1.0f);
	canvas->fillRect(0, 0, 480, 320);
	
	canvas->enableColorPointer(TRUE);
	
	
	static float alpha = 1.0f;
	static int delta = -1;
	
	if (delta == -1 && alpha > 0.0f){
		alpha -= 0.02f;
		if (alpha <= 0.0f)
		{
			delta = 1;
			g_nGameState = GAME_STATE_TITLE;
		}
	}
	
	mSplash->SetColor(1.0f, 1.0f, 1.0f, alpha);
	canvas->drawImage(mSplash, 0.0f, 320.0f, (3.1415926f/2.0f), 1.0f, 1.0f);
	
	canvas->enableColorPointer(FALSE);
	
	//	canvas->setColor(1.0f, 1.0f, 1.0f, alpha);
	//	canvas->fillRect(0.0f, 0.0f, 480.0f, 320.0f);
}

void GameLogoOnTouchEvent(int touchStatus, float fX, float fY)
{
	if (touchStatus == 3)
	{
		g_nGameState = GAME_STATE_TITLE;
	}
}
