/*
 *  GameRes.h
 *  ZPR
 *
 *  Created by Neo01 on 5/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __GAME_RES_H__
#define __GAME_RES_H__

#import <OpenGLES/ES1/gl.h>

#import "Font.h"

#import "GameSection.h"


#define MAX_GAME_TEXTURE		32
#define PNG_FONT				0
#define PNG_P1					1
#define MAX_ACHIEVE				24
#define MAX_BEDROOM_PROPS		12
#define MAX_STORY				25

#define BG_UINIT_WIDTH			29
#define  BG_OPTIOH_UINIT_WIDTH   30

#define BACK_COLOR   0.46

//extern GLuint g_nGameTextures[MAX_GAME_TEXTURE];


//void InitTexture(GLuint *pointer, NSString *name);
void setPercent(float m);
float getPercent();

void InitGameTextures();
void ReleaseGameTextures();

void InitMenuRes();
void RelMenuRes();

//void InitCreditRes();
//void RelCreditRes();

void InitGcRes();
void RelGcRes();

void InitGcOverRes(int iOver);
void RelGcOverRes();

#ifdef __IN_APP_PURCHASE__
void initResStore();
void freeResStore();
#endif

#ifdef __PROMOTE_ADS__
void initResAds();
void freeResAds();
#endif

void drawSky();

class Image;
class Sprite;

extern Image* mBg;

#ifdef DBG_MEM_MONITOR
class Font;
extern Font* mFont0;
#endif

class Stage;
extern Stage* stages;

//title
extern Image* mOptionBarbg;
extern Image* mTitleBG;
extern Image* mTitleBG2;
extern Image* mClose;	
extern Image* m2TitleBG;
extern Image* mLevelbgsky[5];
extern Image* mSound[2];
extern Image* mVolume[2];
extern Image* adsImage;


//Success
extern Image* m2TitleBG;
extern Image* mQestion;

//select
extern Image* mBack;
extern Image* mStars[3];
extern Image* mSelectPlay[2 * LEVEL_NUM_MAX];
extern Image* mLevel[3];
extern Image* mOptionStar[2];

extern Image* mBackbg;

#ifdef __PROMOTE_ADS__

//extern Image* ads_iPad_free_shoes;
//extern Image* ads_iPad_free_bed;
//extern Image* ads_iPad_free_buy;
//extern Image* ads_iPad_full_shoes;
//extern Image* ads_iPad_full_bed;

extern Image* ads_shoes;
extern Image* ads_buy;
extern Image* ads_bed;
extern Image* ads_fouth;

#endif

//house and bedroom
extern Image* mAchieve[MAX_ACHIEVE];
extern Image* mAchieveInfo[MAX_ACHIEVE];
extern Image* mBedroomProps[MAX_BEDROOM_PROPS];
extern Image* mBedroomPropsInfo[MAX_BEDROOM_PROPS];

extern Image* mStory[MAX_STORY];

extern Image* mSucInfoImg[10];

extern Image* mNewsImg[14];

extern Image* mGcIcons[2];

extern Sprite* mEffect1;
extern Sprite* mEffect2;
extern Sprite* mEffect3;
extern Sprite* mEffect4;
extern Sprite* mStartGiant;

//extern Sprite* mStartGiant;
//extern Sprite* mStartGiant2;

#ifdef __IN_APP_PURCHASE__
// Store
extern Image* mStoreBg;
#endif

#endif //__GAME_RES_H__
