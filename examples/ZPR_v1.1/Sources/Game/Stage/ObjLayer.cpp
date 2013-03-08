/*
 *  ObjLayer.cpp
 *  Zombie Dash
 *
 *  Created by Neo01 on 6/29/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "ObjLayer.h"
#include "ObjRect.h"

#include "Canvas2D.h"
#include "Image.h"
#include "neoRes.h"

#include "GameRes.h"
#include "Sprite.h"
#include "Opponent.h"
#include "GameOption.h"
#include "Stage.h"
#include "Item.h"	// temp
#include "Opponent.h"
#include "Runner.h"

#import "GameState.h"
#import "Stage.h"
#import "GameHouse.h"

#include <math.h>

ObjLayer::ObjLayer(int _index, int _width, int _height, int _type)
{
	index  = _index;
	width  = _width;
	height = _height;
	baseX  = 0.0f;
	baseY  = 0.0f;
	type   = _type;
	
	bClrUserData = true;
}

ObjLayer::~ObjLayer()
{
	std::list<ObjRect*>::iterator it = data.begin();
	std::list<ObjRect*>::iterator itEnd = data.end();
	for (; it != itEnd;)
	{
		if (bClrUserData)
		{
			(*it)->clrUserData();
		}
		delete (*it);
		(*it) = NULL;
		it = data.erase(it);
	}
	data.clear();
}

void ObjLayer::addObj(int objId, float x, float y, float w, float h, int imgId, void* userData, int userDataType)
{
	ObjRect* obj = new ObjRect(objId, x, y, w, h, imgId, userData, userDataType);
	data.push_back(obj);
}

void ObjLayer::appendObj(std::list<ObjRect*> _data, float offsetX)
{
	baseOffsetX = offsetX;
	
	std::list<ObjRect*>::iterator it = _data.begin();
	std::list<ObjRect*>::iterator itEnd = _data.end();
	for (; it != itEnd; ++it)
	{
		addObj((*it)->objId, (*it)->x + baseOffsetX, (*it)->y, (*it)->width, (*it)->height, (*it)->imgId, (*it)->userData, (*it)->userDataType);
		if ((*it)->userData)
		{
			switch ((*it)->userDataType) {
				case 0:
				{
					Opponent* opponent = (Opponent *)((*it)->userData);
					opponent->mOrgX = (*it)->x + baseOffsetX;
					opponent->reset();
//					printf("zombie is set to x: %f (+ %f)\n", (*it)->x, baseOffsetX);
					break;
				}
				case 1:
				{
					Item* item = (Item *)((*it)->userData);
					item->mOrgX = (*it)->x + baseOffsetX;
					item->reset();
//					printf("treasure is set to x: %f (+ %f)\n", (*it)->x, baseOffsetX);
					break;
				}
				default:
					break;
			}
		}
	}
}

void ObjLayer::reset()
{
	baseX = 0.0f;
	baseY = 0.0f;
	
	std::list<ObjRect*>::iterator it = data.begin();
	std::list<ObjRect*>::iterator itEnd = data.end();
	for (; it != itEnd;)
	{
		delete (*it);
		(*it) = NULL;
		it = data.erase(it);
	}
	data.clear();
}

#pragma mark -
#pragma mark update / render
void ObjLayer::update(float dt, float posX, float posY, bool refresh)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	
	float offsetX = 0.0f;
	
	baseX = posX;
	baseY = posY;
//	printf("baseX = %f\n", baseX);
	
//	if (refresh)
	{
		std::list<ObjRect*>::iterator it = data.begin();
		std::list<ObjRect*>::iterator itEnd = data.end();
		for (; it != itEnd;)
		{
//			(*it)->update(dt);
			
			offsetX = (*it)->x + ((*it)->width) * 2.0f;
			
			if (refresh && (baseX > offsetX || !((*it)->isActive())))
			{
				if (type && index == LAYER_TREASURE && (*it)->userData)
				{
					if (!((*it)->moveDone()))
					{
//						printf("ignore it\n");
						if ((baseX + (canvas->getCanvasWidth())) >= (*it)->x)
						{
							(*it)->update(dt);
						}
						++it;
						continue;
					}
//					else {
//						printf("delete it\n");
//					}
				}
				//printf("erase \t%f\n", offsetX);
//				ObjRect* obj2Del = *it;
//				it = data.erase(it);
//				delete obj2Del;
//				obj2Del = NULL;
				delete (*it);
				(*it) = NULL;
				it = data.erase(it);
			}
			else
			{
				if (type && (index == LAYER_ZOMBIE || index == LAYER_TREASURE))
				{
					if ((baseX + (canvas->getCanvasWidth())) < (*it)->x)
					{
						++it;
						continue;
					}
					(*it)->update(dt);
				}
				else if (type && index == LAYER_HINT/* && GetLevelMode() == 1*/)
				{
					if ((baseX + (canvas->getCanvasWidth())) < (*it)->x)
					{
						++it;
						continue;
					}
					(*it)->update(dt);
				}
				
				++it;
			}
		}
	}
	
//	if (type && index == LAYER_ZOMBIE)
//	{
//		Canvas2D* canvas = Canvas2D::getInstance();
//		std::list<ObjRect*>::iterator itr = data.begin();
//		std::list<ObjRect*>::iterator itrEnd = data.end();
//		for (; itr != itrEnd; ++itr)
//		{
//			if ((baseX + (canvas->getCanvasWidth())) < (*itr)->x)
//			{
//				continue;
//			}
//			(*itr)->update(dt);
//		}
//	}
//	else if (type && index == LAYER_TREASURE)
//	{
//		Canvas2D* canvas = Canvas2D::getInstance();
//		std::list<ObjRect*>::iterator itr = data.begin();
//		std::list<ObjRect*>::iterator itrEnd = data.end();
//		for (; itr != itrEnd; ++itr)
//		{
//			if ((baseX + (canvas->getCanvasWidth())) < (*itr)->x)
//			{
//				continue;
//			}
//			(*itr)->update(dt);
//		}
//	}
//	else if (type && index == LAYER_HINT && GetLevelMode() == 1)
//	{
//		Canvas2D* canvas = Canvas2D::getInstance();
//		std::list<ObjRect*>::iterator itr = data.begin();
//		std::list<ObjRect*>::iterator itrEnd = data.end();
//		for (; itr != itrEnd; ++itr)
//		{
//			if ((baseX + (DISTANCE_PARAM * canvas->getCanvasWidth())) < (*itr)->x)
//			{
//				continue;
//			}
//			(*itr)->update(dt);
//		}
//	}
}

void ObjLayer::render(float dt, float offsetX, float offsetY)
{
	Canvas2D* canvas = Canvas2D::getInstance();
	std::list<ObjRect*>::iterator it = data.begin();
	std::list<ObjRect*>::iterator itEnd = data.end();
	
	float _offsetX = 0;
	float _offsetY = 0;
	
	for (; it != itEnd; ++it)
	{
#ifdef VERSION_IPAD
		if ((baseX + 512.0f) < (*it)->x)
		{
			continue;
		}
#else
		if ((baseX + canvas->getCanvasWidth()) < (*it)->x)
		{
			continue;
		}
#endif
		_offsetX = offsetX + (-baseX) + (*it)->x;
		_offsetY = offsetY + (-baseY) + (*it)->y;
		
		_offsetY += SCENE_OFFSET;
		

#ifdef VERSION_IPAD
		if (index >= LAYER_BG)
		{
			canvas->drawImage(g_GcResMgr->getImage((*it)->imgId), floor(_offsetX), floor(_offsetY), 
							  0.0f, width*GLOBAL_CANVAS_SCALE/512.0f, height*GLOBAL_CANVAS_SCALE/512.0f);
			continue;
		}
#endif
		
		if (type && (index == LAYER_ZOMBIE || index == LAYER_BILLBOARD))
		{
			(*it)->render(dt, _offsetX, _offsetY);
		}

		else if (type && (index == LAYER_TREASURE))
		{
// This would break the layer structure but it's an easy way to add the halo effect for the item.
			
			if ((*it)->objId == 24)
			{
				(*it)->render(dt, _offsetX, _offsetY + SCENE_OFFSET);
				continue;
			}
			else if ((*it)->objId <= (MAX_ITEM) && (stages->itemHalo))
			{
				static float haloScale = 1.0f;
				static float dScale = 0.05f;
				static float dRot = 0.0f;
				haloScale += dScale;
				if (dScale > 0 && haloScale > 1.5f)
				{
					dScale = -dScale;
				}
				else if (dScale < 0 && haloScale < 1.0f)
				{
					dScale = -dScale;
				}
				dRot += 0.098f;
				if (dRot >= 3.1415926f)
				{
					dRot = 0.0f;
				}
				
				stages->itemHalo->update(dt);
#ifdef VERSION_IPAD
//				canvas->flush();
//				glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
				stages->itemHalo->render(_offsetX+16.0f, _offsetY+16.0f, dRot, haloScale * GLOBAL_CANVAS_SCALE, haloScale * GLOBAL_CANVAS_SCALE);
//				canvas->flush();
//				glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
#else
				stages->itemHalo->render(_offsetX+16.0f, _offsetY+16.0f, dRot, haloScale, haloScale);
#endif
///				stages->itemHalo->render(_offsetX+16.0f, _offsetY+16.0f, 0.0f, haloScale, haloScale);
			}

			
			(*it)->render(dt, _offsetX, _offsetY);
			
		}
		else if (type && index == LAYER_HINT && GetLevelMode() == 1)
		{
			if ((baseX + DISTANCE_PARAM * (canvas->getCanvasWidth())) < (*it)->x)
			{
				continue;
			}
			Image* tmpImg = g_GcResMgr->getImage((*it)->imgId);
			canvas->enableColorPointer(true);
			//printf("%d, %f, %f, %f\n", (*it)->objId, (float)((*it)->alpha / ((*it)->interval / 3.0f)), (*it)->timer, (*it)->interval);
			tmpImg->SetColor(1.0f, 1.0f, 1.0f, (float)((*it)->alpha / ((*it)->interval / 3.0f)));
			canvas->drawImage(tmpImg, _offsetX, _offsetY);
			canvas->enableColorPointer(false);
			tmpImg->SetColor(1.0f, 1.0f, 1.0f, 1.0f);
		}
		else
		{
			canvas->drawImage(g_GcResMgr->getImage((*it)->imgId), floor(_offsetX), floor(_offsetY));
			//canvas->fillRect(_offsetX, _offsetY, 32.0f, 32.0f);
		}

#if DEBUG
					 if (index == LAYER_TERRAIN && type)
					 {
						 canvas->strokeRect(_offsetX, _offsetY, (*it)->width, (*it)->height);
						 
						 float x = _offsetX -DISTANCE_KASH_VAULT;
						 float w = DISTANCE_KASH_VAULT-DISTANCE_TIC_TAC;
						 
						 canvas->setColor(0.0f, 1.0f, 0.0f, 0.5f);
						 canvas->strokeRect(x, _offsetY, w, (*it)->height);
						 
						 canvas->setColor(1.0f, 1.0f, 0.0f, 0.5f);
						 canvas->strokeRect(_offsetX-DISTANCE_TIC_TAC, _offsetY, DISTANCE_TIC_TAC, (*it)->height);
						 
						 canvas->setColor(1.0f, 0.0f, 0.0f, 0.5f);
						 canvas->strokeRect(_offsetX-DISTANCE_TIC_TAC, _offsetY, DISTANCE_TIC_TAC, DISTANCE_CAT_LEAP);
						 
						 canvas->setColor(1.0f, 1.0f, 1.0f, 1.0f);
						 canvas->flush();
						 continue;
					 }
#endif
					 
	}
//	printf("-----------------------\n");
}
