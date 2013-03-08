/*
 *  ActionTag.h
 *  ZPR
 *
 *  Created by Neo01 on 8/24/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __ACTION_TAG_H__
#define __ACTION_TAG_H__

#include "InfoTag.h"

#define ACTION_TAG_STR_LEN	32

#define INFOTAG_START	0
#define INFOTAG_FADEIN	1
#define INFOTAG_RUN		2
#define INFOTAG_FADEOUT	3
#define INFOTAG_END		4
#define INFOTAG_UP	    5
#define INFOTAG_DOWN	6
#define TIMECOUNT      2000


class ActionTag : public InfoTag
{
public:
	ActionTag(float x, float y, const char* _str, float r, float g, float b);
	~ActionTag();
	
	void update(float dt);
	void render(float dt);
	
public:
	char str[ACTION_TAG_STR_LEN];
	
	float alpha;
	float yv, ya;
	
	float r, g, b;
	
	float sx, sy;
	float dw;
};

#endif //__ACTION_TAG_H__
