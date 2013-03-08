//
//  StoreInfo.h
//  A04
//
//  Created by Tony Ju on 2/28/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreInfo : NSObject{
    NSString *storeId;
    NSString *name;
    NSString *brands;
    NSString *address;
    NSString *tel;
    NSDate *createdDate;

}

@property (nonatomic, assign) NSString *storeId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *brands;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSDate *createdDate;

@end
