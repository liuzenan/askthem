//
//  QuestionModel.h
//  AskMe
//
//  Created by Zenan on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Parse/Parse.h>


#pragma mark - PFObject Question Class
// Class key
extern NSString *const kATQuestionClassKey;

// Field keys
extern NSString *const kATQuestionTitleKey;
extern NSString *const kATQuestionBodyKey;
extern NSString *const kATQuestionUserKey;

@interface QuestionModel : PFObject {
    
}

+ (QuestionModel*)newQuestion;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;

@end
