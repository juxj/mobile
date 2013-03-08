//
//  CMOpenALSoundManager.m
//  ZPR
//
//  Created by Chris Xia on 11-7-12.
//  Copyright 2011 Break Media. All rights reserved.
//

#import "CMOpenALSoundManager.h"
#import "CMOpenALSound.h"
#import "SynthesizeSingleton.h"
#import "DebugOutput.h"

@interface CMOpenALSoundManager()
@property (nonatomic, retain) NSMutableDictionary *soundDictionary;
@property (nonatomic, retain) AVAudioPlayer *backgroundAudio;
@property (nonatomic) BOOL interrupted;
@property (nonatomic) BOOL isiPodAudioPlaying;
@property (nonatomic, copy) NSString *currentBackgroundAudioFile;
@end

@interface CMOpenALSoundManager(private)
- (NSString *) keyForSoundID:(NSUInteger)soundID;
- (void) setupAudioCategorySilenceIpod:(BOOL)silenceIpod;
- (void) shutdownOpenAL;
- (BOOL) startupOpenAL;
@end

//audio interruption callback...
void interruptionListenerCallback(void *inUserData, UInt32 interruptionState)
{
    CMOpenALSoundManager *soundMgr = (CMOpenALSoundManager *) inUserData;
	
    if (interruptionState == kAudioSessionBeginInterruption)
	{
		debug(@"Start audio interruption");
		[soundMgr beginInterruption];
		soundMgr.interrupted = YES;
    }
	else if ((interruptionState == kAudioSessionEndInterruption) && (soundMgr.interrupted))
	{
		debug(@"Stop audio interruption");
		[soundMgr endInterruption];
        soundMgr.interrupted = NO;
    }
}

@implementation CMOpenALSoundManager
@synthesize soundDictionary, soundFileNames, backgroundAudio, isiPodAudioPlaying, interrupted, currentBackgroundAudioFile;

#if USE_AS_SINGLETON
SYNTHESIZE_SINGLETON_FOR_CLASS(CMOpenALSoundManager);
#endif

#pragma mark -
#pragma mark init/dealloc
- (id) init
{
	self = [super init];	
	if (self != nil)
	{
		//create audio session.
		OSStatus status = AudioSessionInitialize(NULL, NULL, interruptionListenerCallback, self);
		if (status != kAudioSessionNoError)
		{
			debug(@"AudioSessionInitialize failed! %d", status);
		}
		
		self.soundDictionary = [NSMutableDictionary dictionary];
		self.soundEffectsVolume = 1.0;
		self.backgroundMusicVolume = 1.0;
		
		//isiPodAudioPlaying = YES;
//		[self endInterruption];
	}
	return self;
}

// start up openAL
-(BOOL) startupOpenAL
{				
	ALCcontext	*context = NULL;
	ALCdevice	*device = NULL;

	// Initialization
	device = alcOpenDevice(NULL); // select the "preferred device"
	if(!device) return NO;
		
	// use the device to make a context
	context = alcCreateContext(device, NULL);
	if(!context) return NO;
	
	// set my context to the currently active one
	alcMakeContextCurrent(context);
	
	debug(@"oal inited ok");
	return YES;	
}

- (void) dealloc
{
	debug(@"CMOpenALSoundManager dealloc");
	
	[self shutdownOpenAL];
	
	[backgroundAudio release];
	[soundFileNames release];
	[soundDictionary release];
	[currentBackgroundAudioFile release];

	[super dealloc];
}

- (void) shutdownOpenAL
{
	//self.backgroundAudio = nil;
	//self.soundFileNames = nil;
	//self.soundDictionary = nil;
	
	ALCcontext	*context = NULL;
    ALCdevice	*device = NULL;
	
	//Get active context (there can only be one)
    context = alcGetCurrentContext();
	
    //Get device for active context
    device = alcGetContextsDevice(context);
	
    //Release context
    alcDestroyContext(context);
	
    //Close device
    alcCloseDevice(device);
}

#pragma mark -
#pragma mark audio session mgmt

- (void) beginInterruption
{		
	debug(@"begin interruption");
	[self stopBackgroundMusic];
	[self purgeSounds];
	[self shutdownOpenAL];
	
	[self setupAudioCategorySilenceIpod: NO];
//	if(!self.isiPodAudioPlaying)
//	{
//		UInt32	sessionCategory = kAudioSessionCategory_MediaPlayback;
//		AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
//		AudioSessionSetActive(YES);
//	}
//	else
	{
		UInt32	sessionCategory = kAudioSessionCategory_UserInterfaceSoundEffects;
		AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
		AudioSessionSetActive(YES);
	}
	
	AudioSessionSetActive(NO);
}

- (void) endInterruption
{
	debug(@"end interruption");
	[self setupAudioCategorySilenceIpod: NO];
	[self startupOpenAL];
	
//	UInt32	sessionCategory = kAudioSessionCategory_AmbientSound;
//	AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
//	AudioSessionSetActive(YES);
}

- (void) checkOtherAudioIsPlaying
{
	[self setupAudioCategorySilenceIpod: NO];
}

- (void) suspendSounds
{
	debug(@"suspendSounds");
	[self stopBackgroundMusic];
	[self purgeSounds];
	[self shutdownOpenAL];
	AudioSessionSetActive(NO);
}

- (void) resumeSounds
{
	debug(@"resumeSounds");
	[self setupAudioCategorySilenceIpod: NO];
	[self startupOpenAL];
	
	UInt32	sessionCategory = kAudioSessionCategory_AmbientSound;
	AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
	AudioSessionSetActive(YES);
}

- (void) setupAudioCategorySilenceIpod:(BOOL)silenceIpod;
{
	UInt32 audioIsAlreadyPlaying;
	UInt32 propertySize = sizeof(audioIsAlreadyPlaying);
	
	//query audio hw to see if ipod is playing...
	OSStatus err = AudioSessionGetProperty(kAudioSessionProperty_OtherAudioIsPlaying, &propertySize, &audioIsAlreadyPlaying);	
	if (err) debug(@"AudioSessionGetProperty error:%i", err);
	debug(@"kAudioSessionProperty_OtherAudioIsPlaying = %@", audioIsAlreadyPlaying ? @"YES" : @"NO");
	
	if (audioIsAlreadyPlaying && !silenceIpod)
	{
		self.isiPodAudioPlaying = YES;
		
		//register session as ambient sound so our effects mix with ipod audio
		UInt32	sessionCategory = kAudioSessionCategory_AmbientSound;
		AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
	}
	else
	{
		self.isiPodAudioPlaying = NO;
		
		//register session as solo ambient sound so the ipod is silenced, and we can use hardware codecs for background audio
		UInt32	sessionCategory = kAudioSessionCategory_SoloAmbientSound;
		AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
	}
}

#pragma mark -
#pragma mark cleanup
- (void) purgeSounds
{
	//call this if you get a memory warning, to unload all sounds from memory
	[self.soundDictionary removeAllObjects];

	//if there's a background audio that's not playing, remove that too...
	if(![backgroundAudio isPlaying])
	{
		self.backgroundAudio = nil;
		self.currentBackgroundAudioFile = nil;
	}
}

#pragma mark -
#pragma mark background music playback
// plays a file as the background audio...
- (void) playBackgroundMusic:(NSString *)file
{
	[self playBackgroundMusic:file forcePlay:NO];
}

- (void) playBackgroundMusic:(NSString *)file forcePlay:(BOOL)forcePlay
{		
	if(forcePlay)	//if we want to kill other audio sources, like the iPod...
	{
		[backgroundAudio stop]; //if there's audio already playing...
		[self setupAudioCategorySilenceIpod:YES];
	}
	
	if(isiPodAudioPlaying) //if other background audio is playing bail out...
	{
		debug(@"Sry, ipod is playing... can't play file %@",file);
		return;
	}
	
	if(self.backgroundAudio && [self.currentBackgroundAudioFile isEqualToString:file])
	{
		[self.backgroundAudio play];
		return; //already playing
	}
	
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: [file stringByDeletingPathExtension] 
															  ofType: [file pathExtension]];	
	
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
	
	NSError *error = nil;
	AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL 
																   error:&error];
	
	[fileURL release];
	
	if(error)
	{
		//TODO:chequear por errores
		debug(@"***** ERROR creando backgroundMusicPlayer file:%@", file);
		[player release];
		return;
	}	
	
	self.currentBackgroundAudioFile = file;
	[player setNumberOfLoops:-1]; //loop forever
	player.volume = backgroundMusicVolume;
	[player play];		
	
	self.backgroundAudio = player;
	[player release];
}

- (void) stopBackgroundMusic
{
	[backgroundAudio stop];
	[backgroundAudio setCurrentTime:0.0];	// reset to the start point
}

- (void) pauseBackgroundMusic
{
	[backgroundAudio pause];
}

- (void) resumeBackgroundMusic
{
	[backgroundAudio play];
}

#pragma mark -
#pragma mark effects playback
// grab the filename (key) from the filenames array
- (NSString *) keyForSoundID:(NSUInteger)soundID
{
	if(/*soundID < 0 || */soundID >= [soundFileNames count])
		return nil;
	
	return [[soundFileNames objectAtIndex:soundID] lastPathComponent];
}

- (void) playSoundWithID:(NSUInteger)soundID repeat:(BOOL)bRepeat
{	
	//get sound key
	NSString *soundFile = [self keyForSoundID:soundID];
	if(!soundFile) return;
	
	CMOpenALSound *sound = [soundDictionary objectForKey:soundFile];
	
	if(!sound)
	{
		//create a new sound
		sound = [[CMOpenALSound alloc] initWithSoundFile:soundFile doesLoop:bRepeat]; //this will return nil on failure
//		sound = [[CMOpenALSound alloc] initWithSoundFile:soundFile doesLoop:NO]; //this will return nil on failure
		
		if(!sound) //error
			return;
		
		[soundDictionary setObject:sound forKey:soundFile];
		[sound release];
	}
	
	[sound play];
	sound.volume = self.soundEffectsVolume;
}

- (void) stopSoundWithID:(NSUInteger)soundID
{
	NSString *soundFile = [self keyForSoundID:soundID];
	if(!soundFile) return;
	
	CMOpenALSound *sound = [soundDictionary objectForKey:soundFile];		
	[sound stop];
}

- (void) pauseSoundWithID:(NSUInteger)soundID
{
	NSString *soundFile = [self keyForSoundID:soundID];
	if(!soundFile) return;
	
	CMOpenALSound *sound = [soundDictionary objectForKey:soundFile];		
	[sound stop];
}

- (void) rewindSoundWithID:(NSUInteger)soundID
{
	NSString *soundFile = [self keyForSoundID:soundID];
	if(!soundFile) return;
	
	CMOpenALSound *sound = [soundDictionary objectForKey:soundFile];
	[sound rewind];
}

- (BOOL) isPlayingSoundWithID:(NSUInteger)soundID
{
	NSString *soundFile = [self keyForSoundID:soundID];
	if(!soundFile) return NO;
	
	CMOpenALSound *sound = [soundDictionary objectForKey:soundFile];		
	return [sound isAnyPlaying];
}

- (BOOL) isBackGroundMusicPlaying
{
	return [backgroundAudio isPlaying];
}

#pragma mark -
#pragma mark properties
- (float) backgroundMusicVolume
{
	return backgroundMusicVolume;
}

- (void) setBackgroundMusicVolume:(float) newVolume
{
	backgroundMusicVolume = newVolume;
	backgroundAudio.volume = newVolume;
}

- (float) soundEffectsVolume
{
	return soundEffectsVolume;
}

- (void) setSoundEffectsVolume:(float) newVolume
{
	soundEffectsVolume = newVolume;
	for(NSString *key in soundDictionary)
	{
		((CMOpenALSound *)[soundDictionary objectForKey:key]).volume = newVolume;
	}
}
@end
