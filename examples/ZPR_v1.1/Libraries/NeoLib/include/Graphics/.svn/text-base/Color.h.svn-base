/*
 *  Color.h
 *
 *  Created by Neo01 on 5/30/11.
 *
 */

#ifndef __COLOR_H__
#define __COLOR_H__

#define	ARGB(a, r, g, b)	((a << 24) | (r << 16) | (g << 8) | b)
#define	RGBA(r, g, b, a)	((a << 24) | (b << 16) | (g << 8) | r)

struct Color
{
	unsigned char r;
	unsigned char g;
	unsigned char b;
	unsigned char a;
};

struct Colorf
{ 
	Colorf() { r = 1.0f; g = 1.0f; b = 1.0f; a = 1.0f; }
	Colorf(float red, float green, float blue, float alpha) { r = red; g = green; b = blue; a = alpha; }
	
	float r;
	float g;
	float b;
	float a;
};

#endif//__COLOR_H__
