//
//  MainViewController.m
//  A03
//
//  Created by Tony Ju on 2/27/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import "MainViewController.h"
#import "NetworkChecker.h"

@interface MainViewController ()

@end



@implementation MainViewController

@synthesize lblTest;
@synthesize checker;

- (void) callback:(NSString *) message {
    lblTest.text = message;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBtnClick:(id)sender {
    [self checkNetworkStatus];
}


- (void) checkNetworkStatus {
    NSString *host = @"www.apple.com";
    checker = [[NetworkChecker alloc] initWithHostName:host];
    checker.delegate = self;
    [checker getNetworkStatus];
}
@end
