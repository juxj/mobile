//
//  NetworkStatusChecker.m
//  A02
//
//  Created by Tony Ju on 2/25/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import "NetworkStatusChecker.h"
#import "Reachability.h"

@implementation NetworkStatusChecker


@synthesize r;

- (id) initWithHostName:(NSString *) hostName {
    
    if (self = [ super init]) {
        r = [[Reachability reachabilityWithHostName:hostName] retain];
    }
    
    return self;
}

// Get Network Status
- (NSString *) getNetworkStatus{
    
    NSString *result = nil;
    
    switch ([r currentReachabilityStatus]){
        case NotReachable:
            result = NSLocalizedString(@"NETWORK_CONNECTION_NO", nil);
            break;
        case ReachableViaWWAN:
            result = NSLocalizedString(@"NETWORK_CONNECTION_3G", nil);
            break;
        case ReachableViaWiFi:
            result = NSLocalizedString(@"NETWORK_CONNECTION_WIFI", nil);
            break;
    }
    
    return result;
}

@end
