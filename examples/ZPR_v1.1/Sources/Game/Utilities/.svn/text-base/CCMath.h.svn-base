//
//  CCUtil.mm
//  CCLib
//
//  Created by futao.huang on 2011-7-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef CCMATH_H
#define CCMATH_H

/// converts degrees to radians
#define CC_D2R(A) ((A)/180.0f * (float)M_PI)

/// converts radians to degrees
#define CC_R2D(A) ((A)/(float)M_PI*180.0f)


namespace CClib
{
	//return true indicate collision.
	bool InsideRect(float tx, float ty, float tw, float th, float x, float y, float w, float h);
	//return true indicate collision.
	bool InsideRange(float tx, float ty, float x, float y, float w, float h);
	//return FLT_MAX indicate no collision.
	float InsideParall(float ang, float v, float tx, float ty, float x, float y, float w, float h);
}

#endif
