/*
 *  Effect.cpp
 *  ZPR
 *
 *  Created by Neo01 on 8/17/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "Effect.h"
#include "Sprite.h"
#include "Runner.h"

Effect::Effect(Sprite* spr, float _x, float _y)
{
	sprite = spr;
	x = _x;
	y = _y;
	active = true;
	sprite->setCurrentAction(0);
	sprite->restartAction();
}

Effect::~Effect()
{
	sprite = NULL;
}

void Effect::update(float dt)
{
	x = GetPlayerX() - PLAYER_SHIFT_X - mScrollWorld - 24 + cameraX;
	y = GetPlayerY() - PLAYER_SHIFT_Y + 28 + cameraY;
	sprite->update(dt);
	if (sprite->isLastMoveInAction())
	{
		active = false;
	}
}

void Effect::render(float dt)
{
	sprite->render(x, y);
}
