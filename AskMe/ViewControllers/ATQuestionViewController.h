//
//  ATQuestionViewController.h
//  AskMe
//
//  Created by Minitheory Design on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATBaseViewController.h"

@interface ATQuestionViewController : ATBaseViewController <UITextViewDelegate> {
    
    PFObject *_question;
    
    // UI
    
    UIWebView *questionWebView;
    UITableView *_tableView;
    
    UIView *replyBar;
    UITextView *replyTextView;
    UIButton *submitButton;
    
    UIButton *shareButton;
    
}

@property (nonatomic, strong) NSString *questionID;

@end
