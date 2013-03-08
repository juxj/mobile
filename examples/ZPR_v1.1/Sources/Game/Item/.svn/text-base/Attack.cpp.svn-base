/*
 *  Attack.cpp
 *  ZPR
 *
 *  Created by Neo01 on 8/17/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "Attack.h"
#include "Sprite.h"
#include "Runner.h"

Attack::Attack(Sprite* spr, float _x, float _y)
{
	sprite = spr;
	x = _x;
	y = _y;
	active = true;
	sprite->setCurrentAction(0);
	sprite->restartAction();
}

Attack::~Attack()
{
	sprite = NULL;
}

void Attack::update(float dt)
{
//	x = GetPlayerX() - PLAYER_SHIFT_X - mScrollWorld - 24;
//	y = GetPlayerY() - PLAYER_SHIFT_Y + 28;
	sprite->update(dt);
	if (sprite->isLastMoveInAction())
	{
		active = false;
	}
}

void Attack::render(float dt)
{
	sprite->render(x-37 - mScrollWorld+cameraX, y-37 +cameraY);
}
