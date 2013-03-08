//
//  Runner.h
//  ZPR
//
//  Created by futao.huang on 11-7-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef __RUNNER_H__
#define __RUNNER_H__

#import "GameSection.h"

//=========================================================================
//const
//=========================================================================
#define PTM_RATIO	32
#define PTM_GRAVITY	19.56f
#define PTM_GRAVITY2	4.89f
#define PTM_GRAVITY3	14.72f

#define BLOCK_TILES_SIZE			(11)//block type nums
#define BLOCK_FLAT_TERRAIN			0
#define BLOCK_BILL_BOARD			1
#define BLOCK_NEED_CRAWL			2
#define BLOCK_STREET_LIGHT			3
#define BLOCK_DEBRIS_HIT			4
#define BLOCK_BARBED_WIRE			5
#define BLOCK_WATER_DELAY			6
#define BLOCK_LINES_CLIMB			7
#define BLOCK_LINES_SLIDE			8
#define BLOCK_POLE_SWING			9
#define BLOCK_TILE_FENCE			10

#define ZONE_SLOW_MOTION			100
#define ZONE_RECOVER_MOTION			101

#ifdef ENABLE_CHECKPOINT
#define BLOCK_CHECK_POINT			200	// 200, 201, 202...
#define CHECK_POINT_MAX				(16)
#define CHECK_POINT_DATA_ELEMENTS	(8)
#define NUM_CHECK_POINT_MAX			(CHECK_POINT_DATA_ELEMENTS * CHECK_POINT_MAX)
#endif


//=========================================================================
//setting
//=========================================================================
#define CAMERA_WHEEL_SPEED			1.0f//wheel camera speed
#define CAMERA_NORMAL_SPEED			4.0f//normal camera speed
#define CAMERA_BOSS_SPEED			0.0f//boss camera speed
#define CAMERA_DIVE_SPEED			2.0f//dive camera speed
#define CAMERA_HIPPIE_SPEED			3.0f//hippie camera speed

#define ATTACK_WHEEL_SPEED			2.5f//Attack Zombie Wheel
#define ATTACK_NORMAL_SPEED			0.2f//Attack Zombie Norml
#define ATTACK_BOSS_SPEED			1.0f//Attack Zombie Boss
#define ATTACK_DIVE_SPEED			2.0f//Attack Zombie Dive
#define ATTACK_HIPPIE_SPEED			3.0f//Attack Zombie Hippie


#define TIME_SLOW_MOTION			1000.0f	// 1000ms
#define SLOW_MOTION_RATIO			5.00f	// slow down the motion with this target ratio

#define CAMERA_ADJUST_SPEED			1.5f//adjust camera speed
#define CAMERA_FALLOW_SPEED			8.0f//fallow camera speed
#define CAMERA_LEAST_SPEED			4.0f//least camera speed

#define CAMERA_MAX_WIDTH			20//screen width reference
#define CAMERA_NIN_WIDTH			-100//screen width reference
#define DISTANCE_KASH_VAULT			96//kash vault success distance
#define DISTANCE_TIC_TAC			32//failed vault/tic tac distance
#define DISTANCE_CAT_LEAP			16//ledge/cat leap height distance
#define	TIME_TOUCH_VALID			0.350f//emulate key hold
#define	TIME_TOUCH_AVOID			0.150f//avoid key hold


#define PLAYER_RUN_SPEED			8.0f//nomal run speed
#define PLAYER_RUN_FASTER			9.0f//fast run speed
#define PLAYER_JUMP_SPEED			9.0f//jump horizontal speed
#define PLAYER_JUMP_FASTER			9.5f//fast horizontal speed
#define PLAYER_VSP_SPEED			9.0f//jump vertical speed
#define PLAYER_VSP_FASTER			9.5f//fast vertical speed

#define PLAYER_NORMAL_SPEED			8.0f//player nomal speed
#define PLAYER_WALK_SPEED			3.0f//player walk speed
#define PLAYER_VAULT_SPEED			11.0f//better vault speed
#define PLAYER_JETE_SPEED			6.0f//npc jump speed
#define PLAYER_BOARD_SPEED			3.0f//board vsp speed
#define PLAYER_CRAWL_SPEED			6.0f//crawl slow speed
#define PLAYER_WATER_SPEED			6.0f//water stumb speed
#define PLAYER_ATTAC_SPEED			6.0f//attack zombie speed


//=========================================================================
//setting
//=========================================================================
#define PLAYER_SHIFT_X			45
#define	PLAYER_SHIFT_Y			80
#define PLAYER_SHIFT_W			8
#define	PLAYER_SHIFT_H			50

#define	GAME_FIN_SUCC			(3*32)
#define	GAME_FIN_AUTO			(12*32)
#define	GAME_FIN_DISABLE_TR     (16*32)
#ifdef VERSION_IPAD
	#define	GAME_FIN_WIDTH			(512)
#else
	#define	GAME_FIN_WIDTH			(480)
#endif

#define CHECK_TYPE_ATTACK		0
#define CHECK_TYPE_TOUCH		1
#define CHECK_TYPE_HURT			2
#define CHECK_TYPE_WATER		3

#define VALID_ATTACK_SHIFT		10
#define VALID_ATTACK_LEFT		60
#define VALID_ATTACK_WATER		135
#define VALID_ATTACK_HIPPIE		35

//=========================================================================
//setting
//=========================================================================

#define ACTION_VAULT	"Kash Vault"
#define ACTION_SWING	"Swing"
#define ACTION_LINES	"Zip Line"
#define ACTION_MONKEY	"Monkeybars"
#define ACTION_SLIDE	"Slide"
#define ACTION_BOARD	"Wall Run"

#define ACTION_WHEEL	"Wheels!"
#define ACTION_NORMAL	"Salaryman!"
#define ACTION_BIGGER	"Off to the Races!"
#define ACTION_DIVER	"Triple Gainer!"
#define ACTION_HIPPLE	"Groovy, Man!"

#define TAP_TO_START	"Tap to Start"

#define WELCOME_FONT_SIZE	0.9f

#define WELCOME_CITYS_00	"\"Welcome to Paradise!\""
#define WELCOME_CITYS_01	"\"Short Jumper\""
#define WELCOME_CITYS_02	"\"Billboards & Barbed Wire\""
#define WELCOME_CITYS_03	"\"Wheels & Deals\""
#define WELCOME_CITYS_04	"\"The Scaffold Slide\""
#define WELCOME_CITYS_05	"\"Urban Ascent\""
#define WELCOME_CITYS_06	"\"Zombie Alley\""
#define WELCOME_CITYS_07	"\"Speed Demon\""
#define WELCOME_SITES_00	"\"Eli's Coming\""
#define WELCOME_SITES_01	"\"Barrel of Monkey Bars\""
#define WELCOME_SITES_02	"\"Swing is the Thing\""
#define WELCOME_SITES_03	"\"Diver? I Barely Know Her!\""
#define WELCOME_SITES_04	"\"Barbs & Wire\""
#define WELCOME_SITES_05	"\"Short Hops\""
#define WELCOME_SITES_06	"\"Zombie Fight\""
#define WELCOME_SITES_07	"\"Hips Swing!\""
#define WELCOME_PARAD_00	"\"Kashin' In\""
#define WELCOME_PARAD_01	"\"Underground\""
#define WELCOME_PARAD_02	"\"Slip and Slide\""
#define WELCOME_PARAD_03	"\"Light it Up\""
#define WELCOME_PARAD_04	"\"Low Jumps and Tricks\""
#define WELCOME_PARAD_05	"\"Think Fast!\""
#define WELCOME_PARAD_06	"\"Leap of Faith\""
#define WELCOME_PARAD_07	"\"Monkey Bars\""
#define WELCOME_CITYS2_00	"\"UP UP DOWN DOWN!\""
#define WELCOME_CITYS2_01	"\"Watch Your Step\""
#define WELCOME_CITYS2_02	"\"Long Jump\""
#define WELCOME_CITYS2_03	"\"Slide Under Barbed Wires\""
#define WELCOME_CITYS2_04	"\"Zombie Army\""
#define WELCOME_CITYS2_05	"\"Zombie Stairs\""
#define WELCOME_CITYS2_06	"\"Tricks of Boxes\""
#define WELCOME_CITYS2_07	"\"Narrow Footholds\""
#define WELCOME_CITYS2_08	"\"Swing Like Tarzan\""
#define WELCOME_CITYS2_09	"\"Billboards\""
#define WELCOME_CITYS2_10	"\"Stepping Stones\""
#define WELCOME_CITYS2_11	"\"Thrilling Short Jumps\""

//=========================================================================
//state
//=========================================================================
#define PLAYER_STATE_SIZE			(31)

#define PLAYER_STATE_STAND			(0)
#define PLAYER_STATE_RUN			(1)
#define PLAYER_STATE_JUMP			(2)
#define PLAYER_STATE_GRAB			(3)//Jump
#define PLAYER_STATE_FALL			(4)
#define PLAYER_STATE_DROP			(5)//Jump Drop
#define PLAYER_STATE_SCROLL			(6)
#define PLAYER_STATE_SLIDE			(7)
#define PLAYER_STATE_WATER			(8)
//#define PLAYER_STATE_STUMB			()

#define PLAYER_STATE_WALK			(9)
#define PLAYER_STATE_QUICK			(10)
#define PLAYER_STATE_CRAWL			(11)
#define PLAYER_STAND_JUMP			(12)
#define PLAYER_STATE_CAT			(13)
#define PLAYER_STATE_FAIL			(14)

#define PLAYER_STATE_BOARD			(15)
#define PLAYER_BOARD_FALL			(16)
#define PLAYER_LINES_CLIMB			(17)//Lines Up
//#define PLAYER_CLIMB_FALL			()
#define PLAYER_STATE_LIGHT			(18)
//#define PLAYER_LIGHT_FALL			()
#define PLAYER_STATE_PRAN			(19)
///#define PLAYER_STATE_PRAN2			()

#define PLAYER_LINES_SLIDE			(20)
//#define PLAYER_SLIDE_FALL			()
#define PLAYER_STATE_RINGS			(21)//Rings Ready
#define PLAYER_STATE_RINGS2			(22)//Rings Fly
//#define PLAYER_RINGS_FALL			(23)
///#define PLAYER_STATE_JETE			()
#define PLAYER_STATE_JETE2			(24)
#define PLAYER_STATE_SUCC			(25)

#define PLAYER_ATTAC_RUN			(26)
#define PLAYER_ATTAC_NORM			(27)
#define PLAYER_ATTAC_BIG			(28)
#define PLAYER_ATTAC_WATER			(29)
#define PLAYER_ATTAC_HIPPIE			(30)

//=========================================================================
//varia
//=========================================================================
extern float mScrollWorld;
class Sprite;
extern Sprite* mPlayer;

extern float cameraX, cameraY;
extern float cameraYMax;
extern float defaultCameraY;
extern float mStepCam;

extern float ColorShadow[4][4];
extern int mActionCount;
extern int mFastLevel;
extern bool mFastFlag;

extern bool mRunnerMode[LEVEL_NUM_MAX][STAGE_IN_LV_MAX];

void InitShadow();
void DisableShadow();
void ResetShadow();
void UpdateShadow();
void RenderShadow();

void InitializePlayer();
#ifdef __IN_APP_PURCHASE__
void PlayerJumpTo();
#endif
void RenderPlayer();
void UpdatePlayer(float dt);
bool isEnableTouchRm();
bool isEnableTouchTr();
void TouchPlayer(int touchStatus, float fX, float fY);
void SetPlayer(int state);

float GetPlayerX();
float GetPlayerY();
void SetPlayerAction(int action);
int GetPlayerAction();

void UpdateWorld(float dt);
void SetFailState();
void SetSuccState();
void SetWalkState(bool flag);
bool IsAutoState();

int IsBlockLand(float tx, float ty, float *xx, float *yy);
bool IsBlockFence(float tx, float ty, float *xx, float *yy);
int IsBlockCollide(float tx, float ty, float *xx, float *yy);
bool IsBoardAttach(float x, float y);
bool IsPoleSwing(bool flag, float x, float y, float w, float h);

void panUpDnCamera(float dy);
//void panUpDnCameraTo(float dy);
//void updateCamera();
void defaultCamera();
void setDefaultCamY(float defaultCamY);

bool isRunnerMode();

#endif //__RUNNER_H__
