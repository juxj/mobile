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

Attack::Attack(Sprite* spr, float _x, float _y, int _w, int _h)
{
	sprite = spr;
	x = _x;
	y = _y;
	w = _w/2;
	h = _h/2;
	
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
	sprite->render(x-w - mScrollWorld+cameraX, y-h +cameraY + SCENE_OFFSET, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
}
