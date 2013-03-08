//
//  MainViewController.m
//  A02
//
//  Created by Tony Ju on 2/25/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import "MainViewController.h"
#import "NetworkStatusChecker.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize lblNetworkStatus;
@synthesize checker;

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


- (void) networkStatusChanged:(NetworkStatusChecker *) checker {
    NSString *msgNetworkStatus = checker.getNetworkStatus;
    lblNetworkStatus.text = msgNetworkStatus;
}

- (IBAction)onBtnNetworkStatusClick:(id)sender {
    
    //Instance Network Status Checker;
    checker = [[NetworkStatusChecker alloc] retain];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanges:) name:kReachabilityChangedNotification object:nil];
    //Get network status
    [self networkStatusChanged:checker];
    [checker.r startNotifier];
    
    /* Alert
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really reset?" message:msgNetworkStatus delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    //[alert addButtonWithTitle:@"Yes"];
    
    [alert show];
     */
    
}
@end
