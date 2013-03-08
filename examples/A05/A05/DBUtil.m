//
//  DBUtil.m
//  A04
//
//  Created by Tony Ju on 2/28/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import "DBUtil.h"
#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "StoreInfo.h"
#import "Constants.h"


@implementation DBUtil
@synthesize delegate;
@synthesize dbFilePath;


-(NSString *) getQueryConditionsFromDict:(NSDictionary *) dict :(NSInteger *) pageSize :(NSInteger *) pageNumber {
    NSString* result = @" where ";
    NSArray* keys = [dict allKeys];
    //NSArray* values = [dict allValues];
    int m = 0;
    NSString*  connector= @"";
    for (NSString * key in keys) {
        //NSString* value = [values objectAtIndex:m];
        if (m > 0) {
            connector = @" and ";
        }
        m ++;
    }
    return result;
}

-(NSString *) sqlBuilder:(NSDictionary *) dict :(NSInteger *)pageSize :(NSInteger *) pageNumber {
    NSString* sql = NULL;
    NSString* SELECT =[NSString stringWithFormat:@"%@%@", @"select * from ", [self.delegate getTableName]];
    if ([dict count]>0) {
        NSString* queryConditions = [self getQueryConditionsFromDict:dict :pageSize :pageNumber];
        sql = [NSString stringWithFormat:@"%@%@", SELECT, queryConditions];

    } else {
        sql = SELECT;
    }
    return sql;
}

-(id) initWithDBName:(NSString *) databaseName {
    
    if (self = [super init]) {
        dbFilePath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:databaseName];
        NSLog(@"%@", dbFilePath);
    
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        
        BOOL success = [fileMgr fileExistsAtPath:dbFilePath];
        NSLog(success ? @"Yes" : @"No");
        if (success) {
            if(!(sqlite3_open([dbFilePath UTF8String], &db) == SQLITE_OK))
            {
                NSLog(@"An error has occured.");
            } else {
                NSLog(@"Successfully connected to db file");
                sqlite3_close(db);
            }
        }

    }
    return self;
}

-(int) insertData:(NSString *) sql{
    
    int result = 1;
        
    sqlite3_stmt    *statement;
    
    if (sqlite3_open([dbFilePath UTF8String], &db) == SQLITE_OK)
    {
        const char *insert_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            result = 1;
        } else {
            result = 0;
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
        
    } else {
        result = 0;
    }
    
    return result;
}

-(NSObject *) getObjectByPK:(NSString *) pkField :(NSString *) pkValue {
    NSInteger index = 0;
    NSObject* result = NULL;
    NSString *sql =[NSString stringWithFormat:
                    @"%@ %@ %@ %@ %@%@%@",@"select * from ", [self.delegate getTableName], @"where ",pkField,@"='", pkValue, @"'"];
    NSLog(sql, nil);
    NSMutableArray *array = [self query:sql :@"-1"];
    if ([array count] >0) {
        result  = [array objectAtIndex:index];
    }
    return result;
}

-(NSMutableArray *) query:(NSString *) sql :(NSString *) currPage {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    if (sqlite3_open([dbFilePath UTF8String], &db) == SQLITE_OK) {
        sqlite3_stmt* stmt = NULL;
        const char *query_stmt = [sql UTF8String];
        if (sqlite3_prepare_v2(db, query_stmt, -1, &stmt, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(stmt)==SQLITE_ROW) {
                NSObject *object = [self.delegate populateObject:stmt];
                [result addObject:object];
            }
            sqlite3_finalize(stmt);
        }
        sqlite3_close(db);
    } else {
        NSLog(@"Can't open database!");
    }
    return result;
}

-(NSMutableArray *) getAll:(NSString *) currPage {
    NSString *sql = [NSString stringWithFormat:@"%@%@", @"select * from ", [self.delegate getTableName]];
    
    NSLog(@"%@", sql);
    NSString* startIndex = [self getStartIndex:currPage];
    NSLog(@"%@", startIndex);
    sql = [NSString stringWithFormat:@"%@ %@ %@%@%@",
           sql, @"limit", startIndex, @",", DB_PAGE_SIZE];
    return [self query:sql :currPage];
}

-(NSString *) getStartIndex: (NSString *) currPage {
    int startIndex = 0;
    if ([currPage intValue] >  1){
        startIndex = ([currPage intValue] -1)  * [DB_PAGE_SIZE intValue];
    }
    return [NSString stringWithFormat:@"%i", startIndex];
}

-(BOOL) deleteObject:(NSString *) sql {
    return FALSE;
}

@end
