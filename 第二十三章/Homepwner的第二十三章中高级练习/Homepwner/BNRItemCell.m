//
//  BNRItemCell.m
//  Homepwner
//
//  Created by More Xiong on 01/12/2016.
//  Copyright © 2016 More Xiong. All rights reserved.
//

#import "BNRItemCell.h"

@interface BNRItemCell ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;

@end

@implementation BNRItemCell

- (IBAction)showImage:(id)sender
{
    if (self.actionBliock) {
        self.actionBliock();
    }
}

- (void)updateinterfaceForDynamicTypeSize
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.ValueLabel.font = font;
    
    static NSDictionary *imageSizeDictionary;
    if (!imageSizeDictionary) {
        imageSizeDictionary = @{
                                UIContentSizeCategoryExtraSmall : @40,
                                UIContentSizeCategorySmall : @40,
                                UIContentSizeCategoryMedium : @40,
                                UIContentSizeCategoryLarge : @40,
                                UIContentSizeCategoryExtraLarge : @45,
                                UIContentSizeCategoryExtraExtraLarge : @55,
                                UIContentSizeCategoryExtraExtraExtraLarge : @65};
    }
    NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
    NSNumber *imageSize = imageSizeDictionary[userSize];
    self.imageViewHeightConstraint.constant = imageSize.floatValue;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self updateinterfaceForDynamicTypeSize];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(updateinterfaceForDynamicTypeSize) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.thumbnailView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.thumbnailView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [self.thumbnailView addConstraint:constraint];
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

@end
