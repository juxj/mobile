/*
 *  Font.h
 *
 *  Created by Neo01 on 6/7/11.
 *
 */

#ifndef __FONT_H__
#define __FONT_H__

#define CHAR_COUNT		95
#define TEXTURE_SIZE	256

class Texture;
class Image;
class Canvas2D;

class Font
{
public:
	Font(float fontSize);
	~Font();
	
	void		drawString(const char* str, float x, float y);
	float		getHeight();
	Texture*	getTexture();
	
private:
	Canvas2D*	mCanvas;
	Texture*	mTexture;
	Image**		mCharacters;
	float*		mCharWidthArray;
	float		mFontHeight;
};

#endif //__FONT_H__
