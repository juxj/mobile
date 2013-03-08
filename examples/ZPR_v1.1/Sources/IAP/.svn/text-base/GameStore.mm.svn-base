//
//  GameStore.mm
//  ZPR

//  Created by Neo01 on 11/2/11.
//  Copyright (c) 2011 Break Media. All rights reserved.
//

#ifdef __IN_APP_PURCHASE__

#import "ZPRAppDelegate.h"
#import "FlurryAnalytics.h"

#import "GameState.h"
#import "GameStore.h"
#import "Canvas2D.h"
#import "Sprite.h"
#import "zprUIButton.h"
#import "Utilities.h"
#import "GameHouse.h"
#import "GamePlay.h"
#import "GameRes.h"
#import "String.h"
#import "ZPRViewController.h"
#import "GameTitle.h"
#import "GamePlay.h"
#import "DownloadView.h"
#import "PurchaseCounts.h"
#import "CheckNetwork.h"
#import "GameAudio.h"
#ifdef __DOWNLOAD_RES__
#else
#import "GameData.h"
#endif


PurchaseCounts* timeCounts;

ZprUIButton *purchaseBtn1;
ZprUIButton *purchaseBtn2;
ZprUIButton *purchaseBtn3;
ZprUIButton *purchaseBtn4;
ZprUIButton *closeBtn;
ZprUIButton *buyItemBtn;
Image *addRunnerModeAni;
Image *addTrampolinesAni;
Image *addComboPackAni;
Image *addUpgradeAni;
bool isAddRunnerModePlay;
bool isAddTrampolinePlay;
int addAniX;
int addAniY;
int quantityTrampoline;
int quantityRunnermode;
int quantityComboPack;
int quantityShowTrampoline;
int quantityShowRunnermode;
UIAlertView *waitView ;
bool isBuyPressed;
bool isUpdateShowQuantity;
bool isPressBackMain;
int curItemInx;

bool havePurchasedComic = false;

char* name[5]=
{
    (char*)"",
	(char*)"LEVEL PACK",
	(char*)"SUPER KICKS",
	(char*)"TRAMPOLINE",
    (char*)"COMBO PACK"
};
char* purchaseName[5]=
{
    (char*)"",
	(char*)"Level Pack",
	(char*)"Super Kicks x5",
	(char*)"Trampoline x3",
    (char*)"Combo Pack"
    
    
};
char* purchaseDecription[5]=
{
    (char*)"",
#ifdef V_FREE
    (char*)"Get access to three more areas, with new moves and new zombies! Plus... no ads!",
#else
    (char*)"Get access to 12 new levels of zombie mayhem in Old Town... a brand new area of the city!",
#endif
    (char*)"This 5-pack of sneakers give you instant Level 3 Runner\'s High. Your high score will thank you.",
    (char*)"Having trouble with a level? Jump to the next flag! A trampoline 3-pack.",
    (char*)"A 7-pack of Super Kicks and a 4-pack of Trampolines!"
};

char* purchasePrice[5]=
{ 
 (char*)"$0",
#ifdef VERSION_IPAD
 (char*)"BUY $0.99",    // Level Pack for iPad
#else
 (char*)"BUY $0.99",    // Level Pack for iPhone
#endif
 (char*)"BUY $0.99",    // Super Kicks
 (char*)"BUY $0.99",    // Trampoline
 (char*)"BUY $1.99"     // Combo Pack
 
};

#import "ZPR_IAP.h"

bool isPurchasing = false;
void updateQuantity(){
    isUpdateShowQuantity = true;
    quantityTrampoline = [app.iap quantityTrampolineInLocalStore];
    quantityRunnermode=[app.iap quantityRunnerModeInLocalStore];
    
}


void initWaitView(){
    
    UIActivityIndicatorView* indView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    waitView = [[UIAlertView alloc]initWithFrame:CGRectMake(240,160,0,0)];
    [waitView setTitle:TIPWAIT];
    [waitView setDelegate:app.purchaseCounts];
    indView.center  = CGPointMake(140*IPAD_X, 70*IPAD_X);
    [indView startAnimating];
    [waitView addSubview:indView];
    [indView release];
}

void showWaiting(){
    if (waitView==NULL) {
        initWaitView();
    }
    [waitView show];
    
}
void diswWaiting(){
    if (waitView!=NULL) {
        [waitView dismissWithClickedButtonIndex:0 animated:YES];
    }
}

static void GameStorePurchaseSuccessHandler (SKPaymentTransaction* transaction) {
	NSString *message;

    curItemInx = 0;
    isPurchasing = false;
	
    if ([transaction.payment.productIdentifier isEqualToString:kIAPRunnerModeProductId]) {
		message =SUCESS2;
    }else if([transaction.payment.productIdentifier isEqualToString:kIAPTrampolineProductId]){
		message =SUCESS3;
    }else if([transaction.payment.productIdentifier isEqualToString:kIAPComicProductId]){
#ifdef __DOWNLOAD_RES__
		//message =SUCESS1;
        [waitView dismissWithClickedButtonIndex:0 animated:NO];
        
        if (isUpdate) {
            [app.viewController downloadResource ];
        }else{
            [app.viewController downloadVersion:NO ];
        }
        return;
#else
        message = SUCESS1_FREE;
        availableLevels = MAX_ITEM;
        setDownVersion(0);
        isUpdate = false;
        SaveFile();
#endif
    }else{
		message =SUCESS4 ;
    }
	
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_PURCHASE_SUCCESSFUL message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    [message release];
    [waitView dismissWithClickedButtonIndex:0 animated:NO];
	
    updateItemCounts();
}

static void GameStorePurchaseFailedHandler (SKPaymentTransaction* transaction) {
    if (!isPurchasing) {
        return;
    }
    NSString *message;
	
    //curItemInx = 0;
    isPurchasing = false;
    
    if(transaction.error.code != SKErrorPaymentCancelled ){

        if ([transaction.payment.productIdentifier isEqualToString:kIAPRunnerModeProductId]) {
            message =FAIL2 ;
        }else if([transaction.payment.productIdentifier isEqualToString:kIAPTrampolineProductId]){
            message =FAIL3 ;
        }else if([transaction.payment.productIdentifier isEqualToString:kIAPComicProductId]){
#ifdef __DOWNLOAD_RES__
#else
            message =FAIL1;
#endif
        }else{
            message =FAIL4 ;
        }
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_PURCHASE_FAILED message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        [message release];
    }
    
	[waitView dismissWithClickedButtonIndex:0 animated:NO];
}

void GameStoreRestoreSuccessHandler () {
     //updateItemCounts();
}

void GameStoreRestoreFailedHandler () {

}



void GameStoreBegin()
{
    if ([app.iap hasUnlockComicInLocalStore]) {
        havePurchasedComic = true;
    }
    
    if (waitView==NULL) {
        initWaitView();
    }

    app.iap.purchaseSuccessCallback = GameStorePurchaseSuccessHandler;
    app.iap.purchaseFailedCallback = GameStorePurchaseFailedHandler;
    updateQuantity();
    initResStore();
}

void GameStoreEnd()
{
    app.iap.purchaseSuccessCallback = NULL;
    app.iap.purchaseFailedCallback = NULL;
}




void GameStoreUpdate(float dt)
{
    if(isUpdateShowQuantity){
        isUpdateShowQuantity= false;

        if (quantityShowRunnermode<quantityRunnermode) {
            isUpdateShowQuantity=true;
            quantityShowRunnermode++;
        }
        if(quantityShowTrampoline<quantityTrampoline){
            isUpdateShowQuantity=true;
            quantityShowTrampoline++;
        }
    
    }

    
}




void drawItemDetail(){
    
    if (curItemInx==0) {
        return;
    }
    
    Canvas2D *canvas = Canvas2D::getInstance();
    canvas->flush();
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    float  blackBg_X= (canvas->getCanvasWidth()*IPAD_X-TILE_HOUSE_COL*BG_OPTIOH_UINIT_WIDTH*1.4)/2.0f;
    //float  blackBg_Y= (canvas->getCanvasHeight()*IPAD_PROPS_X-TILE_HOUSE_ROW*BG_OPTIOH_UINIT_WIDTH*1.4)/2.0f;
    RenderTileBG(TYPE_HOUSE_BG, blackBg_X, 12*IPAD_X, 1.4f, 1.4f*IPAD_X);
    DrawMultiLineString(purchaseDecription[curItemInx ],120*IPAD_X,40*IPAD_X,0.65,240*IPAD_X,25*IPAD_X,1,1,1);
    
    buyItemBtn->render();
    DrawString(name[curItemInx], 240*IPAD_X-GetStringWidth(name[curItemInx],0.6,0)/2*IPAD_X, 35*IPAD_X,0.6f,1,1,0);
    DrawString(purchasePrice[curItemInx], buyItemBtn->_x-GetStringWidth(purchasePrice[curItemInx],0.6f)*0.5f , buyItemBtn->_y-buyItemBtn->_h*0.3,0.6f,1,1,0);
    if(curItemInx==1){
     canvas->drawImage(addUpgradeAni,240*IPAD_X ,buyItemBtn->_y-65.f*IPAD_X);
    }else if (curItemInx==2) {
        canvas->drawImage(addRunnerModeAni,240*IPAD_X ,buyItemBtn->_y-50.f*IPAD_X);
        DrawString((char*)"x5",280*IPAD_X ,buyItemBtn->_y-70*IPAD_X,1.0f,1,0,0);
    }else if(curItemInx==3 ){
        canvas->drawImage(addTrampolinesAni,240*IPAD_X ,buyItemBtn->_y-65.f*IPAD_X);
        DrawString((char*)"x3",280*IPAD_X ,buyItemBtn->_y-70*IPAD_X,1.0f,1,0,0);
    }else if(curItemInx==4){
         canvas->drawImage(addComboPackAni,240*IPAD_X ,buyItemBtn->_y-75.f*IPAD_X);
    }

    closeBtn->render();
}



void GameStoreRender(float dt)
{
    Canvas2D *canvas = Canvas2D::getInstance();
    canvas->drawImage(mStoreBg, 0.0f, 0.0f);

    purchaseBtn2->render();
    purchaseBtn3->render();
    purchaseBtn4->render();
#ifdef __STORE_LEVEL_PACK__
    purchaseBtn1->render();
    DrawString(purchaseName[1], purchaseBtn1->_x-GetStringWidth(purchaseName[1],0.5f,2)*0.5f*IPAD_X , purchaseBtn1->_y-12.0f*IPAD_X,0.5f,1.f,0.f,0.f,1.f,2);
#else
    #ifdef __DOWNLOAD_RES__
        purchaseBtn1->render();
        DrawString(purchaseName[1], purchaseBtn1->_x-GetStringWidth(purchaseName[1],0.5f,2)*0.5f*IPAD_X , purchaseBtn1->_y-12.0f*IPAD_X,0.5f,1.f,0.f,0.f,1.f,2);
        
        if (isUpdate) {
            canvas->drawImage(mNewsImg[13], purchaseBtn1->_x+45.0f, purchaseBtn1->_y-25.0f ); 
            DrawString((char* )"1", purchaseBtn1->_x+40.0f, purchaseBtn1->_y-40.f,0.7f );
        }
    #endif
#endif
     DrawString(purchaseName[2], purchaseBtn2->_x-GetStringWidth(purchaseName[2],0.5f,2)*0.5f*IPAD_X , purchaseBtn2->_y-12.0f*IPAD_X,0.5f,1.f,0.f,0.f,1.f,2);
     DrawString(purchaseName[3], purchaseBtn3->_x-GetStringWidth(purchaseName[3],0.5f,2)*0.5f*IPAD_X , purchaseBtn3->_y-12.0f*IPAD_X,0.5f,1.f,0.f,0.f,1.f,2);
     DrawString(purchaseName[4], purchaseBtn4->_x-GetStringWidth(purchaseName[4],0.5f,2)*0.5f*IPAD_X , purchaseBtn4->_y-12.0f*IPAD_X,0.5f,1.f,0.f,0.f,1.f,2);
 
	float colorbg=isPressBackMain?BACK_COLOR:0;
	canvas->setColor(colorbg, colorbg, colorbg, 1);
	canvas->fillRect(387*IPAD_X, 0.0f, 160*IPAD_X, 24*IPAD_X);
	int color=isPressBackMain?0:1;
	DrawString((char*)"MAIN MENU",398.f*IPAD_X,4.0f*IPAD_X,0.35,1,1,color,1,0);
	canvas->setColor(1, 1, 1, 1);
    drawItemDetail();

}


void sendPurchaseRequest(){
    if (![CheckNetwork isNetworkAvailable]) {
        return;
    }
    switch (curItemInx) {
        case 0:
            break;
        case 1:
#ifdef __DOWNLOAD_RES__
            if (isUpdate) {
                if ([app.iap purchaseComic]){
                    isPurchasing = true;
                    showWaiting();
                }else{
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_PURCHASE_FAILED message:FAIL1 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];                    
                }
            }else{
                if (isServiceBusy) {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_PURCHASE_FAILED message:SERVICE_BUSY_TIP delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }else{
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NO_NEW_LEVEL delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
#else
            if ([app.iap purchaseComic]){
                isPurchasing = true;
                showWaiting();
            }else{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_PURCHASE_FAILED message:FAIL1 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];                    
            }
#endif
            break;
        case 2:
            if ([app.iap purchaseRunnerModeWithQuantity:1]){
                isPurchasing = true;
                showWaiting();
            }else{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_PURCHASE_FAILED message:FAIL2 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            break;
        case 3:
            if ([app.iap purchaseTrampolineWithQuantity:1]){
                isPurchasing = true;
                showWaiting();
            }else{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_PURCHASE_FAILED message:FAIL3 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            
            break;
        case 4:
            if ([app.iap purchaseComboPackWithQuantity:1]){
                isPurchasing = true;
                showWaiting();
            }else{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_PURCHASE_FAILED message:FAIL4 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            break;
        default:
          
            break;

            
    }
    

}


void GameStoreTouchEvent(int touchStatus, float fX, float fY)
{
    if (isPurchasing||isDownloading) {
        return;
    }
    
    if (curItemInx==0) {

        isPressBackMain = false;
#ifdef __STORE_LEVEL_PACK__
        if (purchaseBtn1->onTouch(touchStatus, fX, fY)&& purchaseBtn1->getButtonState()==ZPR_UI_BTN_RELEASED ) 
		{
            playSE(SE_BUTTON_CONFIRM);
            
            [FlurryAnalytics logEvent:@"Level Pack"];//level
            
            if ([app.iap hasUnlockComicInLocalStore])
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NO_NEW_LEVEL delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            else
            {
                purchaseBtn1->setButtonState(ZPR_UI_BTN_NORMAL);
                curItemInx = 1;
            }
        }
        else 
#else
    #ifdef __DOWNLOAD_RES__
            if (purchaseBtn1->onTouch(touchStatus, fX, fY)&& purchaseBtn1->getButtonState()==ZPR_UI_BTN_RELEASED ) 
            {
                playSE(SE_BUTTON_CONFIRM);
                
                [FlurryAnalytics logEvent:@"Level Pack"];//level
                
                if ([app.iap hasUnlockComicInLocalStore])
                {
                    if (![CheckNetwork isNetworkAvailable])
                    {
                        return;
                    }
                    if (isUpdate)
                    {
                        [app.viewController downloadResource];
                    }
                    else
                    {
                        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NO_NEW_LEVEL delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                    }
                }
                else
                {
                    purchaseBtn1->setButtonState(ZPR_UI_BTN_NORMAL);
                    curItemInx = 1;
                }
            }
            else 
    #endif
#endif
        if(purchaseBtn4->onTouch(touchStatus, fX, fY)&& purchaseBtn4->getButtonState()==ZPR_UI_BTN_RELEASED){
            playSE(SE_BUTTON_CONFIRM);
            purchaseBtn4->setButtonState(ZPR_UI_BTN_NORMAL);
            curItemInx = 4;
			
			[FlurryAnalytics logEvent:@"Combo Pack"];//combo
        }else if (purchaseBtn3->onTouch(touchStatus, fX, fY)&& purchaseBtn3->getButtonState()==ZPR_UI_BTN_RELEASED ) {
            playSE(SE_BUTTON_CONFIRM);
            purchaseBtn3->setButtonState(ZPR_UI_BTN_NORMAL);
            curItemInx = 3;
			
			[FlurryAnalytics logEvent:@"Trampoline"];//trampoline
        }else if (purchaseBtn2->onTouch(touchStatus, fX, fY)&& purchaseBtn2->getButtonState()==ZPR_UI_BTN_RELEASED ) {
            playSE(SE_BUTTON_CONFIRM);
            purchaseBtn2->setButtonState(ZPR_UI_BTN_NORMAL);
            curItemInx = 2;
			
			[FlurryAnalytics logEvent:@"Super Kicks"];//kick
        }
    
        if ( fX > 380*IPAD_X && fX < 480*IPAD_X && fY > 0 && fY <40*IPAD_X) {
            
            if (touchStatus==ZPR_UI_BTN_RELEASED) {
                playSE(SE_BUTTON_CANCEL);
                g_nGameState =GAME_STATE_TITLE;
                SwitchGameState();
                isPressBackMain = false;
                return;
            }else if(touchStatus==ZPR_UI_BTN_HOLDED){
                isPressBackMain = true;
            }else{
                isPressBackMain = true;
            }
        }
    }else{
        if ( closeBtn->onTouch(touchStatus, fX, fY) && closeBtn->getButtonState()==ZPR_UI_BTN_RELEASED ) {
            playSE(SE_BUTTON_CANCEL);
            curItemInx=0;
            return;
        }
        else if (buyItemBtn->onTouch(touchStatus, fX, fY) && buyItemBtn->getButtonState()==ZPR_UI_BTN_RELEASED ) {
            playSE(SE_BUTTON_CONFIRM);
            sendPurchaseRequest();
            return;
        }
    }
    
}





#endif
