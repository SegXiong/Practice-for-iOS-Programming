//
//  BNRItemCell.h
//  Homepwner
//
//  Created by More Xiong on 01/12/2016.
//  Copyright © 2016 More Xiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *ValueLabel;

@property (nonatomic, copy) void (^actionBliock)(void);

@end
