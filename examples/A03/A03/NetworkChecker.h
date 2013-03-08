//
//  NetworkChecker.h
//  A03
//
//  Created by Tony Ju on 2/27/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol myTestProtocol <NSObject>
@required
- (void) callback:(NSString *) message;
@end

@class Reachability;
@interface NetworkChecker : NSObject{
id <myTestProtocol> delegate;
}

@property (nonatomic, retain) id<myTestProtocol>delegate;
@property (nonatomic, retain) Reachability* r;

- (void) getNetworkStatus;
- (id) initWithHostName:(NSString *) hostName;

@end
