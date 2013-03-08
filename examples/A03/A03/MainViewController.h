//
//  MainViewController.h
//  A03
//
//  Created by Tony Ju on 2/27/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkChecker.h"




@class NetworkChecker;
@interface MainViewController : UIViewController<myTestProtocol>{
    NetworkChecker *checker;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTest;
@property (nonatomic, retain) NetworkChecker* checker;

- (IBAction)onBtnClick:(id)sender;

@end
