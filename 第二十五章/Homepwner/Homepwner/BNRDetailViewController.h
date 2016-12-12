//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by More Xiong on 2016/11/9.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;

@interface BNRDetailViewController : UIViewController <UIViewControllerRestoration>

@property (nonatomic, strong) BNRItem *item;

@property (nonatomic, copy) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;

@end
