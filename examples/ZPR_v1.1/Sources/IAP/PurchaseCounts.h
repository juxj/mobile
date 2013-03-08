//
//  PurchaseCounts.h
//  ZPR
//
//  Created by Kale Guo on 11-11-18.
//  Copyright (c) 2011年 Break Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PurchaseCounts : NSObject <UIAlertViewDelegate>{
            float timeCounts ;
            BOOL isBeginCount;
            
}
-(BOOL)isTimeOut;
-(void)updateCounts:(float)dt;         
@end
