//
//  BNRHypnosiViewController.m
//  HypnoNerd
//
//  Created by More Xiong on 2016/11/3.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRHypnosiViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosiViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;


- (void)drawHypnoticMessage:(NSString *)message;

@end

@implementation BNRHypnosiViewController

- (void)loadView
{
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
    
    CGRect lableFrame = CGRectMake(40, 70, 240, 30);
    self.textField = [[UITextField alloc] initWithFrame:lableFrame];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"Hypnotize me";
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    
    [backgroundView addSubview:self.textField];
    
    self.view = backgroundView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = image;
        
        self.restorationIdentifier = NSStringFromClass([self class]);
        self.restorationClass = [self class];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"BNRHypnosiViewController loaded its view.");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++) {
        UILabel *messageLable = [[UILabel alloc] init];
        messageLable.backgroundColor = [UIColor clearColor];
        messageLable.textColor = [UIColor whiteColor];
        messageLable.text = message;
        
        [messageLable sizeToFit];
        
        int width = (int)(self.view.bounds.size.width - messageLable.bounds.size.width);
        int x = arc4random() % width;
        
        int height = (int)(self.view.bounds.size.height - messageLable.bounds.size.height);
        int y = arc4random() % height;
        
        CGRect frame = messageLable.frame;
        frame.origin = CGPointMake(x, y);
        messageLable.frame = frame;
        
        [self.view addSubview:messageLable];
        
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLable addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLable addMotionEffect:motionEffect];
        
        
    }
}

//中级练习
+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    UITabBarController *tbc = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    return tbc.viewControllers[0];
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.textField.text forKey:@"textFiled.text"];
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.view.subviews forKey:@"subviews"];
    [archiver finishEncoding];
    [coder encodeDataObject:data];
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.textField.text = [coder decodeObjectForKey:@"textFiled.text"];
    
    NSData *data = [coder decodeDataObject];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSArray *subviews = [unarchiver decodeObjectForKey:@"subviews"];
    [unarchiver finishDecoding];
    for (UIView *subview in subviews) {
        [self.view addSubview:subview];
    }
    
    [super decodeRestorableStateWithCoder:coder];
}

@end
