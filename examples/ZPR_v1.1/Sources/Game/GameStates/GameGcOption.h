/*
 *  GameGcOption.h
 *  ZPR
 *
 *  Created by Neo Lin on 9/24/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#define GCOP_BTN_QUIT			0
#define GCOP_BTN_GCLB			1
#define GCOP_BTN_GCAS			2
#define GCOP_BTN_MAX			3
#define GCOP_BTN_DATA_ELEM		4
#define GCOP_BTN_DATA_LENGTH	(GCOP_BTN_MAX * GCOP_BTN_DATA_ELEM)

#define GCOP_BTN_QUIT_INDEX		(GCOP_BTN_DATA_ELEM * GCOP_BTN_QUIT)
#define GCOP_BTN_GCLB_INDEX		(GCOP_BTN_DATA_ELEM * GCOP_BTN_GCLB)
#define GCOP_BTN_GCAS_INDEX		(GCOP_BTN_DATA_ELEM * GCOP_BTN_GCAS)

//#define BTN_QUIT_NORMAL_SCALE	1.0f
//#define BTN_QUIT_PRESSED_SCALE	1.2f

void GameGcOptionBegin();
void GameGcOptionUpdate(float dt);
void GameGcOptionRender(float dt);
void GameGcOptionTouchEvent(int touchStatus, float fX, float fY);

void GameCommonFrame(float x, float y, float w, float h, float alpha);
