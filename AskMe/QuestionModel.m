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
NSString *const kATQuestionTitleKey  = @"title";
NSString *const kATQuestionBodyKey  = @"body";
NSString *const kATQuestionUserKey  = @"user";

@implementation QuestionModel

@synthesize title, body;

+ (QuestionModel*)newQuestion{
    QuestionModel *question = (QuestionModel*)[PFObject objectWithClassName:kATQuestionClassKey];
    if (question){
        
    }
    return question;
}

- (NSString *)title{
    return [self objectForKey:kATQuestionTitleKey];
}

- (void)setTitle:(NSString *)title{
    [self setObject:title forKey:kATQuestionTitleKey];
    
}

- (NSString *)body{
    return [self objectForKey:kATQuestionBodyKey];
}

- (void)setBody:(NSString *)body{
    [self setObject:body forKey:kATQuestionBodyKey];
}

@end
