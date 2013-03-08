//
//  Utilities.cpp
//  ZPR
//
//  Created by futao.huang on 11-7-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Utilities.h"

#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"

Image* mFonts[FONT_CHAR_ARR_MAX];
//Image* mFont[FONT_CHAR_MAX];
//Image* mFontB[FONT_CHAR_MAX];

const float xadv[FONT_CHAR_XADV_MAX] = {
	13, 10, 13, 22, 23, 24, 27,  7, 11, 11, 
	17, 17,  9, 14,  8, 16, 23, 13, 21, 21, 
	22, 22, 22, 19, 23, 22,  8,  9, 11, 14, 
	11, 20, 26, 24, 27, 23, 27, 21, 21, 25, 
	24, 16, 20, 25, 18, 31, 29, 30, 27, 30, 
	26, 27, 21, 28, 22, 30, 24, 26, 24, 10, 
	16, 10, 16, 18, 30, 25, 27, 23, 25, 24, 
	15, 24, 24, 10, 10, 22, 10, 33, 22, 26, 
	25, 25, 20, 20, 15, 24, 20, 28, 20, 25, 
	19, 12,  7, 12, 18, 
	10,  7, 10, 19, 15, 21, 18,  5,  8,  8, 
	15, 13,  5, 15,  4, 11, 15,  9, 16, 17, 
	17, 17, 16, 15, 16, 15,  5,  5, 14, 17, 
	14, 15, 22, 17, 16, 16, 18, 16, 15, 19, 
	17, 14, 15, 15, 14, 20, 16, 17, 13, 18, 
	15, 13, 12, 15, 15, 27, 16, 12, 17, 10, 
	11, 10, 12, 26, 18, 16, 16, 12, 14, 14, 
	10, 13, 15,  7,  7, 14,  7, 23, 13, 17, 
	15, 14, 13, 15, 12, 17, 12, 21, 14, 14, 
	15, 11,  7, 12, 17
};

void DrawFont(int nID,float fX, float fY, float scale, float r, float g, float b, float a, int fontType)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	Image* charImg = mFonts[nID + FONT_CHAR_MAX * fontType];//hasOutline?mFontB[nID]:mFont[nID];
	charImg->SetColor(r, g, b, a);
//	canvas->enableColorPointer(true);	// move this to DrawString to reduce the state changes
#ifdef VERSION_IPAD
	canvas->setCanvasScale(1.0f, 1.0f);
#endif
	canvas->drawImage(charImg, fX + charImg->mOffsetX * scale, fY + charImg->mOffsetY * scale, 0.0f, scale, scale);
#ifdef VERSION_IPAD
	canvas->setCanvasScale(GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
#endif
//	canvas->enableColorPointer(false);	// move this to DrawString to reduce the state changes
	charImg->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
}

void DrawString(char *szString, float fX, float fY, float scale, float r, float g, float b, float a, int fontType, bool opt1)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	int i = 0;
	int nID = 0;
	int nLen = strlen(szString);
	char *cBuffer = szString;
	int xAdvHint = (fontType<=FONT_TYPE_SLACKEY_OL)?0:1;
	
#ifdef VERSION_IPAD
	fX *= GLOBAL_CANVAS_SCALE;
	fY *= GLOBAL_CANVAS_SCALE;
	scale *= IMG_RES_SCALE;
#endif
	
	float currX = fX;
//	float currY = fY;
	
	nLen = strlen(szString);
	cBuffer = szString;
	
	if (opt1)
		canvas->enableColorPointer(true);
	for (i = 0; i < nLen; i++)
	{
		nID = 0;
		if (*cBuffer >= char(32) && *cBuffer <= char(126))
		{
			nID = *cBuffer - ' ';
		}
		DrawFont(nID, currX, fY, scale, r, g, b, a, fontType);
		cBuffer++;
		currX += xadv[nID + FONT_CHAR_MAX * xAdvHint] * scale;
	}
	if (opt1)
		canvas->enableColorPointer(false);
}

float GetStringWidth(char *szString, float scale, int fontType)
{
	int i = 0;
	int nID = 0;
	float stringWidth = 0.0f;
	int nLen = strlen(szString);
	char *cBuffer = szString;
	int xAdvHint = (fontType<=FONT_TYPE_SLACKEY_OL)?0:1;
	
	for (i = 0; i < nLen; i++)
	{
		nID = 0;
		if (*cBuffer >= char(32) && *cBuffer <= char(126))
		{
			nID = *cBuffer - ' ';
		}
		cBuffer++;
		stringWidth += xadv[nID + FONT_CHAR_MAX * xAdvHint] * scale;
	}
	return stringWidth;
}
