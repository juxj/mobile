//
//  Opponent.h
//  ZPR
//
//  Created by futao.huang on 11-7-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef __OPPONENT_H__
#define __OPPONENT_H__

//=========================================================================
//const
//=========================================================================
#define ZOMBIE_TYPE_NORMAL		0
#define ZOMBIE_TYPE_HIPPIE		1
#define ZOMBIE_TYPE_WATER		2
#define ZOMBIE_TYPE_WHEEL		3
#define ZOMBIE_TYPE_BOSS		4
#define ZOMBIE_TYPE_MAX			5

#define RANGE_ATTACK_NORMAL		45
#define RANGE_ATTACK_HIPPIE		60
#define RANGE_ATTACK_WATER		200
#define RANGE_ATTACK_WHEEL		60
#define RANGE_ATTACK_BOSS		45

//=========================================================================
//setting
//=========================================================================
#define ZOMBIE_TIMER_IDLE		600.0f

#define ZOMBIE_RUN_SPEED		2.0f//nomal run speed
#define ZOMBIE_JUMP_SPEED		2.0f//jump horizontal speed
#define ZOMBIE_VSP_SPEED		3.5f//jump vertical speed

//=========================================================================
//state
//=========================================================================
#define ZOMBIE_STATE_STAND		0
#define ZOMBIE_STATE_RUN		1
#define ZOMBIE_STATE_WATER		2
#define ZOMBIE_STATE_ATTACK		3
#define ZOMBIE_STATE_FALL		4
#define ZOMBIE_STATE_HIPPIE		5
#define ZOMBIE_STATE_MAX		6


//=========================================================================
//class
//=========================================================================
class Sprite;
class Image;

class Opponent
{
public:
	Opponent(int type, float x, float y);
	~Opponent();
	
	void initialize();
	void destroy();
	void reset();
	
	void update(float dt);
	void render(float dt, float posX, float posY);
	
	int getType();
	float getX();
	float getY();
	void SetAction(int action);
	int GetAction();
	void SetAttack();
	
	void updateHintTime(float dt);
	void setHintDuration(float duration);
	void setHintInterval(float interval);
	
private:
	int mAction;
	float mTimer;
	bool mAttack;
	int mWait;
	float mOffY;
	bool mSound;
	bool mLand;
	
public://private:
	float mOrgX;
	float mOrgY;
	float mX;
	float mY;
	
	float mSX;
	float mSY;
	float mW;
	float mH;
	
	int mType;
	static int classId;
	
public:
	Sprite* mSprite;
	Image* shadowImage;
	
	int   count;
	float timer;
	float alpha;
	float duration;
	float interval;
};

#endif //__OPPONENT_H__
