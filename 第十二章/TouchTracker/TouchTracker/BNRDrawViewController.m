//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by More Xiong on 2016/11/10.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@interface BNRDrawViewController ()

//@property (nonatomic) BNRDrawView *willLoadView;

@end

@implementation BNRDrawViewController

- (void)loadView
{
    /*self.willLoadView = [[BNRDrawView alloc] initWithFrame:CGRectZero];
    [self.willLoadView redrawSavedLines];
    self.view = self.willLoadView;*/
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

/*- (void)viewWillAppear:(BOOL)animated
{
    [self.willLoadView saveAllLines];
}*/

@end
