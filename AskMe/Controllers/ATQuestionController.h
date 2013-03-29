//
//  ATQuestionController.h
//  AskMe
//
//  Created by Minitheory Design on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuestionModel;

@interface ATQuestionController : NSObject {
    
    
}

+ (ATQuestionController*)shared;

- (QuestionModel*)createQuestion:(NSString*)body title:(NSString*)title;

- (void)saveQuestion:(QuestionModel*)question;

@end
