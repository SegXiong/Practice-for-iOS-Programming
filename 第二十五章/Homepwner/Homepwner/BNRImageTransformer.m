//
//  BNRImageTransformer.m
//  Homepwner
//
//  Created by More Xiong on 07/12/2016.
//  Copyright © 2016 More Xiong. All rights reserved.
//

#import "BNRImageTransformer.h"
#import <UIKit/UIKit.h>

@implementation BNRImageTransformer

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}

@end
