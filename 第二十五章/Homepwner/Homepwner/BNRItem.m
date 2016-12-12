//
//  BNRItem.m
//  RandomItems
//
//  Created by More Xiong on 16/6/29.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRItem.h"

@interface BNRItem ()

@end

@implementation BNRItem

@dynamic dateCreated;
@dynamic itemKey;
@dynamic itemName;
@dynamic orderingValue;
@dynamic serialNumber;
@dynamic thumbnail;
@dynamic thumbnailData;
@dynamic valueInDollars;
@dynamic assetType;

- (void)setThumbnailFromImage:(UIImage *)image
{
    CGSize origImageSize = image.size;
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    float ratio = MAX(newRect.size.width / origImageSize.width,newRect.size.height / origImageSize.height);
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    [image drawInRect:projectRect];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    UIGraphicsEndImageContext();
}

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    self.dateCreated = [NSDate date];
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *key = [uuid UUIDString];
    self.itemKey = key;
}

@end
