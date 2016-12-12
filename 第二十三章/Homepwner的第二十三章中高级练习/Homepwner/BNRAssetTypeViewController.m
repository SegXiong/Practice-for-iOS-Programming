//
//  BNRAssetTypeViewController.m
//  Homepwner
//
//  Created by More Xiong on 07/12/2016.
//  Copyright © 2016 More Xiong. All rights reserved.
//

#import "BNRAssetTypeViewController.h"
#import <UIKit/UIKit.h>
#import "BNRItem.h"
#import "BNRItemStore.h"
#import "BNRNewAssetNameViewController.h"

@interface BNRAssetTypeViewController ()

@property (nonatomic, strong) BNRNewAssetNameViewController *nameSelector;

@property (nonatomic, strong) NSMutableArray *itemsOfType;

@end

@implementation BNRAssetTypeViewController

- (instancetype)init
{
    return [super initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIBarButtonItem *addNewAssetTypeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAssetName)];
    self.navigationItem.rightBarButtonItem = addNewAssetTypeButton;  //中级练习
}

//高级练习
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [[BNRItemStore sharedStore].allAssetTypes count];
    } else {
        NSArray *allitems = [[[BNRItemStore sharedStore] allItems] mutableCopy];
        self.itemsOfType = [[NSMutableArray alloc] init];
        if (!self.item.assetType) {
            return 0;
        } else {
            for (BNRItem *item in allitems) {
                if (item.assetType == self.item.assetType) {
                    [self.itemsOfType addObject:item];
                }
            }
        }
        return [self.itemsOfType count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
        NSManagedObject *assetType = allAssets[indexPath.row];
        NSString *assetLabel = [assetType valueForKey:@"label"];
        cell.textLabel.text = assetLabel;
        
        if (assetType == self.item.assetType) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        BNRItem *item = self.itemsOfType[indexPath.row];
        cell.textLabel.text = item.itemName;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
        NSManagedObject *assetType = allAssets[indexPath.row];
        self.item.assetType = assetType;
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//中级练习
- (void)addAssetName
{
    self.nameSelector = [[BNRNewAssetNameViewController alloc] init];
    [self.navigationController pushViewController:self.nameSelector animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.nameSelector.assetName.text) {
        NSString *newName = self.nameSelector.assetName.text;
        [[BNRItemStore sharedStore] creatAssetType:newName];
        
        [self.tableView reloadData];
        self.nameSelector.assetName.text = nil;
        
    }
}

//高级练习
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Asset Types";
    } else {
        return @"All items of selected Asset Type";
    }
}

@end
