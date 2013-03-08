/*
 *  GameStory.h
 *  ZPR
 *
 *  Created by Linda Li on 7/6/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

void GameStoryBegin();
void GameStoryEnd();
void GameStoryOnTouchEvent(int touchStatus, float fX, float fY);
void GameStoryRender(float dt);
void GameStoryIndexRender(int mStoryIndex, float dt);
void MoveFromAngle(float sx, float sy, int sIndex, int signX, int signY, float dt);
void drawStoryPageSp1(float x, float y);
void drawStoryPageSp2(float x, float y);
void drawStoryPageSp3(float x, float y);
void drawStoryPageSp4(float x, float y);

