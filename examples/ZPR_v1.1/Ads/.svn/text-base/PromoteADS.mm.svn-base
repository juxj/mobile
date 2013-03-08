//
//  PromoteADS.mm
//  ZPR
//
//  Created by Kenrich Xiao on 11/15/11.
//  Copyright 2011 Break Media. All rights reserved.
//

#import "PromoteADS.h"
#import "GameState.h"
#import "Image.h"
#import "Canvas2D.h"
#import "Utilities.h"
#import "GameRes.h"
#import "GameLevel.h"

Canvas2D *canvas;
float ads_alpha=0.01f;
float  timecount=0.0f;
#define ADS_TIME  2000
void GameDrawBuyImageBegin()
{
     initResAds();
     ads_alpha=0.01f;
     timecount=0.0f;
}
void GameDrawBuyImageRender(float dt)
{
  Canvas2D* canvas = Canvas2D::getInstance();
    canvas->enableColorPointer(TRUE);
    
    if (ads_alpha <1.0f)
    {
        ads_alpha +=0.01f;
      
    }
    else
    {
        ads_alpha =1.0f;
         timecount+=dt;
    }
    switch (adsStyle)
    {
        case ADS_STATE_FREE_BUY:
        {
            ads_buy->SetColor(1.0f, 1.0f, 1.0f, ads_alpha);
            canvas->drawImage(ads_buy, 0.0f, 0.0f, 0.0f, 1.0f, 1.0f);
        }
            break;
        case ADS_STATE_FOUTH_BUY:
        {
            ads_fouth->SetColor(1.0f, 1.0f, 1.0f, ads_alpha);
            canvas->drawImage(ads_fouth, 0.0f, 0.0f, 0.0f, 1.0f, 1.0f);
        }
           break;
        default:
            break;
    }

    canvas->enableColorPointer(FALSE);
 
}
void GameAdsOnTouchEvent(int touchStatus, float fX, float fY)
{
    
    if (touchStatus==3)
    {
        if( timecount>=ADS_TIME)
        {
            switch (adsStyle)
            {
                case ADS_STATE_FREE_BUY:
                {
                    g_nGameState=GAME_STATE_TITLE;
                    SwitchGameState();
                }
                    break;
                case ADS_STATE_FOUTH_BUY:
                {
                    g_nGameState=GAME_STATE_MISSION_SELECT;
                    SwitchGameState();
                }
                    break;
                default:
                    break;
            }
            
        }
        
    }
    
}