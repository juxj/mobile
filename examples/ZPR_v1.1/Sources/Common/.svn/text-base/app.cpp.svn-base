/*
 *  app.cpp
 *  NeoApp
 *
 *  Created by Neo01 on 2010-08-08.
 *  Copyright 2010 Neo01. All rights reserved.
 *
 */

#include "app.h"
#include "neoApp.h"

#include "GameState.h"

//int GAME_FPS = 30;//60;

void appInit()
{
	bSuspend = false;
	bResume = false;
	
	neolib::App::Config conf;
	conf.maxFPS = GAME_FPS;
	conf.width = PORTRAIT_SCREEN_WIDTH;
	conf.height = PORTRAIT_SCREEN_HEIGHT;
	conf.orientation = neolib::App::ORIENTATION_LEFT;
	neolib::App::create(conf);
	initGameData();
}

void appQuit()
{
	neolib::App::destroy();
	
	freeGameData();
}

void appSuspend()
{
//	neolib::App::suspend();
}

void appResume()
{
//	neolib::App::resume();
}
