/*
 *  GameNews.h
 *  ZPR
 *
 *  Created by Neo Lin on 9/20/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#define NEWS_BTN_QUIT			0
#define NEWS_BTN_PGUP			1
#define NEWS_BTN_PGDN			2
#define NEWS_BTN_MAX			3
#define NEWS_BTN_DATA_ELEM		4
#define NEWS_BTN_DATA_LENGTH	(NEWS_BTN_MAX * NEWS_BTN_DATA_ELEM)

#define NEWS_BTN_QUIT_INDEX		(NEWS_BTN_DATA_ELEM * NEWS_BTN_QUIT)
#define NEWS_BTN_PGUP_INDEX		(NEWS_BTN_DATA_ELEM * NEWS_BTN_PGUP)
#define NEWS_BTN_PGDN_INDEX		(NEWS_BTN_DATA_ELEM * NEWS_BTN_PGDN)

#define BTN_QUIT_NORMAL_SCALE	1.0f
#define BTN_QUIT_PRESSED_SCALE	1.2f

#define NEWS_FONT_SIZE_SCALE	0.6f

#define NEWS_NONE		0
#define NEWS_CACHED		1
#define NEWS_DLD		2
#define NEWS_CHECK		3
#define NEWS_REFRESH	4
#define NEWS_DONE		5

extern int  newsFlag;
extern bool newsChecked;
extern int  newsNoti;
extern char newsData[1024];

void GameNewsBegin();
void GameNewsUpdate(float dt);
void GameNewsRender(float dt);
void GameNewsTouchEvent(int touchStatus, float fX, float fY);

void GameNewsDownload();
void GameNewsHaveRead();
int  GameNewsCheck();
void GameNewsCheckManually();
void GameNewsFrame(float x = 0.0f, float y = 96.0f, float w = 36.0f, float h = 84.0f, float alpha = 1.0f);
