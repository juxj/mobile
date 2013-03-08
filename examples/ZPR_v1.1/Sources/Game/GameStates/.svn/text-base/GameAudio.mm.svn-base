//
//  GameAudio.m
//  ZPR
//
//  Created by Chris Xia on 11-7-12.
//  Copyright 2011 Break Media. All rights reserved.
//

#import "GameAudio.h"
#import "CMOpenALSoundManager.h"
#import "GameOption.h"

int currentBgmId = BGM_MENU;

CMOpenALSoundManager *audioMgr;

void objAudioInit()	//void objAudioInit(int roleType, int audioType, bool state)
{
	audioMgr = [[CMOpenALSoundManager alloc] init];
	audioMgr.soundFileNames = [NSArray arrayWithObjects: 
								@"S_01.caf",
								@"S_02.caf",
								@"S_03.caf",
								@"S_04.caf",
								@"S_05_1.caf",
								@"S_05_2.caf",
								@"S_06_1.caf",
								@"S_06_2.caf",
								@"S_06_3.caf",
								@"S_06_4.caf",
								@"S_06_5.caf",
								@"S_06_6.caf",
								@"S_07.caf",
								@"S_09.caf",
								@"S_11.caf",
								@"S_13.caf",
								@"S_08.caf",
								@"S_10.caf",
								@"S_15.caf",
								@"S_16_1.caf",
								@"S_16_2.caf",
								@"S_16_3.caf",
								@"S_17.caf",
								@"S_18.caf",
								@"S_37.caf",
							   @"S_38_1.caf",
							   @"S_38_2.caf",
							   @"S_39_1.caf",
							   @"S_39_2.caf",
							   @"S_12.caf",
							   @"S_20.caf",
							   @"S_23.caf",
							   @"S_40.caf",
								@"S_14.caf",
								@"S_19.caf",
								@"S_21.caf",
								@"S_22.caf",
								@"S_24.caf",
								@"S_25.caf",
								@"S_27.caf",
								@"S_28.caf",
								@"S_30.caf",
								@"S_31.caf",
								@"S_32.caf",
								@"S_34.caf",
								@"S_35.caf",
								@"S_36_1.caf",
								@"S_36_2.caf",
								@"S_36_3.caf",
								nil];
	
	m_b4iPod = m_bBgm;
	m_b4sSnd = m_bBgm;
}

//void objAudioPlay(int roleType, int audioType, bool state, bool force)
//{
//	if (!audioMgr) return;
//	
//	if (roleType == EVENT_TYPE_BACKGROUND && 
//		audioType == SOUND_TYPE_INDEX_BACKGROUND)
//	{
//		if (state)
//		{
//			if (force)
//			{
//				[audioMgr playBackgroundMusic:@"background.caf" forcePlay:force];
//			}
//			else
//			{
//				[audioMgr playBackgroundMusic:@"background.caf"];
//			}
//		    return;
//		}
//		else if ([audioMgr isBackGroundMusicPlaying])
//		{
//			[audioMgr stopBackgroundMusic];
//		}
//		return;
//	}
//	
//	[audioMgr playSoundWithID:2];
//	return;
//}

//void objAudioStop(int roleType, int audioType, bool state)
//{
//	if (!audioMgr) return;
//	
//	if (roleType == ALL_GAME_PLAY && 
//		(audioType == ALL_GAME_PLAY_AUDIO && state))
//	{
//		if ([audioMgr isBackGroundMusicPlaying])
//		{
//			[audioMgr stopBackgroundMusic];
//			return;
//		}
//	}
//	
//	if (roleType == EVENT_TYPE_BACKGROUND && 
//		(audioType == SOUND_TYPE_INDEX_BACKGROUND && 
//		 state))
//	{
//		if ([audioMgr isBackGroundMusicPlaying])
//		{
//			[audioMgr stopBackgroundMusic];
//			return;
//		}
//	}
//	
//	if (roleType == EVENT_TYPE_UI_CLICK && 
//		(audioType == SOUND_TYPE_INDEX_UI_CLICK && state))
//	{
//		[audioMgr stopSoundWithID:2];
//		return;
//	}
//}

void playBGM(int soundID, bool force)
{
	currentBgmId = soundID;
#ifndef SND_BTN_AS_SE_BTN
	if (audioMgr && m_bSounds)
#else
	if (audioMgr)
#endif
	{
		if (m_bBgm)
		{
			if (soundID == BGM_GAME)
			{
				if (force)
				{
					[audioMgr playBackgroundMusic:@"bgm_game.caf" forcePlay:YES];
				}
				else
				{
					[audioMgr playBackgroundMusic:@"bgm_game.caf"];
				}
			}
			else if (soundID == BGM_MENU)
			{
				if (force)
				{
					[audioMgr playBackgroundMusic:@"bgm_menu.caf" forcePlay:YES];
				}
				else
				{
					[audioMgr playBackgroundMusic:@"bgm_menu.caf"];
				}
			}
		}
		else if ([audioMgr isBackGroundMusicPlaying])
		{
			[audioMgr stopBackgroundMusic];
		}
	}
}

void stopBGM()
{
	if (audioMgr)
	{
		if ([audioMgr isBackGroundMusicPlaying])
		{
			[audioMgr stopBackgroundMusic];
		}
	}
}

void pauseBGM()
{
	if (audioMgr && m_bSounds && m_bBgm)
	{
		if ([audioMgr isBackGroundMusicPlaying])
		{
			[audioMgr pauseBackgroundMusic];
		}
	}
}

void resumeBGM()
{
	if (audioMgr && m_bSounds && m_bBgm)
	{
		if ([audioMgr isBackGroundMusicPlaying])
		{
			[audioMgr resumeBackgroundMusic];
		}
	}
}

void playSE(int soundID, bool bLoop)
{
#ifdef SOUND_SE
	if (audioMgr && m_bSounds)
	{
		[audioMgr playSoundWithID:soundID repeat:bLoop];
	}
#endif
}

void stopSE(int soundID)
{
#ifdef SOUND_SE
	if (audioMgr && m_bSounds)
	{
		[audioMgr stopSoundWithID:soundID];
	}
#endif
}

void objAudioRealease(int roleType, int audioType, bool state)
{
	if (!audioMgr) return;
	[audioMgr purgeSounds];
}

void objAudioSuspend()
{
	if (!audioMgr) return;
	[audioMgr beginInterruption];
//	[audioMgr suspendSounds];
}

void objAudioResume()
{
	if (!audioMgr) return;
	[audioMgr endInterruption];
//	[audioMgr resumeSounds];
//	[audioMgr endInterruption];
	
	if ([audioMgr isiPodAudioPlaying])
	{
		m_b4iPod = m_bBgm;
		m_bBgm = false;
		m_b4sSnd = false;
		//printf("**keep playing iPod music and the previous BGM status is %d.\n", m_b4iPod?1:0);
	}
	else if (m_b4iPod)
	{
		m_bBgm = m_b4iPod;
		//printf("**switch to the previous BGM status %d.\n", m_bBgm?1:0);
	}
}
