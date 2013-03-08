/*
 *  GameState.h
 *  ZPR
 *
 *  Created by Neo01 on 5/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

// Game states
#define	GAME_STATE_SYS				0
#define	GAME_STATE_INIT				1
#define	GAME_STATE_SPLASH			2
#define	GAME_STATE_TITLE			3
#define	GAME_STATE_MISSION_SELECT	4
#define	GAME_STATE_GAME_PLAY		5
#define	GAME_STATE_FAILD			6

#define	GAME_STATE_PAUSE			7
#define GAME_STATE_CREDIT			8
#define GAME_STATE_SUC		        9
#define	GAME_STATE_OVER			    10
#define	GAME_STATE_CAUGHT_OVER		11

#define GAME_STATE_STORY			12
#define GAME_STATE_ACHIEVE			13
#define GAME_STATE_OPTION			14
#define GAME_STATE_HOUSE			15
#define GAME_STATE_LEVEL_SELECT		16

#define GAME_STATE_LOADING			17
//#define GAME_STATE_SUC_INFO		    17

#define GAME_STATE_NEWS				18
#define GAME_STATE_GCOP				19
#define GAME_STATE_LEVELTWL_SELECT		20
#define GAME_STATE_BEDROOM		21
#ifdef __IN_APP_PURCHASE__
#define GAME_STATE_STORE            22
#define GAME_STATE_RUNNERMODE       23
#define GAME_STATE_TRAMPOLINE       24
#define GAME_STATE_ADS              25
#endif
#ifdef V_1_1_0
#define GAME_STATE_TIPS             26
#endif

#ifdef __PROMOTE_ADS__
#define ADS_STATE_FREE_SHOE       0
#define ADS_STATE_FREE_BED        1
#define ADS_STATE_FREE_BUY        2

#define ADS_STATE_FULL_SHOE       3
#define ADS_STATE_FULL_BED        4   
#define ADS_STATE_FOUTH_BUY       5
#endif

//#ifdef V_1_1_0
//    #ifdef VERSION_IPAD
//        #ifdef V_FREE
//            #define GC_ID_ALL_LEVELS "947937"
//        #else
//            #define GC_ID_ALL_LEVELS "927937"
//        #endif
//    #else
//        #ifdef V_FREE
//            #define GC_ID_ALL_LEVELS "937937"
//        #else
//            #define GC_ID_ALL_LEVELS "917937"
//        #endif
//    #endif       
//#endif

#define LEVEL_NAME1			"CITY CENTER"
#define LEVEL_NAME2			"CONSTRUCTION AREA"
#define LEVEL_NAME3			"AMUSEMENT PARK"
#define LEVEL_NAME4			"OLDTOWN"
#define REPlAY			    "REPlAY"
#define QUIT			    "QUIT"
#define SOUND		        "SOUND"
#define MUSIC			    "MUSIC"
#define OPENFEINT			"OPENFEINT"
#define GAMECENTER			"GAMECENTER"
#define RESETDATA           "CLEAR PROFILE"
#define BACK			    "BACK"

#ifdef V_1_1_0
    #define ALL_NAME_MAX	12
#else
    #define ALL_NAME_MAX	10
#endif
extern int g_nGameState;
extern int g_nPrevGameState;
extern int g_nNextGameState;
class Image;
// Touches
extern int		g_nButtonPress;
extern float	g_fButtonXY[2];

// Timer
extern int		g_nFrameCount;
     
// Resource Manager
class NeoRes;
extern NeoRes* g_MenuResMgr;	// The resource that can be released when entering the stage
extern NeoRes* g_UiResMgr;
extern NeoRes* g_GcResMgr;
extern NeoRes* g_GcOverResMgr;
extern NeoRes* g_HouseResMgr;
extern NeoRes* g_StoryResMgr;
#ifdef __IN_APP_PURCHASE__
extern NeoRes* g_StoreResMgr;
#endif
#ifdef __PROMOTE_ADS__
extern NeoRes* g_AdsResMgr;
#endif

// Canvas Mask
#define CANVAS_NORMAL	0
#define CANVAS_FADE_IN	1
#define CANVAS_FADE_OUT	2
extern int g_canvas_state;
extern float g_alpha;
extern float g_alpha_delta;

extern char* Name[ALL_NAME_MAX];

extern bool bSuspend;
extern bool bResume;
extern int mStoryIndex;  
extern bool isPurchase;

extern int accessPath;

#ifdef V_1_1_0
#ifdef V_FREE
extern int totalScoreForGameCenter;
#endif
#endif

#ifdef _AD_ADCOLONY_EMBEDDED_
extern int gsCountGameOver;
extern int tabAdPlayList[8];
void resetCountGameOver();
void setCountGameOver();
int  getCountGameOver();
void resetTabAdPlayList();
#endif

// Game State Switching
int UpdateTouches(int nOption, float fX, float fY);
int MultiTouch(int nOption, float fDist1, float fDist2);

void initGameData();
void freeGameData();

void initResGame();
void freeResGame();

void initResHouse();
void freeResHouse();

void initResStory(int index);
void freeResStory();

int SwitchGameState();
int UpdateGameState(float dt);
int RenderGameState(float dt);

void GameSuspend();
void GameResume();

void setLockScreenOrientation(bool flag);

void setGlobalFadeInAndGoTo(int nextState = -1);
void setGlobalFadeOutAndGoTo(int nextState = -1);
void setGlobalFadeInThenGoTo(int nextState = -1);
void setGlobalFadeOutThenGoTo(int nextState = -1);
void setCanvasMaskNormal();
void updateCanvasMask(float dt);
void renderCanvasMask(float dt);
bool isInFadingProcess();


extern int props_order[24];
