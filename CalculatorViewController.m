//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Mouza Mac on 6/27/13.
//  Copyright (c) 2013 Mouza Mac. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"


@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize description = _description;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

-(CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber)
        self.display.text = [self.display.text stringByAppendingString:digit];
    else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber && [sender.currentTitle isEqualToString:@"+/-"])
        [self.brain pushOperand:[self.display.text doubleValue]];
    else if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    
    self.description.text = [[[self.description.text  stringByReplacingOccurrencesOfString:@" =" withString:@" "] stringByAppendingString:sender.currentTitle] stringByAppendingString:@" ="];
    
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}

- (IBAction)enterPressed
{
    if ([self.description.text length] >= 25) self.description.text = @"";
    self.description.text = [[[self.description.text stringByReplacingOccurrencesOfString:@" =" withString:@" "] stringByAppendingString:self.display.text] stringByAppendingString:@" "];
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)dotPressed:(UIButton *)sender
{
    if (!self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = @"0.";
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    else
        if ([self.display.text rangeOfString:@"."].location == NSNotFound)
        self.display.text = [self.display.text stringByAppendingString:@"."];
}

- (IBAction)cPressed:(UIButton *)sender
{
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.display.text = @"0";
    self.description.text = @"";
    [self.brain clearAll];
}

- (IBAction)backspacePressed:(UIButton *)sender
{
    self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
    if ([self.display.text length] < 1) self.display.text = @"0";
}

@end














