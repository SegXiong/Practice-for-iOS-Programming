//
//  BNRHypnosiViewController.m
//  HypnoNerd
//
//  Created by More Xiong on 2016/11/3.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRHypnosiViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosiViewController ()

@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation BNRHypnosiViewController

- (IBAction)changeColor:(UISegmentedControl *)sender
{
    BNRHypnosisView *hypnosisView = [[BNRHypnosisView alloc] init];
    hypnosisView = (BNRHypnosisView *)self.view;
    
    if (sender.selectedSegmentIndex == 0) {
        hypnosisView.circleColor = [UIColor redColor];
    }
    else if (sender.selectedSegmentIndex == 1) {
        hypnosisView.circleColor = [UIColor greenColor];
    }
    else if (sender.selectedSegmentIndex == 2) {
        hypnosisView.circleColor = [UIColor blueColor];
    }
    
} //中级练习

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = image;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"BNRHypnosiViewController loaded its view.");
}

@end
