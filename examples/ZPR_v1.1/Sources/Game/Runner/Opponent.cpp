//
//  Opponent.cpp
//  ZPR
//
//  Created by futao.huang on 11-7-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Opponent.h"
#import "Runner.h"
#import "Stage.h"
#import "GameState.h"
#include "GameRes.h"
#import "GameOver.h"

#import "neoRes.h"
#import "sprite.h"
#import "Image.h"
#import "Canvas2D.h"
#import "GameAudio.h"

//#include "GameRes.h"

int Opponent::classId = 0;

Opponent::Opponent(int type, float x, float y)
	:mType(type), mX(x), mY(y), mOrgX(x), mOrgY(y), shadowImage(NULL)
{
	char filename[16] = {0};
	memset(filename, '\0', sizeof(filename));
	sprintf(filename, "z%d.xml", type);
	mSprite = new Sprite();
//	NeoRes* neoRes = NeoRes::getInstance();
	if(mType == ZOMBIE_TYPE_WATER ||mType == ZOMBIE_TYPE_WHEEL ||mType == ZOMBIE_TYPE_BOSS){
		g_GcResMgr->createSprite(mSprite, filename, NULL/*, IMG_RES_SCALE*/);///1.0
	}else {
		g_GcResMgr->createSprite(mSprite, filename, NULL, 1.0f, IMG_RES_SCALE/*, IMG_RES_SCALE*/);///1.0
	}

	
#if 0//DEBUG
	mSprite->dbgDrawFrame = true;
#endif
	
//	mSprite->setFlip(true, -1);
	mSprite->setCurrentAction(0);
	mSprite->startAction();
	
	//debug
	static int ZDimention[ZOMBIE_TYPE_MAX][4] = {
		{22,0,30,25},
		{22 +30,0,26,35},
		{40,0,35,60},
		{32,0,32,45},
		{40,0,30,55},
	};
	
	mSX = ZDimention[type][0];
	mSY = ZDimention[type][1];
	mW = ZDimention[type][2];
	mH = ZDimention[type][3];
	mAttack = false;
	mWait = 0;
	mSound = false;
	mLand = false;
	
	// setup shadow mSprite
	g_GcResMgr->loadRes("shadow_res.xml", NULL, IMG_RES_SCALE);
	shadowImage = g_GcResMgr->getImage("p1_b4");
	
	
	count = 0;
	timer = 0.0f;
	alpha = 1.0f;
	setHintDuration(1000.0f);
	setHintInterval(1000.0f);
}

Opponent::~Opponent()
{
	if (mSprite)
	{
//		mSprite->release();
		delete mSprite;
		mSprite = NULL;
	}
}

void Opponent::initialize()
{
	//reset();
}

void Opponent::destroy()
{
}

void Opponent::reset()
{
	mSound = false;
	mLand = false;
	
	mX = mOrgX;
	mY = mOrgY;
	
	SetAction(ZOMBIE_STATE_STAND);
	
	mAttack = false;
	mWait = 0;
	
	count = 0;
	timer = 0.0f;
	alpha = 1.0f;
	
	setHintDuration(1000.0f);
	setHintInterval(1000.0f);
}

int Opponent::getType()
{
	return mType;
}

float Opponent::getX()
{
	return mX;
}
float Opponent::getY()
{
	return mY;
}

void Opponent::SetAction(int action)
{
	//NSLog(@"SetPlayerAction: %d.",action);
	mAction = action;
	mTimer = 0;
	
	if(ZOMBIE_STATE_WATER == mAction) {
		mOffY = mY;
		mLand = false;
	}
	
	//debug
	static int ZAction[ZOMBIE_TYPE_MAX][ZOMBIE_STATE_MAX] = {
		{0,-1,-1,1, 0,0,},
		{0,-1,-1,1, 0,2,},
		{0,-1,1,2, 0,0,},
		{0,1,-1,2, 0,0,},
		{0,1,-1,2, 0,0,},
	};
	int act = ZAction[mType][action];
	
	mSprite->setCurrentAction(act);
	mSprite->startAction();
}

int Opponent::GetAction()
{
	return mAction;
}

void Opponent::SetAttack()
{
	if(mType ==ZOMBIE_TYPE_WATER && mAction ==ZOMBIE_STATE_STAND)
	{
		SetAction(ZOMBIE_STATE_WATER);
		return;
	}
	
	//debug
	static int ZCount[ZOMBIE_TYPE_MAX] = {
		10,
		10,
		10,
		20,
		10,
	};
	int count = ZCount[mType];
	mWait = count;
	mAttack = true;
}

void Opponent::update(float dt)
{
	if(GetPlayerAction() == PLAYER_STATE_STAND)return;
	
	mSprite->update(dt);
	updateHintTime(dt);
	
	if(!mSound)
	{
		if(mType == ZOMBIE_TYPE_WHEEL){
			playSE(SE_ZOMBIE_MOAN3);
		}else if(mType == ZOMBIE_TYPE_NORMAL){
			playSE(SE_ZOMBIE_MOAN1);
		}else if(mType == ZOMBIE_TYPE_BOSS){
			playSE(SE_ZOMBIE_MOAN5);
		}else if(mType == ZOMBIE_TYPE_WATER){
			playSE(SE_ZOMBIE_MOAN4);
		}else if(mType == ZOMBIE_TYPE_HIPPIE){
			playSE(SE_ZOMBIE_MOAN2);
		}
		mSound = true;
	}
	
	if(mAttack)
	{
		mWait--;
		if(mWait <= 0){
			mAttack = false;
			mWait = 0;
			
			SetAction(ZOMBIE_STATE_ATTACK);
			
			if(mType == ZOMBIE_TYPE_WHEEL){
//				playSE(SE_ZOMBIE_DEATH3);
				playSE(SE_ZOMBIE_DODGE3);
			}else if(mType == ZOMBIE_TYPE_NORMAL){
//				playSE(SE_ZOMBIE_DEATH1);
				playSE(SE_ZOMBIE_DODGE1);
			}else if(mType == ZOMBIE_TYPE_BOSS){
//				playSE(SE_ZOMBIE_DEATH5);
				playSE(SE_ZOMBIE_DODGE5);
			}else if(mType == ZOMBIE_TYPE_WATER){
//				playSE(SE_ZOMBIE_DEATH4);
				playSE(SE_ZOMBIE_DODGE4);
			}else if(mType == ZOMBIE_TYPE_HIPPIE){
//				playSE(SE_ZOMBIE_DEATH2);
				playSE(SE_ZOMBIE_DODGE2);
			}
		}
	}
	
	switch (mAction) {
		case ZOMBIE_STATE_STAND:
		{
			switch (mType) {
				case ZOMBIE_TYPE_WATER:
				{
					float xx = mX+mSX +(mW/2);
					float tx = GetPlayerX() -PLAYER_SHIFT_W;
					
					if(xx-tx < VALID_ATTACK_WATER+16){
						SetAction(ZOMBIE_STATE_WATER);
					}
				}
					break;
				case ZOMBIE_TYPE_HIPPIE:
				{
					float xx = mX+mSX +(mW/2);
					float tx = GetPlayerX() -PLAYER_SHIFT_W;
					
					float action = GetPlayerAction();
					float yy = mY+mSY -mH;
					float ty = GetPlayerY();
					
					if(action == PLAYER_ATTAC_HIPPIE) break;
					
					if(xx-tx < VALID_ATTACK_HIPPIE+16 && xx > tx && ty > yy && ty <= mY ){
						SetAction(ZOMBIE_STATE_HIPPIE);
						mOverType = 2;
						SetFailState();
					}
				}
					break;
				case ZOMBIE_TYPE_WHEEL:
				case ZOMBIE_TYPE_BOSS:
					SetAction(ZOMBIE_STATE_RUN);
					break;
				default:
					break;
			}
		}
			break;
		case ZOMBIE_STATE_RUN:
		{
			float v = PTM_RATIO*ZOMBIE_RUN_SPEED*dt/1000;
			mX -= v;
			
			float xx = mX+mSX +(mW/2);
			float yy = mY;
			
			int t = IsBlockLand(xx, yy+1, &xx,&yy);
			if(t == BLOCK_TILES_SIZE)
			{
				SetAction(ZOMBIE_STATE_FALL);
			}
		}
			break;
		case ZOMBIE_STATE_WATER:
		{
			float v = PTM_RATIO*ZOMBIE_JUMP_SPEED*dt/1000;
			
			int index = mSprite->getCurrentFrameIndex();
			if(index >=10 && index <20){
				float dy = index *ZOMBIE_VSP_SPEED;
				mY = mOffY -dy;
			}else if(index >=20){
				mY += ZOMBIE_VSP_SPEED;
				if(mY >mOffY){
					mY = mOffY;
					
					if (!mLand) {
						mLand = true;
						playSE(SE_ZOMBIE_SPLAT4);//land
						
						float xx = mX+mSX;
						float yy = mY;
						stages->makeCollectingEffect(EFFECT_ATTACK_ZOMBIE2, mEffect4, 
													 xx, yy);
					}
				}
			}
			
			bool last =mSprite->isLastMoveInAction();
			if(last){
				mTimer +=dt;
				if(mTimer <ZOMBIE_TIMER_IDLE){
					break;
				}
				
				SetAction(ZOMBIE_STATE_STAND);
			}else {
				mX -= v;
			}

		}
			break;
		case ZOMBIE_STATE_ATTACK:
		{	
			if(mType == ZOMBIE_TYPE_WATER){
				mY += ZOMBIE_VSP_SPEED;
				if(mY >mOffY){
					mY = mOffY;
					
					if (!mLand) {
						mLand = true;
						playSE(SE_ZOMBIE_SPLAT4);//land
						
						float xx = mX+mSX;
						float yy = mY;
						stages->makeCollectingEffect(EFFECT_ATTACK_ZOMBIE2, mEffect4, 
													 xx, yy);
					}
				}
			}
		}
			break;
		case ZOMBIE_STATE_FALL:
		{
			mY +=ZOMBIE_VSP_SPEED;
			
			float xx = mX+mSX +(mW/2);
			float yy = mY;
			
			int tile = IsBlockLand(xx, yy+1, &xx,&yy);
			if(tile != BLOCK_TILES_SIZE)
			{
				mY = yy;
				SetAction(ZOMBIE_STATE_STAND);
			}
		}
			break;
		default:
			break;
	}
	
}

void Opponent::render(float dt, float _posX, float _posY)
{	
	static float RangeAttack[ZOMBIE_TYPE_MAX] = {
		RANGE_ATTACK_NORMAL,
		RANGE_ATTACK_HIPPIE,
		RANGE_ATTACK_WATER,
		RANGE_ATTACK_WHEEL,
		RANGE_ATTACK_BOSS,
	};

	if(mType == ZOMBIE_TYPE_WATER ||mType == ZOMBIE_TYPE_WHEEL ||mType == ZOMBIE_TYPE_BOSS){
		mSprite->render(_posX, _posY, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	}else {
		mSprite->render(_posX, _posY, 0.0f, GLOBAL_CANVAS_SCALE, 1.0f);
	}
	
	if (shadowImage) 
	{
		float r = RangeAttack[mType];
		float d = r -mSX;
		
		Canvas2D* canvas = Canvas2D::getInstance();
		
		if(mType == ZOMBIE_TYPE_WATER)
		{	
			if(mAction == ZOMBIE_STATE_WATER) {
				int index = mSprite->getCurrentFrameIndex();
				if(index >= 5) {
					//shadowImage->SetColor(1, 1, 1, 1);
					canvas->drawImage(shadowImage, _posX -16, _posY - 48 -16, 0, 1, 1); //NEEDFIX: don't use the const code
				}
			}else {
				canvas->drawImage(shadowImage, _posX -d, _posY - 48, 0, 1, 1); //NEEDFIX: don't use the const code
			}
		}else {
			canvas->enableColorPointer(true);
			shadowImage->SetColor(1, 1, 1, (float)(alpha / (interval / 3.0f)));
			canvas->drawImage(shadowImage, _posX -d, _posY - 48, 0, 1, 1); //NEEDFIX: don't use the const code
			canvas->enableColorPointer(false);
		}
	}
	
#if DEBUG
	Canvas2D* canvas = Canvas2D::getInstance();
	canvas->setColor(0.0f, 1.0f, 0.0f, 1.0f);
	canvas->strokeRect(_posX+mSX,_posY+mSY-mH, mW,mH);
	canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
	canvas->flush();
#endif
}

void Opponent::updateHintTime(float dt)
{
	if (count > 0)
	{
		if (timer >= 0.0f && timer < (float)(interval / 3.0f))
		{
			timer += dt;
			alpha += dt;
			//printf("%d\tflash start: %f, %f\n", objId, timer, (float)(timer / interval));
		}
		else if (timer >= (interval / 3.0f) && timer < (float)(interval / 3.0f * 2.0f))
		{
			timer += dt;
			alpha = (float)(interval / 3.0f);
			//printf("%d\tno flash: %f, %f\n", objId, timer, (float)(timer / interval));
		}
		else if (timer >= (float)(interval / 3.0f * 2.0f) && timer < interval)
		{
			timer += dt;
			alpha -= dt;
			//printf("%d\tflash end: %f, %f\n", objId, timer, (float)(timer / interval));
		}
		else
		{
			//printf("%d\tflash done------: %d - %f, %f\n", count, objId, timer, (float)(timer / interval));
			--count;
			timer = 0.0f;
			alpha = 0.0f;
		}
	}
}

void Opponent::setHintDuration(float _duration)
{
	duration = _duration;
}

void Opponent::setHintInterval(float _interval)
{
	interval = _interval;
	count = (int)(duration / interval);
}
