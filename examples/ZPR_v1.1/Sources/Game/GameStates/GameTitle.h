/*
 *  GameTitle.h
 *  ZPR
 *
 *  Created by Neo Lin on 5/31/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

class ZprUIButton;
extern ZprUIButton *btnFacebookAtTitle;
extern ZprUIButton *btnTwitterAtTitle;
extern ZprUIButton *btnStartIcon[11];

extern BOOL isUpdate;
extern BOOL isServiceBusy;


void GameTitleBegin();
void GameTitleEnd();
void GameTitleUpdate(float dt);
void GameTitleRender(float dt);
void GameTitleOnTouchEvent(int touchStatus, float fX, float fY);
class Image;


extern Image* mFree;
extern Image* mWheel;
extern Image* mLight;
extern Image* mBtnStartBg;
