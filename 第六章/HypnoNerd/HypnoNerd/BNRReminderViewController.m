//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by More Xiong on 2016/11/4.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRReminderViewController.h"
//#import <UserNotifications/UserNotifications.h>//@import UserNotifications;

@interface BNRReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Hypnotize me!";
    note.fireDate = date;
    
    UIUserNotificationSettings *noteSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:noteSettings];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = self.tabBarItem;
        tbi.title = @"Reminder";
        UIImage *image = [UIImage imageNamed:@"Time.png"];
        self.tabBarItem.image = image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"BNRReminderViewController loaded its view.");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

@end
