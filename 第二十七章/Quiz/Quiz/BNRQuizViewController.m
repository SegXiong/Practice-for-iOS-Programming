//
//  BNRQuizViewController.m
//  Quiz
//
//  Created by More Xiong on 16/6/27.
//  Copyright © 2016年 More Xiong. All rights reserved.
//

#import "BNRQuizViewController.h"

@interface BNRQuizViewController ()

@property (nonatomic) int currentQuestionIndex;

@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;

@property (nonatomic, weak) IBOutlet UILabel *questionLable;
@property (nonatomic, weak) IBOutlet UILabel *answerLable;

@end

@implementation BNRQuizViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.questions = @[@"From what is cognac made?",
                           @"What is 7+7?",
                           @"what is the capital of Vermont?"];
        
        self.answers = @[@"Grapes",
                         @"14",
                         @"montpelier"];
    }
    return self;
}

- (IBAction)showQuestion:(id)sender
{
    self.currentQuestionIndex++;
    if (self.currentQuestionIndex == [self.questions count]) {
        self.currentQuestionIndex = 0;
    }
    NSString *question = self.questions[self.currentQuestionIndex];

    [self animateLabel:self.questionLable withStrings:question];

    if (![self.answerLable.text isEqualToString:@"???"]) {
        [self animateLabel:self.answerLable withStrings:@"???"];
    }
    
}

- (IBAction)showAnswer:(id)sender
{
    NSString *answer =self.answers[self.currentQuestionIndex];

    [self animateLabel:self.answerLable withStrings:answer];
}


//中级练习
- (void)animateLabel:(UILabel *)label withStrings:(NSString *)text
{
    CGFloat windowWidth = [[UIScreen mainScreen] bounds].size.width;
    CGRect origRect = label.frame;
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 0.0;
        CGRect newRect = origRect;
        newRect.origin.x = windowWidth;
        label.frame = newRect;
    }completion:^(BOOL finished) {
        label.text = text;
        CGRect newRect = origRect;
        newRect.origin.x = -windowWidth;
        label.frame = newRect;
        [UIView animateWithDuration:0.5 animations:^{
            label.alpha = 1.0;
            label.frame = origRect;
        }completion:nil];
    }];
    
    }

@end
