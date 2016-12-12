//
//  BNRItemCell.m
//  Homepwner
//
//  Created by More Xiong on 01/12/2016.
//  Copyright © 2016 More Xiong. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

- (IBAction)showImage:(id)sender
{
    if (self.actionBliock) {
        self.actionBliock();
    }
}

@end
