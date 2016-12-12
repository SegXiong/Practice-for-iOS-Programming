//
//  BNRItemStore.h
//  Homepwner
//
//  Created by More Xiong on 2016/11/6.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import <Foundation/Foundation.h>
@ class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *itemsOver50;
@property (nonatomic, readonly) NSArray *itemsDown50;

+ (instancetype)sharedStore;

- (BNRItem *)creatItem;

@end
