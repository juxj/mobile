/*
 *  GameFaild.cpp
 *  ZPR
 *
 *  Created by Neo Lin on 5/31/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "GameSuc.h"

#import "GameLevel.h"
#import "GameSection.h"
#import "GameHouse.h"
#import "GameOption.h"
#import "GameAchieve.h"
#import "GameAudio.h"

#import "GamePlay.h"
#import "Sprite.h"
#import "Stage.h"
#import "Runner.h"
#import "GameData.h"
#import "Canvas2D.h"
#import "Image.h"
#import "GameState.h"
#import "GameRes.h"
#import "GameLevel.h"

#import "neoRes.h"
#import "Utilities.h"

#import "ZPRAppDelegate.h"

#import "CheckNetwork.h"

#ifdef V_1_1_0
#import "GameTips.h"
#endif

//Image* mResultBG;
#define REPLAYBG_Y		272.0f*IPAD_X
#define IMAG_Y			264.0f*IPAD_X
#define WORD_Y			265.0f*IPAD_X
#define REPLAYBG_X		176.0f*IPAD_X
#define NEXTBG_X		316.0f*IPAD_X
#define REPLAYWORD_X	128.0f*IPAD_X
#define NEXTWORD_X		283.0f*IPAD_X
#define TIME_WAIT		 500

#ifdef VERSION_IPAD
	#define IPAD_SCROLL_Y    2

#else
	#define IPAD_SCROLL_Y     0
#endif
int stepSucInfo = GAMESUCINFO_STEP_ACH_NOTI_ZOMBIE;
int gc_scrolY=0.0f;
Image* mReplaybg;
float alpha = 0.0f;
Image* mNext;
Image* mNextWord;
Image* mReplayWord;
bool isShow=false;
int nCountTime=0;
Image* mDropBox;
int nCnt[10]={0};
int Scroll_X=0;
int scoreId[10]={0};
int numCount=0; 
int starCount = 0;
int order[10]={0};
int orderIdx=0;
//int AcheiveIdx=0;
int Num[10]={0};
bool isScoreOver=false;
bool isShowAll=false;
bool isGCPush=false;
bool isGCPop=false;
int mRand=0;
int scoreOrder=0,numOrder=0;
bool BtnSuccPress[7]={false,false,false,false,false,false,false};
float BtnSuccStartPos[2]={0.0f, 0.0f};

float BtnSucRange[28]=
{    
	94*IPAD_X,245*IPAD_X,246*IPAD_X,307*IPAD_X,//replay if ((fX > 94 && fX <235 ) && ( fY > 205 && fY < 258))
    245*IPAD_X,391*IPAD_X,246*IPAD_X,307*IPAD_X, //next if((fX > 261 && fX <406) && ( fY > 206 && fY < 261))
	337*IPAD_X,418*IPAD_X,0,35*IPAD_X,//back if((fX > 337 && fX <418) && ( fY > 3 && fY < 37)){
	417*IPAD_X,448*IPAD_X,0,35*IPAD_X ,     //openfeint if((fX > 417 && fX <448 ) && ( fY > 3 && fY < 33))
	448*IPAD_X,480*IPAD_X,0,33*IPAD_X,     //gamecenter if((fX > 451 && fX <480 ) && ( fY > 3 && fY < 35))
	445*IPAD_X,480*IPAD_X,33,64,   //leaderborad
	445*IPAD_X,480*IPAD_X,64,110   //achievement
};
char* sucName[10] = 
{
	(char*) "Zombie Defeated:",
	(char*)  "Kash Vaults:",
	(char*)	  "Coins:",
	(char*)   "Zip Lines:",
	(char*)   "Monkeybars:",
	(char*)   "Wall Runs:",
	(char*)   "Slides:",
	(char*)   "Swings:",
	(char*)   "Max Runner Modes:",
	(char*)	  "House Item Collected:",
};
void GameSucBegin()
{
#ifdef __PROMOTE_ADS__
    //					adsStyle = ADS_STATE_FREE_BUY;
#ifdef V_FREE
    if ([app.iap hasUnlockComicInLocalStore])
    {
        int temp = ActiveLevel;
        if (ActiveLevel < STAGE_IN_LV_MAX-1) {
            temp++;
        }
        
        if (mLevelPlayCount[LevelIndex][temp] == 0) {
            
            int random_ = arc4random() % 2;
            
            if (random_ == 0) {
                adsStyle = ADS_STATE_FULL_SHOE;
            }
            else {
                adsStyle = ADS_STATE_FULL_BED;
            }
        }
        else if (mLevelCLear[LevelIndex][temp]) {
            
            adsStyle = ADS_STATE_FREE_SHOE;
            
        }
        else{
            
            adsStyle = ADS_STATE_FREE_BED;
            
        }
    }
    else    // locked
    {
        int temp = ActiveLevel;
        if (ActiveLevel < STAGE_IN_LV_MAX-1) {
            temp++;
        }
        
        if (mLevelPlayCount[LevelIndex][temp] == 0) {
            
            adsStyle = ADS_STATE_FREE_BUY;
        }
        else if (mLevelCLear[LevelIndex][temp]) {
            
            adsStyle = ADS_STATE_FREE_SHOE;
        }
        else{
            
            adsStyle = ADS_STATE_FREE_BED;
        }
    }
#else
    int temp = ActiveLevel;
    if (ActiveLevel < STAGE_IN_LV_MAX-1) {
        temp++;
    }
    
    if (mLevelPlayCount[LevelIndex][temp] == 0) {
        
        int random_ = arc4random() % 2;
        
        if (random_ == 0) {
            adsStyle = ADS_STATE_FULL_SHOE;
        }
        else {
            adsStyle = ADS_STATE_FULL_BED;
        }
    }
    else if (mLevelCLear[LevelIndex][temp]) {
        
        adsStyle = ADS_STATE_FREE_SHOE;
        
    }
    else{
        
        adsStyle = ADS_STATE_FREE_BED;
        
    }

#endif 
#endif
    
#ifdef ENABLE_ACHIEVEMENTS
	AchKillZombieCheck();
	AchComboCountCheck();
	AchCollectCoinCheck();
	AchGetItemBackCheck();
	AchPassObstacleCheck();
	AchRunDistanceCheck();
	
	AchCheckStars();
	AchHighScoreCheck();
	
	AchEndWithRunnerModeCheck();
	
	AchGotPerfectLevel();
	AchCollectItem();
	AchClearLevel(LevelIndex, ActiveLevel);
#endif
    if (LevelIndex<3)
    {        
        if (ActiveLevel < 7)
        {
            mLevelLock[LevelIndex][ActiveLevel+1] = false;
        }
        else
        {
            if (LevelIndex < (LEVEL_NUM_MAX-1))
            {
                mSectionLock[LevelIndex+1] = false;
                mLevelLock[LevelIndex+1][0] = false;
            }
        }
    }
    else
    {
        if (ActiveLevel < 11)
        {
            mLevelLock[LevelIndex][ActiveLevel+1] = false;
        }
    
    }
	SaveFile();
	
//#ifdef ENABLE_ACHIEVEMENTS
//	AchGotPerfectLevel();
//	AchCollectItem();
//	AchClearLevel(LevelIndex, ActiveLevel);
//#endif
//	SaveFile();
	
	//	init
	isGCPush=false;
	isGCPop=false;
	isScoreOver=false;
	gc_scrolY=0.0f;
	orderIdx=0;
	alpha = 0.0f;
	starCount = 0;
	isShow=false;
	nCountTime=0;
	numCount=0;
	isShowAll=false;
	Scroll_X=0;
	for (int i=0;i<10;i++) 
	{   nCnt[i]=0;
		scoreId[i] = 0;
		Num[i]=0;
		order[i]=0;
	}
	
//caculate the	score
	int num=mGetScore;
	while (num/10!=0) {
		Num[numCount]=num%10;
		num=num/10;
		numCount++;
	}
	
	Num[numCount]=num;
	scoreOrder=0;
	numOrder=numCount;

//caculate the number of achievement	
	for (int AcheiveIdx=0; AcheiveIdx<10; AcheiveIdx++) 
	{
		if (AcheiveIdx!=9&&ParkourStatistics[AcheiveIdx]!=0)
		{
			order[orderIdx]=AcheiveIdx;
			orderIdx++;
		}
		else if(AcheiveIdx==9&&ParkourStatistics[AcheiveIdx]!=-1){
			order[orderIdx]=AcheiveIdx;
			orderIdx++;
		}
		
	}
}

void GameSucEnd()
{
}

void GameSucUpdate()
{
	if(isGCPop)
	{
		if (gc_scrolY<108+IPAD_SCROLL_Y) 
		{
			gc_scrolY+=8;
			
		}
		
		else 
		{
			gc_scrolY=108+IPAD_SCROLL_Y;
			
		}	
	}
	
	
	else if(isGCPush)
	{
		if (gc_scrolY>=0) 
		{
			gc_scrolY-=8;
		}
		
		else 
		{
			gc_scrolY=0;
		}
		
		
	}
	
//#ifdef V_1_1_0
//    #ifdef V_FREE
//    if (totalScoreForGameCenter >= 0 && 
//        LevelIndex < STAGE_SECTION_V001 && ActiveLevel < STAGE_LEVEL_V001)
//    {
//        submitScore(TARGET_OPENFEINT, GC_ID_ALL_LEVELS, totalScoreForGameCenter);
//        totalScoreForGameCenter = -1;
//    }
//    #endif
//#endif
}

void ShowScore()
{    
	char cBuffer[32]={0}; 

	for (int j=0;j<=scoreOrder;j++) 
	{   
		
		if(nCnt[j]==4)
		{
			memset(cBuffer, '\0', sizeof(cBuffer));
			sprintf(cBuffer,"%d",scoreId[j]); 
			DrawString(cBuffer, 265*IPAD_X+25*IPAD_X*j,70.0f*IPAD_X+IPAD_THREE_Y,1,1,1,0,1,0);
		}
	}
	
	if (!isScoreOver) 
	{   
			if (nCnt[scoreOrder]<4)//0-9  cycle 4 times
            {
				scoreId[scoreOrder]=mRand++;
                memset(cBuffer, '\0', sizeof(cBuffer));
				sprintf(cBuffer,"%d",scoreId[scoreOrder]); 
				DrawString(cBuffer, 265*IPAD_X+scoreOrder*25*IPAD_X,70.0f*IPAD_X+IPAD_THREE_Y,1,1,1,0,1,0);
				if (mRand>9) {
					mRand=0;
					nCnt[scoreOrder]++;
				}
			}
			else {
				
				scoreId[scoreOrder]=Num[numOrder];
				
                memset(cBuffer, '\0', sizeof(cBuffer));
				sprintf(cBuffer,"%d",scoreId[scoreOrder]); 
     			DrawString(cBuffer, 265*IPAD_X+scoreOrder*25*IPAD_X,70.0f*IPAD_X+IPAD_THREE_Y,1,1,1,0,1,0);
				if(scoreOrder<numCount)
				{
					scoreOrder++;
				}
				if (numOrder>0) {
					numOrder--;
				}
				else {
					scoreOrder=numCount;
					numOrder=0;
					isScoreOver=true;
				}	
				
			}
		
			
	}
	
}

void ShowAchieve()
{    
   
	for (int i=0; i<orderIdx; i++)
	{
		if (nCountTime<TIME_WAIT)
		{   
			char str[8]={0};
			char cBuffer[128];
			
			if(order[i]!=8&&order[i]!=9)
			{
				sprintf(str, "%d", ParkourStatistics[order[i]]);
				
			}
			else if(order[i]==8){
				sprintf(str, "X%d", ParkourStatistics[order[i]]);
			}
			else if(order[i]==9){
				sprintf(str, "%s","YES");
			}
			
			sprintf(cBuffer, "%s %s", sucName[order[i]],str);
			DrawString(cBuffer,(480*IPAD_X-GetStringWidth(cBuffer, 0.5, 0))/2+i*480*IPAD_X+Scroll_X,220.0f*IPAD_X,0.5,1,1,1,1,0);
			nCountTime++;
           
		}
		else
		{   
            
			Scroll_X-=480*IPAD_X;
			nCountTime=0;
		}
		if (Scroll_X<=-(orderIdx*480*IPAD_X)) 
        {
			Scroll_X=0;
		}
	}
	 	
	
}

void GameSucRender(float dt)
{
	//paint button
	mSelectStar[LevelIndex] = 0;
	Canvas2D* canvas = Canvas2D::getInstance();
	stages->render(dt);
	canvas->drawImage(mDropBox, 462*IPAD_X, (68-108)*IPAD_X+gc_scrolY, 3.14/2, 0.58, 1.0);
	if(isGCPop)
	{
		for (int i=5; i<7; i++) {
			float colorbg=BtnSuccPress[i]?BACK_COLOR:1;
			float alphacg=BtnSuccPress[i]?1:0;
			canvas->setColor(colorbg, colorbg, colorbg, alphacg);
			switch (i) {
				case 5:
					
					canvas->fillRect(447*IPAD_X, 26.0f, 31,42);
					
					break;
				case 6:
					
					canvas->fillRect(447*IPAD_X, 68.0f, 31,42);
					break;
				default:
					break;
			}
			canvas->setColor(1, 1, 1, 1);
		}
	}
	canvas->drawImage(mGcIcons[0], 447.0f*IPAD_X, (34-108)*IPAD_X+gc_scrolY);
	canvas->drawImage(mGcIcons[1], 447.0f*IPAD_X, (32+40.0f-108)*IPAD_X+gc_scrolY);

	RenderTileBG(TYPE_SUCC_BG, (canvas->getCanvasWidth()*IPAD_X-TILE_SUCC_COL*29)/2, 33*IPAD_X+IPAD_THREE_Y, 1, 0.99);
    
	for (int i=2; i<5; i++) {
		
		float colorbg=BtnSuccPress[i]?BACK_COLOR:0;
		
		canvas->setColor(colorbg, colorbg, colorbg, 1);
		
		switch (i) {
			case 2:
				canvas->fillRect(350*IPAD_X, 0.0f, 62*IPAD_X, 28*IPAD_X);
				break;
			case 3:canvas->fillRect(412*IPAD_X, 0.0f, 34*IPAD_X, 28*IPAD_X);
				break;
			case 4:canvas->fillRect(446*IPAD_X, 0.0f, 37*IPAD_X, 28*IPAD_X);
				break;
			default:
				break;
		}
		canvas->setColor(1, 1, 1, 1);
	}

	canvas->drawImage(optionBtnImg[OPTION_BTN_OF], 414*IPAD_X, 0.0f, 0.0f, 0.9f, 0.9f);
	canvas->drawImage(optionBtnImg[OPTION_BTN_GC], 449*IPAD_X, 0.0f, 0.0f, 0.9f, 0.9f);

	DrawString((char*)"Score:",125*IPAD_X,70.0f*IPAD_X+IPAD_THREE_Y,1,1,1,1,1,0);
	for (int i=0; i<3; i++)
	{
		canvas->drawImage(mStars[0], 96*IPAD_X+66*i, 132.0f*IPAD_X+IPAD_THREE_Y, 0.0f, 1.2f, 1.2f);
		
	}
	
	for (int i=0; i<=8; i+=4)
	{
			float scale=BtnSuccPress[i/4]?1.0f:1.1f;
		   float color=BtnSuccPress[i/4]?0.0f:1.0f;
			switch (i) 
			{
				case 0:
				{
					canvas->drawImage(mReplaybg, REPLAYBG_X,REPLAYBG_Y,0.f,scale,scale);
					DrawString((char*)"REPLAY",REPLAYWORD_X,WORD_Y,0.5,1,1,color,1,0);
				}
					break;
				case 4:
				{
					canvas->drawImage(mReplaybg, NEXTBG_X,REPLAYBG_Y,0.f,scale,scale);
					DrawString((char*)"NEXT", NEXTWORD_X,WORD_Y,0.5,1,1,color,1,0);
				}
				break;
				case 8:
					DrawString((char*)"BACK",365.f*IPAD_X,5.0f*IPAD_X,0.35,1,1,color,1,0);
					break;
				default:
					break;
			}
		
	}	
	canvas->drawImage(optionBtnImg[PAUSE_BTN_RP],(REPLAYWORD_X+70),IMAG_Y);
	canvas->drawImage(mNext, (NEXTWORD_X+50),IMAG_Y);
	
	
	//paint stars and props
	if (isShowAll)
	{
		char cBuffer[32]={0}; 
        for (int j=numCount; j>=0; j--) 
        {
			memset(cBuffer, '\0', sizeof(cBuffer));
			sprintf(cBuffer,"%d",Num[j]); 
			DrawString(cBuffer, 265*IPAD_X+25*IPAD_X*(numCount-j),70.0f*IPAD_X+IPAD_THREE_Y,1,1,1,0,1,0);

        }
		
		for (int i=0; i<levelRating; i++)
		{
			canvas->drawImage(mStars[2], 96*IPAD_X+66*i, 132.0f*IPAD_X+IPAD_THREE_Y, 0.0f, 1.2f, 1.2f);
			
		}
		
		if (ParkourStatistics[9]!=-1)
		{
            if (LevelIndex<3)
            {
				int type = props_order[LevelIndex*8+ActiveLevel];
                canvas->drawImage(mAchieveInfo[type], 299.0f*IPAD_X, 115.0f*IPAD_X+IPAD_THREE_Y, 0.0f, 
#ifdef VERSION_IPAD
                                  1.5f, 1.5f
#else
                                  0.7f, 0.7f
#endif
                                  );
            }
            else
            {
                canvas->drawImage(mBedroomPropsInfo[ParkourStatistics[ACH_STA_ITEM]-25], 299.0f*IPAD_X, 115.0f*IPAD_X+IPAD_THREE_Y, 0.0f, 
#ifdef VERSION_IPAD
                                  1.5f, 1.5f
#else
                                  0.7f, 0.7f
#endif
                                  
                                  );
            }
		}
		else
		{
			canvas->drawImage(mQestion, 315.0f*IPAD_X, 130.0f*IPAD_X+IPAD_THREE_Y);
		}
		
	}
	else
	{
		ShowScore();
		
		if (isScoreOver)
		{		
			for (int i=0; i<starCount; i++) 
			{
				canvas->drawImage(mStars[2], 96*IPAD_X+66*i,132.0f*IPAD_X+IPAD_THREE_Y,0.0f,1.2f,1.2f);
			}
			canvas->enableColorPointer(TRUE);
			if (starCount < levelRating)
			{
				if (alpha < 1.0f)
				{
					alpha += 0.05f;
					mStars[2]->SetColor(1.0f, 1.0f, 1.0f, alpha);
					canvas->drawImage(mStars[2], 96*IPAD_X+66*starCount, 132.0f*IPAD_X+IPAD_THREE_Y, 0.0f, 1.2f, 1.2f);
					
				}
				else
				{
					mStars[2]->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
					canvas->drawImage(mStars[2], 96*IPAD_X+66*starCount, 132.0f*IPAD_X+IPAD_THREE_Y, 0.0f, 1.2f, 1.2f);
					alpha = 0.0f;
					starCount++;
				}
				
			}
			
			// Item
			else if (ParkourStatistics[9]!=-1)
			{  
				if(alpha < 1.0f&&!isShow)
				{
					alpha += 0.05f;
				if (LevelIndex<3)
                    {
                        int type = props_order[LevelIndex*8+ActiveLevel];
                        mAchieveInfo[type]->SetColor(1.0f, 1.0f, 1.0f, alpha);
                        canvas->drawImage(mAchieveInfo[type], 299.0f*IPAD_X, 115.0f*IPAD_X+IPAD_THREE_Y, 0.0f, 
#ifdef VERSION_IPAD
                                          1.5f, 1.5f
#else
                                          0.7f, 0.7f
#endif
                                          );
                    }
                    else
                    {
						mBedroomPropsInfo[ParkourStatistics[ACH_STA_ITEM]-25]->SetColor(1.0f, 1.0f, 1.0f, alpha);

                        canvas->drawImage(mBedroomPropsInfo[ParkourStatistics[ACH_STA_ITEM]-25], 299.0f*IPAD_X, 115.0f*IPAD_X+IPAD_THREE_Y, 0.0f, 
#ifdef VERSION_IPAD
                                          1.5f, 1.5f
#else
                                          0.7f, 0.7f
#endif
                                          
                                          );
                    }
				}
				else 
				{    isShow=true;
                    if (LevelIndex<3)
                    {
						int type = props_order[LevelIndex*8+ActiveLevel];
						canvas->drawImage(mAchieveInfo[type], 299.0f*IPAD_X, 115.0f*IPAD_X+IPAD_THREE_Y, 0.0f, 
#ifdef VERSION_IPAD
                                      1.5f, 1.5f
#else
                                      0.7f, 0.7f
#endif
                                      );
                    }
                    else
                    {
                        canvas->drawImage(mBedroomPropsInfo[ParkourStatistics[ACH_STA_ITEM]-25], 299.0f*IPAD_X, 115.0f*IPAD_X+IPAD_THREE_Y, 0.0f, 
#ifdef VERSION_IPAD
                                          1.5f, 1.5f
#else
                                          0.7f, 0.7f
#endif

                                         );
                    }
					alpha = 0.0f;
				}
				
			}
			else
			{
				if(alpha < 1.0f&&!isShow)
				{
					alpha += 0.05f;
					mQestion->SetColor(1.0f, 1.0f, 1.0f, alpha);
					canvas->drawImage(mQestion, 315.0f*IPAD_X, 130.0f*IPAD_X+IPAD_THREE_Y);
				}
				else 
				{  isShow=true;
					canvas->drawImage(mQestion, 315.0f*IPAD_X, 130.0f*IPAD_X+IPAD_THREE_Y);
					alpha = 0.0f;
				}
			}
			canvas->enableColorPointer(false);
		}
	}	
	if (isShow||isShowAll)
	{
		ShowAchieve();
	}
//	for (int i=0; i<28; i+=4) {
//			
//		canvas->strokeRect( BtnSucRange[i],  BtnSucRange[i+2], 
//						   (BtnSucRange[i+1]-BtnSucRange[i]),(BtnSucRange[i+3]-BtnSucRange[i+2]));
//		}
}

void GameSucOnTouchEvent(int touchStatus, float fX, float fY)
{
	if (stages == NULL)
	{
		return;
	}
	if (touchStatus == 1)
	{
		BtnSuccStartPos[0]=fX;
		BtnSuccStartPos[1]=fY;
		for (int i = 0; i < 28; i += 4)
		{
			if(BtnSuccStartPos[0] > BtnSucRange[i] && BtnSuccStartPos[0] < BtnSucRange[i+1]  && BtnSuccStartPos[1] > BtnSucRange[i+2]  && BtnSuccStartPos[1] <BtnSucRange[i+3])
			{
				BtnSuccPress[i/4]=true;
			}
		}
	}
	else if (touchStatus == 2)
	{
		for (int i = 0; i < 28; i += 4)
		{
			if((fX > BtnSucRange[i] && fX < BtnSucRange[i+1]  && fY > BtnSucRange[i+2]  && fY <BtnSucRange[i+3])
			   && (BtnSuccStartPos[0] > BtnSucRange[i] && BtnSuccStartPos[0] < BtnSucRange[i+1]  && BtnSuccStartPos[1] > BtnSucRange[i+2]  && BtnSuccStartPos[1] <BtnSucRange[i+3]))
			{
				BtnSuccPress[i/4]=true;
			}
			else {
				BtnSuccPress[i/4]=false;
			}
		}
	}
	else if (touchStatus == 3)
	{
		for (int i = 0; i < 28; i += 4)
		{
			BtnSuccPress[i/4]=false;
		}
		int i=0;
		while (!(
				 (fX > BtnSucRange[i] && fX < BtnSucRange[i+1]  && fY > BtnSucRange[i+2]  && fY <BtnSucRange[i+3])
				 && (BtnSuccStartPos[0] > BtnSucRange[i] && BtnSuccStartPos[0] < BtnSucRange[i+1]  && BtnSuccStartPos[1] > BtnSucRange[i+2]  && BtnSuccStartPos[1] <BtnSucRange[i+3]))
				   &&(i<28) )
		{
			i+=4;
		}
        {
            BtnSuccStartPos[0] = BtnSuccStartPos[1] = -1.0f;
        }
		if (i < 20)
		{
			switch(i)
			{
				// Replay
				case 0:
				{
					playSE(SE_BUTTON_CONFIRM);
					
					//g_nGameState = GAME_STATE_GAME_PLAY;//replay
					
					DisableShadow();//runner mode.
					if (stages)
					{
#ifdef ENABLE_CHECKPOINT
						stages->resetCheckPoint();
#endif
						stages->reset();
					}
#ifdef ENABLE_ACHIEVEMENTS
					ResetTempAchievements();
#endif
					SwitchGameState();
					setGlobalFadeInAndGoTo(GAME_STATE_GAME_PLAY);
				}
					break;
				// Next
				case 4:
				{
					
					int temp = ActiveLevel;
					if (ActiveLevel < STAGE_IN_LV_MAX-1) {
						temp++;
					}
					mLevelPlayCount[LevelIndex][temp] ++;
					
					playSE(SE_BUTTON_CONFIRM);
#ifdef ENABLE_ACHIEVEMENTS
					ResetTempAchievements();
#endif
                    
#ifdef V_1_1_0
                    freeResTip();
#endif

#if V_FREE                    
                    if (LevelIndex==3 && ActiveLevel<11 && ((LevelIndex*8)+ActiveLevel)>=(availableLevels-1)) 
					{
						g_nGameState = GAME_STATE_LEVELTWL_SELECT;//back to menu
                        SwitchGameState();
                        DisableShadow();
                        break;
                    }
#endif		
					if(LevelIndex==STAGE_SECTION_V002-1)
                    {
                        if (ActiveLevel<STAGE_LEVEL_V002-1)
                        {
                            ActiveLevel++;
                            if (stages)
                            {
                                stages->clearBG();
                                stages->clearLevelData();
                                delete stages;
                                stages = NULL;
                            }
                            RelGcRes();
                            
                            g_nGameState = GAME_STATE_LOADING;
                            SwitchGameState();
                        }
                        else 
                        {
                            mStoryIndex=18;
							
							ActiveLevel=0;
                            LevelIndex++;
							
                            if (stages)
                            {
                                stages->clearBG();
                                stages->clearLevelData();
                                delete stages;
                                stages = NULL;
                            }
                            RelGcRes();
                            
                            g_nGameState = GAME_STATE_STORY;
                            SwitchGameState();
						}
                        
                            

                    }
                     else  if (ActiveLevel<STAGE_LEVEL_V001-1)
                        {
                            ActiveLevel++;
                            if (stages)
                            {
                                stages->clearBG();
                                stages->clearLevelData();
                                delete stages;
                                stages = NULL;
                            }
                            RelGcRes();
                            
                            g_nGameState = GAME_STATE_LOADING;
                            SwitchGameState();
                        }					
					else
					{
						if (LevelIndex==0) {
                           mStoryIndex=5;
						}
						else if(LevelIndex==1){
							mStoryIndex=10;
						}
						else if(LevelIndex==2){
							mStoryIndex=13;
						}
						
						ActiveLevel=0;
						LevelIndex++;
						
						//release stages
						if (stages)
						{
							stages->clearBG();
							stages->clearLevelData();
							delete stages;
							stages = NULL;
						}
						RelGcRes();
						
						g_nGameState = GAME_STATE_STORY;
						SwitchGameState();
					}
				}
					break;
				// Back
				case 8:
				{
					playSE(SE_BUTTON_CANCEL);
                    
#ifdef V_1_1_0
                    freeResTip();
#endif
                    
					if(LevelIndex==STAGE_SECTION_V002-1)
                    {
                        if (ActiveLevel < STAGE_LEVEL_V002-1) 
                        {
                            ActiveLevel++;
                        }
                    }
					else if (ActiveLevel < STAGE_LEVEL_V001-1)
					{	
						ActiveLevel++;
					}
					else if (LevelIndex < LEVEL_NUM_MAX-1)
					{

                        if (availableLevels>(LevelIndex+1)*8) 
                        {
                            ActiveLevel=0;
                            LevelIndex++;
                        }

					}
                       					
					//release stages
					if (stages)
					{
						stages->clearBG();
						stages->clearLevelData();
						delete stages;
						stages = NULL;
					}
					RelGcRes();
                    InitMenuRes();
					
#ifdef ENABLE_ACHIEVEMENTS
					ResetTempAchievements();
#endif
					
                    if (LevelIndex<STAGE_SECTION_V001) 
                    {
                        g_nGameState = GAME_STATE_LEVEL_SELECT;//back to menu
                    }
                    else 
                    {       
                        g_nGameState = GAME_STATE_LEVELTWL_SELECT;//back to menu
                    }
					SwitchGameState();
					DisableShadow();//runner mode.
				}
					
					break;
				case 12:
					//playSE(SE_BUTTON_CONFIRM);
					if (app.hasAccount || [CheckNetwork isExistenceNetwork])	// Bug-fix
					LaunchOpenFeint();
					break;
				case 16:
					//playSE(SE_BUTTON_CONFIRM);
					//LaunchGameCenterAchievements();
				{
                    if (![CheckNetwork isNetworkAvailable])
                    {
                        break;
                    }
					app.showCheckGC = true;
					if (1/*[app checkLoginGameCenter] == YES*/)
					{
						app.showCheckGC = false;
					
					if (!isGCPop&&!isGCPush) {
						isGCPop=true;
					}
					else if(isGCPop)
					{
						isGCPop=false;
						isGCPush=true;
					}
					else if(isGCPush)
					{
						isGCPop=true;
						isGCPush=false;
					}
					
					}
				}
					break;
				default:
					break;	
			}
			
		}
		
		if(isGCPop&&i<28){
			
			 switch(i)
			 {
				 case 20:
				 {
					 playSE(SE_BUTTON_CANCEL);
//					 g_nGameState = GAME_STATE_TITLE;
//					 SwitchGameState();
					 LaunchGameCenterLeaderboards();
				 
				 }
					 break;
				 case 24:
				 {
					 playSE(SE_BUTTON_CANCEL);
//					 g_nGameState = GAME_STATE_TITLE;
//					 SwitchGameState();
					 LaunchGameCenterAchievements();
				 }
					 break;
					 
			 }
		 }

		else 
		{
			isShowAll=true;
		}
	}
}
