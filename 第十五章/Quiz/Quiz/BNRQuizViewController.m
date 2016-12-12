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
    self.questionLable.text = question;
    self.answerLable.text = @"???";
}

- (IBAction)showAnswer:(id)sender
{
    NSString *answer =self.answers[self.currentQuestionIndex];
    self.answerLable.text = answer;
}

@end
