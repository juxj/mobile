//
//  BaseManager.m
//  A04
//
//  Created by Tony Ju on 2/28/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import "BaseManager.h"
#import "DBUtil.h"

@implementation BaseManager
@synthesize db;

-(id) initDatabase {
    db = [[DBUtil alloc] initWithDBName:@"4S_STORE"];
    return self;
}
@end