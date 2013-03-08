//
//  MyBookView.m
//
//  Created by pubo on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "DownloadView.h"
#import "ASIHTTPRequest.h"
#import "ZipArchive.h"
#import "MBProgressHUD.h"
#import "ZPRAppDelegate.h"
#import "ZPRViewController.h"
#import "GameStore.h"

@implementation DownloadView

@synthesize delegate;
@synthesize bookID;
@synthesize bookName;
@synthesize contentLength;
@synthesize bookPath;
@synthesize zztjProView;
@synthesize downText;
@synthesize downloadCompleteStatus;
bool isDownloading;
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

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		self.backgroundColor = [UIColor grayColor];
		self.alpha = 0.9;
		
		
		
		downText = [[UILabel alloc] initWithFrame:CGRectMake(180, 80, 200, 30)];
		downText.backgroundColor = [UIColor clearColor];
		[downText setTextAlignment:UITextAlignmentCenter];
		CGRect screenRect=[[UIScreen mainScreen] bounds];
		if ([self isPad]) {
			zztjProView = [[UIProgressView alloc] initWithFrame:CGRectMake(75, 100, 150, 20)];
			zztjProView.center = CGPointMake(screenRect.size.height/2.0f, screenRect.size.width/2.0f);
			downText.center = CGPointMake(screenRect.size.height/2.0f, screenRect.size.width/2.0f-40.0f);
		}
		else {
			zztjProView = [[UIProgressView alloc] initWithFrame:CGRectMake(75, 100, 150, 20)];
			zztjProView.center = CGPointMake(screenRect.size.height/2.0f, screenRect.size.width/2.0f);
			downText.center = CGPointMake(screenRect.size.height/2.0f, screenRect.size.width/2.0f-40.0f);
		}
		
		[self addSubview:zztjProView];
		[self addSubview:downText];		
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code.
	
	downText.text = bookName;
	
	if (downloadCompleteStatus) {
		
		

		
	}else {
		
	
	}
}

#pragma mark -
#pragma mark click method
- (void)downButtonClick {
	
	if ([delegate respondsToSelector:@selector(downBtnOfBookWasClicked:)]) {
		
		[delegate downBtnOfBookWasClicked:self];
	}
}

- (void)pauseButtonClick {
	
	if ([delegate respondsToSelector:@selector(pauseBtnOfBookWasClicked:)]) {

	}
}

-(void)unZipClick {
	downText.hidden = YES;
	MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self animated:YES];
	mbp.labelText = TIPWAIT;
    CGRect screenRect=[[UIScreen mainScreen] bounds];
    mbp.center = CGPointMake(screenRect.size.height/2.0f, screenRect.size.width/2.0f);
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d.zip",bookID]];
	NSString *unZipPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d",bookID]];
	ZipArchive *zip = [[ZipArchive alloc] init];
	
	BOOL result;
	
	if ([zip UnzipOpenFile:filePath]) {
		
		result = [zip UnzipFileTo:unZipPath overWrite:YES];
		if (!result) {
		
			NSLog(@"unzip fail................");
		}else {
		
			NSLog(@"unzip success.............");
		
			[self performSelector:@selector(threeClick) withObject:nil afterDelay:3];
		}

		[zip UnzipCloseFile];
	}
	
	
}
- (void)threeClick {
	
	[MBProgressHUD hideHUDForView:self animated:YES];
    [self removeFromSuperview];
    isDownloading = false;
    [app.viewController   updateVersionInfo];
#ifdef V_FREE
    if (havePurchasedComic)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_DOWNLOAD_SUCCESSFUL message:SUCESS1_PAID delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_PURCHASE_SUCCESSFUL message:SUCESS1_FREE delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        havePurchasedComic = true;
    }
#else
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_DOWNLOAD_SUCCESSFUL message:SUCESS1_PAID delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
#endif
}

#pragma mark -
#pragma mark ASIProgressDelegate method


- (void)setProgress:(float)newProgress {
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	self.contentLength = [[userDefaults objectForKey:[NSString stringWithFormat:@"book_%d_contentLength",bookID]] floatValue];
	downText.text = [NSString stringWithFormat:@"%.2f/%.2fM",self.contentLength*newProgress,self.contentLength];
	zztjProView.progress = newProgress;
    
}




#pragma mark -
#pragma mark dealloc method

- (void)dealloc {
	
	[zztjProView release];
	[downText release];
	
    [super dealloc];
}


@end
