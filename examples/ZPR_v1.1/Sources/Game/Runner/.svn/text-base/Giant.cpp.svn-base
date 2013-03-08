//
//  Giant.cpp
//  ZPR
//
//  Created by futao.huang on 11-7-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Giant.h"
#import "Runner.h"

#import "GameAudio.h"
#import "GameRes.h"
#import "Stage.h"

#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"
#import "CCMath.h"
#import <float.h>


Sprite* mGiant;


static float mChaseTime = 0;
static float mIdleTime = 0;
static float mAttacTime = 0;

static int mGiantAction = 0;
float mGiantX = 0;
float mGiantY = 0;

#define CHECK_ROW_SIZE			3
#define CHECK_COL_SIZE			4
static const float mCheckRange[CHECK_ROW_SIZE][CHECK_COL_SIZE]=
{
	{50,50, 120,120},
	{150,32, 64,48},
	{176,125, 64,25},
};

#define GIANT_FRAME_SIZE			(15)
static const int mGaintCollide[GIANT_FRAME_SIZE*4]={
	175,120,80,30,165,80,90,30,155,45,90,30,170,35,90,30,210,75,80,30,195,125,90,30,180,145,90,30,190,150,80,30,190,145,80,30,190,145,80,30,190,145,80,30,180,145,80,30,170,140,80,30,170,140,80,30,175,135,70,30,
};

//=========================================================================
//check
//=========================================================================
float GetGiantX()
{
	return mGiantX;
}

float GetGiantY()
{
	return mGiantY;
}

void SetGiantAction(int action)
{
	//NSLog(@"SetPlayerAction: %d.",action);
	mGiantAction = action;
	
	mGiant->setCurrentAction(action);
	mGiant->startAction();
}

int GetGiantAction()
{
	return mGiantAction;
}

bool CheckGiant(float range)
{
	if(!stages->bChase) return false;
	
	float x = GetPlayerX() -PLAYER_SHIFT_W + cameraX;
	float y = GetPlayerY() -PLAYER_SHIFT_H + cameraY;
	
	for(int i=0;i<CHECK_ROW_SIZE;i++)
	{
		float sx = mCheckRange[i][0] -range;
		float sy = mCheckRange[i][1] -range;
		float w = mCheckRange[i][2] +2*range;
		float h = mCheckRange[i][3] +2*range;
		if (CClib::InsideRect(mGiantX+sx,mGiantY+sy, w,h, x,y, 20,32)) {
			return true;;
		}
	}
	
	if (mGiantAction == GIANT_STATE_ATTAC)
	{
		int index = mGiant->getCurrentFrameIndex();
		if(index < 3) return false;
		
		int sx = mGaintCollide[index*4+0];
		int sy = mGaintCollide[index*4+1];
		int w = mGaintCollide[index*4+2];
		int h = mGaintCollide[index*4+3];
		
		if (CClib::InsideRect(mGiantX+sx,mGiantY+sy, w,h, x,y, 20,32)) {
			return true;;
		}
	}
	
	return false;
}

//=========================================================================
//check
//=========================================================================
void MoveGiant(float dt, float dx)
{
	if(GetPlayerX() >= stages->blockLength- GAME_FIN_AUTO){
		return;
	}
	
	float v = 0.0f;
	
	if(mFastFlag){
		v = PTM_RATIO*PLAYER_RUN_FASTER*dt/1000;//PLAYER_RUN_FASTER;
	}else {
		v = PTM_RATIO*PLAYER_RUN_SPEED*dt/1000;//PLAYER_RUN_SPEED;
	}
	
	if(dx > v+0.1f) {
		dx = (dx-v)*0.9f;
		float t = dx *1000 /PTM_RATIO /GIANT_CHASE_SPEED;
		mChaseTime += t;
		
		mGiantX += v;
	}else {
		mGiantX += dx;
	}

	
	float x = mGiantX -mScrollWorld;
	if(x <GIANT_MIN_DISTANCE)
	{
		mGiantX = GIANT_MIN_DISTANCE+mScrollWorld;
	}
}

void ChaseGiant(bool chase)
{
	float x = stages->startX - GIANT_START_RANGE;
	
	if(chase){
		float x2 = GetPlayerX() - (mGiantX -GIANT_START_OFFX) - GIANT_START_RANGE;
		
		if(x < x2){
			x = x2;
		}
		x = (x-PLAYER_SHIFT_W)/PTM_RATIO /3;
	}else {
		x = -(x-PLAYER_SHIFT_W)/PTM_RATIO /10;
	}

	float t = x/GIANT_CHASE_SPEED *1000;
	mChaseTime += t;
	mIdleTime = 0;
}

void ActionGaint(float dt)
{
	if(GetPlayerAction() == PLAYER_STATE_STAND)return;
	mIdleTime +=dt;
	
	if(mChaseTime > 0){
		mChaseTime -=dt;
		if(mChaseTime < 0) {
			dt +=mChaseTime;
			mChaseTime=0;
		}
		
		float v = PTM_RATIO*GIANT_CHASE_SPEED*dt/1000;
		mGiantX +=v;
	}
	
	if(mIdleTime >GIANT_IDLE_TIME){
		float v = PTM_RATIO*GIANT_EASE_SPEED*dt/1000;
		mGiantX +=v;
	}
	
	float x = mGiantX -mScrollWorld;
	if(x <GIANT_MIN_DISTANCE)
	{
		mGiantX = GIANT_MIN_DISTANCE+mScrollWorld;
	}else if(x >GIANT_MAX_DISTANCE)
	{
		mGiantX = GIANT_MAX_DISTANCE+mScrollWorld;
	}
	
	float y = GetPlayerY() + cameraY -(288-120);
	if(mGiantY > y+PLAYER_SHIFT_Y)//120,448,
	{
		float dy = (y-mGiantY)/10;
		if(dy<-0.5f) dy = -0.5f;
		
		mGiantY +=dy;
		if(mGiantY<0)mGiantY =0;
	}
	else if(mGiantY < y)//120,448,
	{
		float dy = (y-mGiantY)/10;
		if(dy>1.0f) dy = 1.0f;
		
		mGiantY +=dy;
		if(mGiantY>120)mGiantY =120;
	}
}

//=========================================================================
//check
//=========================================================================
void InitializeGiant()
{
	mChaseTime = 0;
	mIdleTime = 0;
	mAttacTime = 0;
	
	//mGiantX = GIANT_START_OFFX;
	mGiantX = GIANT_START_OFFX +(GetPlayerX()-stages->startX);
	mGiantY = GIANT_START_OFFY;
	
	SetGiantAction(GIANT_STATE_FALLOW);
}

void UpdateGiant(float dt)
{
	if(!stages->bChase) return;
	mGiant->update(dt);
	
	if (mGiantAction == GIANT_STATE_FALLOW) {
		mAttacTime +=dt;
		if((mAttacTime >GIANT_ATTA_TIME &&CheckGiant(GIANT_ATTA_RECT)) 
		   ||mAttacTime >GIANT_IDLE_TIME){
			mAttacTime = 0;
			SetGiantAction(GIANT_STATE_ATTAC);
			
			playSE(SE_SUPER_ZOMBIE_MOAN);//attack
		}
	}
	else if (mGiantAction == GIANT_STATE_ATTAC) {
		bool last = mGiant->isLastMoveInAction();
		if(last){
			SetGiantAction(GIANT_STATE_FALLOW);
		}
	}
	
	ActionGaint(dt);
}

void RenderGiant()
{
	if(!stages->bChase) return;
	
	float x = mGiantX -mScrollWorld;
	float y = mGiantY -0;
	
//	mGiant->render(x, y + SCENE_OFFSET, 0.0f, 1.5f, 1.5f);
	mGiant->render(x, y + SCENE_OFFSET, 
				   0.0f, GLOBAL_CANVAS_SCALE*1.5f, 1.5f);
	
#if DEBUG
	if (mGiantAction != GIANT_STATE_ATTAC) return;
	int index = mGiant->getCurrentFrameIndex();
	
	int sx = mGaintCollide[index*4+0];
	int sy = mGaintCollide[index*4+1];
	int w = mGaintCollide[index*4+2];
	int h = mGaintCollide[index*4+3];
	
	Canvas2D* canvas = Canvas2D::getInstance();
	canvas->setColor(0.0f, 1.0f, 0.0f, 1.0f);
	canvas->strokeRect(mGiantX+sx -mScrollWorld,mGiantY+sy + SCENE_OFFSET, w,h);
	canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
	canvas->flush();
#endif
}

