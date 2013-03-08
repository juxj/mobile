/*
 *  GameLogo.h
 *  MonsterWar
 *
 *  Created by Neo Lin on 5/31/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

void GameLogoBegin();
void GameLogoEnd();
void GameLogoUpdate(float dt);
void GameLogoRender(float dt);
void GameLogoOnTouchEvent(int touchStatus, float fX, float fY);

class Image;
extern Image* mSplash;
