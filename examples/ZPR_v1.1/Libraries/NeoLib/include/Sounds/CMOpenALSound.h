//
//  CMOpenALSound.h
//  ZPR
//
//  Created by Chris Xia on 11-7-12.
//  Copyright 2011 Break Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

@interface CMOpenALSound : NSObject 
{
	ALuint			bufferID;		
	ALuint			sourceID;			//base source ID
	ALdouble		duration;			//duration of the sound in seconds
	ALfloat			volume;				//volume [0 - 1]
	ALfloat			pitch;				//speed
	
	ALenum			error;				
	ALvoid			*bufferData;		//holds the actual sound data

	NSMutableArray	*temporarySounds;	//holds source IDs to temporary sounds (sounds played when the base source was busy)
	NSString		*sourceFileName;
}

@property (nonatomic, readonly) ALenum error;
@property (nonatomic, readonly) ALdouble duration;
@property (nonatomic) ALfloat volume;
@property (nonatomic) ALfloat pitch;
@property (nonatomic, copy, readonly) NSString *sourceFileName;

- (id) initWithSoundFile:(NSString *)file doesLoop:(BOOL)loops;

- (BOOL) play;
- (BOOL) stop;
- (BOOL) pause;
- (BOOL) rewind;
- (BOOL) isPlaying;
- (BOOL) isAnyPlaying;
@end
