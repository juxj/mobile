/*
 *  neoLog4Mac.h
 *  NeoLib
 *
 *  Created by Neo01 on 2010-08-08.
 *  Copyright 2010 Neo01. All rights reserved.
 *
 */

#ifndef __NEO_LOG_4_MAC_H__
#define	__NEO_LOG_4_MAC_H__

#include <iostream>
#include <assert.h>

#ifndef ACTIVATE_NEO_LOG
	#define neoinfo(_e)		((void)0)
	#define neowarning(_e)	((void)0)
	#define neoerror(_e)	((void)0)
	#define neofatal(_e)	((void)0)
	#define neoassert(_e)	((void)0)
#else
	#define neoinfo(_e)		std::cout << "Info: "    << __FILE__ << " - " << __LINE__ << __FUNCTION__ << "\n" << _e << "\n";
	#define neowarning(_e)	std::cout << "Warning: " << __FILE__ << " - " << __LINE__ << __FUNCTION__ << "\n" << _e << "\n";
	#define neoerror(_e)	std::cout << "Error: "   << __FILE__ << " - " << __LINE__ << __FUNCTION__ << "\n" << _e << "\n";
	#define neofatal(_e)	std::cout << "Fatal: "   << __FILE__ << " - " << __LINE__ << __FUNCTION__ << "\n" << _e << "\n";
	#define neoassert(_e)	assert(_e);
#endif

#endif //__NEO_LOG_4_MAC_H__
