/*
 *  Stage.h
 *  Zombie Dash
 *
 *  Created by Neo01 on 6/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __STAGE_H__
#define __STAGE_H__

#include <vector>
#include <list>

#include "Runner.h"

#define PROLOGUE		-1
#define STAGE_1			0
#define STAGE_2			1
#define STAGE_3			2
#define STAGE_4			3
#define STAGE_5			4
#define STAGE_MAX		1//5

#define MAIN_BLOCK_1	0
#define MAIN_BLOCK_2	1
#define MAIN_BLOCK_3	2
#define MAIN_BLOCK_4	3
#define MAIN_BLOCK_5	4
#define MAIN_BLOCK_6	5
#define MAIN_BLOCK_MAX	6
#define LINK_BLOCK_1	(MAIN_BLOCK_MAX+0)
#define LINK_BLOCK_2	(MAIN_BLOCK_MAX+1)
#define LINK_BLOCK_MAX	2
#define BLOCK_MAX		(MAIN_BLOCK_MAX+LINK_BLOCK_MAX)

// BG layers scrolling parameters
#define LAYER_BG_V_SCALE	0.0f
#define LAYER_MG_V_SCALE	0.15f
#define LAYER_FG_V_SCALE	0.4f

// Canvas layers
#define LAYER_TERRAIN		0
#ifdef V_1_1_0
#define LAYER_BILLBOARD		1
//#define LAYER_OBJECT		2
//#define LAYER_TREASURE		3
//#define LAYER_ZOMBIE		4
//#define LAYER_HINT			5
//#define LAYER_MAX			6
#define LAYER_PLAYERFIELD	2
#define LAYER_TREASURE		3
#define LAYER_ZOMBIE		4
#define LAYER_HINT			5
#define LAYER_MAX			6
#else
#define LAYER_PLAYERFIELD	1
#define LAYER_TREASURE		2
#define LAYER_ZOMBIE		3
#define LAYER_HINT			4
#define LAYER_MAX			5
#endif

#define LAYER_BG			10

#define EFFECT_COLLECTING_MONEY 0
#define EFFECT_ATTACK_ZOMBIE	1
#define EFFECT_ATTACK_ZOMBIE2	2
#define EFFECT_RUNNER_MODE	3

#define POS_X_LOAD_THE_NEXT	(480.0f)
#define POS_X_TRANSITION	(480.0f)
#define POS_X_FADEOUT		(240.0f)

#define STATE_NORMAL	0
#define STATE_FADEIN	1
#define STATE_TRANS		2
#define STATE_FADEOUT	3
#define STATE_MAX		4

#define TRANSITION_DURATION		500.0f	// in ms
#define TRANSITION_ZOOM_NORM_X	1.0f
#define TRANSITION_ZOOM_NORM_Y	1.0f
#define TRANSITION_ZOOM_IN_X	2.0f	// * 2.0f
#define TRANSITION_ZOOM_IN_Y	2.0f	// * 2.0f
#define TRANSITION_TRANS_X		240.0f
#define TRANSITION_TRANS_Y		160.0f

#define DISTANCE_PARAM			(3.0f/4.0f)	// Canvas Width * DISTANCE_PARAM
#define HINT_FLASH_DURATION		1200.0f		// in ms
#define HINT_FLASH_INTERVAL		1200.0f		// in ms, fade-in -> retain -> fade-out

#define REPEAT_STAGE			1

#define CAM_PAN_UP_SPD_MAX	10.0f
#define CAM_PAN_DN_SPD_MAX	-8.0f///-2.0f


// enable one of them to debug and review the level
// ---------------------------------------------------------
// for level design and debug, comment this to disable it.
#define FIXED_BLOCK_GEN			STAGE_1

#ifdef FIXED_BLOCK_GEN
// normal blocks: 1 ~ 6, link blocks: 7, 8
#define FIXED_BLOCK_ARRAY		{1/*,2,3,4,5,6,7,8*/}	// {7,8}, with the transition effect
extern int dbgBlkIdx;
extern int dbgBlkArr[];
extern int dbgBlkSize;
#endif
// ---------------------------------------------------------
// for level design and debug, comment this to disable it.
//#define SEQUENCE_BLOCK_GEN	STAGE_1

#ifdef SEQUENCE_BLOCK_GEN
#define SEQUENCE_BLOCK_START	LINK_BLOCK_1//MAIN_BLOCK_6
#endif
// ---------------------------------------------------------


class Block;
class Level;
class ObjLayer;
class Background;
class Transition;
class Sprite;
class Particle;
class Rain;
class Item;
class InfoTag;
class ScoreTag;

class Stage
{
public:
	float startX;
	float startY;
	
	int star1, star2, star3;
	
	bool bRain;
	bool bChase;
    
#ifdef SET_CHKPT
    int idxChkpt;
#endif
	
private:
	int level;
	int block;
	
	int nextLevel;
	int nextBlock;
	
public:
	int blockLength;
	int blockHeight;
	int nextBlockLength;
	int nextBlockHeight;
	
	int blockTileHeight;
	
	float distance0;
	float distance;
	
	float posX;
	float posY;
	
	// flags
	float posXinBlock;
	bool  flagLoadNextBlock;
	bool  flagLoadNextBlockDone;
	bool  flagLoadNextLevel;
	bool  flagLoadNextLevelDone;
	
	// level data
	Level* levelData;
	
	// current layers
	std::vector<ObjLayer*> bgLayers;
	std::vector<ObjLayer*> pfLayers;
	
	// stage transition
	int state;
	
	// Weather Effects
	Rain* rain;
	
	// Effects
	std::list<InfoTag*> effectList;
	
	// Slow Motion Zone - time parameter
	float currTimeRatio;
	float targetTimeRatio;
	float deltaTimeRatio;
	
	// Check Points
	int   currentCheckPoint;
	int   lastCheckPoint;
	int   nCheckPoint;
	float mCheckPoint[NUM_CHECK_POINT_MAX];
	
	Sprite* itemHalo;
	
#ifdef __IN_APP_PURCHASE__
    bool isHyperJump;
#endif
	
public:
	Stage(int stageId);
	~Stage();
	void initialize();
	void destroy();
	void update(float dt, float posX, float posY);
	void render(float dt);
	
	void loadLevelData(int accessPath/*int level*/);
	void clearLevelData();
	
	void reset();
	
	void genNextBG();
	void genNextBlock();
	
	void updateBG(float dt);
	void renderBG(float dt);
	
	void updatePF(float dt);
	void renderPF(float dt);
	
	void updateEL(float dt);
	void renderEL(float dt);
	
	void clearBG();
	void clearPF();
	void clearEL();
	
	void makeInfoTag(float x, float y, const char* str, float r = 1.0f, float g = 1.0f, float b = 0.0f);
	void makeCollectingEffect(int type, Sprite* spr, float x, float y);
	void makeActionTag(float x, float y, const char* str, float r, float g, float b);
	void updateEffects(float dt);
	void renderEffects(float dt);
	void clearEffects();
	
	void updateTimeCtrl();
	void enterSlowMotion(float targetRatio = 0.5f);
	void exitSlowMotion();
    void enteringSlowMotion(float targetRatio = 0.5f);
	void exitingSlowMotion();
	
#ifdef ENABLE_CHECKPOINT
	void resetCheckPoint();
	void setCheckPoint(float *playerXoffset, float *playerYoffset);
	void updateCheckPoint();
#endif
	
	int BlockType(float tx, float ty, float *xx, float *yy);
	int BlockParall(float tx, float ty, float v, float *yy, int type);
	int BlockRect(float tx, float ty, float tw, float th, float *xx, float *yy);
	bool BlockSwing(float tx, float ty, float tw, float th, float *xx, float *yy);
	
	void CheckGettingCoin(float tx, float ty, int tw, int th);
	int CheckZombie(int type, float tx, float ty, int th);
};

#endif //__STAGE_H__