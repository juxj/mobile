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

#define NUM_BTN_IN_GAME_LEVELTWL	(STAGE_LEVEL_V002+1)


void GameLevelTwlBegin();
void GameLevelTwlEnd();
void GameLevelTwlUpdate(float dt);
void GameLevelTwlRender(float dt);
void GameLevelTwlOnTouchEvent(int touchStatus, float fX, float fY);


class Image;

//extern bool mLevelLock[LEVEL_NUM_MAX][STAGE_IN_LV_MAX];
//extern int  mLevelStar[LEVEL_NUM_MAX][STAGE_IN_LV_MAX];
//extern int  levelStageScore[LEVEL_NUM_MAX][STAGE_IN_LV_MAX];

extern float  mLevelTwlTags[NUM_BTN_IN_GAME_LEVELTWL][4];
