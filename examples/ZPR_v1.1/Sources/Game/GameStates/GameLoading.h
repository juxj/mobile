/*
 *  GameLoading.h
 *  ZPR
 *
 *  Created by Neo01 on 8/2/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#define LOADING_DURATION    2000.0f  // 2000ms

void GameLoadingBegin();
void GameLoadingEnd();
void GameLoadingUpdate(float dt);
void GameLoadingRender(float dt);
void GameLoadingOnTouchEvent(int touchStatus, float fX, float fY);

extern int loadStep;
extern float loadingStrWidth;
extern float loadCnt;
