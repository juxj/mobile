//
//  MainViewController.m
//  A04
//
//  Created by Tony Ju on 2/28/13.
//  Copyright (c) 2013 Tony Ju. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import "StoreInfo.h"
#import "StoreInfoManager.h"
#import "Constants.h"


@implementation MainViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
    currPage = 1;
    storeInfoMgr = [[StoreInfoManage alloc] init];
    dataArray  = [self getStoreNameArray];
    //dataArray = [[NSMutableArray alloc] initWithObjects:@"What time is it?", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:APP_TABLE_VIEW_FONT_SIZE];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

- (void)refresh {
    [self performSelectorOnMainThread:@selector(addItem) withObject:nil waitUntilDone:NO];
}

- (void)addItem {
    // Add a new time
    currPage = currPage + 1;
    [dataArray release];
    dataArray = [self getStoreNameArray];
    [self.tableView reloadData];
    NSLog(@"%@ %d", @"Data Array Count:",[dataArray count]);
    [self stopLoading];
}
- (IBAction)onBtnSearchClick:(id)sender {
  
    
}

-(NSMutableArray *) getStoreNameArray {
    
    NSMutableArray *array = [storeInfoMgr getAll:currPage];
    
  
    NSMutableArray* storeArray = [[NSMutableArray alloc] init];
    if (array != NULL) {
        int index = 0;
        int startIndex = (currPage - 1) * APP_PAGE_SIZE +1;
        NSLog(@"%d", startIndex);
        for (StoreInfo *store in array) {
            NSString *value = [NSString stringWithFormat:@"%d%@ %@", startIndex,@".", store.name];
            [storeArray insertObject:value atIndex: index];
            startIndex ++;
            index ++;
            //NSLog(@"%@", store.name);
        }
    } else {
        NSLog(@"No data items.");
    }
    return storeArray;
}

- (StoreInfo *) getStoreInfoByPK:(NSString *) pk {
    StoreInfo* storeInfo = [storeInfoMgr getStoreInfoByPK:pk];
    if (storeInfo != NULL) {
        NSLog(@"%@", storeInfo.name);
    }
    return storeInfo;
}
@end
