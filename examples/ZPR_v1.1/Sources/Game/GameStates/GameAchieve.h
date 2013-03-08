//
//  GameAchieve.h
//  ZPR
//
//  Created by Chris Xia on 11-6-23.
//  Updated by Neo01 on 11-9-1.
//  Copyright 2011 Break Media. All rights reserved.
//

#define ENABLE_ACHIEVEMENTS

#define ENABLE_OPENFEINT
//#define ENABLE_GAMECENTER

//#define ACHIEVEMENT_PROGRESS_DETAIL

#define TARGET_OPENFEINT	0
#define TARGET_GAMECENTER	1

#define LEADERBOARD_LV1_1	(0)
#define LEADERBOARD_LV1_2	(1)
#define LEADERBOARD_LV1_3	(2)
#define LEADERBOARD_LV1_4	(3)
#define LEADERBOARD_LV1_5	(4)
#define LEADERBOARD_LV1_6	(5)
#define LEADERBOARD_LV1_7	(6)
#define LEADERBOARD_LV1_8	(7)

#define LEADERBOARD_LV2_1	(8)
#define LEADERBOARD_LV2_2	(9)
#define LEADERBOARD_LV2_3	(10)
#define LEADERBOARD_LV2_4	(11)
#define LEADERBOARD_LV2_5	(12)
#define LEADERBOARD_LV2_6	(13)
#define LEADERBOARD_LV2_7	(14)
#define LEADERBOARD_LV2_8	(15)

#define LEADERBOARD_LV3_1	(16)
#define LEADERBOARD_LV3_2	(17)
#define LEADERBOARD_LV3_3	(18)
#define LEADERBOARD_LV3_4	(19)
#define LEADERBOARD_LV3_5	(20)
#define LEADERBOARD_LV3_6	(21)
#define LEADERBOARD_LV3_7	(22)
#define LEADERBOARD_LV3_8	(23)

#ifdef V_1_1_0
#define LEADERBOARD_LV4_1	(24)
#define LEADERBOARD_LV4_2	(25)
#define LEADERBOARD_LV4_3	(26)
#define LEADERBOARD_LV4_4	(27)
#define LEADERBOARD_LV4_5	(28)
#define LEADERBOARD_LV4_6	(29)
#define LEADERBOARD_LV4_7	(30)
#define LEADERBOARD_LV4_8	(31)
#define LEADERBOARD_LV4_9	(32)
#define LEADERBOARD_LV4_10	(33)
#define LEADERBOARD_LV4_11	(34)
#define LEADERBOARD_LV4_12	(35)

#define LEADERBOARD_AREA1	(36)//(24)
#define LEADERBOARD_AREA2	(37)//(25)
#define LEADERBOARD_AREA3	(38)//(26)
#define LEADERBOARD_ALLAREA	(39)//(27)

#define LEADERBOARD_MAX		(28+12)//(28)
#else
#define LEADERBOARD_AREA1	(24)
#define LEADERBOARD_AREA2	(25)
#define LEADERBOARD_AREA3	(26)
#define LEADERBOARD_ALLAREA	(27)

#define LEADERBOARD_MAX		(28)
#endif


#define DEFAULT_PROGRESS	(100.0)

#define ACHIEVEMENT_1	(0)
#define ACHIEVEMENT_2	(1)
#define ACHIEVEMENT_3	(2)
#define ACHIEVEMENT_4	(3)
#define ACHIEVEMENT_5	(4)
#define ACHIEVEMENT_6	(5)
#define ACHIEVEMENT_7	(6)
#define ACHIEVEMENT_8	(7)
#define ACHIEVEMENT_9	(8)
#define ACHIEVEMENT_10	(9)
#define ACHIEVEMENT_11	(10)
#define ACHIEVEMENT_12	(11)
#define ACHIEVEMENT_13	(12)
#define ACHIEVEMENT_14	(13)

#define ACHIEVEMENT_15	(14)
#define ACHIEVEMENT_16	(15)
#define ACHIEVEMENT_17	(16)
#define ACHIEVEMENT_18	(17)
#define ACHIEVEMENT_19	(18)
#define ACHIEVEMENT_20	(19)
#define ACHIEVEMENT_21	(20)
#define ACHIEVEMENT_22	(21)

#define ACHIEVEMENT_23	(22)
#define ACHIEVEMENT_24	(23)
#define ACHIEVEMENT_25	(24)
#define ACHIEVEMENT_26	(25)
#define ACHIEVEMENT_27	(26)
#define ACHIEVEMENT_28	(27)
#define ACHIEVEMENT_29	(28)
#define ACHIEVEMENT_30	(29)

#define ACHIEVEMENT_31	(30)
#define ACHIEVEMENT_32	(31)
#define ACHIEVEMENT_33	(32)
#define ACHIEVEMENT_34	(33)
#define ACHIEVEMENT_35	(34)
#define ACHIEVEMENT_36	(35)
#define ACHIEVEMENT_37	(36)
#define ACHIEVEMENT_38	(37)

#define ACHIEVEMENT_39	(38)

#ifdef V_1_1_0
#define ACHIEVEMENT_I4_1	(39)
#define ACHIEVEMENT_I4_2	(40)
#define ACHIEVEMENT_I4_3	(41)
#define ACHIEVEMENT_I4_4	(42)
#define ACHIEVEMENT_I4_5	(43)
#define ACHIEVEMENT_I4_6	(44)
#define ACHIEVEMENT_I4_7	(45)
#define ACHIEVEMENT_I4_8	(46)
#define ACHIEVEMENT_I4_9	(47)
#define ACHIEVEMENT_I4_10	(48)
#define ACHIEVEMENT_I4_11	(49)
#define ACHIEVEMENT_I4_12	(50)

#define ACHIEVEMENT_MAX	(39+12+1)//(39)
#else
#define ACHIEVEMENT_MAX     (39)
#endif

#define ACHIEVEMENT_CLEAR_A_LEVEL_3_STARS	ACHIEVEMENT_1	// Clear a level with all 3 stars!
#define ACHIEVEMENT_CLEAR_LEVEL_CITY		ACHIEVEMENT_2
#define ACHIEVEMENT_CLEAR_LEVEL_SITE		ACHIEVEMENT_3
#define ACHIEVEMENT_CLEAR_LEVEL_PARK		ACHIEVEMENT_4
#define ACHIEVEMENT_COLLECTED_12_ITEMS		ACHIEVEMENT_5
#define ACHIEVEMENT_KILLED_100_ZOMBIES		ACHIEVEMENT_6
#define ACHIEVEMENT_COLLECTED_100_COINS		ACHIEVEMENT_7
#define ACHIEVEMENT_PASSED_200_OBSTACLES	ACHIEVEMENT_8
#define ACHIEVEMENT_RUN_100000M				ACHIEVEMENT_9
#define ACHIEVEMENT_MAINTAINED_COMBO_FOR_1M	ACHIEVEMENT_10
#define ACHIEVEMENT_KILLED_500_ZOMBIES		ACHIEVEMENT_11
#define ACHIEVEMENT_30000_IN_ONE_STAGE		ACHIEVEMENT_12
#define ACHIEVEMENT_COLLECTED_24_ITEMS		ACHIEVEMENT_13
#define ACHIEVEMENT_3STARS_ON_ALL_STAGES	ACHIEVEMENT_14

#define ACHIEVEMENT_ZOMBIE_THRESHOLD_1		(100)
#define ACHIEVEMENT_ZOMBIE_THRESHOLD_2		(500)

#define ACHIEVEMENT_COIN_THRESHOLD			(100)

#define ACHIEVEMENT_OBSTACLE_THRESHOLD		(200)

#define ACHIEVEMENT_DISTANCE_THRESHOLD		(100000.0f)

#define ACHIEVEMENT_COMBO_TIME_THRESHOLD	(30000.0f)

#define ACHIEVEMENT_HI_SCORE_THRESHOLD		(11000)//(20000)

#import "GameSection.h"

class Image;

extern int PassTime;


extern Image* mSliderbar;
extern Image* mSlider;

extern float achievementsProgress[ACHIEVEMENT_MAX];	// in percentage
extern bool  retryReportting[ACHIEVEMENT_MAX];		// retry submitting the achievements

extern bool mLevelCLear[LEVEL_NUM_MAX][STAGE_IN_LV_MAX];
extern int  nCoinsInCurrentLevel;

extern bool m_isPerfect;
//extern bool m_isCaughtByZombie;
//extern int m_nClearLevel;
//extern int m_nCollect;
extern int m_nCoinCollection;
extern int m_nKillZomies;
extern int m_nPassObstacles;
extern float m_nMeters;
extern float m_nComboTime;
extern int m_nComboCount;
extern int m_nScore;

#define ACH_COLLECT_NONE	-1
#define ACH_STA_ZOMBIE_DEF	0
#define ACH_STA_KASHVAULT	1
#define ACH_STA_COIN		2
#define ACH_STA_ZIPLINE		3
#define ACH_STA_MONKEYBAR	4
#define ACH_STA_WALLRUN		5
#define ACH_STA_SLIDE		6
#define ACH_STA_SWING		7
#define ACH_STA_COMBO		8
#define ACH_STA_ITEM		9

#define ACH_STA_OBSTACLE	10
#define ACH_STA_DISTANCE	11
#define ACH_STA_MAX			12
extern int ParkourStatistics[ACH_STA_MAX];
extern int ParkourStatisticsAfterCp[ACH_STA_MAX];


void LaunchGameCenterLeaderboards();
void LaunchGameCenterAchievements();
void LaunchOpenFeint();

void submitAchievement(int target, const char* str, float progress = DEFAULT_PROGRESS, bool showNotification = false);
void setAchievement(int index, float progress = DEFAULT_PROGRESS, bool showNotification = true);

void submitScore(int target, const char* str, int score);
void setScore(int index, int score);

void AchGotPerfectLevel();				// 1

void AchClearLevel(int level, int sub);	// 2, 3, 4

void AchCollectItem();					// 5, 13

void AchKillZombieReset();				// 6, 11
void AchKillZombie();					// 6, 11
void AchKillZombieCheck();				// 6, 11

void AchCollectCoinReset();				// 7
void AchCollectCoin();					// 7
void AchCollectCoinCheck();				// 7

void AchPassObstacleReset();			// 8
void AchPassObstacle();					// 8
void AchPassObstacleCheck();			// 8

void AchRunDistanceReset();				// 9
void AchAddRunDistance(float distance);	// 9
void AchRunDistanceCheck();				// 9

void AchComboCountReset();									// 10
void AchAddComboCount(bool doReset = false);				// 10
void AchAddComboCountTime(float dt, bool doReset = false);	// 10
void AchComboCountCheck();									// 10
void AchAddActionByType(int type);							// 10

//void AchCurrentScore(int score);		// 12
void AchHighScoreCheck();				// 12

void AchCheckStars();					// 14

void AchGetItemBack(int itemId);		// 15-38
void AchGetItemBackCheck();				// 15-38

void AchEndWithRunnerModeCheck();			// 39

void ResetTempAchievements();

void resetTempStatistics();
void saveTempStatistics();
void restorePreviousStatistics();

//void CheckAchievements();
//void CheckAchievementPerfect();
//void CheckAchievementCaught();
//void CheckAchievementClear();
//void CheckAchievementCollect();
//void CheckAchievementKillZombies();
//void CheckAchievementCollectCoin();
//void CheckAchievementPassObstacles();
//void CheckAchievementMeters();
//void CheckAchievementCombo();
//void CheckAchievementScore();
//void CheckAchievementStar();
