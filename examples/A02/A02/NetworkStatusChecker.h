//
//  NetworkStatusChecker.h
//  A02
//
//  Created by Tony Ju on 2/25/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@class Reachability;
@interface NetworkStatusChecker : NSObject {
    Reachability* r;
}

@property (nonatomic, retain)  Reachability *r;
- (NSString *) getNetworkStatus;
- (id) initWithHostName:(NSString *) hostName;
@end
