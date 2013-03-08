//
//  GameTips.mm
//  ZPR
//
//  Created by Neo Lin on 11/29/11.
//  Copyright (c) 2011 Break Media. All rights reserved.
//

#import "GameTips.h"

#import "Canvas2D.h"
#import "Image.h"
#import "neoRes.h"

#import "GameState.h"
#import "GameRes.h"
#import "GamePlay.h"
#import "zprUIButton.h"


int igTipsState = IG_TIPS_INIT;
float igTipsAlpha = 0.0f;
int   igTipsCount = 0;
float igTipsX = 0.0f;
float igTipsY = 0.0f;
float igTipsRot = 0.0f;
float igTipsScale = 0.0f;

NeoRes *g_TipResMgr;
Image  *mIgTip;
Image  *mIgTipImgBtn;
ZprUIButton *mIgTipBtn;


void initResTip()
{
    if (g_TipResMgr == NULL)
    {
		g_TipResMgr = new NeoRes();
	}
    else
    {
        return;
    }
    
    Canvas2D *canvas = Canvas2D::getInstance();
    
    mIgTip = NULL;
#ifdef VERSION_IPAD
    g_TipResMgr->createImage("igTip1", "igtip.png", 0.0f, 0.0f, 1024.0f, 768.0f, 0.0f, 0.0f);
#else
    g_TipResMgr->createImage("igTip1", "igtip.png", 0.0f, 0.0f, 480.0f, 320.0f, 0.0f, 0.0f);
#endif
    mIgTip = g_TipResMgr->getImage("igTip1");
    mIgTip->makeCenterAsAnchor();
    
#ifdef VERSION_IPAD
    mIgTipBtn = new ZprUIButton("igTip1", NULL, NULL, 1024.0f, 768.0f, g_TipResMgr);
#else
    mIgTipBtn = new ZprUIButton("igTip1", NULL, NULL, 480.0f, 320.0f, g_TipResMgr);
#endif
    mIgTipBtn->setBtnPos(canvas->mScreenWidth * 0.5f / IMG_RES_SCALE, canvas->mScreenHeight * 0.5f / IMG_RES_SCALE);
}

void freeResTip()
{
    if (g_TipResMgr)
	{
		delete g_TipResMgr;
		g_TipResMgr = NULL;
	}
    mIgTip = NULL;
}

void GameTipsBegin()
{
    Canvas2D *canvas = Canvas2D::getInstance();
    igTipsState = IG_TIPS_INIT;
    igTipsAlpha = 0.0f;
    igTipsCount = 0;
    igTipsX = canvas->mScreenWidth * 0.5f / IMG_RES_SCALE;
    igTipsY = canvas->mScreenHeight * 0.5f / IMG_RES_SCALE;
    igTipsRot = 0.0f;
    igTipsScale = 0.0f;
}

//void GameTipsEnd();

void GameTipsUpdate(float dt)
{
    switch (igTipsState) {
        case IG_TIPS_INIT:
            igTipsState = IG_TIPS_POPUP1;
            igTipsCount = 0;
            break;
        case IG_TIPS_POPUP1:
            igTipsAlpha += 0.05f;
            igTipsScale += 0.005f;
            if (igTipsAlpha >= 1.0f)
            {
                igTipsAlpha = 1.0f;
                igTipsState = IG_TIPS_POPUP2;
            }
            break;
        case IG_TIPS_POPUP2:
            ++igTipsCount;
            igTipsScale = sinf(3.1415926f * 0.5f * igTipsCount / 90);
            if (igTipsScale < 0.1f)
            {
                igTipsScale = 0.1f;
            }
            igTipsRot = 3.1415926f * 8 * sinf(3.1415926f * 0.5f * igTipsCount / 90);
            if (igTipsCount >= 90)
            {
                igTipsCount = 0;
                igTipsScale = 1.0f;
                igTipsRot = 0.0f;
                igTipsAlpha = 1.0f;
                igTipsState = IG_TIPS_STAY;
            }
            break;
        case IG_TIPS_STAY:
//            igTipsState = IG_TIPS_CLOSE;
            break;
        case IG_TIPS_CLOSE:
            igTipsAlpha -= 0.03f;
            if (igTipsAlpha <= 0.0f)
            {
                igTipsAlpha = 0.0f;
                igTipsState = IG_TIPS_DONE;
            }
            break;
        case IG_TIPS_DONE:
            g_nGameState = GAME_STATE_GAME_PLAY;
            break;
        default:
            break;
    }
}

void GameTipsRender(float dt)
{
    Canvas2D *canvas = Canvas2D::getInstance();
    GamePlayRender(dt);
    canvas->flush();
    switch (igTipsState) {
        case IG_TIPS_INIT:
            ;
            break;
        case IG_TIPS_POPUP1:
            canvas->enableColorPointer(true);
            mIgTip->SetColor(1.0f, 1.0f, 1.0f, igTipsAlpha);
            canvas->drawImage(mIgTip, igTipsX, igTipsY, 0.0f, igTipsScale, igTipsScale);
            canvas->enableColorPointer(false);
            mIgTip->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
            break;
        case IG_TIPS_POPUP2:
            canvas->drawImage(mIgTip, igTipsX, igTipsY, igTipsRot, igTipsScale, igTipsScale);
            break;
        case IG_TIPS_STAY:
            canvas->drawImage(mIgTip, igTipsX, igTipsY);
            break;
        case IG_TIPS_CLOSE:
            canvas->enableColorPointer(true);
            mIgTip->SetColor(1.0f, 1.0f, 1.0f, igTipsAlpha);
            canvas->drawImage(mIgTip, igTipsX, igTipsY);
            canvas->enableColorPointer(false);
            mIgTip->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
            break;
        case IG_TIPS_DONE:
            ;
            break;
        default:
            break;
    }
}

void GameTipsTouchEvent(int touchStatus, float fX, float fY)
{
    if (igTipsState == IG_TIPS_STAY)
    {
        if (mIgTipBtn->onTouch(touchStatus, fX, fY))
        {
            if (mIgTipBtn->getButtonState() == ZPR_UI_BTN_RELEASED)
            {
                mIgTipBtn->setButtonState(ZPR_UI_BTN_NORMAL);
                igTipsState = IG_TIPS_CLOSE;
                return;
            }
            return;
        }
    }
}
