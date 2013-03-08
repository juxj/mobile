//
//  NetworkChecker.m
//  A03
//
//  Created by Tony Ju on 2/27/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import "NetworkChecker.h"
#import "Reachability.h"

@implementation NetworkChecker
@synthesize delegate;
@synthesize r;

- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self getNetworkStatusString:curReach];
}


- (id) initWithHostName:(NSString *) hostName {
    
    if (self = [ super init]) {
        r = [[Reachability reachabilityWithHostName:hostName] retain];
    }
    
    return self;
}

// Get Network Status
- (void) getNetworkStatus{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    NSString *result = [self getNetworkStatusString:r];
    [self.delegate callback:result];
    [r startNotifier];
}

-(NSString *) getNetworkStatusString:(Reachability *) currReach{
    
    NSString *result = @"TOY";
    
    switch ([currReach currentReachabilityStatus]){
        case NotReachable:
            result = NSLocalizedString(@"NO", nil);
            break;
        case ReachableViaWWAN:
            result = NSLocalizedString(@"3G", nil);
            break;
        case ReachableViaWiFi:
            result = NSLocalizedString(@"WIFI", nil);
            break;
    }
    [self.delegate callback:result];
    return result;
}

@end
