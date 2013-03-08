/*
 *  GameSection.h
 *  ZPR
 *
 *  Created by Neo Lin on 5/31/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */


#ifdef CHEAT_UNLOCK_ALL_LEVELS
   #define UNLOCKED_LEVEL		1
#else
   #define UNLOCKED_LEVEL		0
#endif

#define LEVEL_NUM_MAX		4
#define STAGE_IN_LV_MAX		12

#define SEC_LOCK_ALPHA      0.3f,0.3f,0.3f,0.6f


void GameSectionBegin();
void GameSectionEnd();
void GameSectionUpdate(float dt);
void GameSectionRender(float dt);
void GameSectionOnTouchEvent(int touchStatus, float fX, float fY);
extern int availableLevels;
extern int ActiveLevel;
extern int LevelIndex;
extern int nLevelCleared[LEVEL_NUM_MAX];
extern int levelTotalScore[LEVEL_NUM_MAX];
extern int levelAverageStars[LEVEL_NUM_MAX];
extern int mSelectStar[LEVEL_NUM_MAX];
extern int itemStatus[LEVEL_NUM_MAX];
extern bool mSectionLock[LEVEL_NUM_MAX];
extern  bool isMainMenu;