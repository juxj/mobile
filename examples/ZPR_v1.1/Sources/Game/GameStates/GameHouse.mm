/*
 *  GameHouse.mm
 *  ZPR
 *
 *  Created by Linda Li on 7/19/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#import "GameHouse.h"
#import "GameAudio.h"
#import "GameState.h"
#import "GamePlay.h"
#import "GameOption.h"
#import "GamePause.h"
#import "GameAchieve.h"

#import "GameRes.h"

#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"

#import <string>
#import "Utilities.h"

#ifdef  VERSION_IPAD
 #define IMG_HOURSEROOM_XOFFSET   26.0f
#else 
   #define IMG_HOURSEROOM_XOFFSET   0.0f
#endif

#define PROPS_OFFX		153
#define PROPS_OFFY		70
#define PROPS_FONT		0.55
#define SCALE_HOUSE_WIDTH 1.2
#define SCALE_HOUSE_HIGHT 1.2


bool BtnHousePress[4]={false,false,false,false};
float startPointXY[2]={0.0f,0.0f};
Image* mHouse;
Image* mCutRoomBtn;
int ShowDetail = -1;
bool toFirstRoom=false;
bool toSecondRoom=false;
float houseOffset=0.0f;
Image* mHouseBackBrand;
Image* mBedroomBackBrand;


bool mObjFlag[MAX_ITEM] = {
	false, false, false, false, false, false, false, false, 
	false, false, false, false, false, false, false, false, 
	false, false, false, false, false, false, false, false, 

    false, false, false, false, false, false, 
    false, false, false, false, false, false

};

float HoursePos[16]={
320*IPAD_X,370*IPAD_X,30*IPAD_X+IPAD_TWO_Y,70*IPAD_X+IPAD_TWO_Y,//close
(382-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X,(452-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X,55*IPAD_PROPS_X,120*IPAD_PROPS_X,      //backband
380.0f*IPAD_X,480.0f*IPAD_X,0.0f*IPAD_X,50.0f*IPAD_X,   //main menu
(238.0f-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X,(305.0f-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X,65.0f*IPAD_PROPS_X,112.0*IPAD_PROPS_X      //cut btn
};

char* objName[24] = 
{
	
	(char*)"CLOCK",           // 0
    (char*)"COAT HOOK",      //  1
    (char*)"STUFFED BIRD",   // 2
   	(char*)"FUZZY RUG",       // 3
	(char*)"BOOKCASE",       // 4
    (char*)"WINE",           // 5
	(char*)"KARA'S LIBRARY", // 6
	(char*)"SUITCASE",       //  7
    (char*)"SKATEBOARD",     //  8
    (char*)"OLD SOFA CHAIR", //  9
    (char*)"PILLOW",         // 10
    (char*)"CUDDLY KITTY",    // 11
    (char*)"FRED THE FLOWER",//  12
    (char*)"CLAY BOWL",      //  13
	(char*)"NIGHTSTAND",     //  14
	(char*)"COFFE MAKER",     // 15
	(char*)"TV",             //  16
    (char*)"RYAN'S PHOTO",    // 17
    (char*)"GLOBE",           // 18
    (char*)"RYAN'S UMBRELLA", //19
    (char*)"ANIME ROBOT",     //20
	(char*)"TYPEWRITER",     // 21
	(char*)"SILLY FISH",     // 22
    (char*)"CEILING LAMP"    //23

	
};

char* objDesc[24]=
{
    (char*)"(2-1) When she was fourteen he taught her how to run, timing her with this.",              //0
    (char*)"(2-7) Even when they argued, she always loved the smell of Ryan's leather jacket hanging here.", //1
    (char*)"(3-4) He brought this home the day she told him she didn't want to leave the City.",  // 2
    (char*)"(2-2) Kara teased that he and the rug were alike, because they were both from the 70s.",    //3
	(char*)"(3-2) He got her this for her 17th birthday. She loved to read pre-zombie-outbreak novels.",      //  4
    (char*)"(3-7) After his third day missing, Kara took a drink of this. She spat it out.", //5
	(char*)"(3-3) Ryan told her she should spend more time training, not reading, so they could leave soon.",  // 6
    (char*)"(2-3) He brought this home two years after the attack, talking again about leaving the City.",//7
    (char*)"(1-3) She was too young to run like him, but she dodged zombies with this.",//8
    (char*)"(2-5) They both used to be able to fit on this, but she got too big.",          // 9
    (char*)"(3-6) She cried into this when he stormed out. It made her feel better.",        //10
    (char*)"(2-8) A stray. Ryan let Kara keep it as a sweet sixteen present.", //11
    (char*)"(1-5) He salvaged this from a toy store for her. \"Don't grow up too fast,\"he said.",//12
	(char*)"(1-4) She made this in the kitchen two months after the attack. It felt like home.",//13
	(char*)"(1-6) Six months in, he started leaving at night. He left her notes on this, and he always came back.",//14
    (char*)"(2-4) Kara never liked it, but Ryan was never so happy as when he found coffee.",    //15
	(char*)"(2-6) He didn't want her watching zombies on TV. They fought about it.",         //16
	(char*)"(3-8) It's old, but it's the only photo Kara has of her brother. Maybe the only one she ever will have.", //17
	(char*)"(1-8) He started pointing to all the places he'd been, and everywhere he would take her one day.", //18
    (char*)"(1-1) It was raining the day the zombies came. He gave her this.",     //19
     (char*)"(3-1) \"We should go to Japan,\" Ryan said, holding the robot. \"Maybe there are no zombies there.\"",// 20
	(char*)"(3-5) She got this to write stories with, but she only ever seemed to write apologies.", //21
    (char*)"(1-7) They fished in the reservoir before it iced up. She giggled when this was what they caught.",//22
	(char*)"(1-2) When they hid in this house, the light was still working."     // 23
    
  };

float ObjPos[24][4]=
{
	{48,4,58,52},		// clock          0
	{28,68,81,29},		//  hook          1
    {67,62,50,40},        // bird 22       2
	{2,209,424,319},      //rug            3
	{28,124,79,54},		//  bookcase       4
	{122,129,27,43},		// wine        5
	{46,126,41,16},		// lib             6
	{111,176,65,39},		// suitcase     7
    {94,144,33,91},      // scateboard    8
	{12,175,152,103},		// sofa        9
	{42,199,69,49},		// pillow          10
	{49,207,70,50},		// cat              11
	{25,238,59,74},		// flower           12
	{214,274,40,40},		//bowl          13
	{163,223,98,53},	      //table       14
	{175,177,80,78},         //coffemaker   15
	{240,161,100,82},	      //tv          16
	{296,98,60,62},		//photo              17
	{263,117,47,63},      //globle          18
	{358,118,36,119},	      // umbrellar  19
    
    {93,98,26,33},		// robot           20
    
	{349,238,90,65},	      // Typewriter 21
	{267,32,106,55},	      // fish       22
	{108,0,90,80}		//  bulb            23
};



void setProps(int i)
{
#ifdef ENABLE_ACHIEVEMENTS
		AchGetItemBack(i);
#endif
}

void GameHouseBegin()
{
    ShowDetail=-1;

}

void GameHouseEnd();

void GameHouseUpdate(float dt)
{    
   if (toSecondRoom) 
    {
        if (houseOffset>-480*IPAD_X) 
        {   
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
            houseOffset=0.0f;
        }
     }
    
    
}

void GameHouseRender(float dt)
{
	
    Canvas2D* canvas = Canvas2D::getInstance();
     canvas->drawImage(mHouse, 0.0f+houseOffset, 0.0f);
    
	float colorbg=BtnHousePress[2]?BACK_COLOR:0;
	canvas->setColor(colorbg, colorbg, colorbg, 1);
		canvas->fillRect(387*IPAD_X, 0.0f, 160*IPAD_X, 28*IPAD_X);
	canvas->setColor(1, 1, 1, 1);

	int color=BtnHousePress[2]?0:1;
	DrawString((char*)"MAIN MENU",398.f*IPAD_X,4.0f*IPAD_X,0.35,1,1,color,1,0);

	float rotation=BtnHousePress[1]?-0.2f:.0f;
	canvas->drawImage(mHouseBackBrand, (418.0f-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X+houseOffset, 59.f*IPAD_PROPS_X,rotation,ROOM_SCALE,ROOM_SCALE);
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    
    float bedroomrotation=BtnHousePress[3]?-0.2f:.0f;
	canvas->drawImage(mBedroomBackBrand, (268-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X+houseOffset, 76.f*IPAD_PROPS_X,bedroomrotation,ROOM_SCALE,ROOM_SCALE);
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	
	for (int i = 0; i <24; i++)
	{

#if 0//DEBUG
		mObjFlag[i] = 1;
#endif
        int type =0;
        for (int j=0; j<24; j++)
        {
            if (props_order[j]==i) 
            {
                type=j;
                break;
            }
        }
        
        
		if (mObjFlag[type])
		{
			canvas->drawImage(mAchieve[i],(ObjPos[i][0]-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X +houseOffset, ObjPos[i][1]*IPAD_PROPS_X,0,ROOM_SCALE,ROOM_SCALE);
		}
	}
	canvas->flush();
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
	if (ShowDetail != -1)
	{   
        float  blackBg_X= (canvas->getCanvasWidth()*IPAD_X-TILE_HOUSE_COL*BG_OPTIOH_UINIT_WIDTH*SCALE_HOUSE_WIDTH)/2.0f;
        float  blackBg_Y= (canvas->getCanvasHeight()*IPAD_PROPS_X-TILE_HOUSE_ROW*BG_OPTIOH_UINIT_WIDTH*SCALE_HOUSE_HIGHT)/2.0f;
		RenderTileBG(TYPE_HOUSE_BG,blackBg_X, blackBg_Y,SCALE_HOUSE_WIDTH, SCALE_HOUSE_HIGHT);
		canvas->flush();
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
        
        float picWidth=mAchieveInfo[ShowDetail]->mWidth*ROOM_INFO_SCALE/GLOBAL_CANVAS_SCALE;
        float picHeight=(mAchieveInfo[ShowDetail]->mHeight*ROOM_INFO_SCALE)/GLOBAL_CANVAS_SCALE;
        canvas->drawImage(mAchieveInfo[ShowDetail], 
                          (canvas->getCanvasWidth()*IPAD_X-picWidth)/2, 
                          canvas->getCanvasHeight()*IPAD_PROPS_X-blackBg_Y-picHeight-17*IPAD_PROPS_X,0,ROOM_INFO_SCALE,ROOM_INFO_SCALE);
#if 0//DEBUG
        canvas->strokeRect((canvas->getCanvasWidth()*IPAD_X-picWidth)/2, canvas->getCanvasHeight()*IPAD_PROPS_X-blackBg_Y-picHeight-16*IPAD_PROPS_X,picWidth, picHeight);
#endif
        
		canvas->flush();
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
       DrawString(objName[ShowDetail],(canvas->getCanvasWidth()*IPAD_X-GetStringWidth(objName[ShowDetail],0.65,0))/2,58.0f*IPAD_X+IPAD_TWO_Y,0.65,1,1,1,1,0);
		if (BtnHousePress[0]) {
			canvas->drawImage(mClose,350.f*IPAD_X,48.f*IPAD_X+IPAD_TWO_Y,0,1.5,1.5);
		}
		else {
			canvas->drawImage(mClose,350.f*IPAD_X,48.f*IPAD_X+IPAD_TWO_Y,0,1.2,1.2);
		}
	
       DrawMultiLineString(objDesc[ShowDetail],( canvas->getCanvasWidth()*IPAD_X- (TILE_HOUSE_COL*BG_OPTIOH_UINIT_WIDTH-6))/2, PROPS_OFFY*IPAD_X+IPAD_TWO_Y, PROPS_FONT, TILE_HOUSE_COL*BG_OPTIOH_UINIT_WIDTH-6, 19.0f);
	}
#if 0//DEBUG
    for (int i=0; i<24; i+=1)
    {  if(mObjFlag[i])
		canvas->strokeRect((ObjPos[i][0]-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X, ObjPos[i][1]*IPAD_PROPS_X,ObjPos[i][2]*IPAD_PROPS_X, ObjPos[i][3]*IPAD_PROPS_X, 0,0,0,ROOM_SCALE,ROOM_SCALE );
    }
#endif
}

void GameHouseOnTouchEvent(int touchStatus, float fX, float fY)
{    
	if (touchStatus == 1)
	{
		
		startPointXY[0]=fX;
		startPointXY[1]=fY;
		
		for (int i=0; i<16; i+=4)
		{
			if (fX > HoursePos[i] && fX < HoursePos[i+1]&& fY > HoursePos[i+2] && fY <HoursePos[i+3])
			{
				if (ShowDetail != -1) 
				{
					if (i==0) 
					{
						
						BtnHousePress[0]=true;
						
					}
				}
				else 
				{
					BtnHousePress[i/4]=true;
				}
				
				
			}
		}
	}
	else if (touchStatus==2)
	{
		for (int i=0; i<16; i+=4)
		{
			if ((fX > HoursePos[i] && fX < HoursePos[i+1]&& fY > HoursePos[i+2] && fY <HoursePos[i+3])&&
				(startPointXY[0] > HoursePos[i] && startPointXY[0] < HoursePos[i+1]&& startPointXY[1] > HoursePos[i+2] && startPointXY[1] < HoursePos[i+3]))
			{
				
				if (ShowDetail != -1) 
				{
					if (i==0) 
					{
						BtnHousePress[0]=true;
						
					}
					else 
					{
						BtnHousePress[0]=false;
					}
					
				}
				else 
				{
					BtnHousePress[i/4]=true;
				}
				
				
			}
			else 
			{
				BtnHousePress[i/4]=false;
			}
		}
		
	}
	else if (touchStatus == 3)
	{   
        BtnHousePress[0]=false;
		BtnHousePress[1]=false;
		BtnHousePress[2]=false;
        BtnHousePress[3]=false;
		// in detail
		if ((fX > HoursePos[0] && fX < HoursePos[1]&& fY > HoursePos[2] && fY <HoursePos[3] && ShowDetail != -1)&&
			(startPointXY[0] > HoursePos[0] && startPointXY[0] < HoursePos[1]&& startPointXY[1] > HoursePos[2] && startPointXY[1] < HoursePos[3]&& ShowDetail != -1))
		{  
			ShowDetail = -1;
			playSE(SE_BUTTON_CANCEL);
			return;
		}
		
		if(ShowDetail == -1)
		{      
            for (int i=0; i<16; i+=4)
            {
                if ((fX > HoursePos[i] && fX < HoursePos[i+1]&& fY > HoursePos[i+2] && fY <HoursePos[i+3])&&
                    (startPointXY[0] > HoursePos[i] && startPointXY[0] < HoursePos[i+1]&& startPointXY[1] > HoursePos[i+2] && startPointXY[1] < HoursePos[i+3]))
                {   
                    switch (i) 
                    {
                        case 4:
                        case 8: toFirstRoom=false;
                                toSecondRoom=false;
                                houseOffset=0.0f;
                                toSecondRoom=false;
                                toFirstRoom=false;
                                playSE(SE_BUTTON_CANCEL);
                                g_nGameState = GAME_STATE_TITLE;
                                SwitchGameState();
                           
                            break;
                        case 12:
                            toSecondRoom=true;
                            toFirstRoom=false;
                            g_nGameState=GAME_STATE_BEDROOM;
                            SwitchGameState();
                            break;    
                        default: 
                           
                            break;
                    }
                }
				else {
//					int index = ClickHouseObj(fX, fY,startPointXY[0],startPointXY[1]);
//					if(index == -1) {
//						ShowDetail = -1;
//					}else {
//						ShowDetail = props_order[index];
//					}
                 ShowDetail = ClickHouseObj(fX, fY,startPointXY[0],startPointXY[1]);
				}
            }
        }
       // ShowDetail = ClickObj(fX, fY,startPointXY[0],startPointXY[1]);
		
	}
}

void DrawMultiLineString(const char* str, float fx, float fy, float scale, float width, float heightinterval, float r, float g, float b, float a)
{
	char strtmp[100];
	int i = 0;
	int j;
	char strLine[300];
	float posx = 0;
	float posy = 0;
	float strWidth = 0.0f;	// new
	int strLength = strlen(str);
	memset(strLine, '\0', sizeof(strLine));
	while (str[i] != '\0')
	{
		j = 0;
		do
		{
			strtmp[j] = str[i];
			i++;
			j++;
		} while(i < strLength && str[i] != ' ' && str[i] != '\0');
        
		// new
		if (i < strLength && str[i] == ' ')
		{
			strtmp[j] = str[i];
			j++;
		}
		
		strtmp[j] = '\0';
		j++;
        //		if (posx + j*40*scale > width)
        //		{
        //			posy += heightinterval;
        //			posx = 0;
        //		}
		strWidth = GetStringWidth(strtmp, scale, FONT_TYPE_SCHOOLBELL);
		
		if (posx + strWidth > width)
		{
			int strLenTmp = strlen(strLine);
			float strWidthTmp = 0.0f;
			if (strLine[strLenTmp-1] == ' ')
			{
				strLine[strLenTmp-1] = '\0';
				strWidthTmp = GetStringWidth(strLine, scale, FONT_TYPE_SCHOOLBELL);
			}
			posy += heightinterval;
		    posx =(width - strWidthTmp) / 2.0f;
			DrawString(strLine, fx +posx, fy + posy, scale, r, g, b, a, FONT_TYPE_SCHOOLBELL);
			memset(strLine, '\0', sizeof(strLine));
		}
		
        
		strcat(strLine,strtmp);
		posx += strWidth;
		if (str[i] == '\0') {
			i--;
			posy += heightinterval;
		    posx =(width-posx)/2;
			DrawString(strLine, fx +posx, fy + posy, scale, r, g, b, a, FONT_TYPE_SCHOOLBELL);
		}
		else if ((i+1 == strLength) && (str[i] == ' ') && (str[i+1] == '\0'))
		{
			posy += heightinterval;
		    posx =(width-posx)/2;
			DrawString(strLine, fx +posx, fy + posy, scale, r, g, b, a, FONT_TYPE_SCHOOLBELL);
			memset(strLine, '\0', sizeof(strLine));
		}
		i++;
	}
	
}

int ClickHouseObj(float fx,float fy,float startfx,float startfy)
{
	int tempIndex = -1;
	for (int i = 23; i >= 0; i--)
	{   
        int type=0;
        for (int j=0; j<24; j++)
        {
            if (props_order[j]==i) 
            {
                    type=j;
                    break;
            }
        }
   
		if (mObjFlag[type])
		{   
			 if (fx > (ObjPos[i][0]-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X-5&& fx <(ObjPos[i][0]+ObjPos[i][2]-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X
				&& fy > ObjPos[i][1]*IPAD_PROPS_X+5 && fy < (ObjPos[i][1] + ObjPos[i][3])*IPAD_PROPS_X
				&&startfx >(ObjPos[i][0]-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X-5 && startfx <(ObjPos[i][0]+ObjPos[i][2]-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X
				&& startfy > ObjPos[i][1]*IPAD_PROPS_X+5 && startfy < (ObjPos[i][1] + ObjPos[i][3])*IPAD_PROPS_X)
			{
				playSE(SE_BUTTON_CONFIRM);
				
                if(i==3)//rug
                {
                    if ((fx>(145-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X&&fx<(335-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X&&fy>280*IPAD_PROPS_X &&fy<317*IPAD_PROPS_X )
                        &&(startfx>(145-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X&&startfx<(335-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X&&startfy>280*IPAD_PROPS_X &&startfy<317*IPAD_PROPS_X )) 
                    {
                        tempIndex = i;
                        return tempIndex;
                    }
                }
                else if(i==11) //cat
                {
                    if ((fx>(77-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X&&fx<(111-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X&&fy>218*IPAD_PROPS_X &&fy<242*IPAD_PROPS_X )
                        &&(startfx>(77-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X&&startfx<(111-IMG_HOURSEROOM_XOFFSET)*IPAD_PROPS_X&&startfy>218*IPAD_PROPS_X &&startfy<242*IPAD_PROPS_X )) 
                    {
                        tempIndex = i;
                        return tempIndex;
                    }
                   
                }
				else
                {
                    tempIndex = i;
                    if (tempIndex == 9||tempIndex == 16)//sofa  tv
                    {
                        continue;
                    }
                    return tempIndex;
                }
			}
		}
	}
	return tempIndex;//return -1;
}
