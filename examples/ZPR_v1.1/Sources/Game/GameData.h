//
//  GameData.m
//  MonkeyKick
//
//  Created by futao.huang on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef __GAME_DATA__
#define __GAME_DATA__

#import "GameSection.h"

#define STAGE_SECTION_V002		4
#define STAGE_LEVEL_V002		12
#define TOTAL_STAGE_V002		(STAGE_SECTION_V002*STAGE_LEVEL_V002)

#define STAGE_SECTION_V001		3
#define STAGE_LEVEL_V001		8
#define TOTAL_STAGE_V001		(STAGE_SECTION_V001*STAGE_LEVEL_V001)

#define STAGE_SECTION		STAGE_SECTION_V002
#define STAGE_LEVEL			STAGE_LEVEL_V002
#define TOTAL_STAGE			(STAGE_SECTION*STAGE_LEVEL)


void SaveFile();
bool LoadFile();
void ResetData();

int  getDownVersion();
void setDownVersion(int v);

#endif  //__GAME_DATA__

