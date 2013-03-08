/*
 *  ObjRect.h
 *  ZPR
 *
 *  Created by Neo01 on 6/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __OBJ_RECT_H__
#define __OBJ_RECT_H__

class ObjRect {
public:
	bool  active;
	int   objId;
	int   imgId;
	float x;
	float y;
	float width;
	float height;
	
	float scaleX;
	float scaleY;
	
	int   count;
	float timer;
	float alpha;
	float duration;
	float interval;
	
	void* userData;
	int   userDataType;
	
public:
	ObjRect(int _objId, float _x, float _y, float _width = 0.0f, float _height = 0.0f, int imgId = 0, void* userData = 0, int _userDataType = -1);
//	ObjRect(ObjRect& objRect);
	~ObjRect();
	
	void setImageId(int imageId);
	
	void setUserData(void* data);
	void clrUserData();
	
	void setActive(bool flag);
	bool isActive();
	
	void setWidth(float width);
	void setHeight(float height);
	
	// hint
	void update(float dt);
	void render(float dt, float offsetX = 0.0f, float offsetY = 0.0f);
	void setDuration(float duration);
	void setInterval(float interval);
	
	void moveTo(float stx, float sty, float destX, float destY);
	bool moveDone();
};

#endif //__OBJ_RECT_H__
