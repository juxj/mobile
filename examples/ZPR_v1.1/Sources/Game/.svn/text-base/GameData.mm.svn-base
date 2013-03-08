//
//  GameData.m
//  MonkeyKick
//
//  Created by futao.huang on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameData.h"
#import "Runner.h"

#import "GameState.h"
#import "GameSection.h"
#import "GameLevel.h"
#import "GameHouse.h"
#import "GameOption.h"
#import "GameAchieve.h"
#import "GameNews.h"


static float dataVersion = 0.02f;
#ifdef V_FREE
static int downloadVersion = 0;
#else
static int downloadVersion = 0;
#endif


void ReadRecordV001() 
{
	NSAutoreleasePool *_pool = [[NSAutoreleasePool alloc] init];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *documentPath = [documentsDirectory 
							  stringByAppendingPathComponent:@"file.dat"];
	
	NSMutableData *data = [NSData dataWithContentsOfFile:documentPath];
	
	if (!data) {
		[_pool release];
		//return false;
	} 
	
	NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data]; 
	
	/*float version = */[decoder decodeFloatForKey:@"version"];
	m_bSounds = [decoder decodeBoolForKey:@"sound"];
	m_bBgm = [decoder decodeBoolForKey:@"volume"];
	m_nCoinCollection = [decoder decodeIntForKey:@"nCoins"];
	m_nKillZomies = [decoder decodeIntForKey:@"nZombie"];
	m_nPassObstacles = [decoder decodeIntForKey:@"nPassObstacles"];
	m_nMeters = [decoder decodeFloatForKey:@"nMeters"];
	newsNoti = [decoder decodeIntForKey:@"newsNoti"];
	
	for(int i=0; i<TOTAL_STAGE_V001; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"flag:%d", i, nil];
		mObjFlag[i] = [decoder decodeIntForKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE_V001; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"lock:%d", i, nil];
		mLevelLock[i/STAGE_LEVEL_V001][i%STAGE_LEVEL_V001] = [decoder decodeBoolForKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE_V001; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"star:%d", i, nil];
		mLevelStar[i/STAGE_LEVEL_V001][i%STAGE_LEVEL_V001] = [decoder decodeIntForKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE_V001; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"score:%d", i, nil];
		levelStageScore[i/STAGE_LEVEL_V001][i%STAGE_LEVEL_V001] = [decoder decodeIntForKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE_V001; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"levelsCleared:%d", i, nil];
		mLevelCLear[i/STAGE_LEVEL_V001][i%STAGE_LEVEL_V001] = [decoder decodeBoolForKey:tmpString];
	}
	
	for (int i=0; i<STAGE_SECTION_V001; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"nLevelCleared:%d", i, nil];
		nLevelCleared[i] = [decoder decodeIntForKey:tmpString];
	}
	
	for (int i=0; i<STAGE_SECTION_V001; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"levelTotalScore:%d", i, nil];
		levelTotalScore[i] = [decoder decodeIntForKey:tmpString];
	}
	
	for (int i=0; i<STAGE_SECTION_V001; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"levelAverageStars:%d", i, nil];
		levelAverageStars[i] = [decoder decodeIntForKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE_V001; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"runnermode:%d", i, nil];
		mRunnerMode[i/STAGE_LEVEL_V001][i%STAGE_LEVEL_V001] = [decoder decodeBoolForKey:tmpString];
	}
	
	{
		NSString *tmpString = [NSString stringWithFormat:@"newsData"];
		NSUInteger retLength = 0;
		strcpy(newsData, (const char*)[decoder decodeBytesForKey:tmpString returnedLength:&retLength]);
#if DEBUG
		printf("Get news from local cache(%d): %s\n", retLength, newsData);
#endif
	}
	
	[decoder release];
	[_pool release];
	
	//return true;
}

void ReadRecordV002() 
{
	NSAutoreleasePool *_pool = [[NSAutoreleasePool alloc] init];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *documentPath = [documentsDirectory 
							  stringByAppendingPathComponent:@"file.dat"];
	
	NSMutableData *data = [NSData dataWithContentsOfFile:documentPath];
	
	if (!data) {
		[_pool release];
		//return false;
	} 
	
	NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data]; 
	
	/*float version = */[decoder decodeFloatForKey:@"version"];
	m_bSounds = [decoder decodeBoolForKey:@"sound"];
	m_bBgm = [decoder decodeBoolForKey:@"volume"];
	m_nCoinCollection = [decoder decodeIntForKey:@"nCoins"];
	m_nKillZomies = [decoder decodeIntForKey:@"nZombie"];
	m_nPassObstacles = [decoder decodeIntForKey:@"nPassObstacles"];
	m_nMeters = [decoder decodeFloatForKey:@"nMeters"];
	newsNoti = [decoder decodeIntForKey:@"newsNoti"];
	
	for(int i=0; i<MAX_ITEM; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"flag:%d", i, nil];
		mObjFlag[i] = [decoder decodeIntForKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE_V002; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"lock:%d", i, nil];
		mLevelLock[i/STAGE_LEVEL_V002][i%STAGE_LEVEL_V002] = [decoder decodeBoolForKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE_V002; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"star:%d", i, nil];
		mLevelStar[i/STAGE_LEVEL_V002][i%STAGE_LEVEL_V002] = [decoder decodeIntForKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE_V002; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"score:%d", i, nil];
		levelStageScore[i/STAGE_LEVEL_V002][i%STAGE_LEVEL_V002] = [decoder decodeIntForKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE_V002; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"levelsCleared:%d", i, nil];
		mLevelCLear[i/STAGE_LEVEL_V002][i%STAGE_LEVEL_V002] = [decoder decodeBoolForKey:tmpString];
	}
	
	for (int i=0; i<STAGE_SECTION_V002; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"nLevelCleared:%d", i, nil];
		nLevelCleared[i] = [decoder decodeIntForKey:tmpString];
	}
	
	for (int i=0; i<STAGE_SECTION_V002; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"levelTotalScore:%d", i, nil];
		levelTotalScore[i] = [decoder decodeIntForKey:tmpString];
	}
	
	for (int i=0; i<STAGE_SECTION_V002; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"levelAverageStars:%d", i, nil];
		levelAverageStars[i] = [decoder decodeIntForKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE_V002; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"runnermode:%d", i, nil];
		mRunnerMode[i/STAGE_LEVEL_V002][i%STAGE_LEVEL_V002] = [decoder decodeBoolForKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE_V002; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"playCount:%d", i, nil];
		mLevelPlayCount[i/STAGE_LEVEL_V002][i%STAGE_LEVEL_V002] = [decoder decodeIntForKey:tmpString];
	}
	
	{
		NSString *tmpString = [NSString stringWithFormat:@"newsData"];
		NSUInteger retLength = 0;
		strcpy(newsData, (const char*)[decoder decodeBytesForKey:tmpString returnedLength:&retLength]);
#if DEBUG
		printf("Get news from local cache(%d): %s\n", retLength, newsData);
#endif
	}
	
	{	
		downloadVersion = [decoder decodeIntForKey:@"downloadVersion"];
		availableLevels = [decoder decodeIntForKey:@"availableLevels"];
	}
	
	[decoder release];
	[_pool release];
	
	//return true;
}

void SaveFile()
{
	NSAutoreleasePool *_pool = [[NSAutoreleasePool alloc] init];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *documentPath = [documentsDirectory 
							  stringByAppendingPathComponent:@"file.dat"];
	
	NSMutableData *data = [NSMutableData data];
	NSKeyedArchiver *encoder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	
	[encoder encodeFloat:dataVersion forKey:@"version"];
	[encoder encodeBool:m_bSounds forKey:@"sound"];
	[encoder encodeBool:m_bBgm forKey:@"volume"];
	[encoder encodeInt:m_nCoinCollection forKey:@"nCoins"];
	[encoder encodeInt:m_nKillZomies forKey:@"nZombie"];
	[encoder encodeInt:m_nPassObstacles forKey:@"nPassObstacles"];
	[encoder encodeFloat:m_nMeters forKey:@"nMeters"];
	[encoder encodeInt:newsNoti forKey:@"newsNoti"];
	
	for(int i=0; i<MAX_ITEM; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"flag:%d", i, nil];
		[encoder encodeInt:mObjFlag[i] forKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"lock:%d", i, nil];
		[encoder encodeBool:mLevelLock[i/STAGE_LEVEL][i%STAGE_LEVEL] forKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"star:%d", i, nil];
		[encoder encodeInt:mLevelStar[i/STAGE_LEVEL][i%STAGE_LEVEL] forKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"score:%d", i, nil];
		[encoder encodeInt:levelStageScore[i/STAGE_LEVEL][i%STAGE_LEVEL] forKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"levelsCleared:%d", i, nil];
		[encoder encodeBool:mLevelCLear[i/STAGE_LEVEL][i%STAGE_LEVEL] forKey:tmpString];
	}
	
	for (int i=0; i<STAGE_SECTION; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"nLevelCleared:%d", i, nil];
		[encoder encodeInt:nLevelCleared[i] forKey:tmpString];
	}
	
	for (int i=0; i<STAGE_SECTION; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"levelTotalScore:%d", i, nil];
		[encoder encodeInt:levelTotalScore[i] forKey:tmpString];
	}
	
	for (int i=0; i<STAGE_SECTION; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"levelAverageStars:%d", i, nil];
		[encoder encodeInt:levelAverageStars[i] forKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"runnermode:%d", i, nil];
		[encoder encodeBool:mRunnerMode[i/STAGE_LEVEL][i%STAGE_LEVEL] forKey:tmpString];
	}
	
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		NSString *tmpString = [NSString stringWithFormat:@"playCount:%d", i, nil];
		[encoder encodeInt:mLevelPlayCount[i/STAGE_LEVEL][i%STAGE_LEVEL] forKey:tmpString];
	}
	
	{
		NSString *tmpString = [NSString stringWithFormat:@"newsData"];
		[encoder encodeBytes:(const uint8_t*)newsData length:sizeof(newsData) forKey:tmpString];
	}
	
	{
		[encoder encodeInt:downloadVersion forKey:@"downloadVersion"];
		[encoder encodeInt:availableLevels forKey:@"availableLevels"];
	}
	
	[encoder finishEncoding];
	[data writeToFile:documentPath atomically:YES];
	[encoder release];
	
	[_pool release];
}


bool LoadFile() 
{
	NSAutoreleasePool *_pool = [[NSAutoreleasePool alloc] init];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *documentPath = [documentsDirectory 
							  stringByAppendingPathComponent:@"file.dat"];
	
	NSMutableData *data = [NSData dataWithContentsOfFile:documentPath];
	
	if (!data) {
		[_pool release];
		return false;
	} 
	
	NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data]; 
	
	float version = [decoder decodeFloatForKey:@"version"];
    
	[decoder release];
	[_pool release];
    
	
    if (fabs(version-0.01f)<=0.00001f) {
        ReadRecordV001();
        //SaveFile();
    }
    else {
        ReadRecordV002();
	}
	
	mLevelLock[0][0] = false;
    mSectionLock[0] = false;
	for (int i = 1; i < STAGE_SECTION; i++)
	{
		mSectionLock[i] = true;
		for (int j = 0; j < STAGE_LEVEL; j++)
		{
			if (!mLevelLock[i][j]) {
				mSectionLock[i] = false;
			}
		}
	}

#if !(UNLOCKED_LEVEL)
	for (int i = 1; i < STAGE_SECTION_V001; i++)
	{
		if(nLevelCleared[i-1] < STAGE_LEVEL_V001 &&nLevelCleared[i] == 0){
			mSectionLock[i] = true;
		}
	}
#else
	for (int i = 1; i < STAGE_SECTION_V002; i++)
	{
		mSectionLock[i] = false;
	}
#endif
	
	return true;
}

void ResetData()
{
    m_nCoinCollection = 0;
    m_nKillZomies = 0;
    m_nPassObstacles = 0;
    m_nMeters = 0.0f;
    newsNoti = 0;
    
	for(int i=0; i<MAX_ITEM; i++)
	{
		mObjFlag[i] = false;
	}
	
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		mLevelLock[i/STAGE_LEVEL][i%STAGE_LEVEL] = true;  
	}
    
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		mLevelStar[i/STAGE_LEVEL][i%STAGE_LEVEL] = 0;
	}
	
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		levelStageScore[i/STAGE_LEVEL][i%STAGE_LEVEL] = 0;
	}
	
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		mLevelCLear[i/STAGE_LEVEL][i%STAGE_LEVEL] = false;
	}
	
	for (int i=0; i<STAGE_SECTION; i++)
	{
		nLevelCleared[i] = 0;
	}
	
	for (int i=0; i<STAGE_SECTION; i++)
	{
		levelTotalScore[i] = 0;
	}
	
	for (int i=0; i<STAGE_SECTION; i++)
	{
		levelAverageStars[i] = 0;
	}
	
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		mRunnerMode[i/STAGE_LEVEL][i%STAGE_LEVEL] = false;
	}
	
	for(int i=0; i<TOTAL_STAGE; i++)
	{
		mLevelPlayCount[i/STAGE_LEVEL][i%STAGE_LEVEL] = 0;
	}
	
	{
        //memset(newsData, '\0', sizeof(newsData));
	}
    
	mLevelLock[0][0] = false;
    mSectionLock[0] = false;
	for (int i = 1; i < STAGE_SECTION; i++)
	{
		mSectionLock[i] = true;
		for (int j = 0; j < STAGE_LEVEL; j++)
		{
			if (!mLevelLock[i][j]) {
				mSectionLock[i] = false;
			}
		}
	}
}

//#ifdef __DOWNLOAD_RES__
void setDownVersion(int v){
    downloadVersion = v;
}

int getDownVersion(){
    return downloadVersion;
}
//#endif
