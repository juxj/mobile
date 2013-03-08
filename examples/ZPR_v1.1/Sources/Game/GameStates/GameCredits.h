/*
 *  GameCredits.h
 *  ZPR
 *
 *  Created by Linda Li on 6/23/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */
#define MAX_NAME_OBJECT			56
typedef struct NameObject{
	char* name;
	bool  isLeder;
} NAMEOBJECT;
extern NAMEOBJECT g_NameObj[MAX_NAME_OBJECT];

void GameCreditsBegin();
void GameCreditsEnd();
void GameCreditsUpdate(float dt);
void GameCreditsRender(float dt);
void GameCreditsOnTouchEvent(int touchStatus, float fX, float fY);

class Image;
extern Image* mCredits;
extern float g_fCredit;