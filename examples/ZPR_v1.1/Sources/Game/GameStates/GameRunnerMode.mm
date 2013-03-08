//
//  GameRunnerMode.mm
//  ZPR
//
//  Created by Neo Lin on 11/15/11.
//  Copyright (c) 2011 Break Media. All rights reserved.
//

#import "GameRunnerMode.h"

#import "Canvas2D.h"
#import "neoRes.h"
#import "Image.h"
#import "Sprite.h"

#import "GameState.h"
#import "GamePlay.h"
#import "Runner.h"


Image *igRmMeter[IG_RUNNERMODE_METER_MAX];
Image *igRmRHigh[IG_RUNNERMODE_RHIGH_MAX];

bool usingIgRm = false;
int igRmCnt = 0;

int igRmState = IG_RUNNERMODE_INIT;
int igRmSubState = 0;

int igRmWordsCount;

Sprite *igRmWords;


float igRmMeterAlpha = 1.0f;
float igRmWordsAlpha = 1.0f;
float igRmMeterScaleX = IG_RM_METER_SCALE_X_FINAL / 3.0f;
float igRmMeterScaleY = IG_RM_METER_SCALE_Y_FINAL / 3.0f;
float igRmWordsScaleX = IG_RM_WORDS_SCALE_X_FINAL / 3.0f;
float igRmWordsScaleY = IG_RM_WORDS_SCALE_Y_FINAL / 3.0f;
int   igRmRhSel = 0;

void initGameRunnerModeRes()
{
    igRmWords = new Sprite();
	g_GcResMgr->createSprite(igRmWords, "isk.xml", NULL, IMG_RES_SCALE, IMG_RES_SCALE);
    
    // Runner Meter
    g_UiResMgr->createImage("igrmmt0", "igrmmt.png", 0.0f, 0.0f * IMG_RES_SCALE, 128.0f * IMG_RES_SCALE, 21.0f * IMG_RES_SCALE, 0.0f, 0.0f);
	igRmMeter[IG_RUNNERMODE_METER_0] = g_UiResMgr->getImage("igrmmt0");
    igRmMeter[IG_RUNNERMODE_METER_0]->makeCenterAsAnchor();
    
    g_UiResMgr->createImage("igrmmt1", "igrmmt.png", 0.0f, 21.0f * IMG_RES_SCALE, 128.0f * IMG_RES_SCALE, 21.0f * IMG_RES_SCALE, 0.0f, 0.0f);
	igRmMeter[IG_RUNNERMODE_METER_1] = g_UiResMgr->getImage("igrmmt1");
    igRmMeter[IG_RUNNERMODE_METER_1]->makeCenterAsAnchor();
    
    g_UiResMgr->createImage("igrmmt2", "igrmmt.png", 0.0f, 42.0f * IMG_RES_SCALE, 128.0f * IMG_RES_SCALE, 21.0f * IMG_RES_SCALE, 0.0f, 0.0f);
	igRmMeter[IG_RUNNERMODE_METER_2] = g_UiResMgr->getImage("igrmmt2");
    igRmMeter[IG_RUNNERMODE_METER_2]->makeCenterAsAnchor();
    
    // Runner High
    g_UiResMgr->createImage("igrmrh0", "igrmrh.png", 0.0f, 0.0f, 128.0f * IMG_RES_SCALE, 40.0f * IMG_RES_SCALE, 0.0f, 0.0f);
	igRmRHigh[IG_RUNNERMODE_RHIGH_0] = g_UiResMgr->getImage("igrmrh0");
    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->makeCenterAsAnchor();
    
    g_UiResMgr->createImage("igrmrh1", "igrmrh.png", 0.0f, 40.0f * IMG_RES_SCALE, 128.0f * IMG_RES_SCALE, 24.0f * IMG_RES_SCALE, 0.0f, 0.0f);
	igRmRHigh[IG_RUNNERMODE_RHIGH_1] = g_UiResMgr->getImage("igrmrh1");
    igRmRHigh[IG_RUNNERMODE_RHIGH_1]->makeCenterAsAnchor();
}

void relGameRunnerModeRes()
{
    if (igRmWords)
    {
        delete igRmWords;
        igRmWords = NULL;
    }
}

void GameRunnerModeBegin()
{
    igRmState = IG_RUNNERMODE_INIT;
    igRmWordsCount = 0;
    
    igRmMeterAlpha = 1.0f;
    igRmWordsAlpha = 1.0f;
    igRmMeterScaleX = IG_RM_METER_SCALE_X_FINAL / 3.0f;
    igRmMeterScaleY = IG_RM_METER_SCALE_Y_FINAL / 3.0f;
    igRmWordsScaleX = IG_RM_WORDS_SCALE_X_FINAL / 3.0f;
    igRmWordsScaleY = IG_RM_WORDS_SCALE_Y_FINAL / 3.0f;
    igRmRhSel = 0;
}

//void GameRunnerModeEnd()
//{
//}

void GameRunnerModeUpdate(float dt)
{
    switch (igRmState) {
        case IG_RUNNERMODE_INIT:
            igRmState = IG_RUNNERMODE_W_FIN;
            igRmWords->setCurrentAction(0);
            igRmWords->restartAction();
            break;
        case IG_RUNNERMODE_W_FIN:
            if (igRmWords->isLastMoveInAction())
            {
                igRmState = IG_RUNNERMODE_W_STAY;
                igRmWords->setCurrentAction(1);
                igRmWords->restartAction();
            }
            else
            {
                igRmWords->update(dt);
            }
            break;
        case IG_RUNNERMODE_W_STAY:
            ++igRmWordsCount;
            if (igRmWordsCount > IG_RUNNERMODE_WORDS_STIME)
            {
                igRmWordsCount = 0;
                igRmState = IG_RUNNERMODE_W_FOUT;
                igRmWords->setCurrentAction(2);
                igRmWords->restartAction();
            }
            break;
        case IG_RUNNERMODE_W_FOUT:
            if (igRmWords->isLastMoveInAction())
            {
                igRmState = IG_RUNNERMODE_ANIM_0;//igRmState = IG_RUNNERMODE_DONE;
            }
            else
            {
                igRmWords->update(dt);
            }
            break;
        case IG_RUNNERMODE_ANIM_0:
            igRmMeterScaleX += 0.5f;
            if (igRmMeterScaleX >= IG_RM_METER_SCALE_X_FINAL)
            {
                igRmMeterScaleX = IG_RM_METER_SCALE_X_FINAL;
                
                igRmRhSel = ++igRmRhSel % 4;
            }
            igRmMeterScaleY += 0.5f;
            if (igRmMeterScaleY >= IG_RM_METER_SCALE_Y_FINAL)
            {
                igRmMeterScaleY = IG_RM_METER_SCALE_Y_FINAL;
            }
            
            igRmWordsScaleX += 0.2f;
            igRmWordsScaleY += 0.2f;
            
            igRmWordsAlpha -= 0.06f;
            if (igRmWordsAlpha <= 0.0f)
            {
                igRmWordsAlpha = 0.0f;
                igRmState = IG_RUNNERMODE_ANIM_1;
            }
            
            break;
        case IG_RUNNERMODE_ANIM_1:
            igRmRhSel = ++igRmRhSel % 4;
            ++igRmWordsCount;
            if (igRmWordsCount > (IG_RUNNERMODE_WORDS_STIME * 0.5f))
            {
                igRmMeterAlpha -= 0.05f;
                if (igRmMeterAlpha <= 0.0f)
                {
                    igRmMeterAlpha = 0.0f;
                    igRmState = IG_RUNNERMODE_DONE;
                }
            }
            break;
        case IG_RUNNERMODE_DONE:
            g_nGameState = GAME_STATE_GAME_PLAY;
            break;
        default:
            break;
    }
}

void GameRunnerModeRender(float dt)
{
    Canvas2D *canvas = Canvas2D::getInstance();
    GamePlayRender(dt);
    canvas->flush();
    switch (igRmState) {
        case IG_RUNNERMODE_INIT:
            break;
        case IG_RUNNERMODE_W_FIN:
            igRmWords->render(0.0f, IG_RUNNERMODE_WORDS_Y, 0.0f, (480.0f/256.0f), (42.0f/32.0f));
            break;
        case IG_RUNNERMODE_W_STAY:
            igRmWords->render(0.0f, IG_RUNNERMODE_WORDS_Y, 0.0f, (480.0f/256.0f), (42.0f/32.0f));
            break;
        case IG_RUNNERMODE_W_FOUT:
            igRmWords->render(0.0f, IG_RUNNERMODE_WORDS_Y, 0.0f, (480.0f/256.0f), (42.0f/32.0f));
            break;
        case IG_RUNNERMODE_ANIM_0:
            switch (mFastLevel)
            {
                case 1:
                    canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_0], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, igRmMeterScaleX, igRmMeterScaleY);
                    if (igRmWordsScaleX >= IG_RM_WORDS_SCALE_X_FINAL)
                    {
                        canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, IG_RM_WORDS_SCALE_X_FINAL, IG_RM_WORDS_SCALE_Y_FINAL);
                    }
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmWordsAlpha);
                    canvas->enableColorPointer(true);
                    canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, igRmWordsScaleX, igRmWordsScaleY);
                    canvas->enableColorPointer(false);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                    break;
                case 2:
                    canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_1], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, igRmMeterScaleX, igRmMeterScaleY);
                    if (igRmWordsScaleX >= IG_RM_WORDS_SCALE_X_FINAL)
                    {
                        canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, IG_RM_WORDS_SCALE_X_FINAL, IG_RM_WORDS_SCALE_Y_FINAL);
                    }
                    
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmWordsAlpha);
                    canvas->enableColorPointer(true);
                    canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, igRmWordsScaleX, igRmWordsScaleY);
                    canvas->enableColorPointer(false);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                    break;
                case 3:
                    canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_2], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, igRmMeterScaleX, igRmMeterScaleY);
                    if (igRmWordsScaleX >= IG_RM_WORDS_SCALE_X_FINAL)
                    {
                        if (igRmRhSel/2 == 0)
                        {
                            canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_1], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, IG_RM_WORDS_SCALE_X_FINAL, IG_RM_WORDS_SCALE_Y_FINAL);
                        }
                        else
                        {
                            canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, IG_RM_WORDS_SCALE_X_FINAL, IG_RM_WORDS_SCALE_Y_FINAL);
                        }
                    }
                    
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmWordsAlpha);
                    canvas->enableColorPointer(true);
                    canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, igRmWordsScaleX, igRmWordsScaleY);
                    canvas->enableColorPointer(false);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
//                    canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_1], 240.0f, 68.0f, 0.0f, 1.48f, 1.0f);
                    break;
                default:
                    break;
            }
            break;
        case IG_RUNNERMODE_ANIM_1:
            switch (mFastLevel)
            {
                case 1:
                    igRmMeter[IG_RUNNERMODE_METER_0]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                    canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_0], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, 1.11f, 1.52f);
                    canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, 1.48f, 1.0f);
                    igRmMeter[IG_RUNNERMODE_METER_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                    break;
                case 2:
                    igRmMeter[IG_RUNNERMODE_METER_1]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                    canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_1], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, 1.11f, 1.52f);
                    canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, 1.48f, 1.0f);
                    igRmMeter[IG_RUNNERMODE_METER_1]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                    break;
                case 3:
                    igRmMeter[IG_RUNNERMODE_METER_2]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_1]->SetColor(1.0f, 1.0f, 1.0f, igRmMeterAlpha);
                    canvas->enableColorPointer(true);
                    canvas->drawImage(igRmMeter[IG_RUNNERMODE_METER_2], 240.0f, 32.0f+SCENE_OFFSET, 0.0f, 1.11f, 1.52f);
                    if (igRmRhSel)
                    {
                        canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_1], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, 1.48f, 1.0f);
                    }
                    else
                    {
                        canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_0], 240.0f, 68.0f+SCENE_OFFSET, 0.0f, 1.48f, 1.0f);
                    }
                    canvas->enableColorPointer(false);
                    igRmMeter[IG_RUNNERMODE_METER_2]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_0]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
                    igRmRHigh[IG_RUNNERMODE_RHIGH_1]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);

//                    canvas->drawImage(igRmRHigh[IG_RUNNERMODE_RHIGH_1], 240.0f, 68.0f, 0.0f, 1.48f, 1.0f);
                    break;
                default:
                    break;
            }
            break;
        case IG_RUNNERMODE_DONE:
            break;
        default:
            break;
    }
}

void GameRunnerModeTouchEvent(int touchStatus, float fX, float fY)
{
}
