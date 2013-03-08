//
//  GameTrampoline.mm
//  ZPR
//
//  Created by Neo Lin on 11/11/11.
//  Copyright (c) 2011 Break Media. All rights reserved.
//

#import "GameTrampoline.h"

#import "Canvas2D.h"
#import "neoRes.h"
#import "Texture2D.h"
#import "Image.h"
#import "Sprite.h"

#import "GameState.h"
#import "GamePlay.h"

#import "Runner.h"
#import "Giant.h"

#import "Stage.h"
#import "GameRes.h"


#ifdef NEW_TR_EFFECTS
Image *igTrComic = NULL;
int   igComicStep = IG_TRAMPOLINE_COMIC_FIN;
float igTrAlpha = 0.0f;
int   igTrCount = 0;
#else
Image *igTrBg = NULL;
Image *igTrLnW = NULL;
Image *igTrLnB = NULL;
Image *igTrKara[IG_TRAMPOLINE_KARA_MAX];

float igTrWLns[IG_TRAMPOLINE_W_LINES_ARRAY_SIZE];
float igTrBLns[IG_TRAMPOLINE_B_LINES_ARRAY_SIZE];

int   igTrPlayerS = 0;
float igTrPlayerX = 0.0f;
float igTrPlayerY = 0.0f;
float igTrPlayerSX = 0.0f;
float igTrPlayerSY = 0.0f;
float igTrPlayerRot = 0.0f;
#endif

int igTrState = 0;

float alphaTrampoline = 0.0f;
bool usingTrampoline = false;

int igTrWordsCount;

Sprite *igTrWords;


void initGameTrampolineRes()
{
    igTrWords = new Sprite();
	g_GcResMgr->createSprite(igTrWords, "ist.xml", NULL, IMG_RES_SCALE, IMG_RES_SCALE);
    
#ifdef NEW_TR_EFFECTS
    #ifdef VERSION_IPAD
        g_UiResMgr->createImage("igtr", "igtr.png", 0.0f, 0.0f, 1024.0f, 768.0f, 0.0f, 0.0f);
    #else
        g_UiResMgr->createImage("igtr", "igtr.png", 0.0f, 0.0f, 480.0f, 320.0f, 0.0f, 0.0f);
    #endif
    igTrComic = g_UiResMgr->getImage("igtr");
#else
    Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA8888;
    #ifdef VERSION_IPAD
        g_UiResMgr->createImage("igtrbg", "igtrbg.png", 0.0f, 0.0f, 2.0f, 768.0f, 0.0f, 0.0f);
    #else
        g_UiResMgr->createImage("igtrbg", "igtrbg.png", 0.0f, 0.0f, 2.0f, 320.0f, 0.0f, 0.0f);
    #endif
	igTrBg = g_UiResMgr->getImage("igtrbg");
    Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA4444;
    
    g_UiResMgr->createImage("igtrlnw", "igtrln.png", 0.0f, 0.0f * IMG_RES_SCALE, 128.0f * IMG_RES_SCALE, 8.0f * IMG_RES_SCALE, 0.0f, 0.0f);
	igTrLnW = g_UiResMgr->getImage("igtrlnw");
    g_UiResMgr->createImage("igtrlnb", "igtrln.png", 0.0f, 8.0f * IMG_RES_SCALE, 128.0f * IMG_RES_SCALE, 8.0f * IMG_RES_SCALE, 0.0f, 0.0f);
	igTrLnB = g_UiResMgr->getImage("igtrlnb");
    
    g_UiResMgr->createImage("igtrkara0", "igtrkara.png", 0.0f, 0.0f, 128.0f * IMG_RES_SCALE, 128.0f * IMG_RES_SCALE, 0.0f, 0.0f);
    g_UiResMgr->createImage("igtrkara1", "igtrkara.png", 128.0f * IMG_RES_SCALE, 0.0f, 121.0f * IMG_RES_SCALE, 121.0f * IMG_RES_SCALE, 0.0f, 0.0f);
	igTrKara[IG_TRAMPOLINE_KARA_0] = g_UiResMgr->getImage("igtrkara0");
    igTrKara[IG_TRAMPOLINE_KARA_0]->makeCenterAsAnchor();
    igTrKara[IG_TRAMPOLINE_KARA_1] = g_UiResMgr->getImage("igtrkara1");
    igTrKara[IG_TRAMPOLINE_KARA_1]->makeCenterAsAnchor();
#endif
}

void relGameTrampolineRes()
{
    if (igTrWords)
    {
        delete igTrWords;
        igTrWords = NULL;
    }
}

void GameTrampolineBegin()
{
    igTrState = IG_TRAMPOLINE_INIT;
    igTrWordsCount = 0;
    
    alphaTrampoline = 0.0f;
    usingTrampoline = true;
    
#ifdef NEW_TR_EFFECTS
    igComicStep = IG_TRAMPOLINE_COMIC_FIN;
    igTrAlpha = 0.0f;
    igTrCount = 0;
#else
    igTrPlayerS = IG_TRAMPOLINE_KARA_S0;
    igTrPlayerX = -170.0f+80.0f;
    igTrPlayerY = 180.0f+80.0f;
    igTrPlayerSX = 5.0f;
    igTrPlayerSY = 8.5f;
    igTrPlayerRot = 0.0f;
    
    for (int i = 0; i < IG_TRAMPOLINE_MAX_W_LINES; i++)
    {
        igTrWLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_X_OFFSET] = rand() % 16 * 32.0f;
        igTrWLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_Y_OFFSET] = rand() % 9 * 35.0f + 5.0f;
        igTrWLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_S_OFFSET] = -rand() % 8 - 16.0f;
        igTrWLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_W_OFFSET] = rand() % 192;
    }
    for (int i = 0; i < IG_TRAMPOLINE_MAX_B_LINES; i++)
    {
        igTrBLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_X_OFFSET] = rand() % 16 * 32.0f;
        igTrBLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_Y_OFFSET] = rand() % 8 * 35.0f + 20.0f;
        igTrBLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_S_OFFSET] = -rand() % 8 - 16.0f;
        igTrBLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_W_OFFSET] = rand() % 192;
    }
#endif
}

//void GameTrampolineEnd()
//{
//}

void GameTrampolineUpdate(float dt)
{
    switch (igTrState) {
        case IG_TRAMPOLINE_INIT:
            igTrState = IG_TRAMPOLINE_W_FIN;
            igTrWords->setCurrentAction(0);
            igTrWords->restartAction();
            break;
        case IG_TRAMPOLINE_W_FIN:
            if (igTrWords->isLastMoveInAction())
            {
                igTrState = IG_TRAMPOLINE_W_STAY;
                igTrWords->setCurrentAction(1);
                igTrWords->restartAction();
            }
            else
            {
                igTrWords->update(dt);
            }
            break;
        case IG_TRAMPOLINE_W_STAY:
            ++igTrWordsCount;
            if (igTrWordsCount > IG_TRAMPOLINE_WORDS_STIME)
            {
                igTrState = IG_TRAMPOLINE_W_FOUT;
                igTrWords->setCurrentAction(2);
                igTrWords->restartAction();
            }
            break;
        case IG_TRAMPOLINE_W_FOUT:
            if (igTrWords->isLastMoveInAction())
            {
                igTrState = IG_TRAMPOLINE_FIN;
            }
            else
            {
                igTrWords->update(dt);
            }
            break;
        case IG_TRAMPOLINE_FIN:
        {
            alphaTrampoline += 0.1f;
            if (alphaTrampoline >= 1.0f)
            {
                alphaTrampoline = 1.0f;
                igTrState = IG_TRAMPOLINE_ANIM;
            }
        }
            break;
        case IG_TRAMPOLINE_ANIM:
#ifdef NEW_TR_EFFECTS
            switch (igComicStep)
            {
                case IG_TRAMPOLINE_COMIC_FIN:
                    igComicStep = IG_TRAMPOLINE_COMIC_CUT_1;
                    igTrAlpha = 0.0f;
                    igTrCount = 0;
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_1:
                    if (igTrCount == 0)
                    {
                        igTrAlpha += 0.7f;
                        if (igTrAlpha >= 1.0f)
                        {
                            igTrAlpha = 1.0f;
                            ++igTrCount;
                        }
                    }
                    else if (igTrCount > 0 && igTrCount < IG_TR_COMIC_STILL_FRAMES)
                    {
                        ++igTrCount;
                    }
                    else if (igTrCount >= IG_TR_COMIC_STILL_FRAMES)
                    {
                        igTrAlpha -= 0.7f;
                        if (igTrAlpha <= 0.0f)
                        {
                            igTrAlpha = 0.0f;
                            igComicStep = IG_TRAMPOLINE_COMIC_CUT_2;
                            igTrCount = 0;
                        }
                    }
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_2:
                    if (igTrCount == 0)
                    {
                        igTrAlpha += 0.7f;
                        if (igTrAlpha >= 1.0f)
                        {
                            igTrAlpha = 1.0f;
                            ++igTrCount;
                        }
                    }
                    else if (igTrCount > 0 && igTrCount < IG_TR_COMIC_STILL_FRAMES)
                    {
                        ++igTrCount;
                    }
                    else if (igTrCount >= IG_TR_COMIC_STILL_FRAMES)
                    {
                        igTrAlpha -= 0.7f;
                        if (igTrAlpha <= 0.0f)
                        {
                            igTrAlpha = 0.0f;
                            igComicStep = IG_TRAMPOLINE_COMIC_CUT_3;
                            igTrCount = 0;
                        }
                    }
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_3:
                    if (igTrCount == 0)
                    {
                        igTrAlpha += 0.7f;
                        if (igTrAlpha >= 1.0f)
                        {
                            igTrAlpha = 1.0f;
                            ++igTrCount;
                        }
                    }
                    else if (igTrCount > 0 && igTrCount < IG_TR_COMIC_STILL_FRAMES)
                    {
                        ++igTrCount;
                    }
                    else if (igTrCount >= IG_TR_COMIC_STILL_FRAMES)
                    {
                        igTrAlpha -= 0.7f;
                        if (igTrAlpha <= 0.0f)
                        {
                            igTrAlpha = 0.0f;
                            igComicStep = IG_TRAMPOLINE_COMIC_CUT_4;
                            igTrCount = 0;
                        }
                    }
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_4:
                    if (igTrCount == 0)
                    {
                        igTrAlpha += 0.7f;
                        if (igTrAlpha >= 1.0f)
                        {
                            igTrAlpha = 1.0f;
                            ++igTrCount;
                        }
                    }
                    else if (igTrCount > 0 && igTrCount < IG_TR_COMIC_STILL_FRAMES)
                    {
                        ++igTrCount;
                    }
                    else if (igTrCount >= IG_TR_COMIC_STILL_FRAMES)
                    {
                        igTrAlpha -= 0.7f;
                        if (igTrAlpha <= 0.0f)
                        {
                            igTrAlpha = 0.0f;
                            igComicStep = IG_TRAMPOLINE_COMIC_FOUT;///IG_TRAMPOLINE_COMIC_CUT_ALL;
                            igTrCount = 0;
                        }
                    }
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_ALL:
                    if (igTrCount == 0)
                    {
                        igTrAlpha += 0.1f;
                        if (igTrAlpha >= 1.0f)
                        {
                            igTrAlpha = 1.0f;
                            ++igTrCount;
                        }
                    }
                    else if (igTrCount > 0 && igTrCount < (IG_TR_COMIC_STILL_FRAMES*2))
                    {
                        ++igTrCount;
                    }
                    else if (igTrCount >= (IG_TR_COMIC_STILL_FRAMES*2))
                    {
                        igTrAlpha -= 0.1f;
                        if (igTrAlpha <= 0.0f)
                        {
                            igTrAlpha = 0.0f;
                            igComicStep = IG_TRAMPOLINE_COMIC_FOUT;
                            igTrCount = 0;
                        }
                    }
                    break;
                case IG_TRAMPOLINE_COMIC_FOUT:
                    igTrState = IG_TRAMPOLINE_FOUT;
                    if (stages)
                    {
                        if (stages->lastCheckPoint < (stages->nCheckPoint - 1))
                        {
                            stages->lastCheckPoint += 1;
                            
                            // Special Operation
                            if (LevelIndex == 0 && ActiveLevel == 6 && stages->lastCheckPoint == 1)
                            {
                                stages->lastCheckPoint += 1;
                            }
                            else if (LevelIndex == 2 && ActiveLevel == 5 && stages->lastCheckPoint == 1)
                            {
                                stages->lastCheckPoint += 1;
                            }
                            
                            stages->isHyperJump = true;
                        }
                        else
                        {
                            igTrState = IG_TRAMPOLINE_DONE;
#ifdef DEBUG
                            printf("no other check point!!!\n");
#endif
                            break;
                        }
                        
                        PlayerJumpTo();
                        InitializeGiant();
                        
                        SetPlayer(PLAYER_STATE_RUN);
                        GamePlayUpdate(dt);
                        GamePlayUpdate(dt);
                    }
                    break;
                default:
                    break;
            }
#else
        {
            Canvas2D *canvas = Canvas2D::getInstance();
            // Lines
            for (int i = 0; i < IG_TRAMPOLINE_MAX_W_LINES; i++)
            {
                igTrWLns[IG_TR_LN_ELEMENT*i] += igTrWLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_S_OFFSET];
                if (igTrWLns[IG_TR_LN_ELEMENT*i] <= -igTrWLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_W_OFFSET])
                {
                    igTrWLns[IG_TR_LN_ELEMENT*i] += 480.0f;
                }
            }
            for (int i = 0; i < IG_TRAMPOLINE_MAX_B_LINES; i++)
            {
                igTrBLns[IG_TR_LN_ELEMENT*i] += igTrBLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_S_OFFSET];
                if (igTrBLns[IG_TR_LN_ELEMENT*i] <= -igTrBLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_W_OFFSET])
                {
                    igTrBLns[IG_TR_LN_ELEMENT*i] += 480.0f;
                }
            }
            // Kara
            if (igTrPlayerS == IG_TRAMPOLINE_KARA_S0)
            {
                igTrPlayerX += igTrPlayerSX;
                igTrPlayerY -= igTrPlayerSY;
                
                igTrPlayerSY -= 0.25f;
                
                if (igTrPlayerSY < -5.0f)
                {
                    igTrPlayerS = IG_TRAMPOLINE_KARA_S1;
                    
                    igTrPlayerSX = 8.0f;
                    igTrPlayerSY = -5.0f;
                }
            }
            else if (igTrPlayerS == IG_TRAMPOLINE_KARA_S1)
            {
                igTrPlayerX += igTrPlayerSX;
                igTrPlayerY -= igTrPlayerSY;
                
                igTrPlayerRot -= 0.35f;
                
                if (igTrPlayerX > (canvas->mScreenWidth / IMG_RES_SCALE + 80.0f))
                {
                    igTrPlayerS = IG_TRAMPOLINE_KARA_S2;
                }
            }
            else
            {
                igTrState = IG_TRAMPOLINE_FOUT;
                
                if (stages)
                {
                    if (stages->lastCheckPoint < (stages->nCheckPoint - 1))
                    {
                        stages->lastCheckPoint += 1;
                        
                        // Special Operation
                        if (LevelIndex == 0 && ActiveLevel == 6 && stages->lastCheckPoint == 1)
                        {
                            stages->lastCheckPoint += 1;
                        }
                        else if (LevelIndex == 2 && ActiveLevel == 5 && stages->lastCheckPoint == 1)
                        {
                            stages->lastCheckPoint += 1;
                        }
                        
                        stages->isHyperJump = true;
                    }
                    else
                    {
                        igTrState = IG_TRAMPOLINE_DONE;
#ifdef DEBUG
                        printf("no other check point!!!\n");
#endif
                        break;
                    }
                    
                    PlayerJumpTo();
                    InitializeGiant();
                    
                    SetPlayer(PLAYER_STATE_RUN);
                    GamePlayUpdate(dt);
                    GamePlayUpdate(dt);
                    
                    //                    igTrState = IG_TRAMPOLINE_ANIM;
                }
                //                else
                //                {
                //                    igTrState = IG_TRAMPOLINE_DONE;
                //                }
            }
        }
#endif
            break;
        case IG_TRAMPOLINE_FOUT:
            alphaTrampoline -= 0.05f;
            if (alphaTrampoline <= 0.0f)
            {
                alphaTrampoline = 0.0f;
                igTrState = IG_TRAMPOLINE_DONE;
            }
            break;
        case IG_TRAMPOLINE_DONE:
            stages->exitingSlowMotion();
            g_nGameState = GAME_STATE_GAME_PLAY;
            break;
        default:
            break;
    }
}

void GameTrampolineRender(float dt)
{
    Canvas2D *canvas = Canvas2D::getInstance();
    switch (igTrState)
    {
        case IG_TRAMPOLINE_INIT:
            break;
        case IG_TRAMPOLINE_W_FIN:
        case IG_TRAMPOLINE_W_STAY:
        case IG_TRAMPOLINE_W_FOUT:
            GamePlayRender(dt);
            canvas->flush();
            
            igTrWords->render(0.0f, IG_TRAMPOLINE_WORDS_Y, 0.0f, (480.0f/256.0f), (42.0f/32.0f));
            break;
        case IG_TRAMPOLINE_FIN:
        case IG_TRAMPOLINE_FOUT:
        case IG_TRAMPOLINE_DONE:
#ifdef NEW_TR_EFFECTS
            GamePlayRender(dt);
            canvas->flush();
            
            canvas->setColor(0.0f, 0.0f, 0.0f, alphaTrampoline);
            canvas->fillRect(0.0f, 0.0f, canvas->mScreenWidth / IMG_RES_SCALE, canvas->mScreenHeight / IMG_RES_SCALE);
            canvas->flush();
            canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
#else
            GamePlayRender(dt);
            canvas->flush();
            
            igTrBg->SetColor(1.0f, 1.0f, 1.0f, alphaTrampoline);
            igTrLnW->SetColor(1.0f, 1.0f, 1.0f, alphaTrampoline);
            igTrLnB->SetColor(1.0f, 1.0f, 1.0f, alphaTrampoline);
            canvas->enableColorPointer(true);
            // Background
            canvas->drawImage(igTrBg, 0.0f, 0.0f, 0.0f, canvas->mScreenWidth, 1.0f);
            // Lines
            for (int i = 0; i < IG_TRAMPOLINE_MAX_W_LINES; i++)
            {
                canvas->drawImage(igTrLnW, igTrWLns[IG_TR_LN_ELEMENT*i], igTrWLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_Y_OFFSET]);
            }
            for (int i = 0; i < IG_TRAMPOLINE_MAX_B_LINES; i++)
            {
                canvas->drawImage(igTrLnB, igTrBLns[IG_TR_LN_ELEMENT*i], igTrBLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_Y_OFFSET]);
            }
            canvas->enableColorPointer(false);
            igTrBg->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
#endif
            break;
        case IG_TRAMPOLINE_ANIM:
#ifdef NEW_TR_EFFECTS
            igTrComic->SetColor(1.0f, 1.0f, 1.0f, igTrAlpha);
            canvas->enableColorPointer(true);
            switch (igComicStep)
            {
                case IG_TRAMPOLINE_COMIC_FIN:
                    break;
#ifdef VERSION_IPAD
                case IG_TRAMPOLINE_COMIC_CUT_1:
                    drawTrComicCut1(0.0f,   0.0f);
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_2:
                    drawTrComicCut2(188.0f,  0.0f);
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_3:
                    drawTrComicCut3(480.0f, 0.0f);
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_4:
                    drawTrComicCut4(688.0f, 0.0f);
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_ALL:
                    drawTrComicCut1(0.0f,   0.0f);
                    drawTrComicCut2(188.0f, 0.0f);
                    drawTrComicCut3(480.0f, 0.0f);
                    drawTrComicCut4(688.0f, 0.0f);
                    break;
#else
                case IG_TRAMPOLINE_COMIC_CUT_1:
                    drawTrComicCut1(0.0f,   0.0f);
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_2:
                    drawTrComicCut2(88.0f,  0.0f);
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_3:
                    drawTrComicCut3(226.0f, 0.0f);
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_4:
                    drawTrComicCut4(324.0f, 0.0f);
                    break;
                case IG_TRAMPOLINE_COMIC_CUT_ALL:
                    drawTrComicCut1(0.0f,   0.0f);
                    drawTrComicCut2(88.0f,  0.0f);
                    drawTrComicCut3(226.0f, 0.0f);
                    drawTrComicCut4(324.0f, 0.0f);
                    break;
#endif
                case IG_TRAMPOLINE_COMIC_FOUT:
                    break;
                default:
                    break;
            }
//            drawTrComicCut1(0.0f,   0.0f);
//            drawTrComicCut2(88.0f,  0.0f);
//            drawTrComicCut3(226.0f, 0.0f);
//            drawTrComicCut4(324.0f, 0.0f);
            canvas->enableColorPointer(false);
            igTrComic->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
#else
            // Background
            canvas->drawImage(igTrBg, 0.0f, 0.0f, 0.0f, canvas->mScreenWidth, 1.0f);
            
            canvas->flush();
            glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
            
            // Lines
            for (int i = 0; i < IG_TRAMPOLINE_MAX_W_LINES; i++)
            {
                canvas->drawImage(igTrLnW, igTrWLns[IG_TR_LN_ELEMENT*i], igTrWLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_Y_OFFSET]);
            }
            for (int i = 0; i < IG_TRAMPOLINE_MAX_B_LINES; i++)
            {
                canvas->drawImage(igTrLnB, igTrBLns[IG_TR_LN_ELEMENT*i], igTrBLns[IG_TR_LN_ELEMENT*i+IG_TR_LN_Y_OFFSET]);
            }
            
            // Kara
            if (igTrPlayerS == IG_TRAMPOLINE_KARA_S0)
            {
                canvas->drawImage(igTrKara[IG_TRAMPOLINE_KARA_0], igTrPlayerX, igTrPlayerY, 0.0f, 1.3125f, 1.3125f);
            }
            else if (igTrPlayerS == IG_TRAMPOLINE_KARA_S1)
            {
                canvas->drawImage(igTrKara[IG_TRAMPOLINE_KARA_1], igTrPlayerX, igTrPlayerY, igTrPlayerRot, 1.3125f, 1.3125f);
            }
            
            canvas->flush();
            glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
#endif
            break;
        default:
            break;
    }
}

void GameTrampolineTouchEvent(int touchStatus, float fX, float fY)
{
}

#ifdef NEW_TR_EFFECTS

#if VERSION_IPAD
void drawTrComicCut1(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p1[] = {// 8
		0.0f,   0.0f,
		188.0f, 0.0f,
		0.0f,   768.0f,
		188.0f, 768.0f
	};
	const float t1[] = {// 12
		0.0f,             0.0f,
		(188.0f/1024.0f), 0.0f,
		0.0f,             (768.0f/1024.0f),
		
		(188.0f/1024.0f), (768.0f/1024.0f),
		0.0f,             (768.0f/1024.0f),
		(188.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p1, t1);
	
	const float p2[] = {// 8
		188.0f, 0.0f,
		188.0f, 0.0f,
		188.0f, 768.0f,
		274.0f, 768.0f
	};
	const float t2[] = {// 12
		(188.0f/1024.0f), 0.0f,
		(274.0f/1024.0f), 0.0f,
		(188.0f/1024.0f), (768.0f/1024.0f),
		
		(274.0f/1024.0f), (768.0f/1024.0f),
		(188.0f/1024.0f), (768.0f/1024.0f),
		(188.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p2, t2);
}

void drawTrComicCut2(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p1[] = {// 8
		0.0f,  0.0f,
		86.0f, 0.0f,
		86.0f, 768.0f,
		86.0f, 768.0f
	};
	const float t1[] = {// 12
		(188.0f/1024.0f), 0.0f,
		(274.0f/1024.0f), 0.0f,
		(274.0f/1024.0f), (768.0f/1024.0f),
		
		(274.0f/1024.0f), (768.0f/1024.0f),
		(274.0f/1024.0f), (768.0f/1024.0f),
		(274.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p1, t1);
	
	const float p2[] = {// 8
		86.0f,  0.0f,
		292.0f, 0.0f,
		86.0f,  768.0f,
		292.0f, 768.0f
	};
	const float t2[] = {// 12
		(274.0f/1024.0f), 0.0f,
		(480.0f/1024.0f), 0.0f,
		(274.0f/1024.0f), (768.0f/1024.0f),
		
		(480.0f/1024.0f), (768.0f/1024.0f),
		(274.0f/1024.0f), (768.0f/1024.0f),
		(480.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p2, t2);
    
    const float p3[] = {// 8
		292.0f, 0.0f,
		394.0f, 0.0f,
		292.0f, 768.0f,
		292.0f, 768.0f
	};
	const float t3[] = {// 12
		(480.0f/1024.0f), 0.0f,
		(582.0f/1024.0f), 0.0f,
		(480.0f/1024.0f), (768.0f/1024.0f),
		
		(480.0f/1024.0f), (768.0f/1024.0f),
		(480.0f/1024.0f), (768.0f/1024.0f),
		(582.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p3, t3);
}

void drawTrComicCut3(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p1[] = {// 8
		102.0f, 0.0f,
		102.0f, 0.0f,
		0.0f,   768.0f,
		102.0f, 768.0f
	};
	const float t1[] = {// 12
		(582.0f/1024.0f), 0.0f,
		(582.0f/1024.0f), 0.0f,
		(480.0f/1024.0f), (768.0f/1024.0f),
		
		(582.0f/1024.0f), (768.0f/1024.0f),
		(480.0f/1024.0f), (768.0f/1024.0f),
		(582.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p1, t1);
	
	const float p2[] = {// 8
		102.0f, 0.0f,
		208.0f, 0.0f,
		102.0f, 768.0f,
		208.0f, 768.0f
	};
	const float t2[] = {// 12
		(582.0f/1024.0f), 0.0f,
		(688.0f/1024.0f), 0.0f,
		(582.0f/1024.0f), (768.0f/1024.0f),
		
		(688.0f/1024.0f), (768.0f/1024.0f),
		(582.0f/1024.0f), (768.0f/1024.0f),
		(688.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p2, t2);
    
    const float p3[] = {// 8
		208.0f, 0.0f,
		208.0f, 0.0f,
		208.0f, 768.0f,
		266.0f, 768.0f
	};
	const float t3[] = {// 12
		(688.0f/1024.0f), 0.0f,
		(688.0f/1024.0f), 0.0f,
		(688.0f/1024.0f), (768.0f/1024.0f),
		
		(746.0f/1024.0f), (768.0f/1024.0f),
		(688.0f/1024.0f), (768.0f/1024.0f),
		(688.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p3, t3);
}

void drawTrComicCut4(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p1[] = {// 8
		0.0f,  0.0f,
		58.0f, 0.0f,
		58.0f, 768.0f,
		58.0f, 768.0f
	};
	const float t1[] = {// 12
		(688.0f/1024.0f), 0.0f,
		(746.0f/1024.0f), 0.0f,
		(746.0f/1024.0f), (768.0f/1024.0f),
		
		(746.0f/1024.0f), (768.0f/1024.0f),
		(746.0f/1024.0f), (768.0f/1024.0f),
		(746.0f/1024.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p1, t1);
	
	const float p2[] = {// 8
		58.0f,  0.0f,
		336.0f, 0.0f,
		58.0f,  768.0f,
		336.0f, 768.0f
	};
	const float t2[] = {// 12
		(746.0f/1024.0f), 0.0f,
		(1.0f),           0.0f,
		(746.0f/1024.0f), (768.0f/1024.0f),
		
		(1.0f),           (768.0f/1024.0f),
		(746.0f/1024.0f), (768.0f/1024.0f),
		(1.0f),           0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p2, t2);
}
#else
void drawTrComicCut1(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p1[] = {// 8
		0.0f,  0.0f,
		88.0f, 0.0f,
		0.0f,  320.0f,
		88.0f, 320.0f
	};
	const float t1[] = {// 12
		0.0f, 0.0f,
		(88.0f/512.0f), 0.0f,
		0.0f, (320.0f/512.0f),
		
		(88.0f/512.0f), (320.0f/512.0f),
		0.0f, (320.0f/512.0f),
		(88.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p1, t1);
	
	const float p2[] = {// 8
		88.0f,  0.0f,
		88.0f,  0.0f,
		88.0f,  320.0f,
		128.0f, 320.0f
	};
	const float t2[] = {// 12
		(88.0f/512.0f), 0.0f,
		(128.0f/512.0f), 0.0f,
		(88.0f/512.0f), (320.0f/512.0f),
		
		(128.0f/512.0f), (320.0f/512.0f),
		(88.0f/512.0f), (320.0f/512.0f),
		(88.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p2, t2);
}

void drawTrComicCut2(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p1[] = {// 8
		0.0f,  0.0f,
		40.0f, 0.0f,
		40.0f, 320.0f,
		40.0f, 320.0f
	};
	const float t1[] = {// 12
		(88.0f/512.0f),  0.0f,
		(128.0f/512.0f), 0.0f,
		(128.0f/512.0f),  (320.0f/512.0f),
		
		(128.0f/512.0f), (320.0f/512.0f),
		(128.0f/512.0f),  (320.0f/512.0f),
		(128.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p1, t1);
	
	const float p2[] = {// 8
		40.0f,  0.0f,
		138.0f, 0.0f,
		40.0f,  320.0f,
		138.0f, 320.0f
	};
	const float t2[] = {// 12
		(128.0f/512.0f), 0.0f,
		(226.0f/512.0f), 0.0f,
		(128.0f/512.0f), (320.0f/512.0f),
		
		(226.0f/512.0f), (320.0f/512.0f),
		(128.0f/512.0f), (320.0f/512.0f),
		(226.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p2, t2);
    
    const float p3[] = {// 8
		138.0f, 0.0f,
		186.0f, 0.0f,
		138.0f, 320.0f,
		138.0f, 320.0f
	};
	const float t3[] = {// 12
		(226.0f/512.0f), 0.0f,
		(274.0f/512.0f), 0.0f,
		(226.0f/512.0f), (320.0f/512.0f),
		
		(274.0f/512.0f), (320.0f/512.0f),
		(226.0f/512.0f), (320.0f/512.0f),
		(274.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p3, t3);
}

void drawTrComicCut3(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p1[] = {// 8
		48.0f, 0.0f,
		48.0f, 0.0f,
		0.0f,  320.0f,
		48.0f, 320.0f
	};
	const float t1[] = {// 12
		(274.0f/512.0f), 0.0f,
		(274.0f/512.0f), 0.0f,
		(226.0f/512.0f), (320.0f/512.0f),
		
		(274.0f/512.0f), (320.0f/512.0f),
		(226.0f/512.0f), (320.0f/512.0f),
		(274.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p1, t1);
	
	const float p2[] = {// 8
		48.0f, 0.0f,
		98.0f, 0.0f,
		48.0f, 320.0f,
		98.0f, 320.0f
	};
	const float t2[] = {// 12
		(274.0f/512.0f), 0.0f,
		(324.0f/512.0f), 0.0f,
		(274.0f/512.0f), (320.0f/512.0f),
		
		(324.0f/512.0f), (320.0f/512.0f),
		(274.0f/512.0f), (320.0f/512.0f),
		(324.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p2, t2);
    
    const float p3[] = {// 8
		98.0f,  0.0f,
		98.0f,  0.0f,
		98.0f,  320.0f,
		124.0f, 320.0f
	};
	const float t3[] = {// 12
		(324.0f/512.0f), 0.0f,
		(324.0f/512.0f), 0.0f,
		(324.0f/512.0f), (320.0f/512.0f),
		
		(350.0f/512.0f), (320.0f/512.0f),
		(324.0f/512.0f), (320.0f/512.0f),
		(324.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p3, t3);
}

void drawTrComicCut4(float x, float y)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	const float p1[] = {// 8
		0.0f,  0.0f,
		26.0f, 0.0f,
		26.0f, 320.0f,
		26.0f, 320.0f
	};
	const float t1[] = {// 12
		(324.0f/512.0f), 0.0f,
		(350.0f/512.0f), 0.0f,
		(350.0f/512.0f), (320.0f/512.0f),
		
		(350.0f/512.0f), (320.0f/512.0f),
		(350.0f/512.0f), (320.0f/512.0f),
		(350.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p1, t1);
	
	const float p2[] = {// 8
		26.0f,  0.0f,
		156.0f, 0.0f,
		26.0f,  320.0f,
		156.0f, 320.0f
	};
	const float t2[] = {// 12
		(350.0f/512.0f), 0.0f,
		(480.0f/512.0f), 0.0f,
		(350.0f/512.0f), (320.0f/512.0f),
		
		(480.0f/512.0f), (320.0f/512.0f),
		(350.0f/512.0f), (320.0f/512.0f),
		(480.0f/512.0f), 0.0f,
	};
	canvas->drawQuadImage(igTrComic, x, y, p2, t2);
}
#endif

#endif
