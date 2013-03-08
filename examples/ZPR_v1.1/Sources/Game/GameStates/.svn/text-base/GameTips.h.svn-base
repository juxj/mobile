//
//  GameTips.h
//  ZPR
//
//  Created by Neo Lin on 11/29/11.
//  Copyright (c) 2011 Break Media. All rights reserved.
//

#ifndef ZPR_GameTips_h
#define ZPR_GameTips_h


#define IG_TIPS_INIT    0
#define IG_TIPS_POPUP1  1
#define IG_TIPS_POPUP2  2
#define IG_TIPS_STAY    3
#define IG_TIPS_CLOSE   4
#define IG_TIPS_DONE    5

class NeoRes;
class Image;
class ZprUIButton;

extern int   igTipsState;
extern int   igTipsCount;
extern float igTipsAlpha;
extern float igTipsX;
extern float igTipsY;
extern float igTipsRot;
extern float igTipsScale;

extern NeoRes *g_TipResMgr;
extern Image  *mIgTip;
extern ZprUIButton *mIgTipBtn;

void initResTip();
void freeResTip();

void GameTipsBegin();
//void GameTipsEnd();
void GameTipsUpdate(float dt);
void GameTipsRender(float dt);
void GameTipsTouchEvent(int touchStatus, float fX, float fY);

#endif
