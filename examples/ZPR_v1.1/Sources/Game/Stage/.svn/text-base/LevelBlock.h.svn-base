/*
 *  Block.h
 *  ZPR
 *
 *  Created by Neo01 on 6/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __LEVEL_BLOCK_H__
#define __LEVEL_BLOCK_H__

#include <vector>
#include <map>

#include "Runner.h"

//#define LAYER_BLOCK_SCENE	0
//#define LAYER_BLOCK_OBJECT	1
//#define LAYER_BLOCK_MAX		3

class ObjLayer;

class Block {
public://private:
	int width;
	int height;
	int tileWidth;
	int tileHeight;
	int length;		// tileWidth * width
	int nLayer;
	
	float mBaseX;
	float mBaseY;
	float mStartX;
	float mStartY;
	
	int star1;
	int star2;
	int star3;
	
	bool bRain;
	bool bChase;
    
#ifdef SET_CHKPT
    int idxChkpt;
#endif
	
	// Check Points
	int   nCheckPoint;
	float mCheckPoint[NUM_CHECK_POINT_MAX];
	
public:
	std::vector<ObjLayer*> layers;
	std::map<int, int> imageMap;
	
public:
	Block();
	~Block();
	
	bool loadData(const char *resName, const char *directory = 0, int rootDirectory = 0);
	int  getImage(int objId);
};

#endif //__LEVEL_BLOCK_H__
