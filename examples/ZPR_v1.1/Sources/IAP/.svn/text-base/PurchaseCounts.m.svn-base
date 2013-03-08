//
//  PurchaseCounts.m
//  ZPR
//
//  Created by Kale Guo on 11-11-18.
//  Copyright (c) 2011年 Break Media. All rights reserved.
//

#import "PurchaseCounts.h"

@implementation PurchaseCounts
- (id) init
{
    if ((self = [super init])) {
        
        return self;
    }
    return nil;
}
-(void)updateCounts:(float)dt{
    if (isBeginCount) {
        timeCounts+=dt;
    }
    
}
-(BOOL)isTimeOut{
    return timeCounts>60000.f;
}
     
- (void)willPresentAlertView:(UIAlertView *)alertView{
    // before animation and hiding view
    isBeginCount = YES;
    timeCounts=0.f;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
   // after animation
    isBeginCount = NO;

}

-(void)stopCount{
    isBeginCount = NO;
}
@end
