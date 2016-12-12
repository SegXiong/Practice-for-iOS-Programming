//
//  BNRItemStore.m
//  Homepwner
//
//  Created by More Xiong on 2016/11/6.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore  ()

@property (nonatomic) NSMutableArray *privateItemsUp50;
@property (nonatomic) NSMutableArray *privateItemsTo50;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateItemsUp50 = [[NSMutableArray alloc] init];
        _privateItemsTo50 = [[NSMutableArray alloc] init];
    }
    return self;
    
}

- (NSArray *)itemsDown50
{
    return [self.privateItemsTo50 copy];
}

-(NSArray *)itemsOver50
{
    return [self.privateItemsUp50 copy];
}

- (BNRItem *)creatItem
{
    BNRItem *item = [BNRItem randomItem];
    if (item.valueInDollars <= 50) {
        [self.privateItemsTo50 addObject:item];
    } else {
        [self.privateItemsUp50 addObject:item];
    }
    return item;
}  //初级练习

@end
