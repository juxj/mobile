/*
 *  imgResData.h
 *  ZPR
 *
 *  Created by Neo01 on 10/11/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#ifndef __IMG_RES_DATA_H__
#define __IMG_RES_DATA_H__

#define TITLE_BG_TEX_ID		"title BG"
#define TITLE_BG_TEX_FILE	"levelbgsky.png"
#define BG_TEX_X		(IMG_RES_SCALE * 0.0f)
#define BG_TEX_Y		(IMG_RES_SCALE * 0.0f)
#define BG_TEX_W		(IMG_RES_SCALE * 480.0f)
#define BG_TEX_H		(IMG_RES_SCALE * 320.0f)
#define BG_TEX_OX		(IMG_RES_SCALE * 0.0f)
#define BG_TEX_OY		(IMG_RES_SCALE * 0.0f)

#define TITLE_BG2_TEX_ID	"titleBG2"
#define TITLE_BG2_TEX_FILE	"title2.png"
#ifdef  VERSION_IPAD
#define TITLE_TEX_X		0.0f
#define TITLE_TEX_Y		0.0f
#define TITLE_TEX_W		1024.0f
#define TITLE_TEX_H		768.0f
#define TITLE_TEX_OX	0.0f
#define TITLE_TEX_OY	0.0f
#else
#define TITLE_TEX_X		0.0f
#define TITLE_TEX_Y		0.0f
#define TITLE_TEX_W		480.0f
#define TITLE_TEX_H		320.0f
#define TITLE_TEX_OX	0.0f
#define TITLE_TEX_OY	0.0f
#endif
// Sprite: mStartGiant
//#define START_GIANT_FILE	"startGiant.xml"

// Sprite: mStartGiant2
//#define START_GIANT2_FILE	"startGiant2.xml"

// Image: mStartIcon
#define START_ICON_FILE		"starticon.xml"

#define START_NEWS_FILE		"news.png"
#define NEWS_TEX_X		(IMG_RES_SCALE * 0.0f)
#define NEWS_TEX_Y		(IMG_RES_SCALE * 89.0f)
#define NEWS_TEX_W		(IMG_RES_SCALE * 154.0f)
#define NEWS_TEX_H		(IMG_RES_SCALE * 34.0f)
#define NEWS_TEX_OX		(IMG_RES_SCALE * 0.0f)
#define NEWS_TEX_OY		(IMG_RES_SCALE * 0.0f)

//blackbgckground  
#define BLACK_BG_EDGE		(IMG_RES_SCALE * 32.0f)
#define BLACK_BG_WIDTH		(IMG_RES_SCALE * 30.0f)

//coin
#define COIN_TEX_X		    (IMG_RES_SCALE * 0.0f)
#define COIN_TEX_Y		    (IMG_RES_SCALE * 0.0f)
#define COIN_TEX_WIDTH		(IMG_RES_SCALE * 32.0f)

//Select
#define SELECT_TEX_X		(IMG_RES_SCALE * 0.0f)
#define SELECT_TEX_Y		(IMG_RES_SCALE * 322.0f)
#define SELECT_TEX_W		(IMG_RES_SCALE * 346.0f)
#define SELECT_TEX_H		(IMG_RES_SCALE * 166.0f)

//gclb
#define GCLB_TEX_X		(IMG_RES_SCALE * 0.0f)
#define GCLB_TEX_Y		(IMG_RES_SCALE * 0.0f)
#define GCLB_TEX_EDGE		(IMG_RES_SCALE * 32.0f)

// Story
#ifdef VERSION_IPAD
#define	STORY_TEX_X     0
#define	STORY_TEX_Y     0
#define	STORY_TEX_W     1024
#define	STORY_TEX_H     768
#define	STORY_TEX_OX    0
#define	STORY_TEX_OY    0
#else
#define	STORY_TEX_X     0
#define	STORY_TEX_Y     0
#define	STORY_TEX_W     480
#define	STORY_TEX_H     320
#define	STORY_TEX_OX    0
#define	STORY_TEX_OY    0
#endif

#endif
