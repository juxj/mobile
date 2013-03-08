//
//  MainViewController.h
//  A02
//
//  Created by Tony Ju on 2/25/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetworkStatusChecker;
@interface MainViewController : UIViewController{
    NetworkStatusChecker* checker;
}
@property (nonatomic, retain) NetworkStatusChecker* checker;
@property (weak, nonatomic) IBOutlet UILabel *lblNetworkStatus;
- (IBAction)onBtnNetworkStatusClick:(id)sender;

@end