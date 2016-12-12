//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by More Xiong on 2016/11/10.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end
