//
//  ATNewQuestionViewController.h
//  AskMe
//
//  Created by Minitheory Design on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATBaseViewController.h"

@class QuestionModel;

@protocol ATNewQuestionDelegate;

@interface ATNewQuestionViewController : ATBaseViewController <UITextViewDelegate, UITextFieldDelegate, UIAlertViewDelegate> {
    
    // UI
    
    UITextField *titleTextField;
    UITextView *bodyTextView;
    
}
@property (nonatomic, weak) id<ATNewQuestionDelegate> delegate;

@end



@protocol ATNewQuestionDelegate <NSObject>

- (void)newQuestion:(ATNewQuestionViewController*)newQuestion createdQuestion:(QuestionModel*)question;

@end
