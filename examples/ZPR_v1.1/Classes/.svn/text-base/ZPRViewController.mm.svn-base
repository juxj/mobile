//
//  ZPRViewController.m
//  ZPR
//
//  Created by Neo01 on 5/27/11.
//  Copyright 2011 Break Media. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ZPRViewController.h"
#import "EAGLView.h"

#import "ZPRAppDelegate.h"

#ifdef OF_EMBEDED
#import "OpenFeint/OpenFeint.h"
//#import "OpenFeint/OFControllerLoaderObjC.h"
////#import "OpenFeint/OFAnnouncement.h"
//#import "OpenFeint/OFBadgeView.h"
//#import "OpenFeint/OFForumPost.h"
//#import "OpenFeint/OFDependencies.h"
#endif

// Neo01's Utilities
#import "neoMinMax.h"
#import "neoUnixTime.h"
// NeoLib Core
#import "neoApp.h"
#import "Canvas2D.h"

// Game States
#import "GameState.h"
#import "GameRes.h"
#import "GameTitle.h"

#ifdef __DOWNLOAD_RES__
#import "GameData.h"
#import "GameStore.h"
#import "GameState.h"
#import "GameTitle.h"
#endif

//#ifdef OF_EMBEDED
//static NSArray		*appAnnouncementList = nil;
//static NSArray		*devAnnouncementList = nil;
//#endif

// Uniform index.
enum {
    UNIFORM_TRANSLATE,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum {
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
};

@interface ZPRViewController ()
@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) CADisplayLink *displayLink;

- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;

//#ifdef OF_EMBEDED
//- (void)setAnnouncementType:(AnnouncementType)requestedType;
//- (void)announcementIndexChange:(NSInteger)delta;
//- (void)postIndexChange:(NSInteger)delta;
//- (void)refreshStatusText:(OFAnnouncement*)announcement;
//#endif
@end


@implementation ZPRViewController

@synthesize animating, context, displayLink;
#ifdef __DOWNLOAD_RES__
@synthesize downloadView;
#endif

// Neo01's Utilities, Unix Time
//static neolib::TIMEVALUE workTime;

- (void)awakeFromNib
{
    EAGLContext *aContext = 
#ifdef OGLES_1_1_ONLY
		NULL
#else
		[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2]
#endif
	;
    
    if (!aContext)
    {
        aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    }
    
    if (!aContext)
        NSLog(@"Failed to create ES context");
    else if (![EAGLContext setCurrentContext:aContext])
        NSLog(@"Failed to set ES context current");
    
	self.context = aContext;
	[aContext release];
	
    [(EAGLView *)self.view setContext:context];
    [(EAGLView *)self.view setFramebuffer];
    
    if ([context API] == kEAGLRenderingAPIOpenGLES2)
        [self loadShaders];
    
    animating = FALSE;
    animationFrameInterval = 1;
    self.displayLink = nil;
	
//#ifdef OF_EMBEDED
//	[OFAnnouncement setDelegate:self];
//	//OFSafeRelease(postList);
//	if (!devAnnouncementList && !appAnnouncementList)
//	{
//		OFRequestHandle* handle = [OFAnnouncement downloadAnnouncementsAndSortBy:EAnnouncementSortType_CREATION_DATE];
//		
//		if (!handle)
//		{
//			OFLog(@"Did not get request handle from OFAnnouncement's downloadAnnouncementsAndSortBy:");
//		}
//	}
//	else
//	{
//		[self setAnnouncementType: AnnouncementType_App];
//	}
//#endif
}

- (void)dealloc
{
    if (program)
    {
        glDeleteProgram(program);
        program = 0;
    }
    
    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
#ifdef __DOWNLOAD_RES__
    [downloadView release];
	[resourceFile release];
#endif
    [context release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self startAnimation];
	
#ifdef __DOWNLOAD_RES__
//	[self downloadVersion:YES];
//	UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//	
//	downloadBtn.frame = CGRectMake(320, 250, 55, 55);
//	[downloadBtn setImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
//	[downloadBtn addTarget:self action:@selector(downloadResource) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:downloadBtn];
#endif
//#ifdef FACEBOOK_TWITTER
//	UIButton *facebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//	UIButton *twitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//	
//	facebookBtn.frame = CGRectMake(320, 250, 55, 55);
//	[facebookBtn setImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
//	[facebookBtn addTarget:self action:@selector(facebookShare:) forControlEvents:UIControlEventTouchUpInside];
//	
//	twitterBtn.frame = CGRectMake(390, 250, 55, 55);
//	[twitterBtn setImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateNormal];
//	[twitterBtn addTarget:self action:@selector(twitterShare:) forControlEvents:UIControlEventTouchUpInside];
//	
//	[self.view addSubview:facebookBtn];
//	[self.view addSubview:twitterBtn];
//#endif
//    [super viewWillAppear:animated];
}

//#ifdef FACEBOOK_TWITTER
//-(void)facebookShare:(id)sender{
//	ZPRAppDelegate *delegate = (ZPRAppDelegate *) [[UIApplication sharedApplication] delegate];
//    // Check and retrieve authorization information
//	//   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//	//    if ([defaults objectForKey:@"FBAccessTokenKey"] 
//	//        && [defaults objectForKey:@"FBExpirationDateKey"]) {
//	//        [delegate facebook].accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
//	//        [delegate facebook].expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
//	//    }
//    if (![[delegate facebook] isSessionValid]) {
//        //[delegate facebook].sessionDelegate = self;
//		//        [[delegate facebook] authorize:permissions];
//		//		[self share];
//    } else {
//		//  [self showLoggedIn];
//    }
//	
//	
//	
//	
//    SBJSON *jsonWriter = [[SBJSON new] autorelease];
//    
//    // The action links to be shown with the post in the feed
//    NSArray* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
//													  @"Get Started",@"name",@"http://m.facebook.com/apps/hackbookios/",@"link", nil], nil];
//	
//    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
//    // Dialog parameters
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   @"I'm using the Hackbook for iOS app", @"name",
//                                   @"Hackbook for iOS.", @"caption",
//                                   @"Check out Hackbook for iOS to learn how you can make your iOS apps social using Facebook Platform.", @"description",
//                                   @"http://m.facebook.com/apps/hackbookios/", @"link",
//                                   @"http://www.facebookmobileweb.com/hackbook/img/facebook_icon_large.png", @"picture",
//                                   actionLinksStr, @"actions",
//                                   nil];
//    [[delegate facebook] dialog:@"feed"
//					  andParams:params
//					andDelegate:self];
//}
//#endif
//
//#ifdef FACEBOOK_TWITTER
//-(void)twitterShare:(id)sender{
//	SBJSON *jsonWriter = [[SBJSON new] autorelease];
//	NSArray* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
//													  @"Get Started",@"name",@"http://m.facebook.com/apps/hackbookios/",@"link", nil], nil];
//	
//    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
//	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   @"", @"name",
//                                   @"", @"caption",
//                                   @"", @"description",
//                                   @"", @"link",
//                                   @"", @"picture",
//                                   actionLinksStr, @"actions",
//                                   nil];
//	ZPRAppDelegate *delegate = (ZPRAppDelegate *) [[UIApplication sharedApplication] delegate];
//	[[delegate facebook] twitterDialog:@""
//							 andParams:params
//						   andDelegate:self];
//}
//#endif

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopAnimation];
    
//    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
    if (program)
    {
        glDeleteProgram(program);
        program = 0;
    }

    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	self.context = nil;
}

- (NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    /*
	 Frame interval defines how many display frames must pass between each time the display link fires.
	 The display link will only fire 30 times a second when the frame internal is two on a display that refreshes 60 times a second. The default frame interval setting of one will fire 60 times a second when the display refreshes at 60 times a second. A frame interval setting of less than one results in undefined behavior.
	 */
    if (frameInterval >= 1)
    {
        animationFrameInterval = frameInterval;
        
        if (animating)
        {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void)startAnimation
{
    if (!animating)
    {
        CADisplayLink *aDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawFrame)];
        [aDisplayLink setFrameInterval:animationFrameInterval];
        [aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.displayLink = aDisplayLink;
        animating = TRUE;
		
		// Neo01's Utilities
//		neolib::setFramesPerSecond(GAME_FPS);	// default
//		workTime = neolib::getTimeNow();
    }
}

- (void)stopAnimation
{
    if (animating)
    {
        [self.displayLink invalidate];
        self.displayLink = nil;
        animating = FALSE;
    }
}

- (void)drawFrame
{
   
	[(EAGLView *)self.view setFramebuffer];
	// Neo01's Utilities
	CFAbsoluteTime t =  CFAbsoluteTimeGetCurrent();
	CFTimeInterval dt = t - cfTime;
	cfTime = t;
	dt *= 1000.f;
	dt = min(dt, 33.0);
	
//	neolib::TIMEVALUE timeDiff = neolib::substractTime(neolib::getTimeNow(), workTime);
//	int workFrames = neolib::getFrames(&timeDiff);
	
//	while(workFrames--)
	{
		UpdateGameState(dt);
//		neolib::App::update(dt);
//		neolib::addFrame(&workTime);
	}
	
	Canvas2D* canvas = Canvas2D::getInstance();
	canvas->RenderBegin();
	RenderGameState(dt);
	canvas->RenderEnd();
//	neolib::App::render(dt);
	// Neo01's Utilities
    
    [(EAGLView *)self.view presentFramebuffer];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
#ifdef OF_EMBEDED
	const unsigned int numOrientations = 2;
    UIInterfaceOrientation myOrientations[numOrientations] = 
	{
        //UIInterfaceOrientationPortrait, 
		UIInterfaceOrientationLandscapeLeft, 
        UIInterfaceOrientationLandscapeRight
		//, UIInterfaceOrientationPortraitUpsideDown
    };
#endif
    
    if (app && ([app bLockScreenOrient] == YES))
    {
        return NO;
    }
    
#ifdef OF_EMBEDED
	if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
		interfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		[OpenFeint setDashboardOrientation:interfaceOrientation];
	}
    return [OpenFeint 
			shouldAutorotateToInterfaceOrientation:interfaceOrientation 
			withSupportedOrientations:myOrientations 
			andCount:numOrientations];
#else
    return (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || 
    		interfaceOrientation==UIInterfaceOrientationLandscapeRight);
#endif
    //	return (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || 
    //			interfaceOrientation==UIInterfaceOrientationLandscapeRight);
}

#pragma mark Shaders
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return FALSE;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
    {
        glDeleteShader(*shader);
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0)
        return FALSE;
    
    return TRUE;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0)
        return FALSE;
    
    return TRUE;
}

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
    {
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])
    {
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
    }
    
    // Attach vertex shader to program.
    glAttachShader(program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(program, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(program, ATTRIB_COLOR, "color");
    
    // Link program.
    if (![self linkProgram:program])
    {
        NSLog(@"Failed to link program: %d", program);
        
        if (vertShader)
        {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader)
        {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (program)
        {
            glDeleteProgram(program);
            program = 0;
        }
        
        return FALSE;
    }
    
    // Get uniform locations.
    uniforms[UNIFORM_TRANSLATE] = glGetUniformLocation(program, "translate");
    
    // Release vertex and fragment shaders.
    if (vertShader)
        glDeleteShader(vertShader);
    if (fragShader)
        glDeleteShader(fragShader);
    
    return TRUE;
}
#ifdef __DOWNLOAD_RES__
- (BOOL) isPad
{
    if ([[UIDevice currentDevice].model rangeOfString:@"iPad"].location != NSNotFound)
    {
#ifdef DEBUG
        NSLog(@"This is an iPad!");
#endif
        return YES;
    }
    else
    {
#ifdef DEBUG
        NSLog(@"This is an iPhone/iPod touch!");
#endif
        return NO;
    }
}

- (void)downloadResource
{
	isDownloadSource = YES;
	netWorkQueue  = [[ASINetworkQueue alloc] init];
	[netWorkQueue reset];
	[netWorkQueue setShowAccurateProgress:YES];
	[netWorkQueue go];
	
	if (downloadView != nil) {
		[downloadView release];
		downloadView = nil;
	}
	if ([self isPad]) {

		downloadView = [[DownloadView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
	}
	else {
		downloadView = [[DownloadView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
	}
	
//	CGAffineTransform transform = downloadView.transform;   
//	transform = CGAffineTransformRotate(transform,-3.1415926f/2.0f);
//	downloadView.transform = transform; 
	if ([self isPad]) {
		downloadView.center = CGPointMake(512,384);
	}
	else {
		downloadView.center = CGPointMake(240,160);
	}
	downloadView.bookID = 1;
	downloadView.bookName = @"";
    
	downloadView.bookPath = [NSString stringWithFormat:@"%@%@",DOWNLOAD_FILE_URL,resourceFile];
    
    
	downloadView.delegate = self;
	[downloadView downButtonClick];
    isDownloading = true;
	// Add the Download View
	[self.view addSubview:downloadView];
	
}

- (void)downloadVersion:(BOOL)type
{
    if(isUpdate){
        return;
    }
    if (isVersionChecking) {
        return;
    }

    isVersionChecking = true;
    isSimpleType = type;
    isDownloadSource = false;
    
    if (!type) {
        [waitView show];
    }

	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	NSString *folderPath = [path stringByAppendingPathComponent:@"temp"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:folderPath];
	
	if (!fileExists) {
		[fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
    
    NSString *version = [NSString stringWithFormat:@"%@%@",DOWNLOAD_FILE_URL,DOWNLOAD_FILE_VERSION];
	NSURL *url = [NSURL URLWithString:version];
    
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];

	request.delegate = self;

	NSString *savePath = [path stringByAppendingPathComponent:[NSString stringWithString:@"version.plist"]];
	NSString *tempPath = [path stringByAppendingPathComponent:[NSString stringWithString:@"version.plist.temp"]];
	
	[request setDownloadDestinationPath:savePath];
	
	[request setTemporaryFileDownloadPath:tempPath];
	[request start];
	
	[request release];
}

- (void)downBtnOfBookWasClicked:(DownloadView *)book {
	
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	NSString *folderPath = [path stringByAppendingPathComponent:@"temp"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL fileExists = [fileManager fileExistsAtPath:folderPath];
	
	if (!fileExists) {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
	
	NSURL *url = [NSURL URLWithString:book.bookPath];

	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];

	request.delegate = self;

	NSString *savePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d.zip",book.bookID]];
	NSString *tempPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"temp/book_%d.zip.temp",book.bookID]];

	[request setDownloadDestinationPath:savePath];
	
	[request setTemporaryFileDownloadPath:tempPath];

	[request setDownloadProgressDelegate:book];
	[request setAllowResumeForFileDownloads:YES];

	[request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:book.bookID],@"bookID",nil]];
	[netWorkQueue addOperation:request];

	[request release];
}

- (void)pauseBtnOfBookWasClicked:(DownloadView *)book {
	
	for (ASIHTTPRequest *request in [netWorkQueue operations]) {	
		NSInteger bookid = [[request.userInfo objectForKey:@"bookID"] intValue];
		if (book.bookID == bookid) {
		
			[request clearDelegatesAndCancel];
            
		}
	}
}

- (void)checkUpdateState{
    isServiceBusy = NO;
    isVersionChecking = false;
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/version.plist"];
	NSDictionary *versionDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    if(resourceFile != nil){
		[resourceFile release];
		resourceFile = nil;
	}
    resourceFile = [[NSString alloc] initWithString:[versionDictionary objectForKey:@"resource"]];
    NSLog(@"version:%i ",[[versionDictionary objectForKey:@"version"] intValue]);
        NSLog(@"levels:%i ",[[versionDictionary objectForKey:@"availableLevels"] intValue]);
	if ([[versionDictionary objectForKey:@"version"] intValue] !=  getDownVersion()) {
		isUpdate = YES;
        if (!isSimpleType ) {
            [waitView dismissWithClickedButtonIndex:0 animated:NO];
            [self downloadResource];
        }
	}else{
        if (!isSimpleType ) {
            [waitView dismissWithClickedButtonIndex:0 animated:NO];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NO_NEW_LEVEL delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
}


#pragma mark -
#pragma mark ASIHTTPRequestDelegate method

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
	
	//NSLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
	if (isDownloadSource) {
		DownloadView *temp = [[self.view subviews] lastObject];
		
		NSLog(@"userInfo:::::::%d",[[request.userInfo objectForKey:@"bookID"] intValue]);
		NSLog(@"bookId::::%d",temp.bookID);
		if (temp.bookID == [[request.userInfo objectForKey:@"bookID"] intValue]) {
					NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
			float tempConLen = [[userDefaults objectForKey:[NSString stringWithFormat:@"book_%d_contentLength",temp.bookID]] floatValue];
			
			if (tempConLen == 0 ) {	
				[userDefaults setObject:[NSNumber numberWithFloat:request.contentLength/1024.0/1024.0] forKey:[NSString stringWithFormat:@"book_%d_contentLength",temp.bookID]];
			}
		}
	}
}
- (void)requestFinished:(ASIHTTPRequest *)request {

    int code = [request responseStatusCode];
	if(code != 200){
        [self requestFailed:request];
		return;
	}
	if (isDownloadSource) {
		for (DownloadView *temp in [self.view subviews]) {			
			if ([temp respondsToSelector:@selector(bookID)]) {
				
				if (temp.bookID == [[request.userInfo objectForKey:@"bookID"] intValue]) {
					
					temp.downloadCompleteStatus = YES;
					[temp unZipClick];
					[temp setNeedsDisplay];
				}
			}
		}
        

	}
	else {
		[self checkUpdateState];
	}

}

-(void)updateVersionInfo{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/version.plist"];
    NSDictionary *versionDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    availableLevels =[[versionDictionary objectForKey:@"availableLevels"]intValue];
    setDownVersion([[versionDictionary objectForKey:@"version"]intValue]);
    isUpdate = false;
    SaveFile();
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	if (isDownloadSource) {
		[downloadView removeFromSuperview];
		isDownloading = false;
	    NSLog(@"down fail.....");
        isPurchasing = false;
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_DOWNLOAD_FAILED message:DOWNLOAD_FAIED delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];    // failed to download contents
        [alert show];
        [alert release];
    }else{
        isServiceBusy = YES;
        if( !isSimpleType ){
            [waitView dismissWithClickedButtonIndex:0 animated:NO];
        	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_DOWNVERION_FAILED message:TIME_OUT delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];    // failed to check version
        	[alert show];
        	[alert release];
    	}
    	isVersionChecking = false;
    }  
}



#endif

@end
