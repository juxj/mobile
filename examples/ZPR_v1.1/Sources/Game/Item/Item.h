/*
 *  Item.h
 *  Zombie Dash
 *
 *  Created by Neo01 on 7/8/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __ITEM_H__
#define __ITEM_H__

#include "Image.h"
#include "Sprite.h"

#define ITEM_STATE_IDLE			0
#define ITEM_STATE_MOVE			1
#define ITEM_STATE_MOVE_DONE	2

class Item
{
public:
	Item();
	Item(int itemType, float x, float y, int hintId = -1, float hOffsetx = 0.0f, float hOffsety = 0.0f);
	Item(const char* filename, float x, float y, int type);
	~Item();
	
	void initialization();
	void destroy();
	void reset();
	
	void setHint(bool bShowHint, float offsetX, float offsetY);
	
	void update(float dt);
	void render(float dt, float offsetX, float offsetY);
//	void render(float x, float y, float angle = 0.0f, float xScale = 1.0f, float yScale = 1.0f);
	
	void moveTo(float stx, float sty, float dx, float dy);
	bool moveDone();
	
public://private:
	int index;
	int type;
	
	Sprite* sprite;
	
	bool    bHint;
	int     hintType;
	Image*  hintImage;
	
	float mX;
	float mY;
	
	float mOrgX;
	float mOrgY;
	
	static int classId;
	
	int   state;
	float startX;
	float startY;
	float destX;
	float destY;
	float vX;
	float vY;
	
public:
	// box
	float bx;
	float by;
	float bw;
	float bh;
	// drawing
	float ax;
	float ay;
	float angle;
	float sx;
	float sy;
};

#endif //__ITEM_H__
