//
//  BNRDateViewController.m
//  Homepwner
//
//  Created by More Xiong on 2016/11/9.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRDateViewController.h"
#import "BNRItem.h"

@interface BNRDateViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRDateViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BNRItem *item = self.item;
    [self.datePicker setDate:item.dateCreated animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    BNRItem *item = self.item;
    item.dateCreated = self.datePicker.date;
}

@end
