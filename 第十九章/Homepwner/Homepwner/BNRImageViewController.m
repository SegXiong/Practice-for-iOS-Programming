//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by More Xiong on 03/12/2016.
//  Copyright © 2016 More Xiong. All rights reserved.
//

#import "BNRImageViewController.h"

@interface BNRImageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation BNRImageViewController

//高级练习
- (void)loadView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.imgView = [[UIImageView alloc] initWithImage:self.image];
    scrollView.contentSize = self.imgView.bounds.size;
    scrollView.delegate = self;
    scrollView.maximumZoomScale = 2.0;
    scrollView.minimumZoomScale = 0.5;
    [scrollView addSubview:self.imgView];
    self.view = scrollView;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.contentOffset = CGPointMake(self.imgView.bounds.size.width/2 - scrollView.bounds.size.width/2, self.imgView.bounds.size.height/2 - scrollView.bounds.size.height/2);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgView;
}

@end
