          /*
 *  GameBedroom.mm
 *  ZPR
 *
 *  Created by Linda Li on 7/19/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "GameBedroom.h"
#import "GameAudio.h"
#import "GameState.h"
#import "GamePlay.h"
#import "GameOption.h"
#import "GamePause.h"
#import "GameAchieve.h"
#import "GameHouse.h"

#import "GameRes.h"

#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"

#import <string>
#import "Utilities.h"

  #define BTN_BEDROOM_NUM   3*4

#define PROPS_OFFX		153
#define PROPS_OFFY		70
#define PROPS_FONT		0.55
#define SCALE_HOUSE_WIDTH 1.2
#define SCALE_HOUSE_HIGHT 1.2

Image* mBedroom;

bool BtnBedroomPress[BTN_BEDROOM_NUM]={false,false,false};
float startBedroomXY[2]={0.0f,0.0f};
int ShowBedroomDetail = -1;
float BedroomPos[BTN_BEDROOM_NUM]={
320*IPAD_X,370*IPAD_X,30*IPAD_X+IPAD_TWO_Y,70*IPAD_X+IPAD_TWO_Y,//close
380.0f*IPAD_X,480.0f*IPAD_X,0.0f*IPAD_X,50.0f*IPAD_X,//mainmenu
65.0f*IPAD_X,148.0f*IPAD_X,276.0f*IPAD_X+IPAD_TWO_Y,322.0f*IPAD_X+IPAD_TWO_Y//cutbtn
};

char* objBedroomName[MAX_BEDROOM_PROPS] = 
{
	(char*)"Coat",          // 0
	(char*)"Wall Mirror",   // 1
	(char*)"Band Poster",   // 2
	(char*)"Skull Pillow",   //3   
	(char*)"Bed",           //4
	(char*)"Bedside Table ",// 5
    (char*)"Comb",          // 6
	(char*)"Bedspread",      //7
	(char*)"Teddy Bear",    // 8
	(char*)"Backpack",      // 9
	(char*)"Shoes",         // 10
    (char*)"Birthday Card", // 11
  
};

char* objBedroomDesc[MAX_BEDROOM_PROPS]=
{
      (char*)"(4-1) The first few nights Kara searched for Ryan were in the dead of winter. This kept her alive.",
      (char*)"(4-2) Ryan\'s best friend before the zombies came had this mirror, but it showed her no sign of him.",
      (char*)"(4-3) He was always searching for music. She found this in a record store, but no Ryan.",
      (char*)"(4-4) No sign of him at his old girlfriend\'s place. She did have this awesome pillow though.",
      (char*)"(4-5) After Ryan was gone she threw out her old futon and lugged this mattress up to the house. It comforted her.",
      (char*)"(4-6) He joked that the Swedish furniture store would make a good fort. No Ryan, but this cheap table was cute.",
      (char*)"(4-7) She saw herself in the mirror and immediately went out to find this. She didn't want him thinking she couldn\'t take care of herself.",
      (char*)"(4-8) The second winter without him was even colder, so she stocked up on blankets.",
      (char*)"(4-9) Almost torn to shreds, but in the ruins of their old house, she found this. Named it Ry.",
      (char*)"(4-10) After the winter she started venturing farther out and took this for supplies.",
      (char*)"(4-11) She nearly cried when the shoes he had bought her wore out. These weren\'t the same.",
      (char*)"(4-12) In his room, under the bed, she found this from Ryan - lost for a whole year. \"Happy Birthday, Sis.\""
};


float ObjBedroomPos[MAX_BEDROOM_PROPS][4] = 
{
	{654,149,189,261},		// clothes       0     25
	{824,103,253,405},		// mirror        1     26
	
	{464,30,209,298},		// Break  photo  2     27
	{171,316,168,116},		// pillow        3     28
	{94,352,750,263},		// bed           4     29
	{0,420,247,172},		// bedstand      5     30
    
	{815,559,140,63},		// comb          6     31
	
    {320,410,424,240},		//bedsheet       7     32
	{334,238,258,230},		// bear          8     33
	{454,514,244,246},		// schoolbag     9     34
	{340,664,235,313},		// shoes         10    35

     {57,375,168,97}		//birthday card  11    36
};


void GameBedroomBegin()
{
    ShowBedroomDetail=-1;
}
void GameBedroomEnd();

void GameBedroomUpdate(float dt)
{   
    
    if(toFirstRoom) 
    {
        if (houseOffset<0) 
        {   
            houseOffset+=40*IPAD_X;
            if (houseOffset>=0) 
            {
                houseOffset=0.0f;
            }
        }
        else 
        {
            houseOffset=0;

        }
    }
      if(toSecondRoom)
       {  
            
           if (houseOffset>-480*IPAD_X) {
                houseOffset-=40*IPAD_X;
               if(houseOffset<=-480*IPAD_X)
               {
                   houseOffset=-480*IPAD_X;
                   
               }
                
           }
           else
           {
             houseOffset=-480*IPAD_X;
           }   
      }
}

void GameBedroomRender(float dt)
{
	
    Canvas2D* canvas = Canvas2D::getInstance();
    canvas->drawImage(mBedroom,480*IPAD_X+houseOffset, 0.0f);

	float colorbg=BtnBedroomPress[1]?BACK_COLOR:0;
	canvas->setColor(colorbg, colorbg, colorbg, 1);
		canvas->fillRect(387*IPAD_X, 0.0f, 160*IPAD_X, 28*IPAD_X);
	canvas->setColor(1, 1, 1, 1);

	int color=BtnBedroomPress[1]?0:1;
	DrawString((char*)"MAIN MENU",398.f*IPAD_X,4.0f*IPAD_X,0.35,1,1,color,1,0);
    
    float scale=BtnBedroomPress[2]?1.1f:1.0f;
    canvas->drawImage(mCutRoomBtn, 480*IPAD_X+208.0f/IMG_BEDROOM_SCALE+IMG_BEDROOM_XOFFSET+houseOffset,658.0f/IMG_BEDROOM_SCALE,0.0f,scale,scale);
	for (int i = 0; i <12; i++)
	{
#if 0
		mObjFlag[i+24] = 0;
#endif
        if (mObjFlag[i+24])
        {
			int type = i;
            canvas->drawImage(mBedroomProps[type], 480*IPAD_X+IMG_BEDROOM_XOFFSET+ObjBedroomPos[type][0]/IMG_BEDROOM_SCALE+houseOffset,ObjBedroomPos[type][1]/IMG_BEDROOM_SCALE,0,ROOM_SCALE,ROOM_SCALE);
        }
            
	}
    if (mObjFlag[24+3])
    {
          canvas->drawImage(mBedroomProps[3], 480*IPAD_X+IMG_BEDROOM_XOFFSET+ObjBedroomPos[3][0]/IMG_BEDROOM_SCALE+houseOffset,ObjBedroomPos[3][1]/IMG_BEDROOM_SCALE,0,ROOM_SCALE,ROOM_SCALE);
    }
    if (mObjFlag[24+8])
    {
        canvas->drawImage(mBedroomProps[8], 480*IPAD_X+IMG_BEDROOM_XOFFSET+ObjBedroomPos[8][0]/IMG_BEDROOM_SCALE+houseOffset,ObjBedroomPos[8][1]/IMG_BEDROOM_SCALE,0,ROOM_SCALE,ROOM_SCALE);
    }
//	canvas->flush();
//	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
	if (ShowBedroomDetail != -1)
	{
        float  blackBg_X= (canvas->getCanvasWidth()*IPAD_X-TILE_HOUSE_COL*BG_OPTIOH_UINIT_WIDTH*SCALE_HOUSE_WIDTH)/2.0f;
        float  blackBg_Y= (canvas->getCanvasHeight()*IPAD_PROPS_X-TILE_HOUSE_ROW*BG_OPTIOH_UINIT_WIDTH*SCALE_HOUSE_HIGHT)/2.0f;
		RenderTileBG(TYPE_HOUSE_BG,blackBg_X, blackBg_Y,SCALE_HOUSE_WIDTH, SCALE_HOUSE_HIGHT);
		canvas->flush();
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
        
        float picWidth=mBedroomPropsInfo[ShowBedroomDetail]->mWidth *ROOM_INFO_SCALE/GLOBAL_CANVAS_SCALE;
        float picHeight=(mBedroomPropsInfo[ShowBedroomDetail]->mHeight*ROOM_INFO_SCALE)/GLOBAL_CANVAS_SCALE;
        canvas->drawImage(mBedroomPropsInfo[ShowBedroomDetail], 
                          (canvas->getCanvasWidth()*IPAD_X-picWidth)/2, 
                          canvas->getCanvasHeight()*IPAD_PROPS_X-blackBg_Y-picHeight-14*IPAD_PROPS_X,0,ROOM_INFO_SCALE,ROOM_INFO_SCALE);
#if DEBUG
        canvas->strokeRect((canvas->getCanvasWidth()*IPAD_X-picWidth)/2, canvas->getCanvasHeight()*IPAD_PROPS_X-blackBg_Y-picHeight-14*IPAD_PROPS_X,picWidth, picHeight);
#endif
//		canvas->flush();
//		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
       DrawString(objBedroomName[ShowBedroomDetail],(canvas->getCanvasWidth()*IPAD_X-GetStringWidth(objBedroomName[ShowBedroomDetail],0.65,0))/2,58.0f*IPAD_X+IPAD_TWO_Y,0.65,1,1,1,1,0);
		if (BtnBedroomPress[0]) {
			canvas->drawImage(mClose,350.f*IPAD_X,48.f*IPAD_X+IPAD_TWO_Y,0,1.5,1.5);
		}
		else {
			canvas->drawImage(mClose,350.f*IPAD_X,48.f*IPAD_X+IPAD_TWO_Y,0,1.2,1.2);
		}
	
     DrawMultiLineString(objBedroomDesc[ShowBedroomDetail],( canvas->getCanvasWidth()*IPAD_X- (TILE_HOUSE_COL*BG_OPTIOH_UINIT_WIDTH-6))/2, PROPS_OFFY*IPAD_X+IPAD_TWO_Y, PROPS_FONT, TILE_HOUSE_COL*BG_OPTIOH_UINIT_WIDTH-6, 19.0f);
	}
  	
#if DEBUG
    //	for (int i=0; i<12; i+=1)
//    {
//		
//		canvas->strokeRect(ObjBedroomPos[i][0],ObjBedroomPos[i][1],ObjBedroomPos[i][2],ObjBedroomPos[i][3]);
//	}
//   	for (int i=0; i<12; i+=4) {
//   		
//	canvas->strokeRect( BedroomPos[i],  BedroomPos[i+2], 
// 					   (BedroomPos[i+1]-BedroomPos[i]),(BedroomPos[i+3]-BedroomPos[i+2]));
//	}
#endif
}

void GameBedroomOnTouchEvent(int touchStatus, float fX, float fY)
{    
	if (touchStatus == 1)
	{
		
		startBedroomXY[0]=fX;
		startBedroomXY[1]=fY;
		
		for (int i=0; i<BTN_BEDROOM_NUM; i+=4)
		{
			if (fX > BedroomPos[i] && fX < BedroomPos[i+1]&& fY > BedroomPos[i+2] && fY <BedroomPos[i+3])
			{
				if (ShowBedroomDetail != -1) 
				{
					if (i==0) 
					{
						
						BtnBedroomPress[0]=true;
						
					}
				}
				else 
				{
					BtnBedroomPress[i/4]=true;
				}
			}
		}
	}
	else if (touchStatus==2)
	{
		for (int i=0; i<BTN_BEDROOM_NUM; i+=4)
		{
			if ((fX > BedroomPos[i] && fX < BedroomPos[i+1]&& fY > BedroomPos[i+2] && fY <BedroomPos[i+3])&&
				(startBedroomXY[0] > BedroomPos[i] && startBedroomXY[0] < BedroomPos[i+1]&& startBedroomXY[1] > BedroomPos[i+2] && startBedroomXY[1] < BedroomPos[i+3]))
			{
				
				if (ShowBedroomDetail != -1) 
				{
					if (i==0) 
					{
						BtnBedroomPress[0]=true;
						
					}
					else 
					{
						BtnBedroomPress[0]=false;
					}
					
				}
				else 
				{
					BtnBedroomPress[i/4]=true;
				}
				
				
			}
			else 
			{
				BtnBedroomPress[i/4]=false;
			}
		}
		
	}
	else if (touchStatus == 3)
	{   BtnBedroomPress[0]=false;
		BtnBedroomPress[1]=false;
		BtnBedroomPress[2]=false;
		// in detail
		if ((fX > BedroomPos[0] && fX < BedroomPos[1]&& fY > BedroomPos[2] && fY <BedroomPos[3])&&
			(startBedroomXY[0] > BedroomPos[0] && startBedroomXY[0] < BedroomPos[1]&& startBedroomXY[1] > BedroomPos[2] && startBedroomXY[1] < BedroomPos[3])&& ShowBedroomDetail != -1)
		{  
			ShowBedroomDetail = -1;
			playSE(SE_BUTTON_CANCEL);
			return;
		}
		
		if(ShowBedroomDetail == -1)
		{      
            for (int i=4; i<BTN_BEDROOM_NUM; i+=4)
            {
                if ((fX > BedroomPos[i] && fX < BedroomPos[i+1]&& fY > BedroomPos[i+2] && fY <BedroomPos[i+3])&&
                    (startBedroomXY[0] > BedroomPos[i] && startBedroomXY[0] < BedroomPos[i+1]&& startBedroomXY[1] > BedroomPos[i+2] && startBedroomXY[1] < BedroomPos[i+3]))
                {   
                    switch (i) 
                    {
                        case 4:////main menu
                            houseOffset=0.0f;
                               toFirstRoom=false;
                               toSecondRoom=false;
                                playSE(SE_BUTTON_CANCEL);
                                g_nGameState = GAME_STATE_TITLE;
                                SwitchGameState();
                            break;
                        case 8://cut btn
                            toFirstRoom=true;
                            toSecondRoom=false;
                            g_nGameState=GAME_STATE_HOUSE;
                            SwitchGameState();
                            break;    
                        default:
                            break;
                    }
                }
                else  
                {
                    ShowBedroomDetail = ClickBedroomObj(fX, fY,startBedroomXY[0],startBedroomXY[1]);
                }
            }	
        }
		
	}
}
int ClickBedroomObj(float fx,float fy,float startfx,float startfy)
{
	int tempIndex = -1;
	for (int i = 11; i >= 0; i--)
	{
		if (mObjFlag[24+i])
		{
			if (fx > IMG_BEDROOM_XOFFSET+ObjBedroomPos[i][0]/IMG_BEDROOM_SCALE&& fx <IMG_BEDROOM_XOFFSET+(ObjBedroomPos[i][0] + ObjBedroomPos[i][2])/IMG_BEDROOM_SCALE
				&& fy > ObjBedroomPos[i][1]/IMG_BEDROOM_SCALE&& fy < (ObjBedroomPos[i][1] + ObjBedroomPos[i][3])/IMG_BEDROOM_SCALE
				&&startfx > IMG_BEDROOM_XOFFSET+ ObjBedroomPos[i][0]/IMG_BEDROOM_SCALE&& startfx < IMG_BEDROOM_XOFFSET+(ObjBedroomPos[i][0] + ObjBedroomPos[i][2])/IMG_BEDROOM_SCALE
				&& startfy > ObjBedroomPos[i][1]/IMG_BEDROOM_SCALE&& startfy < (ObjBedroomPos[i][1] + ObjBedroomPos[i][3])/IMG_BEDROOM_SCALE)
			{
				playSE(SE_BUTTON_CONFIRM);
				  tempIndex = i;
                if (tempIndex ==4)
              	{
                    continue;
                }
               return tempIndex;
			}
        }

    }
    return tempIndex;
}
