//
//  BNRWebViewController.m
//  Nerdfeed
//
//  Created by More Xiong on 04/12/2016.
//  Copyright © 2016 More Xiong. All rights reserved.
//

#import "BNRWebViewController.h"

@interface BNRWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BNRWebViewController

- (void)loadView
{
    _webView = [[UIWebView alloc] init];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    self.view = _webView;
}

- (void)setURL:(NSURL *)URL
{
    _URL = URL;
    if (_URL) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [self.webView loadRequest:req];
    }
}

//中级练习
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIBarButtonItem *goBackButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self.view action:@selector(goBack)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *goForwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self.view action:@selector(goForward)];
        [goBackButton setEnabled:NO];
        [goForwardButton setEnabled:NO];
        self.toolbarItems = [[NSArray alloc] initWithObjects:goBackButton, flexibleSpace, goForwardButton, nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
};

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.toolbarItems.firstObject setEnabled:webView.canGoBack];
    [self.toolbarItems.lastObject setEnabled:webView.canGoForward];
}

@end
