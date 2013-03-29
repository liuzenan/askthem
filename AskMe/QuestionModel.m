//
//  QuestionModel.m
//  AskMe
//
//  Created by Zenan on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "QuestionModel.h"

#pragma mark - PFObject Question Class
// Class key
NSString *const kATQuestionClassKey = @"Question";

// Field keys
NSString *const kATQuestionBodyKey  = @"boody";
NSString *const kATQuestionUserKey  = @"user";

@implementation QuestionModel

+ (QuestionModel*)newQuestion{
    id question = [PFObject objectWithClassName:kATQuestionClassKey];
    if (question){
        
    }
    return question;
}

- (NSString *)body{
    return [self objectForKey:kATQuestionBodyKey];
}

- (void)setBody:(NSString *)body{
    [self setObject:body forKey:kATQuestionBodyKey];
}

@end
