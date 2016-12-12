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

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;

- (BNRItem *)creatItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

- (BOOL)saveChanges;

- (NSArray *)allAssetTypes;

@end
