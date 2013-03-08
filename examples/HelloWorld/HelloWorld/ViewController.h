//
//  ViewController.h
//  HelloWorld
//
//  Created by Aaron.Poter on 11-11-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtName;
- (IBAction)buttonClicked:(id)sender;

@end
