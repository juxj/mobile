/*
 *  GameOption.h
 *  ZPR
 *
 *  Created by Linda Li on 7/14/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */


    #define BTN_IDX_SE_OPTIONS      0
    #define BTN_IDX_BGM_OPTIONS     1

#ifdef V_1_1_0
    #define BTN_IDX_RD_OPTIONS      2
    #define BTN_IDX_OF_OPTIONS      3
    #define BTN_IDX_GC_OPTIONS      4
    #define BTN_IDX_BK_OPTIONS      5
    #define BTN_NUM_MAX_OPTIONS     6
#else
    #define BTN_IDX_OF_OPTIONS      2
    #define BTN_IDX_GC_OPTIONS      3
    #define BTN_IDX_BK_OPTIONS      4
    #define BTN_NUM_MAX_OPTIONS     5
#endif

    #define BTN_ELE_SE_OPTIONS      (4 * BTN_IDX_SE_OPTIONS)
    #define BTN_ELE_BGM_OPTIONS     (4 * BTN_IDX_BGM_OPTIONS)
#ifdef V_1_1_0
#define BTN_ELE_RD_OPTIONS      (4 * BTN_IDX_RD_OPTIONS)
#endif
    #define BTN_ELE_OF_OPTIONS      (4 * BTN_IDX_OF_OPTIONS)
    #define BTN_ELE_GC_OPTIONS      (4 * BTN_IDX_GC_OPTIONS)

    #define BTN_ELE_BK_OPTIONS      (4 * BTN_IDX_BK_OPTIONS)
    #define BTN_ELE_MAX_OPTIONS     (4 * BTN_NUM_MAX_OPTIONS)

#define SND_BTN_AS_SE_BTN

#define TITLE_CLICK_SOUND		1
#define TITLE_CLICK_VOLUME		2
#define TITLE_CLICK_CREDITS		3

#define PAUSE_BTN_RP		0
#define PAUSE_BTN_QUIT		1
#define OPTION_BTN_SND_ON	2
#define OPTION_BTN_BGM_ON	3

#ifdef V_1_1_0
    #define OVER_BTN_RESET      4
    #define OPTION_BTN_OF		5
    #define OPTION_BTN_GC		6
    #define OPTION_BTN_SND_OFF	7
    #define OPTION_BTN_BGM_OFF	8

    #define OVER_BTN_YES        9
    #define OVER_BTN_NO         10

    #define OPTION_BTN_BG       11
    #define OPTION_IMG_MAX		12
#else
     #define OPTION_BTN_OF		4
    #define OPTION_BTN_GC		5
    #define OPTION_BTN_SND_OFF	6
    #define OPTION_BTN_BGM_OFF	7

    #define OVER_BTN_YES        8
    #define OVER_BTN_NO         9

    #define OPTION_BTN_BG       10
    #define OPTION_IMG_MAX		11
#endif

#define  BAR_SCALEX  1.2
#define  BAR_SCALEY  1.1
#define  WORD_SCALE 0.5
#define  PIC_SCALE  1

int GetLevelMode();//easy,normal,hard

void GameOptionBegin();
void GameOptionEnd();
void GameOptionUpdate(float dt);
void GameOptionRender(float dt);
void GameOptionOnTouchEvent(int touchStatus, float fX, float fY);

void ClickBGM();
void ClickVolume();
void ClickGameCenter();
void ClickOpenFeint();

void ClickCredit();
void ClickDifficulty();

void ClickResetData();

class Image;

extern int TitleLevelIndex;

extern Image* optionBtnImg[OPTION_IMG_MAX];

extern bool m_bBgm;
extern bool m_bSounds;
extern bool m_b4iPod;
extern bool m_b4sSnd;
extern bool isClearData;

extern bool  BtnPress[BTN_NUM_MAX_OPTIONS];
extern float mBtnRectOption[BTN_ELE_MAX_OPTIONS];
extern float BtnOptionStartPos[2];

