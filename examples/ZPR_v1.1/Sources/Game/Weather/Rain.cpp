/*
 *  Rain.cpp
 *  Zombie Dash
 *
 *  Created by Neo01 on 7/8/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "Rain.h"
#include "Particle.h"

#include <math.h>

#include <vector>

#include "GameRes.h"
#include "Stage.h"

#include "Runner.h"

#include "GameAudio.h"

#if DEBUG
#include "Canvas2D.h"
#endif

Rain::Rain()
{
	for (int i = 0; i < MAX_RAIN_DROP; i++)
	{
		Particle *particle = new Particle("rain.xml", -1, 0, 0, -2);
		particle->setX(rand() % 960);
		particle->setY(rand() % 320);
		raindrop.push_back(particle);
	}
	
	angle = 50.0f;
}

Rain::~Rain()
{
	for(int i = 0; i < raindrop.size(); i++)
	{
        delete raindrop[i];
		raindrop[i] = NULL;
	}
	raindrop.clear();
}

float Rain::setScale(float value)
{
	float temp = scale;
	scale = value;
	nDropMax = (int)(MAX_RAIN_DROP * scale);
	return temp;
}

float Rain::getScale()
{
	return scale;
}

float Rain::setAngle(float value)
{
	float temp = angle;
	angle = value;
	return temp;
}

float Rain::getAngle()
{
	return angle;
}


void Rain::update(float dt)
{
	playSe();
	
	// Weather Effects Main
	std::vector<Particle*>::iterator rit = raindrop.begin();
	std::vector<Particle*>::iterator ritEnd = raindrop.end();
	for (; rit != ritEnd; rit++)
	{
		(*rit)->update(dt);
		if ((*rit)->getY() > 330 || (*rit)->getX() < -10)
		{
			(*rit)->setX(rand() % (int)(angle/15.0f*480));
			(*rit)->setY(-32.0f);
			(*rit)->setCurrentAction(0);
			(*rit)->startAction();
		}
		else
		{
			if ((*rit)->getCurrentAction() == 0)
			{
				(*rit)->setX((*rit)->getX() + (-13.5f*sinf(3.1415926f/180.0f * angle)));
				(*rit)->setY((*rit)->getY() + (+13.5f*cosf(3.1415926f/180.0f * angle)));
				float tempX = 0.0f, tempY = 0.0f;

				if ((rand() % 10 > 7) && !stages->BlockType((*rit)->getX() + mScrollWorld - cameraX, (*rit)->getY() - cameraY, &tempX, &tempY))
				{
					//(*rit)->setX(tempX);
					(*rit)->setY(tempY-5.0f);
					(*rit)->setCurrentAction(1);
					(*rit)->startAction();
//					printf("Hit\n");
				}
			}
			else if ((*rit)->getCurrentFrameIndex() >= 3)
			{
				//(*rit)->setY(330.0f);
				(*rit)->setX(rand() % (int)(angle/15.0f*480));
				(*rit)->setY(-32.0f);
				(*rit)->setCurrentAction(0);
				(*rit)->startAction();
			}
		}
	}
}

void Rain::render(float dt)
{
	// Weather Effects Render
	std::vector<Particle*>::iterator rit = raindrop.begin();
	std::vector<Particle*>::iterator ritEnd = raindrop.end();
	for (; rit != ritEnd; rit++)
	{
		if ((*rit)->getCurrentAction() > 0)
		{
			(*rit)->render((*rit)->getX() + cameraX, (*rit)->getY() + cameraY + SCENE_OFFSET, 0.0f, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
//#if DEBUG
//			Canvas2D* canvas = Canvas2D::getInstance();
//			canvas->strokeRect((*rit)->getX() + cameraX, (*rit)->getY() + cameraY, 14.0f, 8.0f);
//#endif
		}
		else
		{
			(*rit)->render((*rit)->getX(), (*rit)->getY() + SCENE_OFFSET, -3.1415926f/2.0f/90.0f * angle, GLOBAL_CANVAS_SCALE, GLOBAL_CANVAS_SCALE);
		}
	}
}

void Rain::playSe()
{
	if (!playingSe)
	{
		playSE(SE_RAIN, true);
		playingSe = true;
	}
}

void Rain::stopSe()
{
	if (playingSe)
	{
		stopSE(SE_RAIN);
		playingSe = false;
	}
}
