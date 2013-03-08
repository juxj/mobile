/*
 *  neoUnixTime.h
 *  NeoLib
 *
 *  Created by Neo01 on 2010-08-10.
 *  Copyright 2010 Neo01. All rights reserved.
 *
 */

#ifndef __NEO_UNIX_TIME_H__
#define __NEO_UNIX_TIME_H__

#include <sys/time.h>

namespace neolib {

// Frame Skip Helper
//struct timeval {
//	int tv_sec;  //seconds
//	int tv_usec; //microseconds
//};

	typedef struct timeval TIMEVALUE;

	TIMEVALUE getTimeNow();
	TIMEVALUE addTime(TIMEVALUE a, TIMEVALUE b);
	TIMEVALUE substractTime(TIMEVALUE a, TIMEVALUE b);

	void setFramesPerSecond(const int ticks);
	int getFrames(TIMEVALUE *tv);
	void addFrame(TIMEVALUE *tv);
	void resetTime();

}

#endif //__NEO_UNIX_TIME_H__
