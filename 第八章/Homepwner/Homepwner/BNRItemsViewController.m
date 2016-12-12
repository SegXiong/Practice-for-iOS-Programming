//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by More Xiong on 2016/11/6.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"

@implementation BNRItemsViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore] creatItem];
        }
    }
    return self;
    
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"More than 50$";
    } else {
        return @"Less than 50$";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (section == 0) {
        return [[[BNRItemStore sharedStore] itemsOver50] count];
    } else {
        return [[[BNRItemStore sharedStore] itemsDown50] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items;
    BNRItem *item;
    
    if (indexPath.section == 0) {
        items = [[BNRItemStore sharedStore] itemsOver50];
    } else{
        items = [[BNRItemStore sharedStore] itemsDown50];
    }
    
    item = items[indexPath.row];
    cell.textLabel.text = [item description];
    return cell;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    CGRect frame = self.tableView.tableFooterView.frame;
    frame.size.height = 44.0;
    UITableViewCell *foo = [[UITableViewCell alloc] initWithFrame:frame];
    self.tableView.tableFooterView = foo;
    foo.textLabel.text = @"No more items!";   //中级练习
    
    self.tableView.rowHeight = 60.0;
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgp.jpg"]];  //高级练习
    
}



@end
