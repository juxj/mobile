/*
 *  Stage.cpp
 *  Zombie Dash
 *
 *  Created by Neo01 on 6/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "Stage.h"
#include "ObjRect.h"
#include "ObjLayer.h"
#include "LevelBlock.h"
#include "Level.h"
#include "Background.h"

#include "GameState.h"
#include "GamePlay.h"
#include "GameRes.h"
#include "GameHouse.h"
#include "GameOption.h"
#include "GameSection.h"
#include "GameAudio.h"

#include "Runner.h"
#include "Opponent.h"
#import "Giant.h"
#include "Particle.h"
#include "Rain.h"

#include "Item.h"
#include "ScoreTag.h"
#include "ActionTag.h"
#include "Attack.h"
#include "Effect.h"
#include "Flust.h"

#include "Canvas2D.h"

///#include "Texture2D.h"
#include "neoRes.h"
#import "CCMath.h"
#import <float.h>

#import "GameAchieve.h"

#ifdef __IN_APP_PURCHASE__
#import "GameRunnerMode.h"
#import "GameTrampoline.h"
#endif


// ---------------------------------------------------------
#ifdef FIXED_BLOCK_GEN
int dbgBlkIdx;
int dbgBlkArr[] = FIXED_BLOCK_ARRAY;
int dbgBlkSize = (sizeof(dbgBlkArr)/sizeof(int));
#endif
// ---------------------------------------------------------


#pragma mark -
#pragma mark Basic functions

Stage::Stage(int stageId)
{
	level = nextLevel = stageId;//STAGE_1;
	block = nextBlock = MAIN_BLOCK_1;
	
	distance = 0.0f;
	distance0 = 0.0f;
	
	posX = 0.0f;
	posY = 0.0f;
	
	posXinBlock = 0.0f;
	flagLoadNextBlock = false;
	flagLoadNextBlockDone = false;
	flagLoadNextLevel = false;
	flagLoadNextLevelDone = false;
	
	state = STATE_NORMAL;
	
	startX = startY = 0.0f;
	star1 = 100;
	star2 = 200;
	star3 = 300;
	
	bRain = false;
	bChase = false;
	
	currTimeRatio = 1.0f;
	targetTimeRatio = 1.0f;
	
	rain = NULL;
    
#ifdef __IN_APP_PURCHASE__
    isHyperJump = false;
#endif
	
	srand((unsigned)time(0));
}

Stage::~Stage()
{
	destroy();
	
	for(int i = 0; i < bgLayers.size(); i++)
	{
		if (bgLayers[i])
		{
			delete bgLayers[i];
			bgLayers[i] = NULL;
		}
	}
	bgLayers.clear();
	
	for(int i = 0; i < pfLayers.size(); i++)
	{
		if (pfLayers[i])
		{
			delete pfLayers[i];
			pfLayers[i] = NULL;
		}
	}
	pfLayers.clear();
}

void Stage::initialize()
{
	levelData = new Level(LevelIndex, level);
	
	loadLevelData(accessPath/*level*/);	// load level data at the startup
	
	reset();
	
	startX = levelData->mBlocks[0]->mStartX;
	startY = levelData->mBlocks[0]->mStartY;
	
	star1 = levelData->mBlocks[0]->star1;
	star2 = levelData->mBlocks[0]->star2;
	star3 = levelData->mBlocks[0]->star3;
	
	bRain = levelData->mBlocks[0]->bRain;
	bChase = levelData->mBlocks[0]->bChase;
	
#ifdef SET_CHKPT
    idxChkpt = levelData->mBlocks[0]->idxChkpt;
//    printf("_____________%d\n", idxChkpt);
#endif
    
	// Check Points
	nCheckPoint = levelData->mBlocks[0]->nCheckPoint;
	for (int i = 0; i < nCheckPoint; i++)
	{
		mCheckPoint[CHECK_POINT_DATA_ELEMENTS*i]   = levelData->mBlocks[0]->mCheckPoint[CHECK_POINT_DATA_ELEMENTS*i];
		mCheckPoint[CHECK_POINT_DATA_ELEMENTS*i+1] = levelData->mBlocks[0]->mCheckPoint[CHECK_POINT_DATA_ELEMENTS*i+1];
		mCheckPoint[CHECK_POINT_DATA_ELEMENTS*i+2] = levelData->mBlocks[0]->mCheckPoint[CHECK_POINT_DATA_ELEMENTS*i+2];
#if DEBUG
		printf("CheckPoint[%d] = %f, %f, %f\n", i, mCheckPoint[CHECK_POINT_DATA_ELEMENTS*i], mCheckPoint[CHECK_POINT_DATA_ELEMENTS*i+1], mCheckPoint[CHECK_POINT_DATA_ELEMENTS*i+2]);
#endif
	}
	lastCheckPoint = currentCheckPoint = -1;
    
#ifdef SET_CHKPT
    lastCheckPoint = currentCheckPoint = idxChkpt;
#endif
	
	Canvas2D* canvas = Canvas2D::getInstance();
	setDefaultCamY(0);
	defaultCamera();
	cameraY = -(startY - (canvas->getCanvasHeight() / 2.0f));
	if (startY < canvas->getCanvasHeight())
	{
		cameraY = 0.0f;
	}
	else if (startY > (canvas->getCanvasHeight() - canvas->getCanvasHeight()))
	{
		cameraY = -(blockHeight - canvas->getCanvasHeight());
	}
	else if (startY >= 0 && startY <= (canvas->getCanvasHeight() - levelData->mBlocks[0]->tileHeight))
	{
		cameraY = 0.0f;
		printf("tileHeight = %d\n", levelData->mBlocks[0]->tileHeight);
	}

//	else {
//		cameraY = -(startX - (canvas->getCanvasHeight() / 2.0f));
//	}

	
	setDefaultCamY(cameraY);
	defaultCamera();
//	startY -= cameraY;
	cameraYMax = -(blockHeight - canvas->getCanvasHeight());
	
	// item halo
///	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA8888;
	itemHalo = new Sprite();
	g_GcResMgr->createSprite(itemHalo, "sucinfoimg.xml", NULL/*, IMG_RES_SCALE*/);
	int imgCnt = itemHalo->getCurrentActionFrameCount();
	for (int i = 0; i < imgCnt; i++)
	{
		(itemHalo->mFrames[i].mImage)->makeCenterAsAnchor();
//		(itemHalo->mFrames[i].mImage)->SetAnchor((itemHalo->mFrames[i].mImage)->mWidth*0.5f, (itemHalo->mFrames[i].mImage)->mHeight*0.5f);
	}
	itemHalo->setCurrentAction(0);
	itemHalo->startAction();
///	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA4444;
	
	if (bRain)
	{
		rain = new Rain();
	}
	
#ifdef __IN_APP_PURCHASE__
    isHyperJump = false;
#endif
    
//	itemTest = new Item("pole.xml", 100, 100, 0);
}

void Stage::destroy()
{
	if (bRain)
	{
		if (rain)
		{
			delete rain;
			rain = NULL;
		}
	}
	
	if (itemHalo)
	{
		delete itemHalo;
		itemHalo = NULL;
	}
	
	if (levelData)
	{
		delete levelData;
		levelData = NULL;
	}
	
//	delete itemTest;
//	itemTest = NULL;
}

void Stage::update(float dt, float _posX, float _posY)
{
	posX = _posX;
	posY = _posY;
//	printf("%f\n", posX);
	
//	++score;
	updateTimeCtrl();
	
#ifdef ENABLE_CHECKPOINT
	if (GetPlayerAction() != PLAYER_STATE_STAND)
	{
		updateCheckPoint();
	}
#endif
	
	// Update background, midground, foreground
	updateBG(dt);
	
	// Update player field
	updatePF(dt);
	
	// Update rain effect
	if (bRain)
	{
		rain->update(dt);
	}
	
//	itemTest->update(dt);
	updateEffects(dt);
	
//	printf("playerY = %f = %f + %f\n", GetPlayerY() + cameraY, GetPlayerY(), cameraY);
	
//	float avgCamY = 0.0f;
//	for (int i = 0; i < CAMERA_Y_CACHE_MAX-1; i++)
//	{
//		cameraYHistory[i] = cameraYHistory[i+1];
//		avgCamY += cameraYHistory[i+1] - cameraYHistory[i];
//	}
//	cameraYHistory[CAMERA_Y_CACHE_MAX-1] = GetPlayerY();
//	avgCamY += cameraYHistory[CAMERA_Y_CACHE_MAX-1] - cameraYHistory[CAMERA_Y_CACHE_MAX-2];
//	avgCamY /= (float)CAMERA_Y_CACHE_MAX;
//	for (int i = 0; i < CAMERA_Y_CACHE_MAX; i++)
//	{
//		printf("cameraYHistory[%d] = %f\n", i, cameraYHistory[i]);
//	}
	
	float step = GetPlayerY() -mStepCam;
	if (step > CAM_PAN_UP_SPD_MAX) step = CAM_PAN_UP_SPD_MAX;
	else if (step < CAM_PAN_DN_SPD_MAX) step = CAM_PAN_DN_SPD_MAX;
	
	mStepCam = step +mStepCam;
	
	if (-cameraY > 0 && mStepCam + cameraY < 128.0f)
	{
//		printf("PanUp\n");
		panUpDnCamera(128.0f - mStepCam - cameraY);
	}
//	printf("avgCamY = %f\n", avgCamY);
//	if (-cameraY > 0 && GetPlayerY() + cameraY < 128.0f)
//	{
//		printf("PanUp: avgCamY = %f\n", avgCamY);
//		panUpDnCamera(128.0f - cameraYHistory[0] + avgCamY - cameraY);
//	}
	else if (-cameraY < (blockHeight + cameraY) && mStepCam + cameraY > 128.0f && (cameraY > cameraYMax))
	{
		float delta = 128.0f - mStepCam - cameraY;
		if (cameraY + delta <= cameraYMax)
		{
			delta -= (cameraY + delta - cameraYMax);
		}
		panUpDnCamera(delta);
//		printf("PanDown: camY = %f, delta = %f\n", cameraY, delta);
	}
}

void Stage::render(float dt)
{
//	Camera* camera = Camera::getInstance();
//	camera->update(dt);
///	glTranslatef(-120.0f, -160.0f, 0.0f);
//	camera->setCamera(-240, -160, 2, 2);
	
	// Render background, midground, foreground
	renderBG(dt);
	
//	static float camY = 0.0f;
//	static float ang = 0.0f;
//	ang += 2.0f;
//	camY = 100.0f*sinf(3.1415926f/180.0f*ang);
//	camera->setCamera(0.0f, camY, 1.0f, 1.0f);
//	camera->update(dt);
	
	// Render player field
	renderPF(dt);
	
	// Render rain effect
	if (bRain)
	{
		rain->render(dt);
	}
	
//	itemTest->render(dt);
//	renderEffects(dt);
	
//	camera->setCamera(0.0f, -camY, 1.0f, 1.0f);
//	camera->update(dt);
}

#pragma mark -
#pragma mark level data

void Stage::loadLevelData(int accessPath/*int level*/)
{
	levelData->initialize(accessPath);
}

void Stage::clearLevelData()
{
	levelData->destroy();
}

#pragma mark -
#pragma mark Layers

void Stage::reset()
{
#ifdef FIXED_BLOCK_GEN
	dbgBlkIdx = 0;
	level = nextLevel = FIXED_BLOCK_GEN;
	block = nextBlock = dbgBlkArr[dbgBlkIdx] - 1;
//	printf("the start block: %d, (%d/%d)\n", (nextBlock+1), (dbgBlkIdx+1), (dbgBlkSize));
#elif defined SEQUENCE_BLOCK_GEN
	level = nextLevel = SEQUENCE_BLOCK_GEN;
	block = nextBlock = SEQUENCE_BLOCK_START;
	printf("the start block:  %d\n", (nextBlock+1));
#else
	level = STAGE_1;
	block = MAIN_BLOCK_1;
	nextLevel = STAGE_1;
	nextBlock = MAIN_BLOCK_1;
	printf("the start block:  %d\n", (nextBlock+1));
#endif
	
//	clearLevelData();
//	loadLevelData(level);
	
	blockLength = 0;
	nextBlockLength = 0;
	
	posXinBlock = 0.0f;
	distance = 0.0f;
	distance0 = 0.0f;
	
	posX = 0.0f;
	posY = 0.0f;
	
	clearBG();
	clearPF();
	
	genNextBG();
	genNextBlock();
	
	flagLoadNextBlock = false;
	flagLoadNextBlockDone = false;
	flagLoadNextLevel = false;
	flagLoadNextLevelDone = false;
	
	// change the state to the normal if
	// in the state of fade-in/out or transition
	state = STATE_NORMAL;
	
//	// reset the camera position/zoom
//	Camera* camera = Camera::getInstance();
//	camera->reset();
	
//	score = 0;
	
	defaultCamera();
	
	clearEffects();
	
	currTimeRatio = 1.0f;
	targetTimeRatio = 1.0f;
	
#ifdef DEBUG
	printf("star: %d\n", nCoinsInCurrentLevel);
#endif
	
#ifdef ENABLE_ACHIEVEMENTS
	if (lastCheckPoint < 0)
	{
		ResetTempAchievements();
	}
#endif
	
#ifdef __IN_APP_PURCHASE__
    isHyperJump = false;
    
    // Speed Meter
    spdmAlpha = 0.0f;
    spdmState = SPEEDMETER_HIDE;
    
    usingTrampoline = false;
#endif
    
//	for (int i = 0; i < CAMERA_Y_CACHE_MAX; i++)
//	{
//		cameraYHistory[i] = 0.0f;
//	}
	
//	if (bRain)
//	{
//		playSE(SE_RAIN, true);
//	}
}

void Stage::genNextBlock()
{
	int i;
	// create each layer for the first time
	if (pfLayers.empty())
	{
		for (i = 0; i < levelData->mBlocks[nextBlock]->nLayer; i++)
		{
			ObjLayer* layer = new ObjLayer(i, 0, 0, 1);
			layer->bClrUserData = false;
			pfLayers.push_back(layer);
		}
	}
	// append the specific layer data to the related layer from the block in the level data
	for (i = 0; i < levelData->mBlocks[nextBlock]->nLayer; i++)
	{
		pfLayers[i]->appendObj(levelData->mBlocks[nextBlock]->layers[i]->data, distance);
	}
	
	// block length
	nextBlockLength = levelData->mBlocks[nextBlock]->tileWidth * levelData->mBlocks[nextBlock]->width;
	nextBlockHeight = levelData->mBlocks[nextBlock]->tileHeight * levelData->mBlocks[nextBlock]->height;
	if (blockLength == 0)
	{
		blockLength = nextBlockLength;
		blockHeight = nextBlockHeight;
//		printf("the current block length: %d\n", blockLength);
//		printf("the next block length: %d\n", nextBlockLength);
	}
	
	// test codes
	// gen hints for the normal difficulty
	if (GetLevelMode() == 1)
	//if (GetLevelMode() < 2)
	{
		std::list<ObjRect*>::iterator it = pfLayers[LAYER_HINT]->data.begin();
		std::list<ObjRect*>::iterator itEnd = pfLayers[LAYER_HINT]->data.end();
		for (; it != itEnd; ++it)
		{
			(*it)->setDuration(HINT_FLASH_DURATION);
			(*it)->setInterval(HINT_FLASH_INTERVAL);
		}
	}
	
	level = nextLevel;
	block = nextBlock;
	
//	printf("generate block: Lv %d - B %d\n", (level+1), (nextBlock+1));
}

void Stage::genNextBG()
{
	if (bgLayers.empty())
	{
		for (int i = 0; i < levelData->mBackgrounds->nLayer; i++)
		{
			ObjLayer* layer = new ObjLayer(LAYER_BG+i, 
										   levelData->mBackgrounds->layers[i]->getWidth(), 
										   levelData->mBackgrounds->layers[i]->getHeight(), 
										   0);
			bgLayers.push_back(layer);
		}
	}
	for (int i = 0; i < levelData->mBackgrounds->nLayer; i++)
	{
		bgLayers[i]->appendObj(levelData->mBackgrounds->layers[i]->data, 0);
	}
}

#pragma mark update / render

void Stage::updateBG(float dt)
{
	const float layer_v_param[] = {
		LAYER_BG_V_SCALE,
		LAYER_MG_V_SCALE,
		LAYER_FG_V_SCALE
	};
	
	int i = 0;
	std::vector<ObjLayer*>::iterator it = bgLayers.begin();
	std::vector<ObjLayer*>::iterator itEnd = bgLayers.end();
	for (; it != itEnd; ++it, ++i)
	{
		levelData->mBackgrounds->params[level].posX = 
			posX * layer_v_param[i] - 
		(int)(posX * layer_v_param[i] / (*it)->getWidth()) * (*it)->getWidth();
					//*levelData->mBackgrounds->params[level].length;
		
		levelData->mBackgrounds->params[level].posY = posY;
		
		(*it)->update(dt, levelData->mBackgrounds->params[level].posX, posY, false);
	}
}

void Stage::renderBG(float dt)
{
	int count, idx;
	std::vector<ObjLayer*>::iterator it = bgLayers.begin();
	std::vector<ObjLayer*>::iterator itEnd = bgLayers.end();
	for (; it != itEnd; ++it)
	{
		count = levelData->mBackgrounds->params[level].renderCount;
		for (idx = 0; idx < count; idx++)
		{
			(*it)->render(dt, floor((*it)->getWidth() * idx), 0.0f);
		}
	}
}

void Stage::updatePF(float dt)
{
	std::vector<ObjLayer*>::iterator it = pfLayers.begin();
	std::vector<ObjLayer*>::iterator itEnd = pfLayers.end();
	for (; it != itEnd; ++it)
	{
		(*it)->update(dt, posX, posY, true);
	}
	
	posXinBlock = posX - distance0;
	if (posXinBlock >= blockLength)
	{
		if (state == STATE_TRANS)
		{
			state = STATE_FADEOUT;
			
// put it here for debug
//Camera* camera = Camera::getInstance();
//camera->moveCameraTo(-240.0f, -160.0f, 1.0f, 1.0f, 1000.0f);
//camera->moveCameraTo(0.0f, 0.0f, 1.0f, 1.0f, 1000.0f);
		}
		
		posXinBlock = 0.0f;
		distance0 = distance;
		blockLength = nextBlockLength;
		printf("current block length: %d\n", blockLength);
		flagLoadNextBlockDone = false;
	}
	
	// fading way
//	if (g_canvas_state == CANVAS_FADE_OUT && g_alpha >= 0.9f)
//	{
//		setCanvasMaskNormal();
//		g_nGameState = GAME_STATE_SUC;
//		SwitchGameState();
//	}
	
	if (state == STATE_NORMAL)
	{
		// load the next block
/*		if ((posXinBlock > (blockLength - POS_X_LOAD_THE_NEXT)) && //if ((posXinBlock > ((32*80) - POS_X_LOAD_THE_NEXT)) && 
			(!flagLoadNextBlock && !flagLoadNextBlockDone))
		{
//			flagLoadNextBlock = true;	// no more block
			distance += blockLength;//distance += 32*80;
			
//#ifdef FIXED_BLOCK_GEN
			dbgBlkIdx = (++dbgBlkIdx) % dbgBlkSize;
			//nextLevel = STAGE_1;
			nextBlock = dbgBlkArr[dbgBlkIdx] - 1;
			
			if (distance >= REPEAT_STAGE*blockLength)///if (block == LINK_BLOCK_1)
			{
				SetSuccState();
			}

			//printf("generate block: %d, (%d/%d)\n", (nextBlock+1), (dbgBlkIdx+1), (dbgBlkSize));
//#elif defined SEQUENCE_BLOCK_GEN
//			if (block == LINK_BLOCK_1)
//			{
//				nextBlock = LINK_BLOCK_2;
//				
//				state = STATE_FADEIN;
////				transitionLayer->setFadeIn();
//				
//				printf("the next block: link block %d\n", (nextBlock+1-MAIN_BLOCK_MAX));
//				
//				Camera* camera = Camera::getInstance();
//				camera->moveCameraTo(-TRANSITION_TRANS_X, -TRANSITION_TRANS_Y, TRANSITION_ZOOM_IN_X, TRANSITION_ZOOM_IN_Y, TRANSITION_DURATION);
//			}
//			else if (block == MAIN_BLOCK_6)
//			{
//				nextBlock = LINK_BLOCK_1;
//				
//				printf("the next block: link block %d\n", (nextBlock+1-MAIN_BLOCK_MAX));
//			}
//
//			else
//			{
//				++nextBlock;
//				if (nextBlock >= BLOCK_MAX)
//				{
//					nextBlock = MAIN_BLOCK_1;
//					
//					Camera* camera = Camera::getInstance();
//					camera->moveCameraTo(0.0f, 0.0f, 1.0f, 1.0f, 1000.0f);
//				}
//				
//				printf("the next block: normal block %d\n", (nextBlock+1));
//			}
//#else
//			// temp setting
//			//if (score > 60*10)
//			//if (the score reaches the standard)
//			//if (block >= MAIN_BLOCK_6)	//debug
//			if (block == LINK_BLOCK_1)
//			{
////				score = 0;
//				nextBlock = LINK_BLOCK_2;
//				
//				state = STATE_FADEIN;
////				transitionLayer->setFadeIn();
//				
//				printf("the next block: link block %d\n", (nextBlock+1-MAIN_BLOCK_MAX));
//				
//				Camera* camera = Camera::getInstance();
//				camera->moveCameraTo(-TRANSITION_TRANS_X, -TRANSITION_TRANS_Y, TRANSITION_ZOOM_IN_X, TRANSITION_ZOOM_IN_Y, TRANSITION_DURATION);
//			}
//			else
//			{
//				nextBlock = rand() % MAIN_BLOCK_MAX;
//				
//				printf("the next block: normal block %d\n", (nextBlock+1));
//			}
//#endif
		}
		if (flagLoadNextBlock)
		{
			// Load the next block
			flagLoadNextBlock = false;
			genNextBlock();
			flagLoadNextBlockDone = true;
			
#ifdef FIXED_BLOCK_GEN
//#elif defined SEQUENCE_BLOCK_GEN
#else
			// Go to the next level
			if (nextBlock == LINK_BLOCK_2)
			{
				++nextLevel;
				if (nextLevel >= STAGE_MAX)
				{
					nextLevel = STAGE_1;
				}
				printf("Go to the next level: %d !!!\n", (nextLevel+1));
			}
#endif
		}*/
	}
	else if (state == STATE_FADEIN)
	{
		if ((posXinBlock > (blockLength - POS_X_TRANSITION)))//if ((posXinBlock > ((32*80) - POS_X_TRANSITION)))
		{
			state = STATE_TRANS;
			flagLoadNextLevel = true;
			flagLoadNextLevelDone = false;
		}
//		transitionLayer->update(dt, posX, posY, false);
//		printf("update trans fadein\n");
	}
	else if (state == STATE_FADEOUT)
	{
		if ((posXinBlock > POS_X_FADEOUT))
		{
			state = STATE_NORMAL;
		}
//		transitionLayer->update(dt, posX, posY, false);
//		printf("update trans fadeout\n");
	}
	else if (state == STATE_TRANS)
	{
		if (flagLoadNextLevel && !flagLoadNextLevelDone)
		{
			clearBG();
			//clearPF();
			
			clearLevelData();
			loadLevelData(nextLevel);
			
			//genNextBlock();
			
			flagLoadNextLevelDone = true;
		}
//		transitionLayer->update(dt, posX, posY, false);
//		printf("update trans main\n");
	}
}

void Stage::renderPF(float dt)
{
	std::vector<ObjLayer*>::iterator it = pfLayers.begin();
	std::vector<ObjLayer*>::iterator itEnd = pfLayers.end();
	for (; it != itEnd; ++it)
	{
		if ((*it)->index == LAYER_TERRAIN) continue;
		if ((*it)->index == LAYER_HINT && GetLevelMode() == 2) continue;
		
		(*it)->render(dt, cameraX, cameraY);
	}
#if DEBUG
	if (pfLayers[LAYER_TERRAIN]->index == LAYER_TERRAIN)
	{
		pfLayers[LAYER_TERRAIN]->render(dt, cameraX, cameraY);
	}
#endif
//	if (state != STATE_NORMAL)
//	{
//		printf("render trans\n");
//		transitionLayer->render(dt);
//	}
}

#pragma mark -
#pragma mark Clear layers

void Stage::clearBG()
{
	std::vector<ObjLayer*>::iterator it = bgLayers.begin();
	std::vector<ObjLayer*>::iterator itEnd = bgLayers.end();
	for (; it != itEnd; ++it)
	{
		(*it)->reset();	//(*it)->data.clear();
	}
}

void Stage::clearPF()
{
	std::vector<ObjLayer*>::iterator it = pfLayers.begin();
	std::vector<ObjLayer*>::iterator itEnd = pfLayers.end();
	for (; it != itEnd; ++it)
	{
		(*it)->reset();
	}
}

void Stage::clearEL()
{
}

#pragma mark -
#pragma mark Effects

void Stage::makeInfoTag(float x, float y, const char* str, float r, float g, float b)
{
	if (y < 0)
	{
		y = 0;
	}
	y += rand() % 25;
	effectList.push_back(new ScoreTag(x + cameraX, y + cameraY, str, r, g, b));
//	printf("add!\n");
}

void Stage::makeActionTag(float x, float y, const char* str, float r, float g, float b)
{
	if (y < 0)
	{
		y = 0;
	}
	y -= 15.0f + rand() % 10;
	effectList.push_back(new ActionTag(x + cameraX, y + cameraY, str, r, g, b));
	//	printf("add!\n");
}

void Stage::makeCollectingEffect(int type, Sprite* spr, float x, float y)
{
	if (type == EFFECT_COLLECTING_MONEY)
	{
		effectList.push_back(new Effect(spr, x + cameraX, y + cameraY));
	}
	else if (type == EFFECT_ATTACK_ZOMBIE)
	{
		effectList.push_back(new Attack(spr, x, y, 74,74));
	}
	else if (type == EFFECT_ATTACK_ZOMBIE2)
	{
		effectList.push_back(new Attack(spr, x, y, 114,50));
	}
	else if(type == EFFECT_RUNNER_MODE)
	{
		effectList.push_back(new Flust(spr, x + cameraX, y + cameraY));
	}
//	printf("add Effect!\n");
}

void Stage::updateEffects(float dt)
{
	std::list<InfoTag*>::iterator it = effectList.begin();
	std::list<InfoTag*>::iterator itEnd = effectList.end();
//	int cnt = 0;
	for (; it != itEnd;)
	{
		(*it)->update(dt);
//		printf("update!\n");
		
		if (/*(*it)->getCount() >= 45 || */!((*it)->active))
		{
			delete (*it);
			(*it) = NULL;
			it = effectList.erase(it);
//			printf("delete!\n");
		}
		else
		{
			++it;
//			++cnt;
		}
	}
//	printf("effects: %d\n", cnt);
}

void Stage::renderEffects(float dt)
{
	std::list<InfoTag*>::iterator it = effectList.begin();
	std::list<InfoTag*>::iterator itEnd = effectList.end();
	Canvas2D *canvas = Canvas2D::getInstance();
	canvas->enableColorPointer(true);
	for (; it != itEnd; it++)
	{
		(*it)->render(dt);
//		printf("render!\n");
	}
	canvas->enableColorPointer(false);
}

void Stage::clearEffects()
{
	std::list<InfoTag*>::iterator it = effectList.begin();
	std::list<InfoTag*>::iterator itEnd = effectList.end();
	for (; it != itEnd;)
	{
		delete (*it);
		(*it) = NULL;
		it = effectList.erase(it);
	}
	effectList.clear();
}

#pragma mark -
#pragma mark Time Control

void Stage::updateTimeCtrl()
{
	float x, y;
	x = y = 0.0f;
	int t = stages->BlockType(GetPlayerX(), GetPlayerY() - 32, &x, &y);
	if (t == ZONE_SLOW_MOTION)
	{
		enterSlowMotion();
        return;
	}
	else if (t == ZONE_RECOVER_MOTION)
	{
		exitSlowMotion();
        return;
	}
    
    if (usingIgRm)
    {
        ++igRmCnt;
        if (igRmCnt > IG_RUNNERMODE_CNT_MAX)
        {
            usingIgRm = false;
            igRmCnt = 0;
            exitingSlowMotion();
            return;
        }
    }
    
//#if 0	
    if (targetTimeRatio - currTimeRatio == 0) return;
	if (deltaTimeRatio == 0.0f) return;
	currTimeRatio += deltaTimeRatio;
	float param = targetTimeRatio - currTimeRatio;
	if (param * param < 0.05f)
	{
		deltaTimeRatio = 0.0f;
		currTimeRatio = targetTimeRatio;
	}
//#endif
}

void Stage::enterSlowMotion(float targetRatio)
{
	SetWalkState(true);
#if 0
	targetTimeRatio = targetRatio;
	deltaTimeRatio = (targetTimeRatio - currTimeRatio) / (TIME_SLOW_MOTION / 33.33333f);
#endif
}

void Stage::exitSlowMotion()
{
	SetWalkState(false);
#if 0
	targetTimeRatio = 1.0f;
	deltaTimeRatio = (targetTimeRatio - currTimeRatio) / (TIME_SLOW_MOTION / 33.33333f);
#endif
}

void Stage::enteringSlowMotion(float targetRatio)
{
    targetTimeRatio = targetRatio;
	deltaTimeRatio = (targetTimeRatio - currTimeRatio) / (TIME_SLOW_MOTION / 33.33333f);
}

void Stage::exitingSlowMotion()
{
    targetTimeRatio = 1.0f;
	deltaTimeRatio = (targetTimeRatio - currTimeRatio) / (TIME_SLOW_MOTION / 33.33333f);
}

#pragma mark -
#pragma mark Check Points
#ifdef ENABLE_CHECKPOINT
void Stage::resetCheckPoint()
{
	lastCheckPoint = currentCheckPoint = -1;
	ResetTempAchievements();
#if DEBUG
	printf("Reset the check point manually.\n");
#endif
}

void Stage::setCheckPoint(float *playerXoffset, float *playerYoffset)
{
	if (lastCheckPoint >= 0)
	{
		currentCheckPoint = lastCheckPoint;
		
		mScrollWorld = mCheckPoint[CHECK_POINT_DATA_ELEMENTS*currentCheckPoint] - 512.0f;
		posX = mScrollWorld;
		updatePF(0.0f);
		
		*playerXoffset = mCheckPoint[CHECK_POINT_DATA_ELEMENTS*currentCheckPoint];
		*playerYoffset = mCheckPoint[CHECK_POINT_DATA_ELEMENTS*currentCheckPoint+1] + mCheckPoint[CHECK_POINT_DATA_ELEMENTS*currentCheckPoint+2];
		
#ifdef __IN_APP_PURCHASE__
        if (!isHyperJump)
#endif
        {
            restorePreviousStatistics();
        }
#ifdef __IN_APP_PURCHASE__
        else
        {
            isHyperJump = false;
			
#if DEBUG
			printf("Restore check point[%d]: (%f, %f, %f),(%f, %f, %f)\n", 
				   currentCheckPoint, 
				   mCheckPoint[CHECK_POINT_DATA_ELEMENTS*currentCheckPoint], 
				   mCheckPoint[CHECK_POINT_DATA_ELEMENTS*currentCheckPoint+1], 
				   mCheckPoint[CHECK_POINT_DATA_ELEMENTS*currentCheckPoint+2]
				   ,cameraX,cameraY,defaultCameraY);
#endif
			
        }
#endif
        
#ifdef __IN_APP_PURCHASE__
        if (lastCheckPoint == (nCheckPoint - 1))
        {
            currentCheckPoint = lastCheckPoint = (stages->nCheckPoint - 2);
        }
#endif
	}
	else
	{
		lastCheckPoint = currentCheckPoint = -1;
#if DEBUG
		printf("Reset the check point\n");
#endif
	}
	
	Canvas2D *canvas = Canvas2D::getInstance();
	float y = *playerXoffset;
	
	cameraY = -(y - (canvas->getCanvasHeight() * 0.5f));
	if (y < canvas->getCanvasHeight())
	{
		cameraY = 0.0f;
	}
	else if (y > (canvas->getCanvasHeight() - canvas->getCanvasHeight()))
	{
		cameraY = -(stages->blockHeight - canvas->getCanvasHeight());
	}
	else if (y >= 0 && 
			 y <= (canvas->getCanvasHeight() - stages->levelData->mBlocks[0]->tileHeight))
	{
		cameraY = 0.0f;
	}
	
	//stages->mCheckPoint[CHECK_POINT_DATA_ELEMENTS*stages->currentCheckPoint+3] = cameraX;
	//stages->mCheckPoint[CHECK_POINT_DATA_ELEMENTS*stages->currentCheckPoint+4] = cameraY;
	//stages->mCheckPoint[CHECK_POINT_DATA_ELEMENTS*stages->currentCheckPoint+5] = defaultCameraY;
	
}

void Stage::updateCheckPoint()
{
	float x, y;
	x = y = 0.0f;
	int t = stages->BlockType(GetPlayerX(), GetPlayerY() - 32, &x, &y);
	if (t >= BLOCK_CHECK_POINT
#ifdef __IN_APP_PURCHASE__
        && (t < BLOCK_CHECK_POINT + nCheckPoint - 1) && !isHyperJump
#endif
        )
	{
		// get the index of the check point
		lastCheckPoint = currentCheckPoint = t - BLOCK_CHECK_POINT;
		saveTempStatistics();
		
#if DEBUG
		printf("Reach the check point %f, %f\n", x, y);
#endif
	}
}
#endif

#pragma mark -
#pragma mark Collision detection

int Stage::BlockRect(float tx, float ty, float tw, float th, float *xx, float *yy)
{
	std::list<ObjRect*>::iterator it = pfLayers[LAYER_TERRAIN]->data.begin();
	std::list<ObjRect*>::iterator itEnd = pfLayers[LAYER_TERRAIN]->data.end();
	for (; it != itEnd; ++it)
	{
		int type = (*it)->objId;
		float x = (*it)->x;// - posX
		float y = (*it)->y;// - posY
		float w = (*it)->width;
		float h = (*it)->height;
		
		if(CClib::InsideRect(tx,ty, tw,th, x,y, w,h)){
			*xx = x;
			*yy = y;
			
			return type;
		}
	}
	
	return BLOCK_TILES_SIZE;
}

int Stage::BlockType(float tx, float ty, float *xx, float *yy)
{
	std::list<ObjRect*>::iterator it = pfLayers[LAYER_TERRAIN]->data.begin();
	std::list<ObjRect*>::iterator itEnd = pfLayers[LAYER_TERRAIN]->data.end();
	for (; it != itEnd; ++it)
	{
		int type = (*it)->objId;
		float x = (*it)->x;// - posX
		float y = (*it)->y;// - posY
		float w = (*it)->width;
		float h = (*it)->height;
		
		if (CClib::InsideRange(tx, ty, x, y, w, h))
		{
			*xx = x;
			*yy = y;
			
			return type;
		}
	}
	
	return BLOCK_TILES_SIZE;
}

int Stage::BlockParall(float tx, float ty, float v, float *yy, int _type)
{
	float ret = FLT_MAX;
	
	std::list<ObjRect*>::iterator it = pfLayers[LAYER_TERRAIN]->data.begin();
	std::list<ObjRect*>::iterator itEnd = pfLayers[LAYER_TERRAIN]->data.end();
	
	for (; it != itEnd; ++it)
	{
		int type = (*it)->objId;
		float x = (*it)->x;// - posX
		float y = (*it)->y;// - posY
		float w = (*it)->width;
		float h = (*it)->height;
		
		if(_type!= BLOCK_TILES_SIZE &&_type!=type) continue;
		
		if(type==BLOCK_LINES_CLIMB) {
			ret =CClib::InsideParall(-25,v, tx, ty, x,y, w,h);
		}
		else if(type==BLOCK_LINES_SLIDE) {
			ret =CClib::InsideParall(25,v, tx, ty, x,y, w,h);
		}
		
		if(ret ==FLT_MAX) continue;
		
		//*xx = x;
		*yy = ret;
		return type;
	}
	
	return BLOCK_TILES_SIZE;
}

bool Stage::BlockSwing(float tx, float ty, float tw, float th, float *xx, float *yy)
{
	std::list<ObjRect*>::iterator it = pfLayers[LAYER_TERRAIN]->data.begin();
	std::list<ObjRect*>::iterator itEnd = pfLayers[LAYER_TERRAIN]->data.end();
	for (; it != itEnd; ++it)
	{
		int type = (*it)->objId;
		float x = (*it)->x;// - posX
		float y = (*it)->y;// - posY
		float w = (*it)->width;
		float h = (*it)->height;
		
		if(type != BLOCK_POLE_SWING) continue;
		
		if(CClib::InsideRect(tx,ty, tw,th, x,y, w,h)){
			*xx = x+(w/2);
			*yy = y+(h/2);
			
			return true;
		}
	}
	
	return false;
}

void Stage::CheckGettingCoin(float tx, float ty, int tw, int th)
{
	std::list<ObjRect*>::iterator it = pfLayers[LAYER_TREASURE]->data.begin();
	std::list<ObjRect*>::iterator itEnd = pfLayers[LAYER_TREASURE]->data.end();
	for (; it != itEnd; ++it)
	{
		if (!(*it)->isActive()) 
		{
			continue;
		}
		
		float x = (*it)->x;// - posX
		float y = (*it)->y;// - posY
		float w = (*it)->width;
		float h = (*it)->height;
		
		if (!CClib::InsideRect(tx,ty, tw,th, x,y, w,h))		// 32 is ...
		{
			continue;
		}
		
		int score = 10;
        int type = (*it)->objId;
		
        if (type == 24)	// light(halo)
		{
			continue;
		}
		else if (type >= 200)	// introductions
		{
			continue;
		}
		else if (type < (MAX_ITEM+1))
		{
			score = 100;
			score *=mFastLevel+1;
			
			mGetScore +=score;
            
#ifdef V_1_1_0
            if (!(mObjFlag[0]) && (type == 0))
            {
                g_nGameState = GAME_STATE_TIPS;
                SwitchGameState();
            }
#endif
            
			//if (type!=24) 
            {
                setProps(type);
            }

			playSE(SE_RUNNER_GET_ITEM);
		}
		else
		{
			score = 1;
			score *=mFastLevel+1;
			
			mGetScore +=score;
			
			++mGetCoin;
			playSE(SE_RUNNER_MONEY);
#ifdef ENABLE_ACHIEVEMENTS
			AchCollectCoin();
#endif
		}

//		(*it)->setActive(false);
		
#define PLAYER_SHIFT_X			45
#define	PLAYER_SHIFT_Y			80
		(*it)->moveTo(GetPlayerX() - PLAYER_SHIFT_X -mScrollWorld, GetPlayerY() - PLAYER_SHIFT_Y, 10.0f, 8.0f);
		
		char str[8] = {0};
		sprintf(str, "+%d", score);
		if (score < 100)
		{
			makeInfoTag(GetPlayerX() - PLAYER_SHIFT_X -mScrollWorld, (GetPlayerY() - PLAYER_SHIFT_Y), str);
		}
		else
		{
			makeInfoTag(GetPlayerX() - PLAYER_SHIFT_X -mScrollWorld, (GetPlayerY() - PLAYER_SHIFT_Y), str, 1.0f, 0.0f, 0.0f);
		}

		makeCollectingEffect(EFFECT_COLLECTING_MONEY, mEffect1, GetPlayerX() - PLAYER_SHIFT_X - mScrollWorld - 24, (GetPlayerY() - PLAYER_SHIFT_Y) + 28);
		break;
	}
}

int Stage::CheckZombie(int type, float tx, float ty, int th)
{
	static float RangeAttack[ZOMBIE_TYPE_MAX] = {
		RANGE_ATTACK_NORMAL,
		RANGE_ATTACK_HIPPIE,
		RANGE_ATTACK_WATER,
		RANGE_ATTACK_WHEEL,
		RANGE_ATTACK_BOSS,
	};
	
	std::list<ObjRect*>::iterator it = pfLayers[LAYER_ZOMBIE]->data.begin();
	std::list<ObjRect*>::iterator itEnd = pfLayers[LAYER_ZOMBIE]->data.end();
	
	for (; it != itEnd; ++it)
	{
		if (!(*it)->isActive())
		{
			continue;
		}
		
		int id = (*it)->objId;
		float x = (*it)->x;
		float y = (*it)->y;
		
		Opponent *opp = (Opponent *)((*it)->userData);
		if(opp->GetAction() == ZOMBIE_STATE_ATTACK) continue;
		
		int w = opp->mW;
		int h = opp->mH;
		int sx = opp->mSX;
		int sy = opp->mSY;
		
		int d = x+sx+w/2 - tx;
		
		if(type == CHECK_TYPE_HURT)
		{
			float tw = PLAYER_SHIFT_W;
			
			if (!CClib::InsideRect(tx,ty, tw,th-10, x+sx,y+sy - h, w,h))//-10
			{
				continue;
			}
			
			return id;
		}
		
		if(type == CHECK_TYPE_WATER)
		{
			float tw = PLAYER_SHIFT_W *2;
			
			if (!CClib::InsideRect(tx,ty, tw,th-10, x+sx,y+sy - h, w,h))//-10
			{
				continue;
			}
			
			if(id == ZOMBIE_TYPE_WATER){
#ifdef ENABLE_ACHIEVEMENTS
				AchKillZombie();
#endif
				opp->SetAttack();
			}
			
			return id;
		}
		
		if(type == CHECK_TYPE_ATTACK)
		{
			if(opp->GetAction() == ZOMBIE_STATE_FALL) continue;//fall
			
			float r = RangeAttack[id];
			float tw = r;
			
			if (!CClib::InsideRect(tx,ty, tw,th-10, x+sx,y+sy - h, w,h))//-10
			{
				 continue;
			}
			
			if(id == ZOMBIE_TYPE_WATER){
				if(d < VALID_ATTACK_WATER){//r -VALID_ATTACK_SHIFT
					continue;
				}
			}
			else {
#ifdef ENABLE_ACHIEVEMENTS
				AchKillZombie();
#endif
			}

			opp->SetAttack();
			return id;
		}
		
		if(type == CHECK_TYPE_TOUCH)
		{
			if(opp->GetAction() == ZOMBIE_STATE_FALL) continue;//fall
			
			float r = RangeAttack[id] +VALID_ATTACK_LEFT;
			float tw = r;
			
			if (!CClib::InsideRect(tx,ty, tw,th-10, x+sx,y+sy - h, w,h))//-10
			{
				continue;
			}
			
			if(id == ZOMBIE_TYPE_WATER){
				if(d < VALID_ATTACK_WATER){
					continue;
				}
			}
			return id;
		}
	}
	
	return ZOMBIE_TYPE_MAX;
}
