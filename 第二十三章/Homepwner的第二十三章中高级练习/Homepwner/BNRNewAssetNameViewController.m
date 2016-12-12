//
//  BNRNewAssetNameViewController.m
//  Homepwner
//
//  Created by More Xiong on 07/12/2016.
//  Copyright © 2016 More Xiong. All rights reserved.
//

#import "BNRNewAssetNameViewController.h"

@interface BNRNewAssetNameViewController ()

@end

@implementation BNRNewAssetNameViewController

//中级练习
- (IBAction)done:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
