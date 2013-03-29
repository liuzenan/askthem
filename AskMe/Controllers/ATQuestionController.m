//
//  ATQuestionController.m
//  AskMe
//
//  Created by Minitheory Design on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ATQuestionController.h"
#import "QuestionModel.h"

@implementation ATQuestionController

// Singletonify this class
+ (ATQuestionController *)shared{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        NSLog(@"Initializing ATQuestionController");
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (QuestionModel*)createQuestion:(NSString *)body title:(NSString *)title {
    
    QuestionModel *question = [QuestionModel newQuestion];
    question.title = title;
    question.body = body;
    
    return question;
}

- (void)saveQuestion:(QuestionModel *)question{
    [question saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"succeeded:%@, error:%@", (succeeded?@"YES":@"NO"), error);
    }];
}

- (void)getPopularQuestions:(PFArrayResultBlock)block{
  
    NSLog(@"getPopularQuestions");
    PFQuery *query = [PFQuery queryWithClassName:kATQuestionClassKey];
    //[query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    
    [query orderByDescending:@"likes"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d questions.", objects.count);
            
            if (block){
                block(objects, error);
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}



@end
