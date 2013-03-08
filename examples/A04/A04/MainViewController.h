//
//  MainViewController.h
//  A04
//
//  Created by Tony Ju on 2/28/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

@class StoreInfoManage;
#import <Foundation/Foundation.h>
#import "PullRefreshTableViewController.h"


@interface MainViewController : PullRefreshTableViewController {
    NSMutableArray *dataArray;
    StoreInfoManage *storeInfoMgr;
    int currPage;
}

- (IBAction)onBtnSearchClick:(id)sender;

@end
