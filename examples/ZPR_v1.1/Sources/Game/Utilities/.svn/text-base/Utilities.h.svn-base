//
//  Utilities.h
//  ZPR
//
//  Created by futao.huang on 11-7-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef __UTILITIES_H__
#define __UTILITIES_H__

#define FONT_CHAR_MAX			(95)
#define FONT_TYPE_MAX			(3)
#define FONT_CHAR_ARR_MAX		(FONT_CHAR_MAX * FONT_TYPE_MAX)
#define FONT_CHAR_XADV_MAX		(FONT_CHAR_MAX * (FONT_TYPE_MAX - 1))

#define FONT_TYPE_SLACKEY		0
#define FONT_TYPE_SLACKEY_OL	1
#define FONT_TYPE_SCHOOLBELL	2

class Image;
extern Image* mFonts[FONT_CHAR_ARR_MAX];
//extern Image* mFont[FONT_CHAR_MAX];
//extern Image* mFontB[FONT_CHAR_MAX];

void DrawFont(int nID,float fX, float fY, 
				float scale = 1.0f, float r = 1.0f, float g = 1.0f, float b = 1.0f, float alpha = 1.0f, 
				int fontType = FONT_TYPE_SLACKEY);
void DrawString(char *szString, float fX, float fY, 
				float scale = 1.0f, float r = 1.0f, float g = 1.0f, float b = 1.0f, float alpha = 1.0f, 
				int fontType = FONT_TYPE_SLACKEY, bool opt1 = true);
float GetStringWidth(char *szString, float scale = 1.0f, int fontType = FONT_TYPE_SLACKEY);

#endif //__UTILITIES_H__
