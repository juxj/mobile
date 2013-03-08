/*
 *  GameLevel.h
 *  ZPR
 *
 *  Created by Linda Li on 7/21/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "GameSection.h"
#import "GameData.h"

#define NUM_BTN_IN_GAME_LEVEL	(STAGE_LEVEL_V001+1)


void GameLevelBegin();
void GameLevelEnd();
void GameLevelUpdate(float dt);
void GameLevelRender(float dt);
void GameLevelOnTouchEvent(int touchStatus, float fX, float fY);


class Image;

extern Image* mSmallOption;
extern Image* mStar[4];
extern Image* mLock;
extern Image* mFreeLock;
extern Image* mProps[36];

extern Image* mActivebg;

extern bool mLevelLock[LEVEL_NUM_MAX][STAGE_IN_LV_MAX];
extern int  mLevelStar[LEVEL_NUM_MAX][STAGE_IN_LV_MAX];
extern int  levelStageScore[LEVEL_NUM_MAX][STAGE_IN_LV_MAX];
extern int  mLevelPlayCount[LEVEL_NUM_MAX][STAGE_IN_LV_MAX];

#ifdef __PROMOTE_ADS__
extern int adsStyle;
#endif

extern float  mLevelTags[NUM_BTN_IN_GAME_LEVEL][4];

