/*
 *  Particle.h
 *  Zombie Dash
 *
 *  Created by Neo01 on 7/6/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __PARTICLE_H__
#define __PARTICLE_H__

#include "Sprite.h"

class Particle : public Sprite {
public:
	int index;
	
	float velocityX;
	float velocityY;
	float accelerationX;
	float accelerationY;
	
	float lifeTime;
	float lifeTimeMax;
	
	Particle(const char* filename, float vX, float vY, float aX, float aY);
	~Particle();
	
	void update(float dt);
//	void render();
//	void render(float x, float y, float angle = 0.0f, float xScale = 1.0f, float yScale = 1.0f);
};

#endif //__PARTICLE_H__
