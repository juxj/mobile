//
//  GameRunnerMode.h
//  ZPR
//
//  Created by Neo Lin on 11/15/11.
//  Copyright (c) 2011 Break Media. All rights reserved.
//

#ifndef ZPR_GameRunnerMode_h
#define ZPR_GameRunnerMode_h

#define IG_RUNNERMODE_IDLE    -1
#define IG_RUNNERMODE_INIT    0
#define IG_RUNNERMODE_W_FIN   1
#define IG_RUNNERMODE_W_STAY  2
#define IG_RUNNERMODE_W_FOUT  3
#define IG_RUNNERMODE_ANIM_0  4
#define IG_RUNNERMODE_ANIM_1  5
#define IG_RUNNERMODE_DONE    6

#define IG_RUNNERMODE_WORDS_Y   144.0f

#define IG_RUNNERMODE_WORDS_STIME   (45)    // 45frames

#define IG_RUNNERMODE_CNT_MAX   60  // 1000msx2


#define IG_RUNNERMODE_METER_0   0
#define IG_RUNNERMODE_METER_1   1
#define IG_RUNNERMODE_METER_2   2
#define IG_RUNNERMODE_METER_MAX 3

#define IG_RUNNERMODE_RHIGH_0   0
#define IG_RUNNERMODE_RHIGH_1   1
#define IG_RUNNERMODE_RHIGH_MAX 2


#define IG_RM_METER_SCALE_X_FINAL 1.11f
#define IG_RM_METER_SCALE_Y_FINAL 1.52f
#define IG_RM_WORDS_SCALE_X_FINAL 1.48f
#define IG_RM_WORDS_SCALE_Y_FINAL 1.0f
#define IG_RM_WORDS_SCALE_L_X_FINAL (1.48f * 1.6f)
#define IG_RM_WORDS_SCALE_L_Y_FINAL (1.0f * 1.6f)

// step 1
#define IG_RUNNERMODE_ANIM_0_W0_SCALE_X0 ()
#define IG_RUNNERMODE_ANIM_0_W0_SCALE_X1 ()
#define IG_RUNNERMODE_ANIM_0_W0_SCALE_X0 ()
#define IG_RUNNERMODE_ANIM_0_W0_SCALE_X1 ()
// step 2
#define IG_RUNNERMODE_ANIM_0_W1_SCALE_X0 ()
#define IG_RUNNERMODE_ANIM_0_W1_SCALE_X1 ()

class Image;
extern Image *igRmMeter[IG_RUNNERMODE_METER_MAX];
extern Image *igRmRHigh[IG_RUNNERMODE_RHIGH_MAX];

extern bool usingIgRm;
extern int igRmCnt;


extern int igRmState;
extern int igRmSubState;

extern int igRmWordsCount;

class Sprite;
extern Sprite *igRmWords;

extern float igRmMeterAlpha;
extern float igRmWordsAlpha;
extern float igRmMeterScaleX;
extern float igRmMeterScaleY;
extern float igRmWordsScaleX;
extern float igRmWordsScaleY;
extern int   igRmRhSel;

void initGameRunnerModeRes();
void relGameRunnerModeRes();

void GameRunnerModeBegin();
//void GameRunnerModeEnd();
void GameRunnerModeUpdate(float dt);
void GameRunnerModeRender(float dt);
void GameRunnerModeTouchEvent(int touchStatus, float fX, float fY);

#endif
