/*
 *  Particle.cpp
 *  Zombie Dash
 *
 *  Created by Neo01 on 7/6/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "Particle.h"
#include "Sprite.h"
#include "neoRes.h"

#import "GameState.h"


Particle::Particle(const char* filename, float vX, float vY, float aX, float aY)
{
//	Sprite::Sprite();
//	NeoRes* neoRes = NeoRes::getInstance();
	g_GcResMgr->createSprite(this, filename, NULL/*, IMG_RES_SCALE*/);
	
	velocityX = vX;
	velocityY = vY;
	accelerationX = aX;
	accelerationY = aY;
	
	lifeTime = 0.0f;
	lifeTimeMax = 5000.0f;
	
	setCurrentAction(0);
	startAction();
}

Particle::~Particle()
{
}

void Particle::update(float dt)
{
	Sprite::update(dt);
//	printf("%f\n", getY());
//	if (getY() >= 200)
//	{
//		setCurrentAction(1);
//		startAction();
//	}
}
//
//void Particle::render()
//{
//}
//
//void Particle::render(float x, float y, float angle = 0.0f, float xScale = 1.0f, float yScale = 1.0f)
//{
//}
