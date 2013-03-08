//
//  CMOpenALSoundManager.h
//  ZPR
//
//  Created by Chris Xia on 11-7-12.
//  Copyright 2011 Break Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

#define USE_AS_SINGLETON 0	//Set this to 0 if you want to use this class as a regular class instead of as a singleton.

@class CMOpenALSound;

@interface CMOpenALSoundManager : NSObject 
{	
	AVAudioPlayer		*backgroundAudio;	// background music
	
	NSMutableDictionary	*soundDictionary;	// stores our soundkeys
	NSArray				*soundFileNames;	// array that holds the filenames for the sounds, they will be referenced by index
	
	BOOL				isiPodAudioPlaying;	// ipod playing music? 

	float				backgroundMusicVolume;
	float				soundEffectsVolume;
	
	BOOL				interrupted;
	NSString			*currentBackgroundAudioFile;
}

@property (nonatomic, retain) NSArray *soundFileNames;
@property (nonatomic, readonly) BOOL isiPodAudioPlaying;
@property (nonatomic) float backgroundMusicVolume;
@property (nonatomic) float soundEffectsVolume;

#if USE_AS_SINGLETON
+ (CMOpenALSoundManager *) sharedCMOpenALSoundManager;
#endif

- (void) purgeSounds;		// purges all sounds from memory, in case of a memory warning...
- (void) beginInterruption;	// handle os sound interruptions
- (void) endInterruption;
- (void) checkOtherAudioIsPlaying;

//- (void) suspendSounds;
//- (void) resumeSounds;

- (void) playBackgroundMusic:(NSString *)file;	//file is the filename to play (from your main bundle)
- (void) playBackgroundMusic:(NSString *)file forcePlay:(BOOL)forcePlay; //if forcePlay is YES, iPod audio will be stopped.
- (void) stopBackgroundMusic;
- (void) pauseBackgroundMusic;
- (void) resumeBackgroundMusic;

- (void) playSoundWithID:(NSUInteger)soundID repeat:(BOOL)bRepeat;	//id is the index in the sound filename array
- (void) stopSoundWithID:(NSUInteger)soundID;
- (void) pauseSoundWithID:(NSUInteger)soundID;
- (void) rewindSoundWithID:(NSUInteger)soundID;

- (BOOL) isPlayingSoundWithID:(NSUInteger)soundID;
- (BOOL) isBackGroundMusicPlaying;
@end
