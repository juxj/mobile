/*
 *  Attack.h
 *  ZPR
 *
 *  Created by Neo01 on 8/17/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __ATTACK_H__
#define __ATTACK_H__

#include "InfoTag.h"

class Sprite;

class Attack : public InfoTag
{
public:
	Attack(Sprite* spr, float x, float y, int _w, int _h);
	~Attack();
	
	void update(float dt);
	void render(float dt);
	
public:
	Sprite* sprite;
	
private:
	int w;
	int h;
};

#endif //__ATTACK_H__
