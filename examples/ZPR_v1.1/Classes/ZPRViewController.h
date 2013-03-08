//
//  ZPRViewController.h
//  ZPR
//
//  Created by Neo01 on 5/27/11.
//  Copyright 2011 Break Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#ifdef __DOWNLOAD_RES__
#import "ASINetworkQueue.h"
#import "DownloadView.h"
#import "ASIHTTPRequest.h"
#endif


@interface ZPRViewController : UIViewController
#ifdef __DOWNLOAD_RES__
    <MyBookDelegate, ASIHTTPRequestDelegate>
#endif
{
#ifdef __DOWNLOAD_RES__
	DownloadView *downloadView;
#endif
    EAGLContext *context;
    GLuint program;
    
    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink *displayLink;
	
	// Neo01's Utilities
	CFAbsoluteTime cfTime;
	
#ifdef __DOWNLOAD_RES__
    BOOL isSimpleType;  //is block pop alert
	BOOL isDownloadSource;
    BOOL isVersionChecking;
	ASINetworkQueue *netWorkQueue;
    NSString *resourceFile;
#endif
}

#ifdef __DOWNLOAD_RES__
@property (assign,readwrite)DownloadView *downloadView;
#endif
@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void)startAnimation;
- (void)stopAnimation;

#ifdef __DOWNLOAD_RES__
- (void)updateVersionInfo;
- (void)downloadVersion:(BOOL)type;
- (void)downloadResource;
- (void)downBtnOfBookWasClicked:(DownloadView *)book;
- (void)pauseBtnOfBookWasClicked:(DownloadView *)book;
#endif

@end
