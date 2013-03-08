//
//  StoreInfoManager.m
//  A04
//
//  Created by Tony Ju on 2/28/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
// Objective-C /C++

#import "StoreInfoManager.h"
#import "DBUtil.h"
#import "StoreInfo.h"
#import "BaseManager.h"

@implementation StoreInfoManage:BaseManager

-(id) populateObject:(sqlite3_stmt *)stmt {
    StoreInfo *store = [[StoreInfo alloc] init];
    
    NSString *storeId = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(stmt, 0)];
    
    NSString *storeName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(stmt, 1)];
    
    
    NSString *brands = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(stmt, 2)];
    
    
    NSString *address = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(stmt, 3)];
    
    
    NSString *tel = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(stmt, 4)];
    
    NSString *createdDate = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(stmt, 5)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    store.storeId = storeId;
    store.name = storeName;
    store.brands = brands;
    store.address = address;
    store.tel  = tel;
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    store.createdDate = [dateFormatter dateFromString:createdDate];
    return store;
}

-(NSString *) getTableName {
    return @"store_info";
}

-(id)init {
    if (self = [super initDatabase]) {
        db.delegate = self;
        NSLog(@"%@", [db.delegate getTableName]);
    }
    return self;
}

//根据主键查找对象
-(StoreInfo *) getStoreInfoByPK:(NSString *) pk {
    StoreInfo *storeInfo = NULL;
    NSObject* obj = [db getObjectByPK:@"store_id" :pk];
    if (obj != NULL) {
        storeInfo = (StoreInfo *) obj;
    }
    return storeInfo;
}
//查找全部对象
-(NSMutableArray *) getAll :(NSString *) currPage{
    NSLog(@"GetALL");
    return [db getAll:currPage];
}
//根据关键词查询
-(NSMutableArray *) getStoreInfoListByKeyword:(NSString *) keyword :(NSString *) currPage{
    NSString *sql =[NSString stringWithFormat:
        @"%@%@%@",@"select * from strore_info where tel like '%", keyword, @"%"];
    return [db query:sql :currPage];
}
//保存
-(int) saveStoreInfo:(StoreInfo *) instance {
    return 0;
}
//删除
-(int) deleteStoreInfoByKey:(NSString *) pk {
    return 0;
}
@end
