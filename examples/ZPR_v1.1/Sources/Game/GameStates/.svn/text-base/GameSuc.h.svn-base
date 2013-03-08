/*
 *  GameSuc.h
 *  ZPR
 *
 *  Created by Neo Lin on 5/31/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#define MENU_ITEM_STR_LEN_MAX	32


#define GAMESUCINFO_STEP_ACH_NOTI_ZOMBIE	0
#define GAMESUCINFO_STEP_ACH_NOTI_PARKOUR	1
#define GAMESUCINFO_STEP_ACH_NOTI_COIN		2
#define GAMESUCINFO_STEP_ACH_NOTI_ITEM		3
#define GAMESUCINFO_STEP_ACH_NOTI_COMBO		4
#define GAMESUCINFO_STEP_ACH_NOTI_DONE		5
#define GAMESUCINFO_STEP_ACH_NOTI_MAX		6

//class MenuItem : public InfoTag
//{
//public:
//	MenuItem(float x, float y, const char* str, float duration);
//	~MenuItem();
//	
//	void update(float dt);
//	void render(float dt);
//	
//public:
//	char str[MENU_ITEM_STR_LEN_MAX];
//	
//	float alpha;
//	float yv, ya;
//	
//	float sx, sy;
//	float dw;
//};
void GameSucBegin();
void GameSucEnd();
void GameSucUpdate();
void GameSucRender(float dt);
void GameSucOnTouchEvent(int touchStatus, float fX, float fY);

class Image;
//extern Image* mResultBG;


extern Image* mReplaybg;
extern 
Image* mDropBox;
extern Image* mNext;
extern Image* mNextWord;
extern Image* mReplayWord;
extern int stepSucInfo;
