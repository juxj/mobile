//
//  StoreInfoManager.h
//  A04
//
//  Created by Tony Ju on 2/28/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "DBUtil.h"

@class DBUtil, StoreInfo;
@interface StoreInfoManage : BaseManager <DBUtilProtocol>

-(int) saveStoreInfo:(StoreInfo *) instance;
-(int) deleteStoreInfoByKey:(NSString *) pk;


-(StoreInfo *) getStoreInfoByPK:(NSString *) pk;
-(NSMutableArray *) getStoreInfoListByKeyword:(NSString *) keyword :(NSString *) currPage;
-(NSMutableArray *) getAll:(NSString *) currPage;

@end