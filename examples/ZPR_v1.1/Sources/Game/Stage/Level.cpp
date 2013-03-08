/*
 *  Level.cpp
 *  Zombie Dash
 *
 *  Created by Neo01 on 6/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "Level.h"
#include "LevelBlock.h"
#include "Background.h"
#include "GameSection.h"

#ifdef __DOWNLOAD_RES__
#define ZPRCP_DIR   "book_1"
#else
#define ZPRCP_DIR   0
#endif

Level::Level(int BgIndex, int LvIndex)
{
	bgIndex = BgIndex;
	lvIndex = LvIndex;
	
	mBackgrounds = NULL;
}

Level::~Level()
{
	if (mBackgrounds)
	{
		delete mBackgrounds;
		mBackgrounds = NULL;
	}
	destroy();
}

void Level::initialize(int accessPath)
{
	char filename[16] = {0};
	memset(filename, '\0', sizeof(filename));
    
//    ///temp///
//    if (bgIndex == 3) bgIndex = 0;
//    ///temp///
    
	sprintf(filename, "bg%d.tmx", (1 + bgIndex));
	mBackgrounds = new Background();
#ifdef __DOWNLOAD_RES__
	mBackgrounds->loadData(filename, (accessPath==0)?0:ZPRCP_DIR, accessPath);
#else
	mBackgrounds->loadData(filename, 0, accessPath);
#endif
	
	// It's not a good choice but...
//	int nBlocks = NUM_BLOCKS_PER_LEVEL;
//	for (int i = 0; i < nBlocks; i++)
//	{
		memset(filename, '\0', sizeof(filename));
		sprintf(filename, "s%d%d.tmx", (LevelIndex), (1 + lvIndex));
		Block* blockData = new Block();
#ifdef __DOWNLOAD_RES__
		blockData->loadData(filename, (accessPath==0)?0:ZPRCP_DIR, accessPath);
#else
		blockData->loadData(filename, 0, accessPath);
#endif
		mBlocks.push_back(blockData);
//	}
}

void Level::destroy()
{
	if (mBackgrounds)
	{
		delete mBackgrounds;
		mBackgrounds = NULL;
	}
	for(int i = 0; i < mBlocks.size(); i++)
	{
        delete mBlocks[i];
		mBlocks[i] = NULL;
	}
	mBlocks.clear();
}
