/*
 *  Item.cpp
 *  Zombie Dash
 *
 *  Created by Neo01 on 7/8/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "Item.h"

#include "neoRes.h"
#include "Canvas2D.h"
#include "Image.h"
#include "Sprite.h"

#include "GameOption.h"

#include "Runner.h"

#import "GameState.h"

#include "math.h"

int Item::classId = 1;

Item::Item()
{
}

Item::Item(int itemType, float x, float y, int hintId, float hOffsetx, float hOffsety)
	:mX(x), mY(y), mOrgX(x), mOrgY(y)
{
	char filename[16] = {0};
	memset(filename, '\0', sizeof(filename));
    if (itemType >= 0 && itemType <= 23)
    {
        sprintf(filename, "i%d.xml", props_order[itemType]);
    }
	else
    {
        sprintf(filename, "i%d.xml", itemType);
    }
	sprite = new Sprite();
	if (itemType == 24)
	{
		g_GcResMgr->createSprite(sprite, filename, NULL);
	}
	else
	{
		g_GcResMgr->createSprite(sprite, filename, NULL, IMG_RES_SCALE, IMG_RES_SCALE);
	}
	
#if 0//DEBUG
	sprite->dbgDrawFrame = true;
#endif
	
	sprite->setCurrentAction(0);
	sprite->startAction();
	
	bHint = false;
	if (hintId >= 0)
	{
		g_GcResMgr->loadRes("p1_res.xml", NULL, IMG_RES_SCALE);
		switch (hintId)
		{
			case 0:
				hintImage = g_GcResMgr->getImage("p1_b4");
				break;
			default:
				break;
		}
		bHint = true;
	}
	
	initialization();
	
	// box
	bx = sprite->getX()+100.0f;
	by = sprite->getY()+100.0f;
	bw = sprite->getCurrentFrame()->mWidth;
	bh = sprite->getCurrentFrame()->mHeight;
	// drawing
	ax = 0.0f;//sprite->getCurrentFrame()->mAnchorX;
	ay = 0.0f;//sprite->getCurrentFrame()->mAnchorY + bh/2.0f;
	angle = 0.0f;//26.0f * (3.1415926f / 180.0f);
	sx = 1.0f;
	sy = 1.0f;
	
//	if (itemType == 100)
//	{
//		sx = sy = 32.0f / 42.0f;
//	}
	
	state = ITEM_STATE_IDLE;
}

Item::~Item()
{
	if (sprite)
	{
//		sprite->release();
		delete sprite;
		sprite = NULL;
	}
}

void Item::initialization()
{
	hintType = GetLevelMode();	// difficulty
}

void Item::destroy()
{
}

void Item::reset()
{
	mX = mOrgX;
	mY = mOrgY;
	sprite->setCurrentAction(0);
	sprite->startAction();
	
	state = ITEM_STATE_IDLE;
}

void Item::setHint(bool fShowHint, float offsetX, float offsetY)
{
	bHint = fShowHint;
}

void Item::update(float dt)
{
	sprite->update(dt);
	
	if (state == ITEM_STATE_MOVE)
	{
		//sprite->setActive(true);
		sprite->update(dt);
		//sprite->setActive(false);
		mX += vX;
		mY += vY;
//		printf("update mX = %f, mY = %f\n", mX, mY);
		if ((fabs(mX - destX) <= 0.01f) && (fabs(mY - destY) <= 0.01f))
		{
			state = ITEM_STATE_MOVE_DONE;
//			printf("DONE\n");
		}
	}
}

void Item::render(float dt, float offsetX, float offsetY)
{
	if (state == ITEM_STATE_MOVE)
	{
		//sprite->setActive(true);
		sprite->render(mX, mY, angle, sx, sy);
		//sprite->setActive(false);
//		printf("render mX = %f, mY = %f\n", mX, mY);
	}
	else
	{
		sprite->render(offsetX, offsetY, angle, sx, sy);
	}
//	if (bHint)
//	{
//		Canvas2D* canvas = Canvas2D::getInstance();
//		canvas->enableColorPointer(true);
//		hintImage->SetColor(1, 1, 1, 0.5f);
//		canvas->drawImage(hintImage, _posX - 30, _posY - 48, 0, 1, 1); //NEEDFIX: don't use the const code
//		canvas->enableColorPointer(false);
//	}
	
//	if (flagShowHint)
//	if (GetLevelMode() < 2)
//	{
//		sPlayer->render(getX() - 40, 
//						getY() - 54, 
//						1.0f, 1.0f, 1.0f, 0.5f, 
//						0.0f, 0.5f, 0.5f);
//		
//		Canvas2D* canvas = Canvas2D::getInstance();
//		if (sPlayer->isActive())
//		{
//			sPlayer->mFrames[sPlayer->getCurrentFrameIndex()].mImage->SetColor(1.0f, 1.0f, 1.0f, 0.5f);
//			printf("%d\n", sPlayer->getCurrentFrameIndex());
//			canvas->enableColorPointer(true);
////			canvas->drawImage(sPlayer->mFrames[sPlayer->getCurrentFrameIndex()].mImage, sPlayer->getX() + mFrames[sPlayer->getCurrentFrameIndex()].xOffset, sPlayer->getY() + mFrames[sPlayer->getCurrentFrameIndex()].yOffset);
//			canvas->drawImage(sPlayer->mFrames[sPlayer->getCurrentFrameIndex()].mImage, 
//							  getX() + mFrames[sPlayer->getCurrentFrameIndex()].xOffset - 40, 
//							  getY() + mFrames[sPlayer->getCurrentFrameIndex()].yOffset - 56, 
//							  0.0f, 0.5f, 0.5f);
//			canvas->enableColorPointer(false);
//		}
//	}
}

void Item::moveTo(float stx, float sty, float dx, float dy)
{
	state = ITEM_STATE_MOVE;
	mX = startX = stx + cameraX;
	mY = startY = sty + cameraY;
	destX = dx;
	destY = dy;
	
	vX = (destX - startX) / 10.0f;
	vY = (destY - startY) / 10.0f;
	
//	printf("sx = %f, sy = %f; dx = %f, dy = %f;  mx = %f, my = %f; vX = %f, vY = %f\n", stx, sty, dx, dy, mX, mY, vX, vY);
//	mX = dx + 50;
//	mY = dy;
}

bool Item::moveDone()
{
	return (state == ITEM_STATE_MOVE_DONE);
}
