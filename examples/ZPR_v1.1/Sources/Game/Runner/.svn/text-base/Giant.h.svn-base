//
//  Giant.h
//  ZPR
//
//  Created by futao.huang on 11-7-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef __GIANT_H__
#define __GIANT_H__

//=========================================================================
//setting
//=========================================================================
#define GIANT_START_OFFX			-185.0f
#define GIANT_START_OFFY			120.0f
#define GIANT_START_RANGE			60.0f

#define GIANT_CHASE_SPEED			1.5f
#define GIANT_EASE_SPEED			0.003f
#define GIANT_MIN_DISTANCE			(GIANT_START_OFFX-160)//screen width half
#define GIANT_MAX_DISTANCE			(160)//screen width half

#define GIANT_IDLE_TIME			10000.0f
#define GIANT_ATTA_TIME			1000.0f
#define GIANT_ATTA_RECT			64.0f

//=========================================================================
//state
//=========================================================================
#define GIANT_STATE_SIZE			(2)
#define GIANT_STATE_FALLOW			(0)
#define GIANT_STATE_ATTAC			(1)

//=========================================================================
//varia
//=========================================================================
//class Image;
//extern Image* mGiant;
class Sprite;
extern Sprite* mGiant;
extern float mGiantX;
extern float mGiantY;

void InitializeGiant();
void UpdateGiant(float dt);
void RenderGiant();

float GetGiantX();
float GetGiantY();
void SetGiantAction(int action);
int GetGiantAction();
bool CheckGiant(float range);

void MoveGiant(float dt, float dx);
void ChaseGiant(bool chase);

#endif //__GIANT_H__
