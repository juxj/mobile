//
//  GameAudio.h
//  ZPR
//
//  Created by Chris Xia on 11-7-12.
//  Copyright 2011 Break Media. All rights reserved.
//

#ifndef __GAME_AUDIO_H__
#define __GAME_AUDIO_H__

#define BGM_GAME	0
#define BGM_MENU	1

#define SE_COMMON_BASE		0
#define SE_RAIN				(SE_COMMON_BASE+0)	// Rain sound loop
#define SE_BUTTON_CANCEL	(SE_COMMON_BASE+1)
#define SE_BUTTON_CONFIRM	(SE_COMMON_BASE+2)
#define SE_GAME_START		(SE_COMMON_BASE+3)	// Zombie moan
#define SE_GAME_OVER_1		(SE_COMMON_BASE+4)	// Zombie laugh
#define SE_GAME_OVER_2		(SE_COMMON_BASE+5)	// Zombie laugh

#define SE_RUNNER_BASE			SE_GAME_OVER_2
#define SE_RUNNER_RUNNING_FT_01	(SE_RUNNER_BASE+1)	// S_06
#define SE_RUNNER_RUNNING_FT_02	(SE_RUNNER_BASE+2)
#define SE_RUNNER_RUNNING_FT_03	(SE_RUNNER_BASE+3)
#define SE_RUNNER_WALLRUN_FT_01	(SE_RUNNER_BASE+4)
#define SE_RUNNER_WALLRUN_FT_02	(SE_RUNNER_BASE+5)
#define SE_RUNNER_WALLRUN_FT_03	(SE_RUNNER_BASE+6)
#define SE_RUNNER_JUMPING		(SE_RUNNER_BASE+7)	// S07, jump voice 25% <- // S_07+S_08, voice and sound effect
#define SE_RUNNER_LANDING		(SE_RUNNER_BASE+8)	// S_09+S_10, voice and sound effect
#define SE_RUNNER_SLIDING		(SE_RUNNER_BASE+9)	// S_11+S_12, (voice and )sound effect
#define SE_RUNNER_ROLLING		(SE_RUNNER_BASE+10)	// S_13+S_14, voice and sound effect
#define SE_RUNNER_MONKEY_BAR	(SE_RUNNER_BASE+11)	// new, S_08
#define SE_RUNNER_SWING			(SE_RUNNER_BASE+12)	// new, S_10
#define SE_RUNNER_MONEY			(SE_RUNNER_BASE+13)	// S_15
#define SE_RUNNER_FASTER_1		(SE_RUNNER_BASE+14)	// S_16_1
#define SE_RUNNER_FASTER_2		(SE_RUNNER_BASE+15)	// S_16_2
#define SE_RUNNER_FASTER_3		(SE_RUNNER_BASE+16)	// S_16_3
#define SE_RUNNER_SUCCESS		(SE_RUNNER_BASE+17)	// S_17
#define SE_RUNNER_FAILURE		(SE_RUNNER_BASE+18)	// S_18
#define SE_RUNNER_BONUS			(SE_RUNNER_BASE+19)	// S_37, new
#define SE_RUNNER_KASH_VAULT_F	(SE_RUNNER_BASE+20)	// S_38_1, new
#define SE_RUNNER_KASH_VAULT	(SE_RUNNER_BASE+21)	// S_38_2, new
#define SE_RUNNER_ZIPLINE_DN	(SE_RUNNER_BASE+22)	// S_39_1, new
#define SE_RUNNER_ZIPLINE_UP	(SE_RUNNER_BASE+23)	// S_39_2, new
#define SE_RUNNER_JUMPING_VOICE	(SE_RUNNER_BASE+24)	// S_12, jump 75%, new
#define SE_RUNNER_GAME_SUCC		(SE_RUNNER_BASE+25)	// S_20 <-, success, new
#define SE_RUNNER_GAME_FAIL		(SE_RUNNER_BASE+26)	// S_23 <-, failure, new
#define SE_RUNNER_RUN_MODE		(SE_RUNNER_BASE+27)	// S_40 <-, activate runner mode
#define SE_RUNNER_GET_ITEM		(SE_RUNNER_BASE+28)	// S_14 <- S_36

#define SE_ZOMBIE_BASE		SE_RUNNER_GET_ITEM
#define SE_ZOMBIE_MOAN1		(SE_ZOMBIE_BASE+1)	// S_19
//#define SE_ZOMBIE_DEATH1	(SE_ZOMBIE_BASE+2)	// S_20
#define SE_ZOMBIE_DODGE1	(SE_ZOMBIE_BASE+2)	// S_21

#define SE_ZOMBIE_MOAN2		(SE_ZOMBIE_BASE+3)	// S_22
//#define SE_ZOMBIE_DEATH2	(SE_ZOMBIE_BASE+5)	// S_23
#define SE_ZOMBIE_DODGE2	(SE_ZOMBIE_BASE+4)	// S_24

#define SE_ZOMBIE_MOAN3		(SE_ZOMBIE_BASE+5)	// S_25
//#define SE_ZOMBIE_DEATH3	(SE_ZOMBIE_BASE+8)	// S_26
#define SE_ZOMBIE_DODGE3	(SE_ZOMBIE_BASE+6)	// S_27

#define SE_ZOMBIE_MOAN4		(SE_ZOMBIE_BASE+7)	// S_28
//#define SE_ZOMBIE_DEATH4	(SE_ZOMBIE_BASE+11)	// S_29
#define SE_ZOMBIE_SPLAT4	(SE_ZOMBIE_BASE+8)	// S_30
#define SE_ZOMBIE_DODGE4	(SE_ZOMBIE_BASE+9)	// S_31

#define SE_ZOMBIE_MOAN5		(SE_ZOMBIE_BASE+10)	// S_32
//#define SE_ZOMBIE_DEATH5	(SE_ZOMBIE_BASE+15)	// S_33
#define SE_ZOMBIE_DODGE5	(SE_ZOMBIE_BASE+11)	// S_34

#define SE_SUPER_ZOMBIE_MOAN		(SE_ZOMBIE_BASE+12)	// S_35
#define SE_SUPER_ZOMBIE_DODGE_01	(SE_ZOMBIE_BASE+13)	// S_36, new
#define SE_SUPER_ZOMBIE_DODGE_02	(SE_ZOMBIE_BASE+14)
#define SE_SUPER_ZOMBIE_DODGE_03	(SE_ZOMBIE_BASE+15)

#define SE_MAX				//26

extern int currentBgmId;

void objAudioInit();
void objAudioPlay(int roleType, int audioType, bool state, bool force = false);
void objAudioFadeIn(int roleType, int audioType, bool state);
void objAudioFadeOut(int roleType, int audioType, bool state);
void objAudioStop(int roleType, int audioType, bool state);
void objAudioRelease(int roleType, int audioType, bool state);

void objAudioSuspend();
void objAudioResume();

void playBGM(int soundID, bool force = false);
void stopBGM();
void pauseBGM();
void resumeBGM();
void playSE(int soundID, bool bLoop = false);
void stopSE(int soundID);

#endif //__GAME_AUDIO_H__
