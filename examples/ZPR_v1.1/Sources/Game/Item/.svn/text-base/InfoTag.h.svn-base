/*
 *  InfoTag.h
 *  ZPR
 *
 *  Created by Neo01 on 8/10/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __INFO_TAG_H__
#define __INFO_TAG_H__

class InfoTag
{
public:
	InfoTag() {}
	virtual ~InfoTag() {}
	virtual void update(float dt) {}
	virtual void render(float dt) {}
	
	int getState() {return state;}
	int getCount() {return cnt;}
	
public:
	bool active;
	int state;
	float x;
	float y;
	float vx;
	float vy;
	float ax;
	float ay;
	float t;
	int cnt;
};

#endif //__INFO_TAG_H__
