/*
 *  Flust.h
 *  ZPR
 *
 *  Created by Neo01 on 8/17/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __FLUST_H__
#define __FLUST_H__

#include "InfoTag.h"

class Sprite;

class Flust : public InfoTag
{
public:
	Flust(Sprite* spr, float x, float y);
	~Flust();
	
	void update(float dt);
	void render(float dt);
	
public:
	Sprite* sprite;
};

#endif //__EFFECT_H__
