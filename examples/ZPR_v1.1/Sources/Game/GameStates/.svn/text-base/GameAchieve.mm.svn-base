//
//  GameAchieve.mm
//  ZPR
//
//  Created by Chris Xia on 11-6-23.
//  Updated by Neo01 on 11-9-1.
//  Copyright 2011 Break Media. All rights reserved.
//

#import "GameAchieve.h"
#import "GameAudio.h"
#import "GamePlay.h"
#import "GameRes.h"
#import "GameState.h"
#import "Image.h"
#import "Sprite.h"
#import "Canvas2D.h"

#import "Stage.h"
#import "Runner.h"
#import "neoRes.h"

#import "ZPRAppDelegate.h"

#import "OpenFeint/OpenFeint.h"
#import "OpenFeint/OFTimeStamp.h"
#import "OpenFeint/OFHighScoreService.h"
#import "OpenFeint/OFAnnouncement.h"
#import "OpenFeint/OFAchievementService.h"
#import "OpenFeint/OFAchievement.h"
#import "OpenFeint/OFLeaderboard.h"
#import "OpenFeint/OFLeaderboardService.h"
#import "OpenFeint/OFHighScoreService.h"
#import "OpenFeint/OpenFeint+Dashboard.h"
#import "GameSection.h"
#import "GameLevel.h"
#import "GameHouse.h"
#import <string>

#import "GameOption.h"

#import "Runner.h"

int PassTime = 0;

Image* mSliderbar;
Image* mSlider;

const char* leaderboardIdOf[LEADERBOARD_MAX] = 
{
	"917667",	// Level 1-1
	"917677",	// Level 1-2
	"917687",	// Level 1-3
	"917697",	// Level 1-4
	"917707",	// Level 1-5
	"917717",	// Level 1-6
	"917727",	// Level 1-7
	"917737",	// Level 1-8
	
	"917747",	// Level 2-1
	"917757",	// Level 2-2
	"917767",	// Level 2-3
	"917777",	// Level 2-4
	"917787",	// Level 2-5
	"917797",	// Level 2-6
	"917807",	// Level 2-7
	"917817",	// Level 2-8
	
	"917827",	// Level 3-1
	"917837",	// Level 3-2
	"917847",	// Level 3-3
	"917857",	// Level 3-4
	"917867",	// Level 3-5
	"917877",	// Level 3-6
	"917887",	// Level 3-7
	"917897",	// Level 3-8
#ifdef V_1_1_0
    "1002876",	// Level 4-1
	"1002886",	// Level 4-2
	"1002896",	// Level 4-3
	"1002906",	// Level 4-4
	"1002916",	// Level 4-5
	"1002926",	// Level 4-6
	"1002936",	// Level 4-7
	"1002946",	// Level 4-8
    "1002956",	// Level 4-9
	"1002966",	// Level 4-10
	"1002976",	// Level 4-11
	"1002986",	// Level 4-12
#endif
	"917907",	// City Center Area
	"917917",	// Construction Area
	"917927",	// Amusement Park Area
    
	"917937",	// All Levels
};

const char* achievementIdOf[ACHIEVEMENT_MAX] = 
{
	"1199522",	// Footloose and Fancy Free
	"1199532",	// At Least There're No Traffic
	"1199542",	// Shoddy Workmanship
	"1199562",	// Out of Cotton Candy
	"1199572",	// Plural Possesive
	"1199602",	// Zom-beatings
	"1199632",	// Cha-Ching!
	"1199642",	// Park Your Parkour Here
	"1199662",	// My Blisters Have Blisters
	"1199672",	// In The Zone
	"1199682",	// Might Want to Seek Counseling
	"1199692",	// Hi, Score!
	"1199702",	// Hoarder!
	"1199712",	// Seeing Stars
		
	"1222662",	// Ryan's Umbrella
	"1222692",	// Ceiling Lamp
	"1222702",	// Skateboard
	"1222712",	// Clay Bowl
	"1222722",	// Fred the Flower
	"1222732",	// Nightstand
	"1222742",	// Silly Fish
	"1222752",	// Globe
	
	"1222762",	// Clock
	"1222772",	// Fuzzy Rug
	"1222782",	// Ryan's Suitcase
	"1222792",	// Coffee Maker
	"1222802",	// Old Sofa
	"1222812",	// TV
	"1222822",	// Coat Hook
	"1249912",	// Cuddly Kitty
	
	"1222832",	// Anime Robot
	"1222842",	// Bookcase
	"1222852",	// Kara's Library
	"1222862",	// Stuffed Bird
	"1222872",	// Typewriter
	"1222882",	// Pillow
	"1222892",	// Wine
	"1222902",	// Ryan's Photo
#ifdef V_1_1_0
    "1368502",  // Coat
    "1368512",  // Wall Mirror
    "1368522",  // Band Poster
    "1368532",  // Skull Pillow
    "1368542",  // Bed
    "1368552",  // Bedside Table
    "1368562",  // Comb
    "1368572",  // Bedspread
    "1368582",  // Teddy Bear
    "1368592",  // Backpack
    "1368602",  // Shoes
    "1368612",  // Birthday Card
    
    "1368632",  // Complete Oldtown
#endif
	"1222912",	// Master Runner
};

#ifdef ENABLE_GAMECENTER
const char* leaderboardIdGc[LEADERBOARD_MAX] = 
{
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	"10001",
	
	"10001",
	"10001",
	"10001",
	"10001",
};

const char* achievementIdGc[ACHIEVEMENT_MAX] = 
{
	"100",	// Footloose and Fancy Free
	"100",	// At Least There're No Traffic
	"100",	// Shoddy Workmanship
	"100",	// Out of Cotton Candy
	"100",	// Plural Possesive
	"100",	// Zom-beatings
	"100",	// Cha-Ching!
	"100",	// Park Your Parkour Here
	"100",	// My Blisters Have Blisters
	"100",	// In The Zone
	"100",	// Might Want to Seek Counseling
	"100",	// Hi, Score!
	"100",	// Hoarder!
	"100",	// Seeing Stars
	
	"100",
	"100",
	"100",
	"100",
	"100",
	"100",
	"100",
	"100",
	
	"100",
	"100",
	"100",
	"100",
	"100",
	"100",
	"100",
	"100",
	
	"100",
	"100",
	"100",
	"100",
	"100",
	"100",
	"100",
	"100",
	
	"100",
};
#endif

bool mLevelCLear[LEVEL_NUM_MAX][STAGE_IN_LV_MAX] = {
	{false,false,false,false,false,false,false,false,false,false,false,false},
	{false,false,false,false,false,false,false,false,false,false,false,false},
	{false,false,false,false,false,false,false,false,false,false,false,false},
#ifdef V_1_1_0
    {false,false,false,false,false,false,false,false,false,false,false,false}
#endif
	
};

int nCoinsInCurrentLevel = 0;

float achievementsProgress[ACHIEVEMENT_MAX] = {0.0f};
bool  retryReportting[ACHIEVEMENT_MAX] = {false};

bool m_isPerfect;
//bool m_isCaughtByZombie;
//int m_nClearLevel = 0;
//int m_nCollect = 0;
int m_nCoinCollection = 0;
int m_nKillZomies = 0;
int m_nPassObstacles = 0;
float m_nMeters = 0;
float m_nComboTime = 0.0f;
int m_nComboCount = 0;
int m_nScore = 0;

int ParkourStatistics[ACH_STA_MAX] = 
{
	0, 0, 0, 0, 0, 
	0, 0, 0, 0, ACH_COLLECT_NONE, 
	0, 0
};
int ParkourStatisticsAfterCp[ACH_STA_MAX] = 
{
	0, 0, 0, 0, 0, 
	0, 0, 0, 0, ACH_COLLECT_NONE, 
	0, 0
};

int retryCycle = 0;


#pragma mark -
#pragma mark Launching Game Center
void LaunchGameCenterLeaderboards()
{
    GKLeaderboardViewController *leaderboards = [[GKLeaderboardViewController alloc] init];
    if (leaderboards != nil)
    {
        leaderboards.leaderboardDelegate = app;
        [app.viewController presentModalViewController:leaderboards animated:YES];
    }
	[leaderboards release];
}

void LaunchGameCenterAchievements()
{
	GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
    if (achievements != nil)
    {
        achievements.achievementDelegate = app;
        [app.viewController presentModalViewController:achievements animated:YES];
    }
    [achievements release];
}

#pragma mark -
#pragma mark Launching OpenFeint

void LaunchOpenFeint()
{
	[OpenFeint launchDashboard];
//	[OpenFeint launchDashboardWithListLeaderboardsPage];
//	[OpenFeint launchDashboardWithAchievementsPage];
//	[OFHighScoreService setHighScore:30 forLeaderboard:@"808146" onSuccess:OFDelegate() onFailure:OFDelegate()];
//	[[OFAchievement achievement: @"1068542"] updateProgressionComplete: 100 andShowNotification: YES];
}

#pragma mark -
#pragma mark Reporting Achievements

void submitAchievement(int target, const char* str, float progress, bool showNotification)
{
	BOOL doShowNotification = showNotification ? YES : NO;
	NSString *identifier = [[NSString alloc] initWithUTF8String:str];
	
	if (target == TARGET_OPENFEINT)
	{
		[[OFAchievement achievement:identifier] updateProgressionComplete:progress andShowNotification:doShowNotification];
	}
	else
	{
		[app reportAchievementIdentifier:identifier percentComplete:progress];
	}
	
	[identifier release];
}

void setAchievement(int index, float progress, bool showNotification)
{
	float currentProgress = achievementsProgress[index];
	if (progress == 0.0f) 
	{
		return;
	}
	if (currentProgress < 100.0f && 
		currentProgress < progress)
	{
///		achievementsProgress[index] = progress; // always doing uploading
#ifdef ENABLE_OPENFEINT
		submitAchievement(TARGET_OPENFEINT, achievementIdOf[index], progress, showNotification);
#endif
#ifdef ENABLE_GAMECENTER
		submitAchievement(TARGET_GAMECENTER, achievementIdGc[index], progress, showNotification);
#endif
	}
	// Game Center available
	// Retry reporting achievements if the previous reporting was a failure.
	for (int i = 0; i < ACHIEVEMENT_MAX; i++)
	{
		if (retryReportting[i])
		{
#ifdef ENABLE_OPENFEINT
			submitAchievement(TARGET_OPENFEINT, achievementIdOf[i]);
#endif
#ifdef ENABLE_GAMECENTER
			submitAchievement(TARGET_GAMECENTER, achievementIdGc[i]);
#endif
		}
	}
}

#pragma mark -
#pragma mark Submitting Scores

void submitScore(int target, const char* str, int score)
{
	NSString *identifier = [[NSString alloc] initWithUTF8String:str];
	
	if (target == TARGET_OPENFEINT)
	{
		[app ofSubmitScore:identifier withScore:score];
	}
	else
	{
		[app reportScore:(int64_t)score forCategory:identifier];
	}
	
	[identifier release];
}

void setScore(int index, int score)
{
#if DEBUG
	printf("set score [%d] = %d\n", index, score);
#endif
#ifdef ENABLE_OPENFEINT
	submitScore(TARGET_OPENFEINT, leaderboardIdOf[index], score);
#endif
#ifdef ENABLE_GAMECENTER
	submitScore(TARGET_GAMECENTER, leaderboardIdOf[index], score);
#endif
}

#pragma mark -
#pragma mark Checking Achievements

void AchGotPerfectLevel()				// 1
{
	if (mLevelStar[LevelIndex][ActiveLevel] == 3)
	{
		setAchievement(ACHIEVEMENT_CLEAR_A_LEVEL_3_STARS);
	}
}

void AchClearLevel(int levelIndex, int subIndex)	// 2, 3, 4
{
	int levelCount = 0;
	
	mLevelCLear[levelIndex][subIndex] = true;

	for (int i = 0; i < LEVEL_NUM_MAX; i++)
	{
		levelCount = 0;
		
		for (int j = 0; j < STAGE_IN_LV_MAX; j++)
		{
			if (mLevelCLear[i][j])
			{
				++levelCount;
			}
		}
		nLevelCleared[i] = levelCount;
		
		if(i<STAGE_SECTION_V001) {
			levelCount = 4;
		}else {
			levelCount = 0;
		}
		
		if (nLevelCleared[i] +levelCount == STAGE_IN_LV_MAX)
		{
            if (i == 3)
            {
                setAchievement(ACHIEVEMENT_MAX - 2);
            }
            else
            {
                setAchievement(ACHIEVEMENT_CLEAR_LEVEL_CITY+i);
            }
		}
	}
	
	levelAverageStars[LevelIndex] = 0;
	for (int i = 0; i < 8; i++)
	{
		levelAverageStars[LevelIndex] += mLevelStar[LevelIndex][i];
	}
	if (nLevelCleared[LevelIndex] > 0)
	{
		levelAverageStars[LevelIndex] /= nLevelCleared[LevelIndex];
	}
#if DEBUG
	printf("Level %d, Average stars: %d\n", LevelIndex, levelAverageStars[LevelIndex]);
#endif
}

#pragma mark Zombie
void AchKillZombieReset()
{
	ParkourStatistics[ACH_STA_ZOMBIE_DEF] = 0;
#ifdef DEBUG
	printf("Reset the num of killed zombie. Total count: %d\n", m_nKillZomies);
#endif
}

void AchKillZombie()					// 6, 11
{
	ParkourStatistics[ACH_STA_ZOMBIE_DEF]++;
#ifdef DEBUG
	printf("Kill a zombie. Current count %d, Total count: %d\n", ParkourStatistics[ACH_STA_ZOMBIE_DEF], m_nKillZomies);
#endif
}

void AchKillZombieCheck()
{
	m_nKillZomies += ParkourStatistics[ACH_STA_ZOMBIE_DEF];
#ifdef ACHIEVEMENT_PROGRESS_DETAIL
	if (m_nKillZomies > 0)
	{
		if (m_nKillZomies < ACHIEVEMENT_ZOMBIE_THRESHOLD_1)
		{
			setAchievement(ACHIEVEMENT_KILLED_100_ZOMBIES, ((float)m_nKillZomies / (float)ACHIEVEMENT_ZOMBIE_THRESHOLD_1 * 100.0f));
		}
		else
		{
			setAchievement(ACHIEVEMENT_KILLED_100_ZOMBIES, 100.0f);
		}
		
		if (m_nKillZomies <= ACHIEVEMENT_ZOMBIE_THRESHOLD_1)
		{
			setAchievement(ACHIEVEMENT_KILLED_500_ZOMBIES, ((float)m_nKillZomies / (float)ACHIEVEMENT_ZOMBIE_THRESHOLD_2 * 100.0f), false);
		}
		else if (m_nKillZomies > ACHIEVEMENT_ZOMBIE_THRESHOLD_1 && 
				 m_nKillZomies < ACHIEVEMENT_ZOMBIE_THRESHOLD_2)
		{
			setAchievement(ACHIEVEMENT_KILLED_500_ZOMBIES, ((float)m_nKillZomies / (float)ACHIEVEMENT_ZOMBIE_THRESHOLD_2 * 100.0f));
		}
		else
		{
			setAchievement(ACHIEVEMENT_KILLED_500_ZOMBIES, 100.0f);
		}
#ifdef DEBUG
		printf("Check the num of killed zombie: %d\n", m_nKillZomies);
#endif
	}
#else
	if (m_nKillZomies > 0)
	{
		if (m_nKillZomies >= ACHIEVEMENT_ZOMBIE_THRESHOLD_1 && m_nKillZomies < ACHIEVEMENT_ZOMBIE_THRESHOLD_2)
		{
			setAchievement(ACHIEVEMENT_KILLED_100_ZOMBIES);
		}
		else if (m_nKillZomies >= ACHIEVEMENT_ZOMBIE_THRESHOLD_2)
		{
			setAchievement(ACHIEVEMENT_KILLED_500_ZOMBIES);
		}
#ifdef DEBUG
		printf("Check the num of killed zombie: %d\n", m_nKillZomies);
#endif
	}
#endif
}

#pragma mark Coin
void AchCollectCoinReset()
{
	ParkourStatistics[ACH_STA_COIN] = 0;
#ifdef DEBUG
	printf("Reset the num of coins. Total count: %d\n", m_nCoinCollection);
#endif
}

void AchCollectCoin()					// 7
{
	ParkourStatistics[ACH_STA_COIN]++;
#ifdef DEBUG
	printf("Get a coin. Current count %d, Total count: %d\n", ParkourStatistics[ACH_STA_COIN], m_nCoinCollection);
#endif
}

void AchCollectCoinCheck()
{
	m_nCoinCollection += ParkourStatistics[ACH_STA_COIN];
#ifdef ACHIEVEMENT_PROGRESS_DETAIL
	if (m_nCoinCollection > 0)
	{
		if (m_nCoinCollection < ACHIEVEMENT_COIN_THRESHOLD)
		{
			setAchievement(ACHIEVEMENT_COLLECTED_100_COINS, ((float)m_nCoinCollection / (float)ACHIEVEMENT_COIN_THRESHOLD * 100.0f));
		}
		else
		{
			setAchievement(ACHIEVEMENT_COLLECTED_100_COINS, 100.0f);
		}
#ifdef DEBUG
		printf("Check the num of coins: %d\n", m_nCoinCollection);
#endif
	}
#else
	if (m_nCoinCollection > 0)
	{
		if (m_nCoinCollection >= ACHIEVEMENT_COIN_THRESHOLD)
		{
			setAchievement(ACHIEVEMENT_COLLECTED_100_COINS);
		}
#ifdef DEBUG
		printf("Check the num of coins: %d\n", m_nCoinCollection);
#endif
	}
#endif
}

#pragma mark Obstacles
void AchPassObstacleReset()				// 8
{
	ParkourStatistics[ACH_STA_OBSTACLE] = 0;
#ifdef DEBUG
	printf("Reset the num of passing obstacles. Total count: %d\n", m_nPassObstacles);
#endif
}

void AchPassObstacle()					// 8
{
	ParkourStatistics[ACH_STA_OBSTACLE]++;
#ifdef DEBUG
	printf("Pass an obstacle. Current count: %d, Total count: %d\n", ParkourStatistics[ACH_STA_OBSTACLE], m_nPassObstacles);
#endif
}

void AchPassObstacleCheck()				// 8
{
	m_nPassObstacles += ParkourStatistics[ACH_STA_OBSTACLE];
#ifdef ACHIEVEMENT_PROGRESS_DETAIL
	if (m_nPassObstacles > 0)
	{
		if (m_nCoinCollection < ACHIEVEMENT_OBSTACLE_THRESHOLD)
		{
			setAchievement(ACHIEVEMENT_PASSED_200_OBSTACLES, ((float)m_nPassObstacles / (float)ACHIEVEMENT_OBSTACLE_THRESHOLD * 100.0f));
		}
		else
		{
			setAchievement(ACHIEVEMENT_PASSED_200_OBSTACLES, 100.0f);
		}
#ifdef DEBUG
		printf("Check the num of passing obstacles: %d\n", m_nPassObstacles);
#endif
	}
#else
	if (m_nPassObstacles > 0)
	{
		if (m_nPassObstacles >= ACHIEVEMENT_OBSTACLE_THRESHOLD)
		{
			setAchievement(ACHIEVEMENT_PASSED_200_OBSTACLES);
		}
#ifdef DEBUG
		printf("Check the num of passing obstacles: %d\n", m_nPassObstacles);
#endif
	}
#endif
}

#pragma mark Distance
void AchRunDistanceReset()				// 9
{
	ParkourStatistics[ACH_STA_DISTANCE] = 0;
#ifdef DEBUG
	printf("Reset the distance. Total count: %f\n", m_nMeters);
#endif
}

void AchAddRunDistance(float distance)	// 9
{
	ParkourStatistics[ACH_STA_DISTANCE] += distance / 8.0f;
#ifdef DEBUG
//	printf("Distance Counting. Current count: %f m, Total count: %f m\n", ParkourStatistics[ACH_STA_DISTANCE], m_nMeters);
#endif
}

void AchRunDistanceCheck()				// 9
{
	m_nMeters += ParkourStatistics[ACH_STA_DISTANCE];
#ifdef ACHIEVEMENT_PROGRESS_DETAIL
	if (m_nMeters > 0.0f)
	{
		if (m_nMeters < ACHIEVEMENT_DISTANCE_THRESHOLD)
		{
			setAchievement(ACHIEVEMENT_RUN_100000M, (m_nMeters / ACHIEVEMENT_DISTANCE_THRESHOLD * 100.0f));
		}
		else
		{
			setAchievement(ACHIEVEMENT_RUN_100000M, 100.0f);
		}
#ifdef DEBUG
		printf("Check the distance: %f\n", m_nMeters);
#endif
	}
#else
	if (m_nMeters > 0.0f)
	{
		if (m_nMeters >= ACHIEVEMENT_DISTANCE_THRESHOLD)
		{
			setAchievement(ACHIEVEMENT_RUN_100000M);
		}
#ifdef DEBUG
		printf("Check the distance: %f\n", m_nMeters);
#endif
	}
#endif
}

#pragma mark Combo
void AchComboCountReset()						// 10
{
	ParkourStatistics[ACH_STA_COMBO] = 0;
	AchAddComboCountTime(0.0f, true);//m_nComboTime = 0.0f;
	m_nComboCount = 0;
	ParkourStatistics[ACH_STA_KASHVAULT] = 
	ParkourStatistics[ACH_STA_ZIPLINE] = 
	ParkourStatistics[ACH_STA_WALLRUN] = 
	ParkourStatistics[ACH_STA_SLIDE] = 
	ParkourStatistics[ACH_STA_SWING] = 
	ParkourStatistics[ACH_STA_MONKEYBAR] = 0;
#ifdef DEBUG
	printf("Reset the num of parkour actions and the combo count. Total count: %d\n", m_nPassObstacles);
#endif
}

void AchAddComboCount(bool doReset)					// 10
{
	if (doReset)
	{
		if (ParkourStatistics[ACH_STA_COMBO] > m_nComboCount)
		{
			m_nComboCount = ParkourStatistics[ACH_STA_COMBO];
		}
	}
	else
	{
		++ParkourStatistics[ACH_STA_COMBO];
	}
}

void AchAddComboCountTime(float dt, bool doReset)	// 10
{
	static bool isSumbit = false;
	if (doReset)
	{
		m_nComboTime = 0.0f;
		isSumbit = false;
		return;
	}
	
	m_nComboTime += dt;
	if (!isSumbit && m_nComboTime >= ACHIEVEMENT_COMBO_TIME_THRESHOLD)
	{
		isSumbit = true;
		setAchievement(ACHIEVEMENT_MAINTAINED_COMBO_FOR_1M);
	}
}

void AchComboCountCheck()						// 10
{
	if (m_nComboTime >= ACHIEVEMENT_COMBO_TIME_THRESHOLD)
	{
		setAchievement(ACHIEVEMENT_MAINTAINED_COMBO_FOR_1M);
	}
}

void AchAddActionByType(int type)				// 10
{
	switch (type) {
		case ACH_STA_KASHVAULT:
			ParkourStatistics[ACH_STA_KASHVAULT]++;
			break;
		case ACH_STA_ZIPLINE:
			ParkourStatistics[ACH_STA_ZIPLINE]++;
			break;
		case ACH_STA_WALLRUN:
			ParkourStatistics[ACH_STA_WALLRUN]++;
			break;
		case ACH_STA_SLIDE:
			ParkourStatistics[ACH_STA_SLIDE]++;
			break;
		case ACH_STA_SWING:
			ParkourStatistics[ACH_STA_SWING]++;
			break;
		case ACH_STA_MONKEYBAR:
			ParkourStatistics[ACH_STA_MONKEYBAR]++;
			break;
		default:
			break;
	}
}

#pragma mark Hi-score
//void AchCurrentScore(int score)		// 12
//{
//	m_nScore = score;
//}

void AchHighScoreCheck()			// 12
{
	for (int i = 0; i < LEVEL_NUM_MAX; i++)
	{
		levelTotalScore[i] = 0;
#if DEBUG
		printf("Level %d: ", i);
#endif
		for (int j = 0; j < STAGE_IN_LV_MAX; j++)
		{
			levelTotalScore[i] += levelStageScore[i][j];
#if DEBUG
			printf("%d, ", levelStageScore[i][j]);
#endif
		}
#if DEBUG
		printf("\nTotal Score: %d\n", levelTotalScore[i]);
#endif
		if (levelTotalScore[i] >= ACHIEVEMENT_HI_SCORE_THRESHOLD)
		{
			setAchievement(ACHIEVEMENT_30000_IN_ONE_STAGE);
		}
	}
}

#pragma mark Stars
void AchCheckStars()				// 14
{
	int count = 0;
	for (int i = 0; i < 3; i++)
	{
		for (int j = 0; j < 8; j++)
		{
			if (mLevelStar[i][j] == 3)
			{
				++count;
			}
		}
	}
#ifdef ACHIEVEMENT_PROGRESS_DETAIL
	if (count > 0)
	{
		setAchievement(ACHIEVEMENT_3STARS_ON_ALL_STAGES, ((float)count / 24.0f * 100.0f));
	}
#else
	if (count >= 24)
	{
		setAchievement(ACHIEVEMENT_3STARS_ON_ALL_STAGES);
	}
#endif
}

#pragma mark Items
void AchGetItemBack(int itemId)
{
	ParkourStatistics[ACH_STA_ITEM] = itemId;
}

void AchGetItemBackCheck()
{
	int index = ParkourStatistics[ACH_STA_ITEM];
	if (index == ACH_COLLECT_NONE)
	{
		return;
	}
	
    if (index==24) 
    {
        return;
    }
	
	if (index>24) 
    {
        index -=1;
    }
	
	mObjFlag[index] = true;
	
	// save the achievement
	setAchievement(ACHIEVEMENT_15 + index);	// it may submit the same achievement for many times
}

void AchCollectItem()		// 5, 13
{
	int itemCount = 0;
	for (int i = 0; i < 24; i++)
	{
		if (mObjFlag[i])
		{
			++itemCount;
		}
	}
#ifdef ACHIEVEMENT_PROGRESS_DETAIL
	if (itemCount > 0 && itemCount <= 12)
	{
		setAchievement(ACHIEVEMENT_COLLECTED_12_ITEMS, (itemCount / 12.0f * 100.0f));
	}
	if (itemCount > 12 && itemCount <= 24)
	{
		setAchievement(ACHIEVEMENT_COLLECTED_24_ITEMS, (itemCount / 24.0f * 100.0f));
	}
#else
	if (itemCount >= 12 && itemCount < 24)
	{
		setAchievement(ACHIEVEMENT_COLLECTED_12_ITEMS);
	}
	else if (itemCount >= 24)
	{
		setAchievement(ACHIEVEMENT_COLLECTED_24_ITEMS);
	}
#endif
}

#pragma mark Runner Mode
void AchEndWithRunnerModeCheck()			// 39
{
	if (isRunnerMode())
	{
		setAchievement(ACHIEVEMENT_39);
	}
}

#pragma mark -
#pragma mark Reset Data

void ResetTempAchievements()
{
	ParkourStatistics[ACH_STA_ITEM] = ACH_COLLECT_NONE;
	AchKillZombieReset();
	AchCollectCoinReset();
	AchPassObstacleReset();
	AchRunDistanceReset();
	AchComboCountReset();
	
	resetTempStatistics();
}

void resetTempStatistics()
{
	for (int i = 0; i < ACH_STA_MAX; i++)
	{
		ParkourStatisticsAfterCp[i] = 0;
	}
	ParkourStatisticsAfterCp[ACH_STA_ITEM] = ACH_COLLECT_NONE;
}

void saveTempStatistics()
{
#if 0//DEBUG
	printf("Save Current Statistics\n");
#endif
	for (int i = 0; i < ACH_STA_MAX; i++)
	{
		ParkourStatisticsAfterCp[i] = ParkourStatistics[i];
#if 0//DEBUG
		printf("%d\t%d\n", i, ParkourStatisticsAfterCp[i]);
#endif
	}
	m_nScore = mGetScore;
#if 0//DEBUG
	printf("score: %d\n", m_nScore);
	printf("\n");
#endif
}

void restorePreviousStatistics()
{
	int i;
	int temp[ACH_STA_MAX+1];
	
#if 0//DEBUG
	printf("Restore Previous Statistics(except item)\n");
#endif
	for (i = 0; i < ACH_STA_MAX; i++)
	{
		temp[i] = ParkourStatistics[i] - ParkourStatisticsAfterCp[i];
#if 0//DEBUG
		printf("%d\t%d\t%d\n", i, ParkourStatisticsAfterCp[i], temp[i]);
#endif
	}
	temp[ACH_STA_ITEM] = ParkourStatisticsAfterCp[ACH_STA_ITEM];
	temp[ACH_STA_MAX] = (mGetScore - m_nScore);
#if 0//DEBUG
	printf("*%d\t%d\t%d\n", ACH_STA_ITEM, ParkourStatistics[ACH_STA_ITEM], temp[ACH_STA_ITEM]);
	printf("score: %d, %d\n", m_nScore, temp[ACH_STA_MAX]);
	printf("\n");
#endif
	
	for (i = 0; i < ACH_STA_MAX; i++)
	{
		ParkourStatistics[i] -= temp[i];
#if 0//DEBUG
		printf("%d\t%d\t%d\n", i, ParkourStatistics[i], temp[i]);
#endif
	}
	ParkourStatistics[ACH_STA_ITEM] = temp[ACH_STA_ITEM];
	mGetScore -= temp[ACH_STA_MAX];
#if 0//DEBUG
	printf("*%d\t%d\t%d\n", ACH_STA_ITEM, ParkourStatistics[ACH_STA_ITEM], temp[ACH_STA_ITEM]);
	printf("score: %d, %d\n", mGetScore, temp[ACH_STA_MAX]);
	printf("\n");
#endif
}

//void CheckAchievements()
//{
//	CheckAchievementPerfect();
//	CheckAchievementCaught();
//	CheckAchievementClear();
//	CheckAchievementCollect();
//	CheckAchievementKillZombies();
//	CheckAchievementCollectCoin();
//	CheckAchievementPassObstacles();
//	CheckAchievementMeters();
//	CheckAchievementCombo();
//	CheckAchievementScore();
//	CheckAchievementStar();
//}
