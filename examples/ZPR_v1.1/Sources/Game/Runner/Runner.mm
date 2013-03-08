//
//  Sprite.cpp
//  ZPR
//
//  Created by futao.huang on 11-7-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Runner.h"
#import "Giant.h"
#import "Opponent.h"

#import "GameAudio.h"
#import "GameState.h"
#import "GamePlay.h"
#import "GameOver.h"
#import "GameRes.h"
#import "Stage.h"
#import "GameSection.h"
#import "GameLevel.h"
#import "GameAchieve.h"

#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"
#import "Utilities.h"
#import <math.h>

#ifdef _AD_ADCOLONY_EMBEDDED_
#import "ZPRAppDelegate.h"
#endif

#ifdef __IN_APP_PURCHASE__
#import "GamePlay.h"
#endif

#ifdef __IN_APP_PURCHASE__
#import "Level.h"
#import "LevelBlock.h"
#import "GameRunnerMode.h"
#endif


static int AttackState[ZOMBIE_TYPE_MAX] = {//action state
	PLAYER_ATTAC_NORM,
	PLAYER_ATTAC_HIPPIE,
	PLAYER_ATTAC_WATER,
	PLAYER_ATTAC_RUN,
	PLAYER_ATTAC_BIG,
};

static float AttackEffect[ZOMBIE_TYPE_MAX][4] = {//frame,sx,sy
	{9,0,-25, CAMERA_WHEEL_SPEED},//PLAYER_ATTAC_WHEEL
	{10,0,-20, CAMERA_WHEEL_SPEED},//PLAYER_ATTAC_NORM
	{10,5,-20, CAMERA_WHEEL_SPEED},//PLAYER_ATTAC_BIG
	{2,5,0, CAMERA_WHEEL_SPEED},//PLAYER_ATTAC_WATER
	{15,0,-40, CAMERA_WHEEL_SPEED},//PLAYER_ATTAC_HIPPIE
};

static float AttackOffset[ZOMBIE_TYPE_MAX][32*2] = {//x,y
	//PLAYER_ATTAC_WHEEL
	{0,-3,5,-6,10,-9,15,-12,20,-15,25,-18,30,-21,37,-24,39,-24,41,-24,43,-24,45,-24,47,-24,49,-24,51,-24,53,-24,55,-24,57,-24,59,-24,61,-24,63,-24,65,-24,67,-24,69,-24,71,-24,73,-24,89,-15,91,-12,101,0,101,0,},
	//PLAYER_ATTAC_NORM
	{0,0,1,0,3,-1,4,-2,6,-2,8,-3,9,-4,11,-4,12,-5,14,-6,21,-10,26,-12,30,-13,34,-15,39,-17,43,-18,47,-20,52,-22,55,-27,58,-28,61,-30,64,-32,75,-28,79,-23,87,-19,89,-14,88,-10,91,-5,96,0,103,0,110,0,118,0,},
	//PLAYER_ATTAC_BIG
	{0,0,2,-4,4,-8,6,-12,8,-16,10,-20,12,-24,14,-28,16,-32,18,-36,20,-40,22,-44,24,-48,26,-52,28,-56,30,-60,32,-64,41,-72,48,-62,55,-52,62,-42,69,-32,76,-22,83,-12,91,0,},
	//PLAYER_ATTAC_WATER
	{0,0,3,-3,6,-6,9,-9,12,-12,15,-15,18,-18,21,-21,24,-24,27,-27,30,-30,33,-33,38,-46,38,-46,38,-46,38,-46,38,-46,},
	//PLAYER_ATTAC_HIPPIE
	{0,0,7,0,15,0,23,0,30,0,38,0,46,0,54,0,57,0,60,0,64,0,67,0,70,0,74,0,77,0,80,0,84,0,87,0,90,0,94,0,97,0,100,0,104,0,107,0,111,0,},
};

Sprite* mPlayer;
float mScrollWorld = 0;
static float mScrollFlag = 0;

static bool mWalkFlag = false;
static bool mFailFlag = false;
static bool mSuccFlag = false;
static bool mEndFlag = false;

static bool mFallFlag = false;
static float mJumpCount = 0;
static float mFallCount = 0;
static float mTapCount = 0;
static float mUseCount = 0;
static float mTempC = 0;
static float mTempG = 0;
static float mTempG2 = 0;

static int mPlayerAction = 0;
static float mPlayerX = 0;
static float mPlayerY = 0;
static float mPlayerOrgX = 0;
static float mPlayerOrgY = 0;

float cameraX = 0.0f;
float cameraY = 0.0f;
float cameraYMax = 0.0f;
float defaultCameraY = 0.0f;
float mStepCam = 0;

//=========================================================================
//shadow
//=========================================================================
static bool mShadowShow = false;
static int mShadowCount = 0;

#define PLAYER_SHADOW_SIZE			6
static float mShadowArray[PLAYER_SHADOW_SIZE][3] ={0};
static float mShadowColor[PLAYER_SHADOW_SIZE][4] ={0};

int mActionCount = 0;
int mFastLevel = 0;
bool mFastFlag = false;


float ColorShadow[4][4]={
	{0.5f,0.9f,0.5f,0.9f},
	{0.5f,0.5f,0.9f,0.9f},
	{0.9f,0.9f,0.5f,0.9f},
	{0.9f,0.5f,0.5f,0.9f},
};

void InitShadow()
{
	mShadowShow = false;
	mShadowCount = 0;
}

void DisableShadow()
{
#ifdef __IN_APP_PURCHASE__
    setSpeedMeter(-1);
#endif
	//mShadowShow = false;
	mShadowCount = PLAYER_SHADOW_SIZE;
	
	mActionCount = 0;
	mFastLevel = 0;
	mFastFlag = false;
}

void ResetShadow()
{
	if(!mFastFlag) return;
	for (int i=0;i<PLAYER_SHADOW_SIZE;i++) 
	{
#if 0	
		mShadowColor[i][0] = 0.3f+(0.2*mFastLevel) - 0.2f*i/PLAYER_SHADOW_SIZE;
		mShadowColor[i][1] = 0.3f+(0.2*mFastLevel) - 0.2f*i/PLAYER_SHADOW_SIZE;
		mShadowColor[i][2] = 1.0f-(0.3*mFastLevel);
		mShadowColor[i][3] = 1.0f - (0.2f + 0.8f*i/PLAYER_SHADOW_SIZE);
#else
		float r = ColorShadow[mFastLevel][0];
		float g = ColorShadow[mFastLevel][1];
		float b = ColorShadow[mFastLevel][2];
		float a = ColorShadow[mFastLevel][3];
		
		if(mFastLevel == 1){
			mShadowColor[i][0] = r - 0.2f*i/PLAYER_SHADOW_SIZE;
			mShadowColor[i][1] = g - 0.2f*i/PLAYER_SHADOW_SIZE;
			mShadowColor[i][2] = b;
			mShadowColor[i][3] = a - ( 0.8f*i/PLAYER_SHADOW_SIZE);
		}else if(mFastLevel == 2){
			mShadowColor[i][0] = r;
			mShadowColor[i][1] = g;
			mShadowColor[i][2] = b - 0.2f*i/PLAYER_SHADOW_SIZE;
			mShadowColor[i][3] = a - (0.8f*i/PLAYER_SHADOW_SIZE);
		}else if(mFastLevel == 3){
			mShadowColor[i][0] = r;
			mShadowColor[i][1] = g - 0.2f*i/PLAYER_SHADOW_SIZE;
			mShadowColor[i][2] = b - 0.2f*i/PLAYER_SHADOW_SIZE;
			mShadowColor[i][3] = a - (0.8f*i/PLAYER_SHADOW_SIZE);
		}
#endif
	}
	
	if(mShadowShow) return;
	for (int i=0;i<PLAYER_SHADOW_SIZE;i++) 
	{
		mShadowArray[i][0] = mPlayerX;
		mShadowArray[i][1] = mPlayerY;
		
		int frameIndex = mPlayer->getCurrentActionStart() + mPlayer->getCurrentFrameIndex();
		mShadowArray[i][2] = frameIndex;
	}
	
	mShadowShow = true;
	mShadowCount = 0;
}

void UpdateShadow()
{
	if(!mShadowShow) return;
	
	for (int i=PLAYER_SHADOW_SIZE-1;i>0;i--) 
	{
		mShadowArray[i][0] = mShadowArray[i-1][0];
		mShadowArray[i][1] = mShadowArray[i-1][1];
		mShadowArray[i][2] = mShadowArray[i-1][2];
	}
	
	mShadowArray[0][0] = mPlayerX;
	mShadowArray[0][1] = mPlayerY;
	
	int frameIndex = mPlayer->getCurrentActionStart() + mPlayer->getCurrentFrameIndex();
	mShadowArray[0][2] = frameIndex;
	
	if(mShadowCount>0)
	{
		mShadowCount --;
		if(mShadowCount <=0){
			mShadowShow = false;
		}
	}
}

void RenderShadow()
{
	if(!mShadowShow) return;
	
	Canvas2D* canvas = Canvas2D::getInstance();
	//int frameIndex = mPlayer->getCurrentActionStart() + mPlayer->getCurrentFrameIndex();
	//mPlayer->render(x, y, 0.0f, 1.0f, 1.0f);
	
	canvas->enableColorPointer(true);
	for (int i=PLAYER_SHADOW_SIZE-1;i>=0;i--) 
	{
		float x =mShadowArray[i][0] -PLAYER_SHIFT_X -mScrollWorld + cameraX;
		float y =mShadowArray[i][1] -PLAYER_SHIFT_Y + cameraY;
		int index = mShadowArray[i][2];
		
		float r = mShadowColor[i][0];
		float g = mShadowColor[i][1];
		float b = mShadowColor[i][2];
		float a = mShadowColor[i][3];
		
		mPlayer->mFrames[index].mImage->SetColor(r, g, b, a);
//		canvas->enableColorPointer(true);
		canvas->drawImage(mPlayer->mFrames[index].mImage, x, y + SCENE_OFFSET, 0.0f, GLOBAL_CANVAS_SCALE, 1.0f);
//		canvas->enableColorPointer(false);
		mPlayer->mFrames[index].mImage->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
	}
	canvas->enableColorPointer(false);
}


bool mRunnerMode[LEVEL_NUM_MAX][STAGE_IN_LV_MAX] = {
	{false,false,false,false,false,false,false,false,false,false,false,false},
	{false,false,false,false,false,false,false,false,false,false,false,false},
	{false,false,false,false,false,false,false,false,false,false,false,false},
#ifdef V_1_1_0
    {false,false,false,false,false,false,false,false,false,false,false,false}
#endif

};

bool isRunnerMode()
{
	for (int i=0; i<LEVEL_NUM_MAX; i++) {
		for (int j=0; j<STAGE_IN_LV_MAX; j++) {
			
			if(i<STAGE_SECTION_V001 && j>=STAGE_LEVEL_V001) continue;
			
			if(!mRunnerMode[i][j]) {
				return false;
			}
		}
	}
	
	return true;
}

void setRunnerMode()
{
	if(!mFastFlag) return;
	mRunnerMode[LevelIndex][ActiveLevel] = true;
}

//=========================================================================
//function
//=========================================================================
void IsValidState(int* state)
{
	if(*state == PLAYER_STATE_RUN
	   || *state == PLAYER_STATE_QUICK
	   || *state == PLAYER_STATE_SCROLL
	   || *state == PLAYER_STATE_CRAWL
	   //|| *state == PLAYER_STATE_STUMB
	   || *state == PLAYER_STATE_WATER
	   
	   || *state == PLAYER_STATE_JUMP
	   //|| *state == PLAYER_STATE_JETE
	   || *state == PLAYER_STATE_JETE2)
	{
		if(mSuccFlag){
			*state= PLAYER_STATE_SUCC;
		}else if(mFailFlag){
			*state= PLAYER_STATE_FAIL;
		}else if(mWalkFlag){
			*state= PLAYER_STATE_WALK;
		}
	}
}

void SetFailState()
{
	if(mFailFlag) return;
	mFailFlag = true;
	DisableShadow();
	
	if(mPlayerAction == PLAYER_STATE_RUN
	   || mPlayerAction == PLAYER_STATE_QUICK
	   || mPlayerAction == PLAYER_STATE_SCROLL
	   || mPlayerAction == PLAYER_STATE_CRAWL
	   //|| mPlayerAction == PLAYER_STATE_STUMB
	   || mPlayerAction == PLAYER_STATE_WATER)
	{
		SetPlayer(PLAYER_STATE_FAIL);
	}
	
	if(mPlayerAction == PLAYER_STATE_JUMP
	   //|| mPlayerAction == PLAYER_RINGS_FALL
	   || mPlayerAction == PLAYER_STATE_FALL
	   || mPlayerAction == PLAYER_BOARD_FALL)
	{
		SetPlayer(PLAYER_STATE_DROP);
	}
}

void SetSuccState()
{
	if(mSuccFlag) return;
	mSuccFlag = true;
	
	if(mPlayerAction == PLAYER_STATE_RUN
	   || mPlayerAction == PLAYER_STATE_QUICK
	   || mPlayerAction == PLAYER_STATE_SCROLL
	   || mPlayerAction == PLAYER_STATE_CRAWL
	   //|| mPlayerAction == PLAYER_STATE_STUMB
	   || mPlayerAction == PLAYER_STATE_WATER)
	{
		SetPlayer(PLAYER_STATE_SUCC);
	}
}

void SetWalkState(bool flag)
{
	if(!flag && mWalkFlag){
		mWalkFlag = false;
		
		if(mPlayerAction == PLAYER_STATE_WALK)
		{
			SetPlayer(PLAYER_STATE_SUCC);
		}
		else {
			SetSuccState();
		}
	}
	
	else if(flag && !mWalkFlag){
		mWalkFlag = true;
		
		if(mPlayerAction == PLAYER_STATE_RUN
		   || mPlayerAction == PLAYER_STATE_QUICK
		   || mPlayerAction == PLAYER_STATE_SCROLL
		   || mPlayerAction == PLAYER_STATE_CRAWL
		   //|| mPlayerAction == PLAYER_STATE_STUMB
		   || mPlayerAction == PLAYER_STATE_WATER)
		{
			SetPlayer(PLAYER_STATE_WALK);
		}
		
		if(mPlayerAction == PLAYER_STATE_JUMP)
		{
			SetPlayer(PLAYER_STATE_FALL);
		}
	}
}

bool IsAutoState()
{
	if(mFailFlag ||mSuccFlag ||mWalkFlag){
		return true;
	}
	
	return false;
}

void AddScore(int state)
{
	char strA[32] = {0};
	int score = 0;
	
	if(state ==PLAYER_STATE_PRAN/* ||state ==PLAYER_STATE_PRAN2*/){
		score = 10;
		score *=mFastLevel+1;
		sprintf(strA, "%s +%d", ACTION_VAULT,score);
#ifdef ENABLE_ACHIEVEMENTS
		AchAddActionByType(ACH_STA_KASHVAULT);
#endif
	}else if(state ==PLAYER_STATE_RINGS){
		score = 20;
		score *=mFastLevel+1;
		sprintf(strA, "%s +%d", ACTION_SWING,score);
#ifdef ENABLE_ACHIEVEMENTS
		AchAddActionByType(ACH_STA_SWING);
#endif
	}else if(state == PLAYER_STATE_LIGHT){
		score = 5;
		score *=mFastLevel+1;
		sprintf(strA, "%s +%d", ACTION_MONKEY,score);
#ifdef ENABLE_ACHIEVEMENTS
		AchAddActionByType(ACH_STA_MONKEYBAR);
#endif
	}else if(state == PLAYER_STATE_SLIDE){
		score = 5;
		score *=mFastLevel+1;
		sprintf(strA, "%s +%d", ACTION_SLIDE,score);
#ifdef ENABLE_ACHIEVEMENTS
		AchAddActionByType(ACH_STA_SLIDE);
#endif
	}else if(state == PLAYER_STATE_BOARD){
		score = 10;
		score *=mFastLevel+1;
		sprintf(strA, "%s +%d", ACTION_BOARD,score);
#ifdef ENABLE_ACHIEVEMENTS
		AchAddActionByType(ACH_STA_WALLRUN);
#endif
	}else if(state == PLAYER_LINES_CLIMB ||state == PLAYER_LINES_SLIDE){
		score = 10;
		score *=mFastLevel+1;
		sprintf(strA, "%s +%d", ACTION_LINES,score);
	}
	
	else if(state == PLAYER_ATTAC_RUN){
		score = 50;
		score *=mFastLevel+1;
		sprintf(strA, "%s +%d", ACTION_WHEEL,score);
	}else if(state == PLAYER_ATTAC_NORM){
		score = 30;
		score *=mFastLevel+1;
		sprintf(strA, "%s +%d", ACTION_NORMAL,score);
	}else if(state == PLAYER_ATTAC_BIG){
		score = 90;
		score *=mFastLevel+1;
		sprintf(strA, "%s +%d", ACTION_BIGGER,score);
	}else if(state == PLAYER_ATTAC_WATER){
		score = 70;
		score *=mFastLevel+1;
		sprintf(strA, "%s +%d", ACTION_DIVER,score);
	}else if(state == PLAYER_ATTAC_HIPPIE){
		score = 30;
		score *=mFastLevel+1;
		sprintf(strA, "%s +%d", ACTION_HIPPLE,score);
	}
	
	else if(state == PLAYER_STAND_JUMP
			|| state == PLAYER_STATE_CRAWL
			|| state == PLAYER_STATE_WATER
			//|| state == PLAYER_STATE_STUMB
			//|| state == PLAYER_STATE_JETE
			|| state == PLAYER_STATE_JETE2
			//|| state == PLAYER_STATE_CAT
			//|| state == PLAYER_STATE_DROP
			)
	{
		DisableShadow();
		ChaseGiant(true);
	}else if(state == PLAYER_STATE_DROP)
	{
		//DisableShadow();
		ChaseGiant(true);
	}
	
	if(score != 0){
		int th = PLAYER_SHIFT_H;
		if(state == PLAYER_STATE_SCROLL ||state == PLAYER_STATE_SLIDE/* ||state == PLAYER_STATE_CRAWL*/){
			th = 30;
		}
		
		ChaseGiant(false);
		AchPassObstacle();
		
		mGetScore += score;
		mActionCount++;
		
		if(mActionCount== 9 && mFastLevel<3){
			mFastFlag = true;
			mFastLevel = 3;
			stages->makeCollectingEffect(EFFECT_RUNNER_MODE, mEffect3, 
								 mPlayerX - PLAYER_SHIFT_X - mScrollWorld - 24, mPlayerY - th);
#ifdef ENABLE_ACHIEVEMENTS
			AchAddComboCount();
#endif
#ifdef __IN_APP_PURCHASE__
            setSpeedMeter(mFastLevel);
#endif
			playSE(SE_RUNNER_FASTER_3);//faster
			playSE(SE_RUNNER_RUN_MODE);	// activate runner mode
		}
		else if(mActionCount== 6 && mFastLevel<2){
			mFastFlag = true;
			mFastLevel = 2;
			stages->makeCollectingEffect(EFFECT_RUNNER_MODE, mEffect3, 
								 mPlayerX - PLAYER_SHIFT_X - mScrollWorld - 24, mPlayerY - th);
#ifdef ENABLE_ACHIEVEMENTS
			AchAddComboCount();
#endif
#ifdef __IN_APP_PURCHASE__
            setSpeedMeter(mFastLevel);
#endif
			playSE(SE_RUNNER_FASTER_2);//faster
			playSE(SE_RUNNER_RUN_MODE);	// activate runner mode
		}
		else if(mActionCount== 3 && mFastLevel<1){
			mFastFlag = true;
			mFastLevel = 1;
			stages->makeCollectingEffect(EFFECT_RUNNER_MODE, mEffect3, 
								 mPlayerX - PLAYER_SHIFT_X - mScrollWorld - 24, mPlayerY - th);
#ifdef ENABLE_ACHIEVEMENTS
			AchAddComboCount();
#endif
#ifdef __IN_APP_PURCHASE__
            if (!usingIgRm)
            {
                setSpeedMeter(mFastLevel);
            }
#endif
			playSE(SE_RUNNER_FASTER_1);//faster
			playSE(SE_RUNNER_RUN_MODE);	// activate runner mode
		}
        else if(mActionCount== 0)
        {
#ifdef __IN_APP_PURCHASE__
            setSpeedMeter(-1);
#endif
			mFastFlag = false;
			mFastLevel = 0;
#ifdef ENABLE_ACHIEVEMENTS
			AchAddComboCountTime(0.0f, true);
			AchAddComboCount(true);
#endif
		}
		
		float r = ColorShadow[mFastLevel][0];
		float g = ColorShadow[mFastLevel][1];
		float b = ColorShadow[mFastLevel][2];
		//float a = ColorShadow[mFastLevel][3];
		
		stages->makeActionTag(GetPlayerX() - PLAYER_SHIFT_X - mScrollWorld - 24, (GetPlayerY() - PLAYER_SHIFT_Y) + 28,
							  strA, r, g, b);
		
		ResetShadow();
	}
}

void AddSound(int state)
{
	if (state ==PLAYER_STATE_JUMP)
	{
		int guess = rand() % 4;
		if (guess < 3) {
			playSE(SE_RUNNER_JUMPING);	// jump
		} else {
			playSE(SE_RUNNER_JUMPING_VOICE);	// jump voice
		}
	}
	else if (state ==PLAYER_STATE_SCROLL)
	{
		playSE(SE_RUNNER_ROLLING);//scroll
	}
	else if (state ==PLAYER_STATE_SLIDE)
	{
		playSE(SE_RUNNER_SLIDING);//slide
	}
	else if (state ==PLAYER_STATE_LIGHT)
	{
		playSE(SE_RUNNER_MONKEY_BAR);//light
	}
	else if (state ==PLAYER_LINES_CLIMB)
	{
		playSE(SE_RUNNER_ZIPLINE_UP);//up
	}
	else if (state ==PLAYER_LINES_SLIDE)
	{
		playSE(SE_RUNNER_ZIPLINE_DN);//down
	}
	else if (state ==PLAYER_STATE_PRAN)
	{
		playSE(SE_RUNNER_KASH_VAULT);//v
	}
	else if (state ==PLAYER_STATE_JETE2)
	{
		playSE(SE_RUNNER_KASH_VAULT_F);//f
	}
	else if (state ==PLAYER_STATE_RINGS)
	{
		playSE(SE_RUNNER_SWING);//ring
	}
	else if (state ==PLAYER_STATE_CAT)
	{
		playSE(SE_RUNNER_LANDING);//land
	}
	else if (state ==PLAYER_STATE_SUCC)
	{
		playSE(SE_RUNNER_GAME_SUCC);
		playSE(SE_RUNNER_SUCCESS);//success
	}
	else if (state ==PLAYER_STATE_FAIL)
	{
		playSE(SE_RUNNER_GAME_FAIL);
		playSE(SE_RUNNER_FAILURE);//fail
	}
}

//=========================================================================
//V
//=========================================================================
static float TimeJumpTop(float v)
{
	return v/PTM_GRAVITY;
}

static float TimeJumpHalf(float v)
{
	return v/PTM_GRAVITY/3.0f;
}

static float HeightJump(float v, float t)
{
	return (v*t - PTM_GRAVITY*t*t*0.5f);
}

static float HeightJumpTop(float v)
{
	return (v*v /(PTM_GRAVITY*2));
}

static float VspJump()
{
	if(mFastFlag){
		return PLAYER_VSP_FASTER;
	}else {
		return PLAYER_VSP_SPEED;
	}
}

static float SpeedJump()
{
	if(mFastFlag){
		return PLAYER_JUMP_FASTER;
	}else {
		return PLAYER_JUMP_SPEED;
	}
}

static float SpeedRun()
{
	if(mFastFlag){
		return PLAYER_RUN_FASTER;
	}else {
		return PLAYER_RUN_SPEED;
	}
}

//=========================================================================
//action
//=========================================================================
float GetPlayerX()
{
	return mPlayerX;
}

float GetPlayerY()
{
	return mPlayerY;
}

void SetPlayerAction(int action)
{
	mPlayer->setCurrentAction(action);
	mPlayer->startAction();
}

int GetPlayerAction()
{
	return mPlayerAction;
}

void SetPlayer(int state)
{
	mTapCount = 1000.0f;
	IsValidState(&state);
	mPlayerAction = state;
	
	AddScore(state);
	AddSound(state);
	
	if(PLAYER_STATE_GRAB ==state){
		SetPlayerAction(PLAYER_STATE_JUMP);
	}
	else if(PLAYER_STATE_RUN ==state){
		if(mFastFlag) {
			SetPlayerAction(PLAYER_STATE_QUICK);
			ResetShadow();
		}else {
			SetPlayerAction(PLAYER_STATE_RUN);
		}
	}
	else {
		SetPlayerAction(state);
	}
	
	switch(state){
		default:
			break;
		case PLAYER_STATE_JUMP:
			mPlayerOrgX = mPlayerX;
			mPlayerOrgY = mPlayerY;
			
			mFallFlag = false;
			mJumpCount = 0;
			break;
		case PLAYER_STATE_FALL:
		//case PLAYER_RINGS_FALL:
		case PLAYER_BOARD_FALL:
		case PLAYER_STATE_DROP:
		//case PLAYER_CLIMB_FALL:
		//case PLAYER_LIGHT_FALL:
		//case PLAYER_SLIDE_FALL:
			mPlayerOrgX = mPlayerX;
			mPlayerOrgY = mPlayerY;
			
			mFallFlag = false;
			mFallCount = 0;
			break;
		case PLAYER_STATE_BOARD:
		case PLAYER_STATE_GRAB:
			mPlayerOrgX = mPlayerX;
			mPlayerOrgY = mPlayerY;
			
			mFallFlag = false;
			mUseCount = 0;
			break;
		case PLAYER_STAND_JUMP:
		case PLAYER_LINES_SLIDE:
		case PLAYER_STATE_RINGS2:
			mPlayerOrgX = mPlayerX;
			mPlayerOrgY = mPlayerY;
			
			mUseCount = 0;
			break;
		case PLAYER_STATE_CAT:
		case PLAYER_STATE_PRAN:
		//case PLAYER_STATE_PRAN2:
			mPlayerOrgX = mPlayerX;
			mPlayerOrgY = mPlayerY;
			break;
			
		case PLAYER_ATTAC_RUN:
		case PLAYER_ATTAC_NORM:
		case PLAYER_ATTAC_BIG:
		case PLAYER_ATTAC_WATER:
		case PLAYER_ATTAC_HIPPIE:
			mPlayerOrgX = mPlayerX;
			mPlayerOrgY = mPlayerY;
			break;
			
		case PLAYER_STATE_LIGHT:
		case BLOCK_LINES_CLIMB:
		case BLOCK_LINES_SLIDE:
			mFallFlag = false;
			mFallCount = 0;
			break;
	}
}

float MovePlayer(float dt, float dv, float cam)
{
	float v = 0.0f;
	
	if(dv != 0) {
		v = PTM_RATIO*dv*dt/1000;
		mPlayerX += v;
#ifdef ENABLE_ACHIEVEMENTS
		AchAddRunDistance(v);
#endif
		
		float dv2 = (dv - cam);
		float v2 = PTM_RATIO*dv2*dt/1000;
		mScrollFlag += v2;
	}else if(cam != 0){
		v = PTM_RATIO*cam*dt/1000;
		mScrollFlag -= v;
	}
	
	if(mScrollFlag >CAMERA_MAX_WIDTH){
		mScrollFlag = CAMERA_MAX_WIDTH;
	}else if (mScrollFlag <CAMERA_NIN_WIDTH) {
		mScrollFlag = CAMERA_NIN_WIDTH;
	}
	
	return v;
}

void UpdateWorld(float dt)
{
	float v = PTM_RATIO*CAMERA_ADJUST_SPEED*dt/1000;
	
	if(mScrollFlag >0.1f){
		mScrollFlag -=v;
		if(mScrollFlag <-0.01f) mScrollFlag = 0;
	}else if(mScrollFlag <-0.1f){
		mScrollFlag +=v;
		if(mScrollFlag >0.01f) mScrollFlag = 0;
	}
	
	float x = mPlayerX- (stages->startX +mScrollFlag);
	if(x >= stages->blockLength- GAME_FIN_WIDTH){
		x = stages->blockLength- GAME_FIN_WIDTH;
	}
	mScrollWorld = x;
}

//=========================================================================
//block
//=========================================================================
int IsBlockLand(float tx, float ty, float *xx, float *yy)
{
	int t = stages->BlockRect(tx-PLAYER_SHIFT_W,ty, PLAYER_SHIFT_W*2,8, xx,yy);
	if(t ==BLOCK_FLAT_TERRAIN 
	   || t ==BLOCK_WATER_DELAY|| t ==BLOCK_DEBRIS_HIT
	   || t ==BLOCK_TILE_FENCE
	   || t ==BLOCK_BARBED_WIRE)
	{
		if(ty >*yy+16){//DISTANCE_CAT_LEAP
			return BLOCK_TILES_SIZE;
		}else {
			return t;
		}
	}
	return BLOCK_TILES_SIZE;
}

bool IsBlockCat(float tx, float ty, float *xx, float *yy)
{
	int t = stages->BlockRect(tx,ty-4, PLAYER_SHIFT_W,8, xx,yy);
	if(t ==BLOCK_FLAT_TERRAIN 
	   || t ==BLOCK_WATER_DELAY|| t ==BLOCK_DEBRIS_HIT
	   || t ==BLOCK_TILE_FENCE)
	{
		if(ty >*yy+4 ||ty <*yy-4){
			return false;
		}else {
			return true;
		}
	}
	return false;
}

int IsBlockCollide(float tx, float ty, float *xx, float *yy)
{
	int t = stages->BlockRect(tx,ty, 2,16, xx,yy);
	
	if(t==BLOCK_FLAT_TERRAIN ||t==BLOCK_WATER_DELAY ||t==BLOCK_DEBRIS_HIT
	   ||t==BLOCK_TILE_FENCE
	   ||t==BLOCK_BARBED_WIRE)
	{
		/*if(tx >*xx+DISTANCE_CAT_LEAP){
			return BLOCK_TILES_SIZE;
		}else */{
			return t;
		}
	}
	
	return BLOCK_TILES_SIZE;
}

int IsBlockTop(float tx, float ty, float *xx, float *yy)
{
	int t = stages->BlockRect(tx,ty, 2,16, xx,yy);
	
	if(t==BLOCK_FLAT_TERRAIN ||t==BLOCK_WATER_DELAY ||t==BLOCK_DEBRIS_HIT
	   ||t==BLOCK_BARBED_WIRE) 
	{
		return t;
	}
	
	return BLOCK_TILES_SIZE;
}

bool IsBoardAttach(float x, float y)
{
	int t = stages->BlockType(x,y-5, &x,&y);
	if(t ==BLOCK_BILL_BOARD)
	{
		return true;
	}
	return false;
}

bool IsPoleSwing(bool flag, float x, float y, float w, float h)
{
	int t = stages->BlockRect(x,y, w,h, &x,&y);
	if(t==BLOCK_POLE_SWING){
		if(flag){
			mPlayerX = x+12;
			mPlayerY = y+16 +PLAYER_SHIFT_H;
		}
		return true;
	}
	return false;
}

static bool JumpAction(float x, float y, float s)
{
	float xx,yy;
	float ww = SpeedJump()*TimeJumpTop(VspJump()) *PTM_RATIO;
	float hh = HeightJumpTop(VspJump()) *PTM_RATIO;
	bool swing = stages->BlockSwing(x+32, y -PLAYER_SHIFT_H-hh, ww*s-32, hh+PLAYER_SHIFT_H,&xx,&yy);
	if(!swing) return false;
	
	float w = xx - x -4;
	float h = y-PLAYER_SHIFT_H+16 - yy;
	///if(w<0 || h<0) return false;
	
	float temp = w/PTM_RATIO/SpeedJump();
	float v = h/PTM_RATIO/temp + PTM_GRAVITY*temp*0.5f;
	
	if(v > VspJump()) {
		return false;
	}
	
	mTempG2 = SpeedJump();
	mTempG = v;
	return true;
}

static bool CheckRunAction(float *x, float *y)
{	
	float xx, yy;
	int t;
	
	t = stages->BlockRect(*x, *y+1 -16, DISTANCE_KASH_VAULT +PLAYER_SHIFT_W,8, &xx,&yy);// +PLAYER_SHIFT_W
	if(t ==BLOCK_NEED_CRAWL) {
		return true;
	}
	else if(t ==BLOCK_DEBRIS_HIT) {
		return true;
	}
	
	int type = stages->CheckZombie(CHECK_TYPE_TOUCH, *x, *y-PLAYER_SHIFT_H, PLAYER_SHIFT_H);
	if(type != ZOMBIE_TYPE_MAX){
		return true;
	}
	
	if(JumpAction(*x,*y,2.0f)) {
		SetPlayer(PLAYER_STATE_GRAB);
		return true;
	}
	
	return false;
}

static bool StandAction(float *x, float *y)
{	
	float xx, yy;
	int t;
	
	t = stages->BlockRect(*x, *y+1 -16, PLAYER_SHIFT_W,2, &xx,&yy);
	if(t == BLOCK_TILE_FENCE)
	{
		return true;
	}
	else if(t == BLOCK_BARBED_WIRE)
	{
		mOverType = 0;
		SetPlayer(PLAYER_STATE_FAIL);
		return true;
	}
	else if(t ==BLOCK_FLAT_TERRAIN 
		|| t ==BLOCK_WATER_DELAY|| t ==BLOCK_DEBRIS_HIT)
	{
		// +PLAYER_SHIFT_W
		*x = xx-PLAYER_SHIFT_W*0.5;
		
		bool cat = IsBlockCat(*x, *y+1-32, &xx,&yy);
		if(cat){
			SetPlayer(PLAYER_STATE_CAT);
			if(true){
				DisableShadow();
			}
		}else {
			float h = (*y-yy-DISTANCE_CAT_LEAP)/PTM_RATIO;
			mTempC =sqrtf(2*h*PTM_GRAVITY2);
			SetPlayer(PLAYER_STAND_JUMP);
		}
		
		return true;
	}
	
	return false;
}

//=========================================================================
//check
//=========================================================================
bool DoRunAction(bool check, float *x, float *y)
{
	float xx, yy;
	int t;

	t = stages->BlockRect(*x +PLAYER_SHIFT_W, *y+1 -16, DISTANCE_TIC_TAC +PLAYER_SHIFT_W,8, &xx,&yy);
	if(t ==BLOCK_NEED_CRAWL)
	{
		if(*x +PLAYER_SHIFT_W > xx){
			SetPlayer(PLAYER_STATE_CRAWL);
		}else if(mTapCount<TIME_TOUCH_VALID){
			SetPlayer(PLAYER_STATE_SLIDE);
		}
		return true;
	}else if(t ==BLOCK_DEBRIS_HIT)
	{
		if(*x +PLAYER_SHIFT_W > xx){
			SetPlayer(PLAYER_STATE_JETE2);
		}else if(mTapCount<TIME_TOUCH_VALID){
			SetPlayer(PLAYER_STATE_PRAN);
		}
		return true;
	}
	else if(StandAction(x,y))
	{
		return true;
	}
	
	t = IsBlockLand(*x, *y+1, &xx,&yy);
	if(t == BLOCK_BARBED_WIRE)
	{
		mOverType = 0;
		SetPlayer(PLAYER_STATE_FAIL);
		return true;
	}
	else if(t == BLOCK_TILES_SIZE)
	{
		SetPlayer(PLAYER_STATE_FALL);
		return true;
	}
	
	if(mTapCount<TIME_TOUCH_VALID){
		int type = stages->CheckZombie(CHECK_TYPE_ATTACK, *x, *y-PLAYER_SHIFT_H, PLAYER_SHIFT_H);
		if(type != ZOMBIE_TYPE_MAX){
			if(type == ZOMBIE_TYPE_WATER){
				mTempG2 = PLAYER_ATTAC_SPEED;
				mTempG = PLAYER_VAULT_SPEED;
				SetPlayer(PLAYER_STATE_GRAB);
			}else {
				int state = AttackState[type];
				SetPlayer(state);
			}
			return true;
		}
	}
	return false;
}

bool DoJumpAction(bool check, float *x, float *y)
{
	float xx, yy;
	int t;

	t = IsBlockCollide(*x+PLAYER_SHIFT_W, *y+1 -32, &xx,&yy);
	if(t != BLOCK_TILES_SIZE) 
	{//t == BLOCK_BARBED_WIRE
		*x = xx-PLAYER_SHIFT_W*0.5;
		
		bool cat = IsBlockCat(*x, *y+1-32, &xx,&yy);
		if(cat){
			SetPlayer(PLAYER_STATE_CAT);
		}else if(t == BLOCK_BARBED_WIRE){
			mOverType = 0;
			SetFailState();
		}else {
			SetPlayer(PLAYER_STATE_DROP);
			if(*y+1 -32 > yy+4){
				DisableShadow();
			}
		}
		return true;
	}
	else if(IsBlockTop(*x, *y+1 -PLAYER_SHIFT_H, &xx,&yy)!=BLOCK_TILES_SIZE) 
	{
		SetPlayer(PLAYER_STATE_FALL);
		return true;
	}
	else {
		int light = stages->BlockType(*x, *y -PLAYER_SHIFT_H, &xx,&yy);
		if(light==BLOCK_STREET_LIGHT){
			*y = yy+PLAYER_SHIFT_H +8;
			SetPlayer(PLAYER_STATE_LIGHT);
			return true;
		}
		
		int parall = stages->BlockParall(*x, *y -PLAYER_SHIFT_H, 0,&yy, BLOCK_TILES_SIZE);
		if(parall ==BLOCK_LINES_CLIMB) {
			*y = yy+PLAYER_SHIFT_H;
			SetPlayer(PLAYER_LINES_CLIMB);
			return true;
		}else if(parall ==BLOCK_LINES_SLIDE) {
			*y = yy+PLAYER_SHIFT_H;
			SetPlayer(PLAYER_LINES_SLIDE);
			return true;
		}
	}
	
	if(mTapCount<TIME_TOUCH_AVOID)
	{
		if(IsPoleSwing(true, mPlayerX-4, mPlayerY-PLAYER_SHIFT_H+8, 8,16)){
			SetPlayer(PLAYER_STATE_RINGS);
		}
		else if(IsBoardAttach(mPlayerX, mPlayerY)){
			SetPlayer(PLAYER_STATE_BOARD);
		}
	}
	return false;
}

bool DoFallAction(bool check, float *x, float *y)
{
	float xx, yy;
	int t;

	if (mPlayerY > stages->blockHeight+PLAYER_SHIFT_H){
		if(!mFailFlag) mOverType = 0;
		SetPlayer(PLAYER_STATE_FAIL);
		return true;
	}
	
	t = IsBlockLand(*x, *y+1, &xx,&yy);
	if(t != BLOCK_TILES_SIZE)
	{
		*y = yy;
		if(t == BLOCK_BARBED_WIRE){
			mOverType = 0;
			SetPlayer(PLAYER_STATE_FAIL);
		}
		else if(t == BLOCK_WATER_DELAY){
			if(StandAction(x,y))
			{
				return true;
			}
			if(mFallCount >=TimeJumpHalf(VspJump())) {
				if(mFallFlag)
				{
					SetPlayer(PLAYER_STATE_SCROLL);
				}else {
					SetPlayer(PLAYER_STATE_WATER);
				}
			}else {
				SetPlayer(PLAYER_STATE_RUN);
			}
			return true;
		}else {
			if(StandAction(x,y))
			{
				return true;
			}
			if(mFallCount >=TimeJumpTop(VspJump())) {
				if(true)//if(mFallFlag ||mFallCount<TimeJumpDelay)
				{
					SetPlayer(PLAYER_STATE_SCROLL);
				}/*else {
					SetPlayer(PLAYER_STATE_STUMB);
				}*/
			}else {
				SetPlayer(PLAYER_STATE_RUN);
			}
			return true;
		}
	}
	else 
	{
		t = IsBlockCollide(*x+PLAYER_SHIFT_W, *y+1 -32, &xx,&yy);
		if(t != BLOCK_TILES_SIZE) 
		{//t == BLOCK_BARBED_WIRE
			*x = xx-PLAYER_SHIFT_W*0.5;
			
			bool cat = IsBlockCat(*x, *y+1-32, &xx,&yy);
			if(cat){
				SetPlayer(PLAYER_STATE_CAT);
			}else if(t == BLOCK_BARBED_WIRE){
				mOverType = 0;
				SetFailState();
			}else if(mPlayerAction != PLAYER_STATE_DROP){
				SetPlayer(PLAYER_STATE_DROP);
				if(*y+1 -32 > yy+4){
					DisableShadow();
				}
			}
			return true;
		}
		else {//if(mFallCount>TIME_TOUCH_AVOID){
			int light = stages->BlockType(*x, *y -PLAYER_SHIFT_H, &xx,&yy);
			if(light==BLOCK_STREET_LIGHT){
				*y = yy+PLAYER_SHIFT_H +8;
				SetPlayer(PLAYER_STATE_LIGHT);
				return true;
			}
			
			int parall = stages->BlockParall(*x, *y -PLAYER_SHIFT_H, 0,&yy, BLOCK_TILES_SIZE);
			if(parall ==BLOCK_LINES_CLIMB) {
				*y = yy+PLAYER_SHIFT_H;
				SetPlayer(PLAYER_LINES_CLIMB);
				return true;
			}else if(parall ==BLOCK_LINES_SLIDE) {
				*y = yy+PLAYER_SHIFT_H;
				SetPlayer(PLAYER_LINES_SLIDE);
				return true;
			}
		}
	}
	
	if(mTapCount<TIME_TOUCH_AVOID)
	{
		if(IsPoleSwing(true, mPlayerX-4, mPlayerY-PLAYER_SHIFT_H+8, 8,16)){
			SetPlayer(PLAYER_STATE_RINGS);
		}
		else if(IsBoardAttach(mPlayerX, mPlayerY)){
			SetPlayer(PLAYER_STATE_BOARD);
		}
	}
	return false;
}

static void DoAttackAction(float dt)
{
	int type = mPlayerAction-PLAYER_ATTAC_RUN;
	
	int frame = AttackEffect[type][0];
	float sx = AttackEffect[type][1];
	float sy = AttackEffect[type][2];
	float cam = AttackEffect[type][3];
	
	int index = mPlayer->getCurrentFrameIndex();

	float offx = AttackOffset[type][index*2];
	float offy = AttackOffset[type][index*2+1];
	
	if(mPlayerAction == PLAYER_ATTAC_NORM
	   || mPlayerAction == PLAYER_ATTAC_HIPPIE
	   || mPlayerAction == PLAYER_ATTAC_RUN)
	{
		MovePlayer(dt,0,cam);

		mPlayerX = mPlayerOrgX +offx;
		mPlayerY = mPlayerOrgY +offy;
		bool last = mPlayer->isLastMoveInAction();
		if(last){
			SetPlayer(PLAYER_STATE_RUN);
		}
		if(index == frame){// - mScrollWorld
			stages->makeCollectingEffect(EFFECT_ATTACK_ZOMBIE, mEffect2, 
										 mPlayerX+sx, mPlayerY+sy);
		}
	}
	else if(mPlayerAction == PLAYER_ATTAC_BIG)
	{
		MovePlayer(dt,0,cam);

		mPlayerX = mPlayerOrgX +offx;
		mPlayerY = mPlayerOrgY +offy;
		bool last = mPlayer->isLastMoveInAction();
		if(last){
			SetPlayer(PLAYER_STATE_SCROLL);
		}
		if(index == frame){// - mScrollWorld
			stages->makeCollectingEffect(EFFECT_ATTACK_ZOMBIE, mEffect2, 
										 mPlayerX+sx, mPlayerY+sy);
		}
	}
	else if(mPlayerAction == PLAYER_ATTAC_WATER)
	{
		MovePlayer(dt,0,cam);

		mPlayerX = mPlayerOrgX +offx;
		mPlayerY = mPlayerOrgY +offy;
		bool last = mPlayer->isLastMoveInAction();
		if(last){
			SetPlayer(PLAYER_STATE_FALL);
		}
		if(index == frame){// - mScrollWorld
			stages->makeCollectingEffect(EFFECT_ATTACK_ZOMBIE2, mEffect4, 
										 mPlayerX+sx, mPlayerY+sy);
		}
	}
}

//=========================================================================
	//player
//=========================================================================
void InitializePlayer()
{
	if (stages)
	{
		mPlayerX = stages->startX;
		mPlayerY = stages->startY;
	}
	
	mScrollWorld = 0;
	mScrollFlag = 0;
	
	mTapCount = 1000.0f;
	
	mWalkFlag = false;
	mFailFlag = false;
	mSuccFlag = false;
	mEndFlag = false;
	
	mShadowShow = false;
	mShadowCount = 0;
	
#if 0//DEBUG	
	mActionCount = 3;
	mFastLevel = 1;
	mFastFlag = true;
#endif
	
	SetPlayer(PLAYER_STATE_STAND);
	InitShadow();
}

void PlayerJumpTo()
{

#ifdef ENABLE_CHECKPOINT
	if (stages)
	{
		stages->setCheckPoint(&mPlayerX, &mPlayerY);
	}
#endif
    
    mStepCam = mPlayerY;
}

void RenderPlayer()
{
	float x = mPlayerX -PLAYER_SHIFT_X -mScrollWorld + cameraX;
	float y = mPlayerY -PLAYER_SHIFT_Y + cameraY;
	
	mPlayer->render(x, y + SCENE_OFFSET, 0.0f, GLOBAL_CANVAS_SCALE, 1.0f);
	
#if DEBUG
	float tx = mPlayerX -mScrollWorld + cameraX;
	float ty = mPlayerY + cameraY;
	
	Canvas2D* canvas = Canvas2D::getInstance();
	canvas->setColor(0.0f, 1.0f, 0.0f, 1.0f);
	canvas->strokeRect(tx-PLAYER_SHIFT_W,ty-PLAYER_SHIFT_H + SCENE_OFFSET, PLAYER_SHIFT_W*2,PLAYER_SHIFT_H-10);//-10
	canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
	canvas->flush();
#endif
}

void UpdatePlayer(float dt)
{
	float xx,yy;
	
	if (mActionCount >= 3){
		AchAddComboCountTime(dt);
	}
	
	mPlayer->update(dt);
	mTapCount +=dt/1000;
	
	if(mPlayerX >= stages->blockLength-GAME_FIN_SUCC){
		SetSuccState();
	}

	if(mPlayerAction == PLAYER_STATE_RUN ||mPlayerAction == PLAYER_STATE_QUICK){
		MovePlayer(dt,SpeedRun(),CAMERA_FALLOW_SPEED);
		/*bool act = */DoRunAction(false, &mPlayerX, &mPlayerY);
		if(!mFastFlag) {	
			//static int se[]={4,12};
			int index = mPlayer->getCurrentFrameIndex();
			if(index == 4|| index ==12){
				int r = rand()%3;
				playSE(SE_RUNNER_RUNNING_FT_01+r);
			}
		}
		else {
			//static int se[]={3,10};
			int index = mPlayer->getCurrentFrameIndex();
			if(index == 4|| index ==12){
				int r = rand()%3;
				playSE(SE_RUNNER_RUNNING_FT_01+r);
			}
		}
	}
	else if(mPlayerAction == PLAYER_STATE_WALK){
		MovePlayer(dt,PLAYER_WALK_SPEED,PLAYER_WALK_SPEED);
		/*bool act = */DoRunAction(false, &mPlayerX, &mPlayerY);
	}
	else if(mPlayerAction == PLAYER_STATE_SCROLL){
		bool last = mPlayer->isLastMoveInAction();
		if(last){
			SetPlayer(PLAYER_STATE_RUN);
		}

		MovePlayer(dt,PLAYER_NORMAL_SPEED,CAMERA_FALLOW_SPEED);
		/*bool act = */DoRunAction(false, &mPlayerX, &mPlayerY);
	}
	else if(mPlayerAction == PLAYER_STATE_WATER 
			/*|| mPlayerAction == PLAYER_STATE_STUMB*/){
		bool last = mPlayer->isLastMoveInAction();
		if(last){
			SetPlayer(PLAYER_STATE_RUN);
		}
		
		MovePlayer(dt,PLAYER_WATER_SPEED,CAMERA_FALLOW_SPEED);
		/*bool act = */DoRunAction(false, &mPlayerX, &mPlayerY);
	}
	else if(mPlayerAction == PLAYER_STATE_SLIDE){
		MovePlayer(dt,PLAYER_NORMAL_SPEED,CAMERA_FALLOW_SPEED);
		
		int t = stages->BlockRect(mPlayerX +PLAYER_SHIFT_W, mPlayerY+1 -16, DISTANCE_TIC_TAC +PLAYER_SHIFT_W,8, &xx,&yy);
		int t2 = stages->BlockRect(mPlayerX -PLAYER_SHIFT_W, mPlayerY+1 -16, PLAYER_SHIFT_W*2,8, &xx,&yy);
		if(t !=BLOCK_NEED_CRAWL &&t2 !=BLOCK_NEED_CRAWL){
			SetPlayer(PLAYER_STATE_RUN);
		}
	}
	else if(mPlayerAction == PLAYER_STATE_CRAWL){
		MovePlayer(dt,PLAYER_CRAWL_SPEED,CAMERA_FALLOW_SPEED);
		
		int t = stages->BlockRect(mPlayerX +PLAYER_SHIFT_W, mPlayerY+1 -16, DISTANCE_TIC_TAC +PLAYER_SHIFT_W,8, &xx,&yy);
		int t2 = stages->BlockRect(mPlayerX -PLAYER_SHIFT_W, mPlayerY+1 -16, PLAYER_SHIFT_W*2,8, &xx,&yy);
		if(t !=BLOCK_NEED_CRAWL &&t2 !=BLOCK_NEED_CRAWL){
			SetPlayer(PLAYER_STATE_RUN);
		}else {
			if(mTapCount<TIME_TOUCH_VALID){
				SetPlayer(PLAYER_STATE_SLIDE);
			}
		}
	}
	else if(mPlayerAction == PLAYER_STATE_JUMP){
		float fall = false;
		float temp = mJumpCount;
		mJumpCount +=dt/1000;
		
		if(mFallFlag){
			float t = TimeJumpHalf(VspJump());
			if(temp <t &&mJumpCount >=t){
				temp = t;
				mFallFlag = false;
				fall = true;
			}
		}
		
		if(!fall){
			temp = mJumpCount;
			float t = TimeJumpTop(VspJump());
			if(temp >= t){
				temp = t;
				mFallFlag = false;
				fall = true;
			}
		}
		
		float height = HeightJump(VspJump(),temp);
		mPlayerY = mPlayerOrgY -PTM_RATIO*height;
		
		if(fall) {
			SetPlayer(PLAYER_STATE_FALL);
		}
		
		MovePlayer(dt,SpeedJump(),CAMERA_FALLOW_SPEED);
		DoJumpAction(false, &mPlayerX, &mPlayerY);
	}
	else if(mPlayerAction == PLAYER_STATE_FALL
			 ||mPlayerAction == PLAYER_BOARD_FALL
			 /*||mPlayerAction == PLAYER_RINGS_FALL
			 ||mPlayerAction == PLAYER_CLIMB_FALL
			 ||mPlayerAction == PLAYER_LIGHT_FALL
			 ||mPlayerAction == PLAYER_SLIDE_FALL*/){
		
		mFallCount += dt/1000;
		float temp = mFallCount;
		float height = PTM_GRAVITY*temp*temp*0.5f;
		mPlayerY = mPlayerOrgY +PTM_RATIO*height;
		
		MovePlayer(dt,SpeedJump(),CAMERA_FALLOW_SPEED);
		/*bool act = */DoFallAction(false, &mPlayerX, &mPlayerY);
	}else if(mPlayerAction == PLAYER_STATE_DROP){
		mFallCount += dt/1000;
		float temp = mFallCount;
		float height = PTM_GRAVITY*temp*temp*0.5f;
		mPlayerY = mPlayerOrgY +PTM_RATIO*height;
		
		MovePlayer(dt,0,CAMERA_LEAST_SPEED);
		/*bool act = */DoFallAction(false, &mPlayerX, &mPlayerY);
	}
	else if(mPlayerAction == PLAYER_STATE_GRAB){
		mUseCount += dt/1000;
		float temp = mUseCount;
		
		float height = mTempG*temp - PTM_GRAVITY*temp*temp*0.5f;
		mPlayerY = mPlayerOrgY -PTM_RATIO*height;
		
		MovePlayer(dt,mTempG2,CAMERA_FALLOW_SPEED);
		if(mUseCount>TIME_TOUCH_AVOID) {
			float t = TimeJumpTop(mTempG);
			if(temp < t){
				DoJumpAction(false, &mPlayerX, &mPlayerY);
			}else {
				DoFallAction(false, &mPlayerX, &mPlayerY);
			}
		}
		
		if(mTapCount<TIME_TOUCH_VALID){
			int type = stages->CheckZombie(CHECK_TYPE_WATER, mPlayerX,mPlayerY-PLAYER_SHIFT_H, PLAYER_SHIFT_H);
			if(type == ZOMBIE_TYPE_WATER){
				SetPlayer(PLAYER_ATTAC_WATER);
			}
		}		
	}
	else if(mPlayerAction == PLAYER_STAND_JUMP){
		MovePlayer(dt,0,CAMERA_LEAST_SPEED);
		
		int index = mPlayer->getCurrentFrameIndex();
		if(index>=2)
		{
			mUseCount += dt/1000;
			float temp = mUseCount;
			float height = mTempC*temp - PTM_GRAVITY2*temp*temp*0.5f;
		
			mPlayerY = mPlayerOrgY -PTM_RATIO*height;
			bool cat = IsBlockCat(mPlayerX, mPlayerY+1-32, &xx,&yy);
			if(cat){
				//mPlayerX = xx-PLAYER_SHIFT_W;
				SetPlayer(PLAYER_STATE_CAT);
			}
		}
	}
	else if(mPlayerAction == PLAYER_STATE_CAT){
		MovePlayer(dt,0,CAMERA_LEAST_SPEED);
		
		bool last = mPlayer->isLastMoveInAction();
		if(last){
			mPlayerY = mPlayerOrgY -32;
			SetPlayer(PLAYER_STATE_RUN);
		}
	}
	else if(mPlayerAction == PLAYER_STATE_BOARD){
		MovePlayer(dt,PLAYER_NORMAL_SPEED,CAMERA_FALLOW_SPEED);
		
		mUseCount += dt/1000;
		float temp = mUseCount;
		float y = mPlayerY;
		
		float height = PLAYER_BOARD_SPEED*temp - PTM_GRAVITY2*temp*temp*0.5f;
		mPlayerY = mPlayerOrgY -PTM_RATIO*height;

		if(mFallFlag){
			if(JumpAction(mPlayerX,mPlayerY,1.0f)) {
				SetPlayer(PLAYER_STATE_GRAB);
			}else {
				SetPlayer(PLAYER_BOARD_FALL);
			}
		}
		else {
			if(!IsBoardAttach(mPlayerX, mPlayerY)){
				if(y>mPlayerY &&IsBoardAttach(mPlayerX, y)){
					mPlayerY = y;
				}
				else if(JumpAction(mPlayerX,mPlayerY,1.0f)) {
					SetPlayer(PLAYER_STATE_GRAB);
				}else {
					SetPlayer(PLAYER_BOARD_FALL);
				}
			}
		}
		
		//static int se[]={4,12};
		int index = mPlayer->getCurrentFrameIndex();
		if(index == 4|| index ==12){
			int r = rand()%3;
			playSE(SE_RUNNER_WALLRUN_FT_01+r);
		}
	}else if(mPlayerAction == PLAYER_STATE_LIGHT){
		MovePlayer(dt,PLAYER_NORMAL_SPEED,CAMERA_FALLOW_SPEED);
		
		int light = stages->BlockRect(mPlayerX, mPlayerY -PLAYER_SHIFT_H, 2,8, &xx,&yy);
		//mPlayerY = yy+60;
		if(light!=BLOCK_STREET_LIGHT){
			if(JumpAction(mPlayerX,mPlayerY,1.0f)) {
				SetPlayer(PLAYER_STATE_GRAB);
			}else {
				SetPlayer(PLAYER_STATE_FALL);//PLAYER_LIGHT_FALL
			}
		}
	}else if(mPlayerAction == PLAYER_LINES_CLIMB){
		float v = MovePlayer(dt,PLAYER_NORMAL_SPEED,CAMERA_FALLOW_SPEED);
		
		int parall = stages->BlockParall(mPlayerX, mPlayerY -PLAYER_SHIFT_H, v,&yy, BLOCK_LINES_CLIMB);
		if(parall ==BLOCK_LINES_CLIMB) {
			mPlayerY = yy+PLAYER_SHIFT_H;
		}else{
			if(JumpAction(mPlayerX,mPlayerY,1.0f)) {
				SetPlayer(PLAYER_STATE_GRAB);
			}else {
				SetPlayer(PLAYER_STATE_FALL);//PLAYER_CLIMB_FALL
			}
		}
	}else if(mPlayerAction == PLAYER_LINES_SLIDE){
		mUseCount += dt/1000;
		float temp = mUseCount;
		float v = MovePlayer(dt,PLAYER_ATTAC_SPEED+ PTM_GRAVITY3*temp,CAMERA_FALLOW_SPEED);
		
		int parall = stages->BlockParall(mPlayerX, mPlayerY -PLAYER_SHIFT_H, v,&yy, BLOCK_LINES_SLIDE);
		if(parall ==BLOCK_LINES_SLIDE) {
			mPlayerY = yy+PLAYER_SHIFT_H;
		}else{
			if(JumpAction(mPlayerX,mPlayerY,1.0f)) {
				SetPlayer(PLAYER_STATE_GRAB);
			}else {
				SetPlayer(PLAYER_STATE_FALL);//PLAYER_SLIDE_FALL
			}
		}
	}
	else if(/*mPlayerAction == PLAYER_STATE_JETE
			|| */mPlayerAction == PLAYER_STATE_JETE2){//npc
		MovePlayer(dt,PLAYER_JETE_SPEED,CAMERA_FALLOW_SPEED);
		
		bool last = mPlayer->isLastMoveInAction();
		if(last)
		{
			SetPlayer(PLAYER_STATE_RUN);
		}
		int index = mPlayer->getCurrentFrameIndex();
		if(index>=10){
			int t = IsBlockLand(mPlayerX, mPlayerY+1, &xx,&yy);
            if(t == BLOCK_BARBED_WIRE)
            {
                mOverType = 0;
                SetPlayer(PLAYER_STATE_FAIL);
            }
            else if(t == BLOCK_TILES_SIZE)
            {
                SetPlayer(PLAYER_STATE_FALL);
            }
		}
	}else if(mPlayerAction == PLAYER_STATE_PRAN){//item
		int index = mPlayer->getCurrentFrameIndex();
		if(index>=12){
			MovePlayer(dt,PLAYER_VAULT_SPEED,CAMERA_FALLOW_SPEED);
		}else {
			MovePlayer(dt,PLAYER_NORMAL_SPEED,CAMERA_FALLOW_SPEED);
		}
		
		if(index==12){
			playSE(SE_RUNNER_BONUS);
		}
		bool last = mPlayer->isLastMoveInAction();
		if(last)
		{
			SetPlayer(PLAYER_STATE_RUN);
		}
	}/*else if(mPlayerAction == PLAYER_STATE_PRAN2){
		int index = mPlayer->getCurrentFrameIndex();
		if(index>=6){
			MovePlayer(dt,PLAYER_VAULT_SPEED,CAMERA_FALLOW_SPEED);
		}else {
			MovePlayer(dt,PLAYER_NORMAL_SPEED,CAMERA_FALLOW_SPEED);
		}
		
		bool last = mPlayer->isLastMoveInAction();
		int t = stages->BlockType(mPlayerX, mPlayerY+1 -16, &xx,&yy);
		if(t !=BLOCK_DEBRIS_HIT &&last)
		{
			SetPlayer(PLAYER_STATE_RUN);
		}
	}*/
	else if(mPlayerAction == PLAYER_STATE_RINGS){
		MovePlayer(dt,0,CAMERA_LEAST_SPEED);
		
		bool last = mPlayer->isLastMoveInAction();
		if(last){
			if(JumpAction(mPlayerX,mPlayerY,2.0f)) {
				SetPlayer(PLAYER_STATE_GRAB);
			}else {
				SetPlayer(PLAYER_STATE_RINGS2);
			}
		}
	}else if(mPlayerAction == PLAYER_STATE_RINGS2){
		mUseCount +=dt/1000;
		float temp = mUseCount;
		float fall = false;
		
		float t = TimeJumpTop(VspJump());
		if(temp >= t){
			temp = t;
			fall = true;
		}
		
		float height = HeightJump(VspJump(),temp);
		mPlayerY = mPlayerOrgY -PTM_RATIO*height;
		
		if(fall) {
			SetPlayer(PLAYER_STATE_FALL);
		}
		
		MovePlayer(dt,SpeedJump(),CAMERA_FALLOW_SPEED);
		if(mUseCount>TIME_TOUCH_AVOID) {
			DoJumpAction(false, &mPlayerX, &mPlayerY);
		}
	}else if(mPlayerAction == PLAYER_ATTAC_RUN 
				|| mPlayerAction == PLAYER_ATTAC_NORM
				|| mPlayerAction == PLAYER_ATTAC_BIG
			 || mPlayerAction == PLAYER_ATTAC_WATER
			 || mPlayerAction == PLAYER_ATTAC_HIPPIE)
	{
		DoAttackAction(dt);
		if(mPlayerY < mPlayerOrgY-16){
			int t = IsBlockLand(mPlayerX, mPlayerY+1, &xx,&yy);
			if(t != BLOCK_TILES_SIZE)
			{
				mPlayerY = yy;
				SetPlayer(PLAYER_STATE_RUN);
			}
		}
		DoJumpAction(false, &mPlayerX, &mPlayerY);
	}else if(mPlayerAction == PLAYER_STATE_FAIL){
		bool last = mPlayer->isLastMoveInAction();
		if(last &&!mEndFlag){
			if(g_nGameState==GAME_STATE_PAUSE) return;
			mEndFlag = true;
		
			if(mOverType == 1){
				setGlobalFadeOutThenGoTo(GAME_STATE_CAUGHT_OVER);//Gaint
			}else {
				int r = rand()%100;
				if(r<20){
					mOverType = 1;
					setGlobalFadeOutThenGoTo(GAME_STATE_CAUGHT_OVER);//Gaint
				}
				else {
					mOverType = 2;
					setGlobalFadeOutThenGoTo(GAME_STATE_OVER);
				}
			}
            
#ifdef _AD_ADCOLONY_EMBEDDED_
            setCountGameOver();
            // enable it only in the level 1, free version
        #define PLAY_ADS_FREQ  5
            if (!([app.iap hasUnlockComicInLocalStore]) && LevelIndex == 0)
            {
                int cnt = getCountGameOver() % PLAY_ADS_FREQ;
                if (cnt == 0)
                {
                    ++tabAdPlayList[ActiveLevel];
                    [app playVideoAdSlot:(1+ActiveLevel)];
                }
            }
#endif
		}
	}else if(mPlayerAction == PLAYER_STATE_SUCC){
		bool last = mPlayer->isLastMoveInAction();
		if(last &&!mEndFlag){
			if(g_nGameState==GAME_STATE_PAUSE) return;
			mEndFlag = true;
			
			setGlobalFadeOutThenGoTo(GAME_STATE_SUC);
			setRunnerMode();
            
#ifdef _AD_ADCOLONY_EMBEDDED_
            resetCountGameOver();
            // enable it only in the level 1, free version
            if (/* && */tabAdPlayList[ActiveLevel] == 0 && LevelIndex == 0)
            {
                int cnt = tabAdPlayList[ActiveLevel];
                if (cnt == 0)
                {
                    ++tabAdPlayList[ActiveLevel];
                    [app playVideoAdSlot:(1+ActiveLevel)];
                }
            }
#endif
		}
	}
}

bool isEnableTouchRm()
{
    bool ret = true;
    if (IsAutoState())
    {
		ret = false;
	}
	if (mPlayerX >= (stages->blockLength - GAME_FIN_AUTO))
    {
		ret = false;
	}
    if (GetPlayerAction() == PLAYER_STATE_STAND)
    {
        ret = false;
    }
    return ret;
}

bool isEnableTouchTr()
{
    bool ret = true;
    if (IsAutoState())
    {
		ret = false;
	}
	if (mPlayerX >= (stages->blockLength - GAME_FIN_DISABLE_TR))
    {
		ret = false;
	}
    if (GetPlayerAction() == PLAYER_STATE_STAND)
    {
        ret = false;
    }
    return ret;
}

void TouchPlayer(int touchStatus, float fX, float fY)
{
	if(IsAutoState()){
		return;
	}
	if(mPlayerX >= stages->blockLength- GAME_FIN_AUTO){
		return;
	}
	
	if(touchStatus == 1){
		mTapCount = 0;
	}
	
	if(mPlayerAction == PLAYER_STATE_STAND)
	{
		if(touchStatus != 1) return;
		SetPlayer(PLAYER_STATE_RUN);
		RelGcOverRes();
	}
	else if(mPlayerAction == PLAYER_STATE_RUN 
		||mPlayerAction == PLAYER_STATE_QUICK
		|| mPlayerAction == PLAYER_STATE_SCROLL)
	{
		if(touchStatus != 1) return;
		
		bool act = CheckRunAction(&mPlayerX, &mPlayerY);
		if(!act) {
			SetPlayer(PLAYER_STATE_JUMP);
		}
	}
	else if(mPlayerAction == PLAYER_STATE_JUMP)
	{
		if(touchStatus == 3) {
			mFallFlag = true;
		}
		else if(IsBoardAttach(mPlayerX, mPlayerY)){
			SetPlayer(PLAYER_STATE_BOARD);
		}
		else if(IsPoleSwing(true, mPlayerX-4, mPlayerY-PLAYER_SHIFT_H+8, 8,16)){
			SetPlayer(PLAYER_STATE_RINGS);
		}
	}
	else if(mPlayerAction == PLAYER_STATE_FALL
			||mPlayerAction == PLAYER_BOARD_FALL
			//||mPlayerAction == PLAYER_RINGS_FALL
			
			||mPlayerAction == PLAYER_STATE_DROP
			/*||mPlayerAction == PLAYER_STATE_GRAB*/)
	{
		if(touchStatus == 3) {
			return;
		}
		else if(IsBoardAttach(mPlayerX, mPlayerY)){
			SetPlayer(PLAYER_STATE_BOARD);
		}
		else if(IsPoleSwing(true, mPlayerX-4, mPlayerY-PLAYER_SHIFT_H+8, 8,16)){
			SetPlayer(PLAYER_STATE_RINGS);
		}
	}else if(mPlayerAction == PLAYER_STATE_BOARD)
	{
		if(touchStatus == 3) {
			mFallFlag = true;
		}
	}else if(mPlayerAction == PLAYER_ATTAC_RUN 
			 || mPlayerAction == PLAYER_ATTAC_NORM
			 || mPlayerAction == PLAYER_ATTAC_BIG
			 || mPlayerAction == PLAYER_ATTAC_WATER
			 || mPlayerAction == PLAYER_ATTAC_HIPPIE)
	{
		if(touchStatus != 1) return;
		int index = mPlayer->getCurrentFrameIndex();
		int count = mPlayer->getCurrentActionFrameCount();
		
		if(mPlayerY == mPlayerOrgY &&index > count*0.5){
			bool act = CheckRunAction(&mPlayerX, &mPlayerY);
			if(!act) {
				SetPlayer(PLAYER_STATE_JUMP);
			}
		}
	}
}

void panUpDnCamera(float dy)
{
	cameraY += dy;
}

//void panUpDnCameraTo(float dy)
//{
//	cameraDesY - cameraY;
//	cameraVy = (cameraDesY - cameraY) / 30.0f;
//}
//
//void updateCamera()
//{
//	cameraY += cameraVy;
////	if (cameraDesY - cameraY > 0.01f)
//}

void defaultCamera()
{
	cameraY = defaultCameraY;
}

void setDefaultCamY(float defaultCamY)
{
	defaultCameraY = defaultCamY;
}

