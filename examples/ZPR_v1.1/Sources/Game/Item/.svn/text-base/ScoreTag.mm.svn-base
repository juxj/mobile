/*
 *  ScoreTag.cpp
 *  ZPR
 *
 *  Created by Neo01 on 8/10/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "ScoreTag.h"
#include "Canvas2D.h"
#include "Utilities.h"
//static float alpha=1;
//int counttime=0;
//int scorestate=INFOTAG_UP;
//float yv=3,ya=-0.3;

ScoreTag::ScoreTag(float _x, float _y, const char* _str, float _r, float _g, float _b)
{
	cnt = 0;
	memset(str, '\0', sizeof(_str));
	strcpy(str, _str);
	x = _x;
	y = _y;   
	alpha = 1.0f;
	yv = 4.0f;
	ya = -0.3f;
	active = true;
	r = _r;
	g = _g;
	b = _b;
}

ScoreTag::~ScoreTag()
{
}

void ScoreTag::update(float dt)
{   
	y -= yv;
	yv += ya;
	x -= 3.0f;
	alpha -= 0.05;//alpha-=0.01;
//	printf("yv＝%f\n",yv);
	
	if (alpha <= 0.0f)
	{
		alpha = 0.0f;
	}
	if (cnt > 5)
	{
		x -= 2;
	}
	if (cnt <= 15)
	{
		cnt++;
	}
	else
	{
		active = false;
	}
}

void ScoreTag::render(float dt)
{
	DrawString(str, x, y, 1.0f, r, g, b, alpha, FONT_TYPE_SLACKEY, false);
}
