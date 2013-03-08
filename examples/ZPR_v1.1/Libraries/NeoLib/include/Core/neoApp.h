/*
 *  neoApp.h
 *  NeoLib
 *
 *  Created by Neo01 on 2010-08-08.
 *  Copyright 2010 Neo01. All rights reserved.
 *
 */

#ifndef __NEO_APP_H__
#define __NEO_APP_H__

namespace neolib {

	class App
	{
	public:
		enum Orientation{
			ORIENTATION_LEFT,
			ORIENTATION_UP,
			ORIENTATION_RIGHT,
			ORIENTATION_DOWN,
		};
		
		struct Config
		{
			Config():
				width(320),
				height(480),
				orientation(ORIENTATION_UP),
				maxFPS(0),
				maxSoundSources(8){
			}
			unsigned short width; 
			unsigned short height;
			unsigned short width0; 
			unsigned short height0;
			Orientation orientation;
			Orientation orientation0;
			int maxFPS;
			int maxSoundSources;
		};
		
		static void create(const Config& config);
		static void destroy();
		static const Config& getConfig();
		static void setOrient(Orientation orient);
		
		static float getAspect();
		static float getCurrFPS();
		
		static void main(float ms);
		static void draw(float ms);
		
		static void update(float ms);
		static void render(float ms);
		
	private:
		static void init();
		static void teardown();
	};

} //namespace neolib

#endif //__NEO_APP_H__
