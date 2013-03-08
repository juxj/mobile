/*
 *  GameRes.cpp
 *  ZPR
 *
 *  Created by Neo01 on 5/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "GameRes.h"

#import "imgResData.h"	// Image Resource

#import "neoRes.h"

#import "Image.h"
#import "Sprite.h"
#import "Utilities.h"

#import "GameState.h"
//#import "GameLogo.h"
#import "GameTitle.h"
#import "GameSection.h"
#import "GameSuc.h"
#import "GameAchieve.h"
#import "GamePlay.h"
#import "GameCredits.h"
#import "GamePause.h"
///#import "GameAchieve.h"
#import "GameOption.h"
#import "GameHouse.h"
#import "GameLevel.h"
#import "GameOver.h"
#import "Stage.h"
#import "Runner.h"
#import "Giant.h"
#import "Opponent.h"

#import "Canvas2D.h"
#import "Texture2D.h"

#import "Texture.h"


#import "GameTitle.h"
#import "ZprUIButton.h"

#ifdef __IN_APP_PURCHASE__
#import "GameStore.h"
#import "GameRunnerMode.h"
#import "GameTrampoline.h"
#endif


#ifdef DBG_MEM_MONITOR
Font* mFont0;
#endif


Image* mAchieve[MAX_ACHIEVE];
Image* mAchieveInfo[MAX_ACHIEVE];
Image* mBedroomProps[MAX_BEDROOM_PROPS];
Image* mBedroomPropsInfo[MAX_BEDROOM_PROPS];


//Sprite* mStartGiant;
//Sprite* mStartGiant2;

Stage* stages;
Image* mTitleBG;
Image* mTitleBG2;
Image* m2TitleBG;
Image* mSound[2];
Image* mVolume[2];
Image* mStars[3];

Image* mLevelbgsky[5];
Image* mLevelbg;
Image* mQestion;


Image* mSelectPlay[2 * LEVEL_NUM_MAX];
Image* mLevel[3];


Image* mOptionStar[2];
Image* mBack;
Image* mBackbg;


Image* mStory[MAX_STORY];

Image* mSucInfoImg[10];

Image* mNewsImg[14];

Image* mGcIcons[2];

Image* mClose;
Image* mOptionBarbg;

Sprite* mEffect1;
Sprite* mEffect2;
Sprite* mEffect3;
Sprite* mEffect4;
Sprite* mStartGiant;

#ifdef __IN_APP_PURCHASE__
// Store
Image* mStoreBg;
#endif

#ifdef __PROMOTE_ADS__
Image* ads_shoes;
Image* ads_buy;
Image* ads_bed;
Image* ads_fouth;
NeoRes* g_AdsResMgr;
#endif


void InitGameTextures()
{
	char filename[16] = {0};
	
//	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA8888;
//	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA4444;
	
	//bg
	for(int i=0; i<8; i++)
	{
		for (int j=0; j<8; j++) {
			memset(filename, '\0', sizeof(filename));
			sprintf(filename, "bg%d", (i*8+j));
			g_UiResMgr->createImage(filename, "bgtile.png", j*BLACK_BG_EDGE+1,i*BLACK_BG_EDGE+1, BLACK_BG_WIDTH, BLACK_BG_WIDTH, NEWS_TEX_OX, NEWS_TEX_OY);
			mTiledBg[i*8+j] = g_UiResMgr->getImage(filename);
			//			glBindTexture(GL_TEXTURE_2D, mTiledBg[i*8+j]->mTexture->mTextureId);
			//			glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
			//			glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		}
	}

	
	//toolbox
	g_UiResMgr->loadRes("toolbox.xml", NULL, IMG_RES_SCALE);
	mReplaybg= g_UiResMgr->getImage("replaybg");
	mReplaybg->makeCenterAsAnchor();
	optionBtnImg[PAUSE_BTN_RP]= g_UiResMgr->getImage("replay");
	optionBtnImg[PAUSE_BTN_QUIT]=g_UiResMgr->getImage("no");
	mNext= g_UiResMgr->getImage("next");
	mStars[0] = g_UiResMgr->getImage("bigdarkstar");
	mStars[1] = g_UiResMgr->getImage("halflightstar");
	mStars[2] = g_UiResMgr->getImage("biglightstar");
	
	
	
	mBackbg = g_UiResMgr->getImage("backbg");
	mActivebg=g_UiResMgr->getImage("activebg");
	mActivebg->makeCenterAsAnchor();
	
	mClose=g_UiResMgr->getImage("close");
	mClose->makeCenterAsAnchor();
	mYesbg=g_UiResMgr->getImage("yesbg");
    mYesbg->makeCenterAsAnchor();
	mNo=g_UiResMgr->getImage("no");
	mYes=g_UiResMgr->getImage("yes");
	mLock=g_UiResMgr->getImage("lock");
    mFreeLock = g_UiResMgr->getImage("redlock");
	mPause=g_UiResMgr->getImage("pause");
	mPause->makeCenterAsAnchor();
	optionBtnImg[OPTION_BTN_BGM_ON]=g_UiResMgr->getImage("musicon");
	optionBtnImg[OPTION_BTN_BGM_OFF]=g_UiResMgr->getImage("musicoff");
	optionBtnImg[OPTION_BTN_SND_ON]=g_UiResMgr->getImage("volumeon");
	optionBtnImg[OPTION_BTN_SND_OFF]=g_UiResMgr->getImage("volumeoff");
	
	optionBtnImg[OPTION_BTN_BG]=g_UiResMgr->getImage("optionbarbg");
	optionBtnImg[OPTION_BTN_BG]->makeCenterAsAnchor();
	
    optionBtnImg[OPTION_BTN_OF]=g_UiResMgr->getImage("openfeint");
	optionBtnImg[OPTION_BTN_GC]=g_UiResMgr->getImage("gamecenter");
#ifdef V_1_1_0
    optionBtnImg[OVER_BTN_RESET] = g_UiResMgr->getImage("reset");
#endif
	mOptionStar[0] = g_UiResMgr->getImage("lightstar");
	mOptionStar[1] = g_UiResMgr->getImage("darkstar");
	mQestion = g_UiResMgr->getImage("question");
	
	// Game Center Icons
	g_UiResMgr->createImage("gclb", "gclb.png", GCLB_TEX_X, GCLB_TEX_Y, GCLB_TEX_EDGE, GCLB_TEX_EDGE, BG_TEX_OX, BG_TEX_OY);
	mGcIcons[0] = g_UiResMgr->getImage("gclb");
	g_UiResMgr->createImage("gcas", "gcas.png", GCLB_TEX_X, GCLB_TEX_Y, GCLB_TEX_EDGE, GCLB_TEX_EDGE, BG_TEX_OX, BG_TEX_OY);
	mGcIcons[1] = g_UiResMgr->getImage("gcas");
	
	g_UiResMgr->createImage("dropbox", "news.png", NEWS_TEX_X, NEWS_TEX_Y, NEWS_TEX_W,NEWS_TEX_H, NEWS_TEX_OX, NEWS_TEX_OY);
	mDropBox = g_UiResMgr->getImage("dropbox");
	mDropBox->makeCenterAsAnchor();
	
//	stars
	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA8888;
	g_UiResMgr->createImage("star0", "stars.png",  0.0f,  0.0f, 32.0f, 32.0f, 0.0f, 0.0f);
	g_UiResMgr->createImage("star1", "stars.png", 32.0f,  0.0f, 32.0f, 32.0f, 0.0f, 0.0f);
	g_UiResMgr->createImage("star2", "stars.png", 32.0f, 32.0f, 32.0f, 32.0f, 0.0f, 0.0f);
	g_UiResMgr->createImage("star3", "stars.png", 32.0f, 32.0f, 16.0f, 16.0f, 0.0f, 0.0f);
	g_UiResMgr->createImage("star4", "stars.png", 48.0f, 48.0f, 16.0f, 16.0f, 0.0f, 0.0f);
	mLevelbgsky[0] = g_UiResMgr->getImage("star0");
	mLevelbgsky[1] = g_UiResMgr->getImage("star1");
	mLevelbgsky[2] = g_UiResMgr->getImage("star2");
	mLevelbgsky[3] = g_UiResMgr->getImage("star3");
	mLevelbgsky[4] = g_UiResMgr->getImage("star4");
	mLevelbgsky[0]->makeCenterAsAnchor();
	mLevelbgsky[1]->makeCenterAsAnchor();
	mLevelbgsky[2]->makeCenterAsAnchor();
	mLevelbgsky[3]->makeCenterAsAnchor();
	mLevelbgsky[4]->makeCenterAsAnchor();
	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA4444;
	
	
	// Fonts
	char charIdx[4] = {0};
	int charCnt = 0;
	for (int i = 0; i < FONT_TYPE_MAX; i++)
	{
		memset(filename, '\0', sizeof(filename));
		sprintf(filename, "font%d.xml", i);
		g_UiResMgr->loadRes(filename, NULL);
		for (int j = 0; j < FONT_CHAR_MAX; j++)
		{
			memset(charIdx, '\0', sizeof(charIdx));
			sprintf(charIdx, "%d", (32 + j + 200 * i));
			mFonts[charCnt] = g_UiResMgr->getImage(charIdx);
			++charCnt;
		}
	}
	
	// Player
	mPlayer = new Sprite();
	g_UiResMgr->createSprite(mPlayer, "player.xml", NULL, 1.0f, IMG_RES_SCALE);
#if 0//DEBUG
	mPlayer->dbgDrawFrame = true;
#endif
  	
#ifdef DBG_MEM_MONITORF
	// UI
	mFont0 = new Font(20);
#endif
}

void ReleaseGameTextures()
{
#ifdef DBG_MEM_MONITOR
	delete mFont0;
	mFont0 = NULL;
#endif
	if (mPlayer)
	{
		delete mPlayer;
		mPlayer = NULL;
	}
	
	if (g_UiResMgr)
	{
		delete g_UiResMgr;
		g_UiResMgr = NULL;
	}
}

void InitMenuRes()
{
	if (g_MenuResMgr == NULL)
	{
		g_MenuResMgr = new NeoRes();
	}
	else
	{
		return;
	}
	
	char filename[16] = {0};
	
	// Title
	g_MenuResMgr->createImage(TITLE_BG2_TEX_ID, TITLE_BG2_TEX_FILE, TITLE_TEX_X, TITLE_TEX_Y, TITLE_TEX_W, TITLE_TEX_H, TITLE_TEX_OX, TITLE_TEX_OY);
	mTitleBG2 = g_MenuResMgr->getImage(TITLE_BG2_TEX_ID);
  
#ifdef V_1_1_0
    //	baowu
   
    for (int i=0; i<4; i++) 
    {
        for (int j=0; j<9; j++) 
        { 
            memset(filename, '\0', sizeof(filename));
            sprintf(filename, "baowu%d", i*9+j);
            g_MenuResMgr->createImage(filename, "baowu.png",j*43*IMG_RES_SCALE,i*50*IMG_RES_SCALE, 43.0f*IMG_RES_SCALE, 50.0f*IMG_RES_SCALE, 0.0f, 0.0f);
			mProps[i*9+j] = g_MenuResMgr->getImage(filename);
        }
        
    }
//mStartGiant
	mStartGiant = new Sprite();
	g_MenuResMgr->createSprite(mStartGiant,"startGiant.xml",NULL,IMG_RES_SCALE,IMG_RES_SCALE);
	mStartGiant->setCurrentAction(0);
	mStartGiant->mFrames[mStartGiant->mFrames.size()-1].mDuration = 2000.0f;
	mStartGiant->startAction();
    //    
///#ifdef V_FREE
    g_MenuResMgr->createImage("free", "starticon.png", 172.0f/IPAD_TITLE_IMG, 0.0f,168.0f/IPAD_TITLE_IMG,82.0f/IPAD_TITLE_IMG, 0.0f, 0.0f);
    mFree = g_MenuResMgr->getImage("free");

//#endif 
	g_MenuResMgr->createImage("Select00", "levelcity.png",BG_TEX_X, BG_TEX_Y, BG_TEX_W, BG_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[4] = g_MenuResMgr->getImage("Select00");
	g_MenuResMgr->createImage("Select01", "levelside.png",BG_TEX_X, BG_TEX_Y, BG_TEX_W, BG_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[5] = g_MenuResMgr->getImage("Select01");
	g_MenuResMgr->createImage("Select02", "levelpark.png", BG_TEX_X, BG_TEX_Y, BG_TEX_W, BG_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[6] = g_MenuResMgr->getImage("Select02");
    g_MenuResMgr->createImage("Select03", "levelunknown.png", BG_TEX_X, BG_TEX_Y, BG_TEX_W, BG_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[7] = g_MenuResMgr->getImage("Select03");
	
	g_MenuResMgr->createImage("Select0", "levelcity.png", SELECT_TEX_X, SELECT_TEX_Y, SELECT_TEX_W, SELECT_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[0] = g_MenuResMgr->getImage("Select0");	
	g_MenuResMgr->createImage("Select1", "levelside.png", SELECT_TEX_X, SELECT_TEX_Y, SELECT_TEX_W, SELECT_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[1] = g_MenuResMgr->getImage("Select1");	
	g_MenuResMgr->createImage("Select2", "levelpark.png",SELECT_TEX_X, SELECT_TEX_Y, SELECT_TEX_W, SELECT_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[2] = g_MenuResMgr->getImage("Select2");
    g_MenuResMgr->createImage("Select3", "levelunknown.png",SELECT_TEX_X, SELECT_TEX_Y, SELECT_TEX_W, SELECT_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[3] = g_MenuResMgr->getImage("Select3");
#else
    g_MenuResMgr->createImage("Select00", "levelcity.png",BG_TEX_X, BG_TEX_Y, BG_TEX_W, BG_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[3] = g_MenuResMgr->getImage("Select00");
	g_MenuResMgr->createImage("Select01", "levelside.png",BG_TEX_X, BG_TEX_Y, BG_TEX_W, BG_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[4] = g_MenuResMgr->getImage("Select01");
	g_MenuResMgr->createImage("Select02", "levelpark.png", BG_TEX_X, BG_TEX_Y, BG_TEX_W, BG_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[5] = g_MenuResMgr->getImage("Select02");
	
	g_MenuResMgr->createImage("Select0", "levelcity.png", SELECT_TEX_X, SELECT_TEX_Y, SELECT_TEX_W, SELECT_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[0] = g_MenuResMgr->getImage("Select0");	
	g_MenuResMgr->createImage("Select1", "levelside.png", SELECT_TEX_X, SELECT_TEX_Y, SELECT_TEX_W, SELECT_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[1] = g_MenuResMgr->getImage("Select1");	
	g_MenuResMgr->createImage("Select2", "levelpark.png",SELECT_TEX_X, SELECT_TEX_Y, SELECT_TEX_W, SELECT_TEX_H, BG_TEX_OX, BG_TEX_OY);
	mSelectPlay[2] = g_MenuResMgr->getImage("Select2");
#endif
	
	// News
	g_MenuResMgr->loadRes("news.xml", NULL, IMG_RES_SCALE);
	for (int i = 0; i < 14; i++)
	{
		memset(filename, '\0', sizeof(filename));
		sprintf(filename, "news%d", i);
		mNewsImg[i] = g_MenuResMgr->getImage(filename);
	}
	mNewsImg[9]->SetAnchor(0.0f, mNewsImg[9]->mHeight);
	mNewsImg[10]->SetAnchor(mNewsImg[10]->mWidth, mNewsImg[10]->mHeight);
	mNewsImg[12]->makeCenterAsAnchor();
	mNewsImg[13]->makeCenterAsAnchor();

    
    g_MenuResMgr->createImage("wheel", "starticon.png", 514/IPAD_TITLE_IMG,0, 222/IPAD_TITLE_IMG,206/IPAD_TITLE_IMG,0,0);
    mWheel=g_MenuResMgr->getImage("wheel");
	mWheel->SetAnchor(111/IPAD_TITLE_IMG, 103/IPAD_TITLE_IMG);
    g_MenuResMgr->createImage("light", "starticon.png", 362/IPAD_TITLE_IMG,4/IPAD_TITLE_IMG, 108/IPAD_TITLE_IMG,88/IPAD_TITLE_IMG,0,0);
    mLight=g_MenuResMgr->getImage("light");
    
    g_MenuResMgr->createImage("btnstartbg","starticon.png",425/IPAD_TITLE_IMG, 210/IPAD_TITLE_IMG, 319/IPAD_TITLE_IMG,440/IPAD_TITLE_IMG,0,0);
    mBtnStartBg=g_MenuResMgr->getImage("btnstartbg");
    
	for (int i=0; i<8; i++) 
    {
		memset(filename, '\0', sizeof(filename));
		sprintf(filename, "starticon%d", i);
        g_MenuResMgr->createImage(filename,"starticon.png",736/IPAD_TITLE_IMG,i*82/IPAD_TITLE_IMG,284/IPAD_TITLE_IMG,82/IPAD_TITLE_IMG,0,0);
	}
    char filename_pre[16] = {0};
    for (int i=0; i<4; i++) 
    {
        sprintf(filename_pre, "starticon%d", i);
        sprintf(filename, "starticon%d", i+4);
        btnStartIcon[i]=new ZprUIButton(filename, filename_pre,NULL,284/(IPAD_TITLE_IMG*IMG_RES_SCALE),82/(IPAD_TITLE_IMG*IMG_RES_SCALE));
    }
    
    for (int i=8; i<12; i++) 
    {
        memset(filename, '\0', sizeof(filename));
		sprintf(filename, "starticon%d", i);
        g_MenuResMgr->createImage(filename,"starticon.png",0,(82+(i-8)*164)/IPAD_TITLE_IMG,426/IPAD_TITLE_IMG,164/IPAD_TITLE_IMG,0,0);

    }
    for (int i=4; i<6; i++) 
    {
        sprintf(filename, "starticon%d", 4+i);
        sprintf(filename_pre, "starticon%d", 4+i+2);
        btnStartIcon[i]=new ZprUIButton(filename, filename_pre,NULL,426/(IPAD_TITLE_IMG*IMG_RES_SCALE),164/(IPAD_TITLE_IMG*IMG_RES_SCALE));
    }
    
#ifdef __IN_APP_PURCHASE__
    closeBtn= new ZprUIButton("close",g_UiResMgr);
    closeBtn->_type=ZPR_UI_BTN_TYPE_4;
    
    closeBtn->setBtnPos(370.0f*IPAD_X,30.0f*IPAD_X);
    closeBtn->setBtnRect(50, 50);
    buyItemBtn = new ZprUIButton("optionbarbg",g_UiResMgr);
    buyItemBtn->setBtnPos(240.0f*IPAD_X, 275.0f*IPAD_X);
    
    g_MenuResMgr->createImage("facebook", "starticon.png", 0,0, 82/IPAD_TITLE_IMG,82/IPAD_TITLE_IMG,0,0);
    btnFacebookAtTitle = new ZprUIButton("facebook",NULL,NULL,82/(IPAD_TITLE_IMG*IMG_RES_SCALE),82/(IPAD_TITLE_IMG*IMG_RES_SCALE));
   
    g_MenuResMgr->createImage("twitter", "starticon.png", 82/IPAD_TITLE_IMG,0, 82/IPAD_TITLE_IMG,82/IPAD_TITLE_IMG,0,0);
     btnTwitterAtTitle = new ZprUIButton("twitter",NULL,NULL,82/(IPAD_TITLE_IMG*IMG_RES_SCALE),82/(IPAD_TITLE_IMG*IMG_RES_SCALE));
#ifdef VERSION_IPAD
    purchaseBtn2 = new ZprUIButton("storeLabel.png",139.0f*IPAD_X,40.0f*IPAD_X);
    purchaseBtn2->setBtnPos(184.0f*IPAD_X, 172.0f*IPAD_X);
    purchaseBtn2->setBtnRect(103.0f*IPAD_X,66.0f*IPAD_X,174.0f*IPAD_X,114.0f*IPAD_X);
    purchaseBtn3 = new ZprUIButton("storeLabel.png",139.0f*IPAD_X,40.0f*IPAD_X);
    purchaseBtn3->setBtnPos(368.0f*IPAD_X, 331.0f*IPAD_X);
    purchaseBtn3->setBtnRect(258.0f*IPAD_X,194.0f*IPAD_X,216.0f*IPAD_X,149.0f*IPAD_X);
    
    purchaseBtn1 = new ZprUIButton("storeLabel.png",139.0f*IPAD_X,40.0f*IPAD_X);
    purchaseBtn1->setBtnPos(346.0f*IPAD_X, 169.0f*IPAD_X);
    purchaseBtn1->setBtnRect(286.0f*IPAD_X,10.0f*IPAD_X,130.0f*IPAD_X,166.0f*IPAD_X);
    
    purchaseBtn4 = new ZprUIButton("storeLabel.png",139.0f*IPAD_X,40.0f*IPAD_X);
    purchaseBtn4->setBtnPos(90.0f*IPAD_X, 320.0f*IPAD_X);
    purchaseBtn4->setBtnRect(30.0f*IPAD_X,185.0f*IPAD_X,117.0f*IPAD_X,149.0f*IPAD_X);
    
  
#else
    purchaseBtn2 = new ZprUIButton("storeLabel.png",139.0f*IPAD_X,40.0f*IPAD_X);
    purchaseBtn2->setBtnPos(184.0f*IPAD_X, 162.0f*IPAD_X);
    purchaseBtn2->setBtnRect(103.0f,66.0f,174.0f,109.0f);
    purchaseBtn3 = new ZprUIButton("storeLabel.png",139.0f*IPAD_X,40.0f*IPAD_X);
    purchaseBtn3->setBtnPos(368.0f*IPAD_X, 299.0f*IPAD_X);
    purchaseBtn3->setBtnRect(258.0f,194.0f,216.0f,119.0f);
    
    purchaseBtn1 = new ZprUIButton("storeLabel.png",139.0f*IPAD_X,40.0f*IPAD_X);
    purchaseBtn1->setBtnPos(336.0f*IPAD_X, 152.0f*IPAD_X);
    purchaseBtn1->setBtnRect(276.0f,10.0f,130.0f,156.0f);
    
    purchaseBtn4 = new ZprUIButton("storeLabel.png",139.0f*IPAD_X,40.0f*IPAD_X);
    purchaseBtn4->setBtnPos(100.0f*IPAD_X, 300.0f*IPAD_X);
    purchaseBtn4->setBtnRect(44.0f,185.0f,117.0f,139.0f);

    
#endif
    g_MenuResMgr->createImage("storeItem1", "storebtn.png", 3.0f*IMG_RES_SCALE, 65.0f*IMG_RES_SCALE, 66.0f*IMG_RES_SCALE, 83.0f*IMG_RES_SCALE, 0.0f, 0.0f);
    g_MenuResMgr->createImage("storeItem2", "storebtn.png", 108.0f*IMG_RES_SCALE, 1.0f*IMG_RES_SCALE, 76.0f*IMG_RES_SCALE, 52.0f*IMG_RES_SCALE, 0.0f, 0.0f);
    g_MenuResMgr->createImage("storeItem3", "storebtn.png", 0.0f, 0.0f, 72.0f*IMG_RES_SCALE, 61.0f*IMG_RES_SCALE, 0.0f, 0.0f);
    g_MenuResMgr->createImage("storeItem4", "storebtn.png", 108.0f*IMG_RES_SCALE, 64.0f*IMG_RES_SCALE, 79.0f*IMG_RES_SCALE, 81.0f*IMG_RES_SCALE, 0.0f, 0.0f);
    addRunnerModeAni =g_MenuResMgr->getImage("storeItem2");
    addRunnerModeAni->makeCenterAsAnchor();
    addTrampolinesAni =g_MenuResMgr->getImage("storeItem3");
    addTrampolinesAni->makeCenterAsAnchor();
    addComboPackAni=g_MenuResMgr->getImage("storeItem4");
    addComboPackAni->makeCenterAsAnchor();
    addUpgradeAni=g_MenuResMgr->getImage("storeItem1");
    addUpgradeAni->makeCenterAsAnchor();
    
//    purchaseBtn1->_type = ZPR_UI_BTN_TYPE_4;
//    purchaseBtn2->_type = ZPR_UI_BTN_TYPE_4;
//    purchaseBtn3->_type = ZPR_UI_BTN_TYPE_4;
//    purchaseBtn4->_type = ZPR_UI_BTN_TYPE_4;
#endif
}

void RelMenuRes()
{
    if (g_MenuResMgr)
	{
#ifdef __IN_APP_PURCHASE__
        if (purchaseBtn1) {
            delete purchaseBtn1;
            purchaseBtn1 = NULL;
        }
        if (purchaseBtn2) {
            delete purchaseBtn2;
            purchaseBtn2 = NULL;
        }
        if (purchaseBtn3) {
            delete purchaseBtn3;
            purchaseBtn3 = NULL;
        }
        if (purchaseBtn4) {
                delete purchaseBtn4;
                purchaseBtn4 = NULL;
        }
        
        if (closeBtn) {
            delete closeBtn;
            closeBtn = NULL;
        }
        if (buyItemBtn) {
            delete buyItemBtn;
            buyItemBtn = NULL;
        }
        if (btnFacebookAtTitle) {
            delete btnFacebookAtTitle;
            btnFacebookAtTitle = NULL;
        }
        if (btnTwitterAtTitle) {
            delete btnTwitterAtTitle;
            btnTwitterAtTitle = NULL;
        }
#endif
        if (mStartGiant)
        {
            delete mStartGiant;
            mStartGiant = NULL;
        }
//        if (mStartGiant2)
//        {
//            delete mStartGiant2;
//            mStartGiant2 = NULL;
//        }
        
        if (g_MenuResMgr)
        {
            delete g_MenuResMgr;
            g_MenuResMgr = NULL;
        }
        if (waitView) {
            [waitView release];
            waitView = NULL;
        }
    }
}

//void InitCreditRes()
//{
//	if (g_MenuResMgr == NULL)
//	{
//		g_MenuResMgr = new NeoRes();
//	}
//	else
//	{
//		return;
//	}
//	
//	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA8888;
//	
//	//level
//	g_MenuResMgr->createImage("Levelbgsky", "levelbgsky.png", TITLE_TEX_X, TITLE_TEX_Y, TITLE_TEX_W, TITLE_TEX_H, TITLE_TEX_OX, TITLE_TEX_OY);
//    mLevelbgsky = g_MenuResMgr->getImage("Levelbgsky");
//	
//	Texture2D.defaultAlphaPixelFormat = kTexture2DPixelFormat_RGBA4444;
//}
//
//void RelCreditRes()
//{
//	if (g_MenuResMgr)
//	{
//		delete g_MenuResMgr;
//		g_MenuResMgr = NULL;
//	}
//}

void InitGcRes()
{
	if (g_GcResMgr == NULL)
	{
		g_GcResMgr = new NeoRes();
	}
	else
	{
		return;
	}
	
	// Giant
	mGiant = new Sprite();
	g_GcResMgr->createSprite(mGiant, "giant.xml", NULL, 1.0f, IMG_RES_SCALE);
#if 0//DEBUG
	mGiant->dbgDrawFrame = true;
#endif
	
	// Effects
	mEffect1 = new Sprite();
	g_GcResMgr->createSprite(mEffect1, "getitem.xml", 0/*, IMG_RES_SCALE*/);
	
	mEffect2 = new Sprite();
	g_GcResMgr->createSprite(mEffect2, "attack.xml", 0/*, IMG_RES_SCALE*/);
	
	mEffect3 = new Sprite();
	g_GcResMgr->createSprite(mEffect3, "flust.xml", 0/*, IMG_RES_SCALE*/);
	
	mEffect4 = new Sprite();
	g_GcResMgr->createSprite(mEffect4, "splash.xml", 0/*, IMG_RES_SCALE*/);
	
	// Coin
	g_GcResMgr->createImage("coin", "i100.png", COIN_TEX_X, COIN_TEX_Y, COIN_TEX_WIDTH, COIN_TEX_WIDTH, NEWS_TEX_OX, NEWS_TEX_OY);
	mCoin = g_GcResMgr->getImage("coin");
    
#ifdef __IN_APP_PURCHASE__
    // Buttons
    g_GcResMgr->loadRes("igbtns.xml", NULL, IMG_RES_SCALE);
    inGameBtnRunnerMode = new ZprUIButton("igb_rmn", NULL, "igb_rmd", 64.0f, 64.0f, g_GcResMgr);
    inGameBtnRunnerMode->setBtnPos(32.0f, (60.0f));
    inGameBtnTrampoline = new ZprUIButton("igb_trn", NULL, "igb_trd", 64.0f, 64.0f, g_GcResMgr);
    inGameBtnTrampoline->setBtnPos(32.0f, (60.0f + 64.0f));
    
    initGameRunnerModeRes();
    initGameTrampolineRes();
#endif
}

void RelGcRes()
{
#ifdef __IN_APP_PURCHASE__
    if (inGameBtnRunnerMode)
    {
        delete inGameBtnRunnerMode;
        inGameBtnRunnerMode = NULL;
    }
    if (inGameBtnTrampoline)
    {
        delete inGameBtnTrampoline;
        inGameBtnTrampoline = NULL;
    }
    
    relGameRunnerModeRes();
    relGameTrampolineRes();
#endif
	if (mGiant)
	{
		delete mGiant;
		mGiant = NULL;
	}
	
	if (mEffect1)
	{
		delete mEffect1;
		mEffect1 = NULL;
	}
	
	if (mEffect2)
	{
		delete mEffect2;
		mEffect2 = NULL;
	}
	
	if (mEffect3)
	{
		delete mEffect3;
		mEffect3 = NULL;
	}
	
	if (mEffect4)
	{
		delete mEffect4;
		mEffect4 = NULL;
	}
	
	if (g_GcResMgr)
	{
		delete g_GcResMgr;
		g_GcResMgr = NULL;
	}
	
	RelGcOverRes();
}

void InitGcOverRes(int iOver)
{
	if (g_GcOverResMgr == NULL)
	{
		g_GcOverResMgr = new NeoRes();
	}
	else
	{
		return;
	}
	
	// over
//#ifdef V_1_1_0
//    if (iOver == 100)
//#else
	if (iOver == 0)
//#endif
	{
		g_GcOverResMgr->createImage("Over", "over.png",  STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX,STORY_TEX_OY);
		mOver = g_GcOverResMgr->getImage("Over");
	}
//#ifdef V_1_1_0
//    else if (iOver == 101)
//#else
	else if (iOver == 1)
//#endif
	{
		g_GcOverResMgr->createImage("Over2", "over2.png",STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX,STORY_TEX_OY);
		mOver2 = g_GcOverResMgr->getImage("Over2");
	}
	else
	{
        if (ParkourStatistics[ACH_STA_ITEM]!=-1)
        {
            if (LevelIndex<3) 
            {
                char tempinfo[24] = {0};
                memset(tempinfo, '\0', sizeof(tempinfo));
				int type = props_order[LevelIndex*8+ActiveLevel];
                sprintf(tempinfo, "props%d.png", type);
                g_GcOverResMgr->createImage("igitem", tempinfo, 0.0f, 0.0f, 128.0f, 128.0f, 0.0f, 0.0f);
                mAchieveInfo[type] = g_GcOverResMgr->getImage("igitem");
            }
            else  
            {
                char tempinfo[24] = {0};
                memset(tempinfo, '\0', sizeof(tempinfo));
                sprintf(tempinfo, "bedprops%d.png", ParkourStatistics[ACH_STA_ITEM]-25);
                g_GcOverResMgr->createImage("igitem", tempinfo, 0.0f, 0.0f, 128.0f, 128.0f, 0.0f, 0.0f);
                mBedroomPropsInfo[ParkourStatistics[ACH_STA_ITEM]-25] = g_GcOverResMgr->getImage("igitem");
            }
        }
//#endif
	}
}

void RelGcOverRes()
{
	if (g_GcOverResMgr)
	{
		delete g_GcOverResMgr;
		g_GcOverResMgr = NULL;
	}
}

#ifdef __IN_APP_PURCHASE__
void initResStore()
{
    if (g_StoreResMgr == NULL)
	{
		g_StoreResMgr = new NeoRes();
	}
	else
	{
		return;
	}
#ifdef VERSION_IPAD
    g_StoreResMgr->createImage("storebg", "storebg.png", 0.0f, 0.0f, 1024.0f, 768.0f, 0.0f, 0.0f);
#else
    g_StoreResMgr->createImage("storebg", "storebg.png", 0.0f, 0.0f, 480.0f, 320.0f, 0.0f, 0.0f);
#endif
	mStoreBg = g_StoreResMgr->getImage("storebg");
}

void freeResStore()
{
    if (g_StoreResMgr)
	{
		delete g_StoreResMgr;
		g_StoreResMgr = NULL;
	}
}
#endif

#ifdef __PROMOTE_ADS__
void initResAds()
{
    if (g_AdsResMgr == NULL)
    {
		g_AdsResMgr = new NeoRes();
	}
    else
    {
        return;
    }
    
    switch (adsStyle) {
        case ADS_STATE_FREE_SHOE:
        case ADS_STATE_FULL_SHOE:
            g_AdsResMgr->createImage("ADS_IPHONE_FULL_SHOES", "ads_iPad_shoes.png", STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
            ads_shoes = g_AdsResMgr->getImage("ADS_IPHONE_FULL_SHOES");
            break;
        case ADS_STATE_FREE_BED:
        case ADS_STATE_FULL_BED:
            g_AdsResMgr->createImage("ADS_IPHONE_FULL_BED", "ads_iPad_bed.png", STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
            ads_bed = g_AdsResMgr->getImage("ADS_IPHONE_FULL_BED");
            break;
        case ADS_STATE_FREE_BUY:
            g_AdsResMgr->createImage("ADS_IPHONE_FREE_BUY", "ads_iPad_buy.png", STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
            ads_buy = g_AdsResMgr->getImage("ADS_IPHONE_FREE_BUY");
            break;
        case ADS_STATE_FOUTH_BUY:
            g_AdsResMgr->createImage("ADS_IPHONE_FOUTH_BUY", "fouth_ads.png", STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
            ads_fouth = g_AdsResMgr->getImage("ADS_IPHONE_FOUTH_BUY");
            break;
        default:
            break;
    }
//	g_AdsResMgr->createImage("ADS_IPHONE_FREE_BUY", "ads_iPad_buy.png", STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
//	ads_buy = g_AdsResMgr->getImage("ADS_IPHONE_FREE_BUY");
//	
//	g_AdsResMgr->createImage("ADS_IPHONE_FULL_SHOES", "ads_iPad_shoes.png", STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
//	ads_shoes = g_AdsResMgr->getImage("ADS_IPHONE_FULL_SHOES");
//    
//	g_AdsResMgr->createImage("ADS_IPHONE_FULL_BED", "ads_iPad_bed.png", STORY_TEX_X, STORY_TEX_Y, STORY_TEX_W, STORY_TEX_H, STORY_TEX_OX, STORY_TEX_OY);
//	ads_bed = g_AdsResMgr->getImage("ADS_IPHONE_FULL_BED");
}

void freeResAds()
{
    if (g_AdsResMgr)
	{
		delete g_AdsResMgr;
		g_AdsResMgr = NULL;
	}
}
#endif

void drawSky()
{
	Canvas2D *canvas = Canvas2D::getInstance();
	canvas->setColor(0.137f, 0.122f, 0.427f, 1.0f);
	canvas->fillRect(0.0f, 0.0f, 512.0f, 384.0f);
	canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
	
	canvas->flush();
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	
	canvas->drawImage(mLevelbgsky[4], 67.0f, 6.0f, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[2], 103.0f, 10.0f, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[1], 135.0f, 11.0f, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[3], 167.0f, 13.0f, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[4], 265.0f, 13.0f, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	
	canvas->drawImage(mLevelbgsky[1], 371, 12, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[4], 493, 2, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[3], 485, 15, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[4], 53, 23, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[2], 18, 47, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	
	canvas->drawImage(mLevelbgsky[1], 49, 67, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[0], 20, 93, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[4], 56, 171, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[3], 33, 203, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[1], 169, 91, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	
	canvas->drawImage(mLevelbgsky[1], 141, 132, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[2], 217, 137, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[3], 175, 277, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[3], 297, 45, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[4], 274, 83, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	
	canvas->drawImage(mLevelbgsky[0], 293, 116, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[4], 308, 175, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[0], 354, 51, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[3], 381, 79, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[2], 357, 131, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	
	canvas->drawImage(mLevelbgsky[0], 385, 185, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[1], 383, 289, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[2], 491, 55, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[3], 475, 81, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[4], 460, 117, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	
	canvas->drawImage(mLevelbgsky[4], 502, 121, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[3], 497, 158, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[4], 493, 189, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[3], 465, 203, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	canvas->drawImage(mLevelbgsky[4], 470, 281, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
	
	canvas->flush();
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
}
