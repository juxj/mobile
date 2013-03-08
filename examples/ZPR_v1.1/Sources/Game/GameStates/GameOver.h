//
//  GameOver.h
//  ZPR
//
//  Created by Xiao Qing Yan on 11-8-23.
//  Copyright 2011 Break Media. All rights reserved.
//

class Image;

extern Image* mOver;
extern Image* mOver2;

extern Image* mYesbg;
extern Image* mNo;
extern Image* mYes;

extern int mOverType;

void GameOverBegin();
void GameOverRender(float dt);
void GameOverTouchEvent(int touchStatus, float fX, float fY);
