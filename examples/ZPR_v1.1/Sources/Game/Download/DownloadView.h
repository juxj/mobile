//
//  MyBookView.h
//
//  Created by pubo on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIProgressDelegate.h"

@class MyBookView;

@protocol MyBookDelegate <NSObject>
 @optional
- (void)downBtnOfBookWasClicked:(UIView *)book;
- (void)pauseBtnOfBookWasClicked:(MyBookView *)book;
- (void)readBtnOfBookWasClicked:(MyBookView *)book;
@end


@interface DownloadView : UIView <ASIProgressDelegate>{
  
	id delegate;
	int bookID;//ID
	NSString *bookName;
	float contentLength;
	NSString *bookPath;
	UIProgressView *zztjProView;
	UILabel *downText;
	BOOL downloadCompleteStatus;
}

extern bool isDownloading;
@property (nonatomic,assign)id<MyBookDelegate> delegate;

@property (nonatomic,assign)int bookID;
@property(nonatomic ,retain)NSString *bookName;
@property (nonatomic,assign)float contentLength;
@property(nonatomic ,retain)NSString *bookPath;
@property(nonatomic ,retain)UIProgressView *zztjProView;
@property(nonatomic ,retain)UILabel *downText;
@property (nonatomic,assign)BOOL downloadCompleteStatus;

- (void)downButtonClick;
- (void)unZipClick;

@end
