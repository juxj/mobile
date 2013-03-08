/*
 *  neoMinMax.h
 *  NeoLib
 *
 *  Created by Neo01 on 2010-08-08.
 *  Copyright 2010 Neo01. All rights reserved.
 *
 */

#ifndef __NEO_MINMAX_H__
#define	__NEO_MINMAX_H__

template<typename T>
const T& min(const T& a, const T& b){
	return a < b ? a : b;
}

template<typename T>
const T& max(const T& a, const T& b){
	return a > b ? a : b;
}

#endif //__NEO_MINMAX_H__
