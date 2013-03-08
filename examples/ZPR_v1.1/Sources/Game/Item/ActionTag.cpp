/*
 *  ActionTag.cpp
 *  ZPR
 *
 *  Created by Neo01 on 8/24/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "ActionTag.h"
#include "Canvas2D.h"
#include "Utilities.h"
#import "Runner.h"
#include <math.h>

ActionTag::ActionTag(float _x, float _y, const char* _str, float _r, float _g, float _b)
{
	cnt = 0;
	memset(str, '\0', sizeof(_str));
	strcpy(str, _str);
	x = _x;
	y = _y;
	alpha = 1.0f;
	yv = 3.0f + rand() % 30 / 10.0f;
	ya = -0.3f;
	active = true;
	r = _r;
	g = _g;
	b = _b;
	
	dw = 0.7f;
	sx = mScrollWorld;
	sy = 0;
}

ActionTag::~ActionTag()
{
}

void ActionTag::update(float dt)
{
#if 1
	y -= yv;
	if (yv > 2.0f)
	{
		yv += ya;
//		x -= 2.0f;
	}
	else
	{
		alpha -= 0.02f;//alpha-=0.01;
	}
	if (y < 0.0f)
	{
		y = 0.0f;
	}
//	printf("yv＝%f\n",yv);
	
	if (alpha <= 0.0f)
	{
		alpha = 0.0f;
	}
	if (cnt <= 150)
	{
		cnt++;
	}
	else
	{
		active = false;
	}
#endif
//	// pop up and be still for a while
////	if (yv < 0.0f && cnt < 60)
////	{
////		cnt++;
////		return;
////	}
//	
//	// Movement
//	if (yv > 0.0f)// no bounce
//	{
//		y -= yv;
//		yv += ya;
//	}
//	if (yv < 10.0f)// no bounce
//	{
//		x -= 2.0f;
//	}
//	
//	// limit the srting position in the screen
//	// no bounce
//	if (y < 0.0f)
//	{
//		y = 0.0f;
//	}
//	// bounce
////	if (y < -16.0f)
////	{
////		y = 0.0f;
////	}
////	
////	if (y > sy)
////	{
////		y = sy;
////		yv = sqrtf(yv * yv * dw);
////	}
//	
////	printf("yv＝%f\n",yv);
//	
//	if (cnt > 30)
//	{
//		alpha -= 0.02f;//alpha-=0.01;
//	}
//	
//	if (alpha <= 0.0f)
//	{
//		alpha = 0.0f;
//	}
////	if (cnt > 5)
////	{
////		x -= 2;
////	}
//	if (cnt <= 150)
//	{
//		cnt++;
//	}
//	else
//	{
//		active = false;
//	}
}

void ActionTag::render(float dt)
{
	float dx = (sx - mScrollWorld)/5;
	
	DrawString(str, x+dx, y, 0.7f, r, g, b, alpha, FONT_TYPE_SLACKEY_OL);
}
