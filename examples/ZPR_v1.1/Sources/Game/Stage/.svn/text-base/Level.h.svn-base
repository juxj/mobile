/*
 *  Level.h
 *  Zombie Dash
 *
 *  Created by Neo01 on 6/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __LEVEL_H__
#define __LEVEL_H__

#include <vector>

#define MAIN_BLOCKS_BEGIN		0
#define NUM_MAIN_BLOCKS			6
#define LINK_BLOCKS_BEGIN		6
#define NUM_LINK_BLOCKS			2
#define NUM_BLOCKS_PER_LEVEL	1///8

class Background;
class Block;

class Level {
public:	//private:
	int bgIndex;
	int lvIndex;
	Background* mBackgrounds;
	std::vector<Block*> mBlocks;
	
public:
	Level(int bgIndex, int lvIndex);
	~Level();
	
	void initialize(int accessPath);
	void destroy();
};

#endif //__LEVEL_H__
