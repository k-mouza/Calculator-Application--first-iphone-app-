//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Mouza Mac on 6/27/13.
//  Copyright (c) 2013 Mouza Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void) pushOperand:(double)operand;
-(double) performOperation:(NSString *)operation;
-(void) clearAll;

@end
