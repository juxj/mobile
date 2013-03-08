//
//  BaseManager.h
//  A04
//
//  Created by Tony Ju on 2/28/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class DBUtil;
@interface BaseManager : NSObject{
    DBUtil *db;
}
@property (nonatomic, retain) DBUtil *db;
-(id) initDatabase;

@end
