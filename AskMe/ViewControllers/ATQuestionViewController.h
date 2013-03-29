//
//  ATQuestionViewController.h
//  AskMe
//
//  Created by Minitheory Design on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATBaseViewController.h"

@interface ATQuestionViewController : ATBaseViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    PFObject *_question;
    NSArray *_answers;
    
    // UI
    UIView *questionView;
    UIScrollView *_scrollView;
    
    UIWebView *questionWebView;
    UITableView *_tableView;
    UILabel *emptyLabel;
    
    UIView *replyBar;
    UITextView *replyTextView;
    UIButton *submitButton;
    
    UIButton *shareButton;
    
    UIView *footer;
    UIButton *answerButton;
    UIButton *laterButton;
    
}

@property (nonatomic, strong) NSString *questionID;

@end
