/*
 *  ObjRect.cpp
 *  ZPR
 *
 *  Created by Neo01 on 6/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "ObjRect.h"
#include <stdio.h>

#include "Item.h"
#include "Opponent.h"

ObjRect::ObjRect(int _objId, float _x, float _y, float _width, float _height, int _imgId, void* _userData, int _userDataType)
{
	active = true;
	objId = _objId;
	imgId = _imgId;
	x = _x;
	y = _y;
	width = _width;
	height = _height;
	
	count = 0;
	timer = 0.0f;
	alpha = 1.0f;
	
	userData = _userData;
	userDataType = _userDataType;
	
//	printf("%d, (%f, %f, %f, %f)\n", objId, x, y, width, height);
}

//ObjRect::ObjRect(ObjRect& objRect)
//{
//	active = objRect.active;
//	objId = objRect.objId;
//	imgId = objRect.imgId;
//	x = objRect.x;
//	y = objRect.y;
//	width = objRect.width;
//	height = objRect.height;
//	
//	count = objRect.count;
//	timer = objRect.timer;
//	alpha = objRect.alpha;
//	
//	userData = new Opponent(objId, x, y);
//}

ObjRect::~ObjRect()
{
	active = false;
}

void ObjRect::setImageId(int imageId)
{
	imgId = imageId;
}

void ObjRect::setUserData(void* data)
{
	userData = data;
}

void ObjRect::clrUserData()
{
	if (userData)
	{
//		printf("clrUserData %d\n", userDataType);
		switch (userDataType)
		{
			case 0:
			{
//				printf("delete zombie\n");
				Opponent* temp = (Opponent*)userData;
				delete temp;
				temp = NULL;
				userData = NULL;
				break;
			}
			case 1:
			{
//				printf("delete treasure\n");
				Item* temp = (Item*)userData;
				delete temp;
				temp = NULL;
				userData = NULL;
				break;
			}
			default:
				break;
		}
	}
}

void ObjRect::setActive(bool flag)
{
	active = flag;
}

bool ObjRect::isActive()
{
	return active;
}

void ObjRect::setWidth(float _width)
{
	width = _width;
}

void ObjRect::setHeight(float _height)
{
	height = _height;
}

// Show Hint
void ObjRect::update(float dt)
{
	if (userData)
	{
		switch (userDataType)
		{
			case 0:
			{
				Opponent* opponent = (Opponent *)userData;
				opponent->update(dt);
				x = opponent->mX;
				y = opponent->mY;
				break;
			}
			case 1:
			{
				Item* item = (Item *)userData;
				item->update(dt);
				x = item->mX;
				y = item->mY - height;
				break;
			}
			default:
				break;
		}
	}
	
	
	if (count > 0)
	{
		if (timer >= 0.0f && timer < (float)(interval / 3.0f))
		{
			timer += dt;
			alpha += dt;
			//printf("%d\tflash start: %f, %f\n", objId, timer, (float)(timer / interval));
		}
		else if (timer >= (interval / 3.0f) && timer < (float)(interval / 3.0f * 2.0f))
		{
			timer += dt;
			alpha = (float)(interval / 3.0f);
			//printf("%d\tno flash: %f, %f\n", objId, timer, (float)(timer / interval));
		}
		else if (timer >= (float)(interval / 3.0f * 2.0f) && timer < interval)
		{
			timer += dt;
			alpha -= dt;
			//printf("%d\tflash end: %f, %f\n", objId, timer, (float)(timer / interval));
		}
		else
		{
			//printf("%d\tflash done------: %d - %f, %f\n", count, objId, timer, (float)(timer / interval));
			--count;
			timer = 0.0f;
			alpha = 0.0f;
		}
	}
}

void ObjRect::render(float dt, float offsetX, float offsetY)
{
	if (userData)
	{
		switch (userDataType) {
			case 0:
			{
				((Opponent *)userData)->render(dt, offsetX, offsetY);
				break;
			}
			case 1:
			{
				if (objId == 24)
				{
					Item* item = (Item *)userData;
					item->sx = GLOBAL_CANVAS_SCALE;
					item->sy = GLOBAL_CANVAS_SCALE;
				}
#ifdef V_1_1_0
    #ifdef VERSION_IPAD
                else if (objId >= 300)
				{
					Item* item = (Item *)userData;
					item->sx = 1.25f;
					item->sy = 1.25f;
				}
    #endif
#endif
				((Item *)userData)->render(dt, offsetX, offsetY);
				break;
			}
			default:
				break;
		}
	}
}

void ObjRect::setDuration(float _duration)
{
	duration = _duration;
}

void ObjRect::setInterval(float _interval)
{
	interval = _interval;
	count = (int)(duration / interval);
//	printf("%d\tcount: %d\n", objId, count);
}

void ObjRect::moveTo(float stx, float sty, float destX, float destY)
{
	if (userData)
	{
		switch (userDataType) {
			case 1:
			{
				((Item *)userData)->moveTo(stx, sty, destX, destY);
				break;
			}
			default:
				break;
		}
	}
}

bool ObjRect::moveDone()
{
	bool ret = false;
	if (userData)
	{
		switch (userDataType) {
			case 1:
			{
				ret = ((Item *)userData)->moveDone();
				break;
			}
			default:
				break;
		}
	}
	return ret;
}
