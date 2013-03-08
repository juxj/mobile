/*
 *  GamePlay.h
 *  ZPR
 *
 *  Created by Neo Lin on 5/31/11.9670
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#define TYPE_HOUSE_BG		0
#define TYPE_OPTION_BG		1
#define TYPE_SELECT_BG		2
#define TYPE_LEVEL_BG		3
#define TYPE_SUCC_BG		4
#define TYPE_FAIL_BG		5
#define TYPE_FAIL_CAUGHT_BG 6
#define TYPE_SUCC_INFO_BG   7
#define TYPE_PAUSE_BG       8
//#define TYPE_TWELVE_LEVEL_BG		9

#define TILE_HOUSE_ROW		7
#define TILE_HOUSE_COL		7
#define TILE_OPTION_ROW		9
#define TILE_OPTION_COL		9
#define TILE_PAUSE_ROW		8
#define TILE_PAUSE_COL		8
#define TILE_SELECT_ROW		8
#define TILE_SELECT_COL		13
#define TILE_LEVEL_ROW		9
#define TILE_LEVEL_COL		14
#define TILE_TWELVE_LEVEL_ROW		10
#define TILE_TWELVE_LEVEL_COL		14
#define TILE_SUCC_ROW		10
#define TILE_SUCC_COL		13
#define TILE_FAIL_ROW		3
#define TILE_FAIL_COL		13
#define TILE_FAIL_CAUGHT_ROW 5
#define TILE_FAIL_CAUGHT_COL 8
#define TILE_SUCC_INFO_ROW  11
#define TILE_SUCC_INFO_COL  16


void GamePlayBegin();
void GamePlayEnd();
void GamePlayUpdate(float dt);
void GamePlayRender(float dt);
void GamePlayOnTouchEvent(int touchStatus, float fX, float fY);

void RenderTileBG(int type, int x, int y,float scaleX,float scaleY);

#ifdef V_1_1_0
bool checkRunnerModeIsUsable();
bool checkTrampolineIsUsable();

void useItemRunnerMode();
void useItemTrampoline();
void updateItemUsage();
#endif

class Image;

extern Image* mCoin;
extern int mGetCoin;
extern int mGetScore;

extern int levelRating;

class Sprite;
extern Image* mPause;
extern Image* mTiledBg[8*8];

#ifdef __IN_APP_PURCHASE__
class ZprUIButton;
extern ZprUIButton *inGameBtnRunnerMode;
extern ZprUIButton *inGameBtnTrampoline;
void updateItemCounts();
#define ITEM_NONE       0
#define ITEM_NOTALLOW   1
#define ITEM_READY      2
#define ITEM_USE        3
#define ITEM_IN_USE     4
#define ITEM_STATE_MAX  5

extern int extRunnerMode;
extern int extTrampoline;

// Speed Meter
#define SPEEDMETER_FIRE_W   (64.0f)
#ifdef VERSION_IPAD
#define SPEEDMETER_FIRE_Y   (8.0f + 32.0f)
#else
#define SPEEDMETER_FIRE_Y   (8.0f)
#endif
#define SPEEDMETER_FIRE_OFFY (0.0f)

#define SPEEDMETER_TAG_OFFX 4.5f
#define SPEEDMETER_TAG_OFFY (34.0f-8.0f-SPEEDMETER_FIRE_OFFY)
#define SPEEDMETER_TAG  0
#define SPEEDMETER_TAG1 1
#define SPEEDMETER_TAG2 2
#define SPEEDMETER_TAG3 3
#define SPEEDM_NUM_OFFX 46.0f
#define SPEEDM_NUM_OFFY (24.0f-SPEEDMETER_FIRE_OFFY)
extern Image *spdmTags[4];

#define SPEEDMETER_PANE_OFFX 9.5f
#define SPEEDMETER_PANE_OFFY (32.0f-SPEEDMETER_FIRE_OFFY)
extern Sprite *spdmFire;
extern Sprite *spdmPane;
extern int nShowSpeedMeter;

#define SPEEDMETER_HIDE     0
#define SPEEDMETER_SHOW     1
#define SPEEDMETER_FADE_OUT 2
#define SPEEDMETER_FADE_OUT_TIME    24
extern int spdmState;
extern int spdmLv;
extern int spdmFadeCnt;
extern float spdmAlpha;
#define MAX_TIME_TO_SHOW_SPD_METER  2   // 1+1

void setSpeedMeter(int level);
void updateSpeedMeter(float dt);
void renderSpeedMeter(float dt);
#endif

//extern int mDistance;
//extern int mPassTerrain;
//extern int mFightZombie;

