//
//  BNRPopoverBackgroundView.m
//  Homepwner
//
//  Created by More Xiong on 2016/11/27.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRPopoverBackgroundView.h"

@implementation BNRPopoverBackgroundView

//高级练习
@synthesize arrowOffset = _arrowOffset;
@synthesize arrowDirection = _arrowDirection;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.arrowDirection = UIPopoverArrowDirectionAny;
        self.arrowOffset = 0;
    }
    return self;
}

+ (CGFloat)arrowBase
{
    return 0;
}

+ (CGFloat)arrowHeight
{
    return 0;
}

+ (UIEdgeInsets)contentViewInsets
{
    return UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0);
}

@end
