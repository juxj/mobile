/*
 *  ScoreTag.h
 *  ZPR
 *
 *  Created by Neo01 on 8/10/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __SCORE_TAG_H__
#define __SCORE_TAG_H__

#include "InfoTag.h"

#define INFOTAG_STR_LEN	16

#define INFOTAG_START	0
#define INFOTAG_FADEIN	1
#define INFOTAG_RUN		2
#define INFOTAG_FADEOUT	3
#define INFOTAG_END		4
#define INFOTAG_UP	    5
#define INFOTAG_DOWN	6
#define TIMECOUNT      2000

class ScoreTag : public InfoTag
{
public:
	ScoreTag(float x, float y, const char* str, float r = 1.0f, float g = 1.0f, float b = 0.0f);
	~ScoreTag();
	
	void update(float dt);
	void render(float dt);
	
public:
	char str[INFOTAG_STR_LEN];
	
	float alpha;
	float yv, ya;
	float r, g, b;
};

#endif //__SCORE_TAG_H__
