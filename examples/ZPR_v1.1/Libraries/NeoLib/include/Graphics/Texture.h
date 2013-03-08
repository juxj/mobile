/*
 *  Texture.h
 *
 *  Created by Neo01 on 5/30/2011.
 *
 */

#ifndef __TEXTURE_H__
#define __TEXTURE_H__

//namespace neolib {

#import <OpenGLES/ES1/gl.h>

class Texture
{
public:
	Texture(GLuint texId, float imgWidth, float imgHeight, float texWidth, float texHeight);
	Texture();
	~Texture();
	
	GLuint mTextureId;
	float mImageWidth;
	float mImageHeight;
	float mTextureWidth;
	float mTextureHeight;
};

//} //namespace neolib

#endif//__TEXTURE_H__
