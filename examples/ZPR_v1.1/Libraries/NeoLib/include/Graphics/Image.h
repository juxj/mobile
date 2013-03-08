/*
 *  Image.h
 *
 *  Created by Neo01 on 5/30/2011.
 *
 */

#ifndef __IMAGE_H__
#define __IMAGE_H__

//namespace neolib {

#import <OpenGLES/ES1/gl.h>
#import "Color.h"

//class Colorf;
class Texture;

class Image
{
public:
	Image(Texture *tex, float x, float y, float w, float h);
	Image(Texture *tex);
	//~Image();
	
	void SetColor(float r, float g, float b, float a);
	void SetAnchor(float x, float y);
	void SetTextureRect(float x, float y, float w, float h);
	void GetTextureRect(float *x, float *y, float *w, float *h);
	
	void setHFlip(bool hflip) { mHFlipped = hflip; }
	void setVFlip(bool vflip) { mVFlipped = vflip; }
	void makeCenterAsAnchor();
	
	float getWidth() {return mWidth/2.0f;};
	float getHeight() {return mHeight/2.0f;};
	float getAnchorX() {return mAnchorX/2.0f;};
	float getAnchorY() {return mAnchorY/2.0f;};
	
	Texture* mTexture;
	
	float mTX0;
	float mTY0;
	float mTX1;
	float mTY1;
	Colorf mColor;
	
	float mX;
	float mY;
	float mWidth;
	float mHeight;
	float mAnchorX;
	float mAnchorY;
	
	bool mHFlipped;
	bool mVFlipped;
	
	float mOffsetX;
	float mOffsetY;
};

//} //namespace neolib

#endif//__IMAGE_H__
