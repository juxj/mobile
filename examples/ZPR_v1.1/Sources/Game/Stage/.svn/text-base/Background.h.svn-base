/*
 *  Background.h
 *  Zombie Dash
 *
 *  Created by Neo01 on 6/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __BACKGROUND_H__
#define __BACKGROUND_H__

#include <vector>
#include <map>

#define LAYER_BACKGROUND	0
#define LAYER_MIDGROUND		1
#define LAYER_FOREGROUND	2
#define LAYER_BG_MAX3		3

#define DEFAULT_LOOP_NUM		(2)
#ifdef VERSION_IPAD
	#define DEFAULT_SCREEN_WIDTH	(512.0f)
#else
	#define DEFAULT_SCREEN_WIDTH	(480.0f)	// make canvas properties be public
#endif

class ObjLayer;

struct BgParam {
	float posX;
	float posY;
	float length;
	int   renderCount;
	bool  flagLoadNext;
	bool  flagLoadNextDone;
};

class Background
{
public://private:
	int width;
	int height;
	int tileWidth;
	int tileHeight;
	
	int   mLoopNum;
	float length;
	
//private:
	float mBaseX;
	float mBaseY;
//	float mVelocityX;
	int   nLayer;
	
public:
	std::vector<ObjLayer*> layers;
	std::map<int, int> imageMap;
	
	std::vector<BgParam> params;
	
public:
	Background();
	~Background();
	
	bool loadData(const char *resName, const char *directory = 0, int rootDirectory = 0);
	int  getImage(int objId);
};

#endif //__BACKGROUND_H__
