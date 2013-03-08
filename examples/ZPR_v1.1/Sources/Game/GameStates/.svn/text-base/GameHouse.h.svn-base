/*
 *  GameHouse.h
 *  ZPR
 *
 *  Created by Linda Li on 7/19/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */


#ifdef V_1_1_0
#define MAX_ITEM     36
#else
#define MAX_ITEM    (24)
#endif

class Image;
extern Image* mHouse;

extern Image* mCutRoomBtn;
extern int ShowDetail;
extern bool mObjFlag[MAX_ITEM];
extern Image* mHouseBackBrand;
extern Image* mBedroomBackBrand;
extern bool toFirstRoom;
extern bool toSecondRoom;
extern float houseOffset;

void GameHouseBegin();
void GameHouseEnd();
void GameHouseUpdate(float dt);
void GameHouseRender(float dt);
void GameHouseOnTouchEvent(int touchStatus, float fX, float fY);

void setProps(int i);
void DrawMultiLineString(const char* str, float fx, float fy, float scale, float width, float heightinterval, float r = 1.0f, float g = 1.0f, float b = 1.0f, float a = 1.0f);
int ClickHouseObj(float fx,float fy,float startfx,float startfy);
