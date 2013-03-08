/*
 *  ScoreTag.cpp
 *  ZPR
 *
 *  Created by Neo01 on 8/10/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "ScoreTag.h"

#include "Utilities.h"

ScoreTag::ScoreTag(float _x, float _y, const char* _str)
{
	cnt = 0;
	memset(str, '\0', sizeof(_str));
	strcpy(str, _str);
	
	x = _x;
	y = _y;
}

ScoreTag::~ScoreTag()
{
}

void ScoreTag::update(float dt)
{
	if (cnt > 3)
	{
		x -= 2;
	}
	if (cnt <= 30)
	{
		cnt++;
	}
}

void ScoreTag::render(float dt)
{
	DrawString(str, x, y, 0.5, 0.6f);
}
