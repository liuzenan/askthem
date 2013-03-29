//
//  ATQuestionViewController.m
//  AskMe
//
//  Created by Minitheory Design on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ATQuestionViewController.h"
#import "ATQuestionController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor-Expanded.h"

@interface ATQuestionViewController ()

@end

@implementation ATQuestionViewController

@synthesize questionID;

- (void)loadView{
    UIView *theView = [[UIView alloc]init];
    theView.frame = CGRectMake(0, 0, 320, APP_FRAME_HEIGHT);
    theView.backgroundColor = [UIColor colorWithRGBHex:0xe8e8e8];
    
    questionWebView = [[UIWebView alloc] init];
    questionWebView.frame = CGRectMake(0, 0, 320, APP_FRAME_HEIGHT-44-KEYPAD_HEIGHT-44);
    [theView addSubview:questionWebView];
    
    
    replyBar = [[UIView alloc]initWithFrame:CGRectMake(0, APP_FRAME_HEIGHT-44-KEYPAD_HEIGHT-44, 320, 44)];
    replyBar.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    replyBar.clipsToBounds = YES;
    [theView addSubview:replyBar];
    
    UIImageView *backBG = [[UIImageView alloc] initWithFrame:CGRectMake(-10, -1, 320+20, 46)];
    backBG.image = [[UIImage imageNamed:@"btn_grad_white_76"] stretchableImageWithLeftCapWidth:6 topCapHeight:10];
    [replyBar addSubview:backBG];
    
    replyTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 7, 320-10-10-75-5, 32)];
    replyTextView.delegate = self;
    replyTextView.font = [UIFont systemFontOfSize:14.0];
    replyTextView.layer.cornerRadius = 4.0;
    replyTextView.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:1.0].CGColor;
    replyTextView.layer.borderWidth = 1.0;
    [replyBar addSubview:replyTextView];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitButton.frame = CGRectMake(320-10-75, 6, 75, 34);
    [submitButton setTitle:@"Send" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitAnswer) forControlEvents:UIControlEventTouchUpInside];
    [replyBar addSubview:submitButton];
    
    self.view = theView;
}

- (void)viewWillAppear:(BOOL)animated{
    [replyTextView becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDefaultBackButton];
    
    shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 44, 44);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    shareButton.backgroundColor = [UIColor clearColor];
    [shareButton addTarget:self action:@selector(shareTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    
    self.navigationItem.title = @"Question";
}

- (void)viewDidAppear:(BOOL)animated{
    if (self.questionID){
        //load the question
        PFQuery *query = [PFQuery queryWithClassName:@"Question"];
        _question = [query getObjectWithId:self.questionID];
        
        NSString *title = [_question objectForKey:kATQuestionTitleKey];
        NSString *body = [_question objectForKey:kATQuestionBodyKey];
        
        NSString *html = [NSString stringWithFormat:@"<b>%@</b><br/>%@", title, body];
        [questionWebView loadHTMLString:html baseURL:nil];
        
        
        NSArray *questions;
        [[ATQuestionController shared] getPopularQuestions:^(NSArray *objects, NSError *error) {
            NSLog(@"questions: %@", objects);
        }];
        NSLog(@"questions: %@", questions);
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark - Custom

- (void)submitAnswer{
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Submitting...";
    [SHARED_APPLICATION setNetworkActivityIndicatorVisible:YES];
    // the keyboard dismisses if I set editable to no
    //[replyTextView setEditable:NO];
    
    NSString *tempBody = replyTextView.text;
    replyTextView.text = @"";
    submitButton.enabled = NO;
    
    
    PFObject *answer = [PFObject objectWithClassName:@"Answer"];
    [answer setObject:tempBody forKey:kATAnswerBodyKey];
    [answer setObject:_question forKey:kATAnswerQuestionKey];
    
    [answer saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"succeeded:%@, error:%@", (succeeded?@"YES":@"NO"), error);
        
        [HUD hide:YES]; [SHARED_APPLICATION setNetworkActivityIndicatorVisible:NO];
        
    }];

}

@end
