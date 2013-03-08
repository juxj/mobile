/*
 *  Effect.h
 *  ZPR
 *
 *  Created by Neo01 on 8/17/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __EFFECT_H__
#define __EFFECT_H__

#include "InfoTag.h"

class Sprite;

class Effect : public InfoTag
{
public:
	Effect(Sprite* spr, float x, float y);
	~Effect();
	
	void update(float dt);
	void render(float dt);
	
public:
	Sprite* sprite;
};

#endif //__EFFECT_H__
