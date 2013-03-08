//
//  DBUtil.h
//  A04
//
//  Created by Tony Ju on 2/28/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@protocol DBUtilProtocol <NSObject>
@required
-(NSObject *) populateObject:(sqlite3_stmt *) stmt;
-(NSString *) getTableName;
@end

@interface DBUtil : NSObject{
    NSString *dbFilePath;
    sqlite3 *db;
    id <DBUtilProtocol> delegate;
}

@property (nonatomic, retain) id<DBUtilProtocol>delegate;
@property (nonatomic, retain) NSString *dbFilePath;
/*
 *  initialize db connection;
 */
- (id) initWithDBName:(NSString *) databaseName;
/*
 *  CRUD operations
 */
- (int) insertData:(NSString *) sql;
- (BOOL) deleteObject:(NSString *) sql;
/*
 *  query block here.
 */
- (NSMutableArray *) query:(NSString *) sql :(NSString *) currPage;
- (NSMutableArray *) getAll:(NSString *) currPage;
- (NSObject *) getObjectByPK:(NSString *) pkField :(NSString *) pkValue;

@end
 