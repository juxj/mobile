/*
 *  Rain.h
 *  Zombie Dash
 *
 *  Created by Neo01 on 7/8/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __RAIN_H__
#define __RAIN_H__

#include <vector>

#define MAX_RAIN_DROP	320

#define MAX_ANGLE		80.0f

class Particle;

class Rain {
public:
	int index;
	
	float velocityX;
	float velocityY;
	float accelerationX;
	float accelerationY;
	
	float lifeTime;
	float lifeTimeMax;
	
	Rain();
	~Rain();
	
	float setScale(float value);
	float getScale();
	
	float setAngle(float value);
	float getAngle();
	
//	int isHit(float tx, float ty, float *xx, float *yy);
	
	void update(float dt);
	void render(float dt);
	//	void render(float x, float y, float angle = 0.0f, float xScale = 1.0f, float yScale = 1.0f);
	
	void playSe();
	void stopSe();
	
private:
	std::vector<Particle*> raindrop;
	int   nDrop;
	int   nDropMax;
	float scale;
	float angle;
	float windVelocity;
	float initialVelocity;
	float gravity;
	
	bool  playingSe;
};

#endif //__RAIN_H__
