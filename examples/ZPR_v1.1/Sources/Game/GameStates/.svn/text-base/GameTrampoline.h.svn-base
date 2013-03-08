//
//  GameTrampoline.h
//  ZPR
//
//  Created by Neo Lin on 11/11/11.
//  Copyright (c) 2011 Break Media. All rights reserved.
//

#ifndef __ZPR_GameTrampoline_h__
#define __ZPR_GameTrampoline_h__

#define IG_TRAMPOLINE_INIT      0
#define IG_TRAMPOLINE_W_FIN     1
#define IG_TRAMPOLINE_W_STAY    2
#define IG_TRAMPOLINE_W_FOUT    3
#define IG_TRAMPOLINE_FIN       4
#define IG_TRAMPOLINE_ANIM      5
#define IG_TRAMPOLINE_FOUT      6
#define IG_TRAMPOLINE_DONE      7

#define IG_TRAMPOLINE_WORDS_Y   144.0f

#define IG_TRAMPOLINE_WORDS_STIME   (45)    // 45frames


class Image;

#define NEW_TR_EFFECTS

#ifdef NEW_TR_EFFECTS
#define IG_TRAMPOLINE_COMICS_ARR    (8 * 10)
#define IG_TRAMPOLINE_COMIC_FIN     0
#define IG_TRAMPOLINE_COMIC_CUT_1   1
#define IG_TRAMPOLINE_COMIC_CUT_2   2
#define IG_TRAMPOLINE_COMIC_CUT_3   3
#define IG_TRAMPOLINE_COMIC_CUT_4   4
#define IG_TRAMPOLINE_COMIC_CUT_ALL 5
#define IG_TRAMPOLINE_COMIC_FOUT    6
#define IG_TR_COMIC_STILL_FRAMES    30

extern Image *igTrComic;
extern int   igComicStep;
extern float igTrAlpha;
extern int   igTrCount;
#else
#define IG_TR_LN_X_OFFSET   0
#define IG_TR_LN_Y_OFFSET   1
#define IG_TR_LN_S_OFFSET   2
#define IG_TR_LN_W_OFFSET   3
#define IG_TR_LN_ELEMENT    4

#define IG_TRAMPOLINE_MAX_W_LINES   8
#define IG_TRAMPOLINE_MAX_B_LINES   8
#define IG_TRAMPOLINE_W_LINES_ARRAY_SIZE  (IG_TR_LN_ELEMENT*IG_TRAMPOLINE_MAX_W_LINES) // x, y, spd
#define IG_TRAMPOLINE_B_LINES_ARRAY_SIZE  (IG_TR_LN_ELEMENT*IG_TRAMPOLINE_MAX_B_LINES)

#define IG_TRAMPOLINE_KARA_0    0
#define IG_TRAMPOLINE_KARA_1    1
#define IG_TRAMPOLINE_KARA_MAX  2

#define IG_TRAMPOLINE_KARA_0    0
#define IG_TRAMPOLINE_KARA_1    1
#define IG_TRAMPOLINE_KARA_MAX  2

#define IG_TRAMPOLINE_KARA_S0    0
#define IG_TRAMPOLINE_KARA_S1    1
#define IG_TRAMPOLINE_KARA_S2    2  // done
#define IG_TRAMPOLINE_KARA_S_MAX 3

extern Image *igTrBg;
extern Image *igTrLnW;
extern Image *igTrLnB;
extern Image *igTrKara[IG_TRAMPOLINE_KARA_MAX];

extern float igTrWLns[IG_TRAMPOLINE_W_LINES_ARRAY_SIZE];
extern float igTrBLns[IG_TRAMPOLINE_B_LINES_ARRAY_SIZE];

extern float igTrPlayerX;
extern float igTrPlayerY;
#endif

extern bool usingTrampoline;
extern float alphaTrampoline;

extern int igTrState;

extern int igTrWordsCount;

class Sprite;
extern Sprite *igTrWords;

void initGameTrampolineRes();
void relGameTrampolineRes();

void GameTrampolineBegin();
//void GameTrampolineEnd();
void GameTrampolineUpdate(float dt);
void GameTrampolineRender(float dt);
void GameTrampolineTouchEvent(int touchStatus, float fX, float fY);

#ifdef NEW_TR_EFFECTS
void drawTrComicCut1(float x, float y);
void drawTrComicCut2(float x, float y);
void drawTrComicCut3(float x, float y);
void drawTrComicCut4(float x, float y);
#endif

#endif  //__ZPR_GameTrampoline_h__
