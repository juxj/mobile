/*
 *  ObjLayer.h
 *  Zombie Dash
 *
 *  Created by Neo01 on 6/29/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __OBJ_LAYER_H__
#define __OBJ_LAYER_H__

#include <list>

#define LAYER_OBJ_IMG	0
#define LAYER_OBJ_SPR	1
#define LAYER_OBJ_HINT	2

class ObjRect;

class ObjLayer {
private:
	int width;
	int height;
	
	float baseX;
	float baseY;
	float baseOffsetX;
	
	int type;

public:
	int index;	//std::String name;
	std::list<ObjRect*> data;
	
	bool bClrUserData;
	
public:
	ObjLayer(int index, int width, int height, int _type);
	~ObjLayer();
	
	void addObj(int objId, float x, float y, float width, float height, int imageId, void* userData = NULL, int userDataType = -1);
	void appendObj(std::list<ObjRect*> data, float offsetX);
	void reset();
	
	int  getWidth() {return width;}
	int  getHeight() {return height;}
	
	void update(float dt, float posX, float posY, bool refresh);	// the position in the block
	void render(float dt, float offsetX = 0.0f, float offsetY = 0.0f);
};

#endif //__OBJ_LAYER_H__
