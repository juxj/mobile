/*
 *  Flust.cpp
 *  ZPR
 *
 *  Created by Neo01 on 8/17/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "Flust.h"
#include "Sprite.h"
#include "Runner.h"

#import "Canvas2D.h"
#import "Image.h"

Flust::Flust(Sprite* spr, float _x, float _y)
{
	sprite = spr;
	x = _x;
	y = _y;
	active = true;
	sprite->setCurrentAction(0);
	sprite->restartAction();
}

Flust::~Flust()
{
	sprite = NULL;
}

void Flust::update(float dt)
{
	x = GetPlayerX() - PLAYER_SHIFT_X - mScrollWorld - 48 + cameraX;
	y = GetPlayerY() - PLAYER_SHIFT_Y + 22 + cameraY;
	sprite->update(dt);
	
	if (sprite->isLastMoveInAction())
	{
		active = false;
	}
}

void Flust::render(float dt)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	int index = sprite->getCurrentFrameIndex();
	
	float r = ColorShadow[mFastLevel][0];
	float g = ColorShadow[mFastLevel][1];
	float b = ColorShadow[mFastLevel][2];
	float a = 0.6f;
	
	canvas->enableColorPointer(true);
	sprite->mFrames[index].mImage->SetColor(r, g, b, a);
	sprite->render(x, y);
	sprite->mFrames[index].mImage->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
	canvas->enableColorPointer(false);
}
