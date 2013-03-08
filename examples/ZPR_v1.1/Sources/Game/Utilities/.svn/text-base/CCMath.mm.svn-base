//
//  CCUtil.mm
//  CCLib
//
//  Created by futao.huang on 2011-7-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCMath.h"
#import <float.h>
#import <math.h>

namespace CClib {

bool InsideRect(float tx, float ty, float tw, float th, float x, float y, float w, float h)
{
	if (y + h < ty || // is the bottom b above the top of a?
		y > ty + th || // is the top of b below bottom of a?
		x + w < tx || // is the right of b to the left of a?
		x > tx + tw) // is the left of b to the right of a?
	{
		return false;
	}
	return true;
}

bool InsideRange(float tx, float ty, float x, float y, float w, float h)
{
	if(tx <x) return false;
	if(tx >x+w) return false;
	
	if(ty <y) return false;
	if(ty >y+h) return false;
	
	return true;
}

float InsideParall(float ang, float v, float tx, float ty, float x, float y, float w, float h)
{
	if(tx <x) return FLT_MAX;
	if(tx >x+w) return FLT_MAX;
	
	if(ty <y) return FLT_MAX;
	if(ty >y+h) return FLT_MAX;
	
	float yy = 0.0f;

	if(ang >=0){//slide
		float k = h/w;//tanf(CC_D2R(ang))
		float dy = v*k;
		ty +=dy;
		
		yy = y +(tx-x)*k;
		if(ty <yy-8 || ty >yy+8) return FLT_MAX;
	}else {//clim
		float k = -h/w;//tanf(CC_D2R(ang))
		float dy = v*k;
		ty +=dy;
		
		yy = y +(tx-x)*k +h;
		if(ty <yy-8 || ty >yy+8) return FLT_MAX;
	}
	
	return yy;
}
}// CClib
