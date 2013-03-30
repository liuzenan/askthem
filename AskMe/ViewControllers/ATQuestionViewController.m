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

#import "UIView+LayoutHelper.h"

@interface ATQuestionViewController ()

@end

@implementation ATQuestionViewController

@synthesize questionID;

- (void)loadView{
    
    UIView *theView = [[UIView alloc]init];
    theView.frame = CGRectMake(0, 0, 320, APP_FRAME_HEIGHT);
    theView.backgroundColor = [UIColor colorWithRGBHex:0xe8e8e8];
    
    questionView = [[UIView alloc]init];
    questionView.frame = CGRectMake(0, 0, 320, APP_FRAME_HEIGHT);
    questionView.backgroundColor = [UIColor colorWithRGBHex:0xe8e8e8];
    
    /*
    questionWebView = [[UIWebView alloc] init];
    questionWebView.frame = CGRectMake(0, 0, 320, APP_FRAME_HEIGHT-44-KEYPAD_HEIGHT-44);
    [questionView addSubview:questionWebView];
    */
    
    titleTextView = [UITextView new];
    titleTextView.frame = CGRectMake(0, 8, 320, 40);
    titleTextView.font = [UIFont boldSystemFontOfSize:14.0];
    [questionView addSubview:titleTextView];
    
    bodyTextView = [UITextView new];
    bodyTextView.frame = CGRectMake(0, 48, 320, 100);
    bodyTextView.font = [UIFont systemFontOfSize:14.0];
    [questionView addSubview:bodyTextView];
    
    emptyLabel = [[UILabel alloc] init];
    //emptyLabel.frame = CGRectMake(0, questionWebView.bounds.size.height + 20, 320, 44);
    emptyLabel.frame = CGRectMake(0, bodyTextView.bottom + 20, 320, 44);
    emptyLabel.text = @"No responses yet, be the first one to advise!";
    emptyLabel.font = [UIFont systemFontOfSize:12.0];
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    emptyLabel.numberOfLines = 2;
    emptyLabel.backgroundColor = [UIColor clearColor];
    [questionView addSubview:emptyLabel];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, bodyTextView.bottom + 20, 320, APP_FRAME_HEIGHT-44-KEYPAD_HEIGHT-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRGBHex:0xCCCCCC];
    //_tableView.backgroundColor = [UIColor clearColor];
    [questionView addSubview:_tableView];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, APP_FRAME_HEIGHT-44)];
    [_scrollView addSubview:questionView];
    _scrollView.delegate = self;
    _scrollView.contentSize = questionView.frame.size;
    _scrollView.scrollEnabled = YES;
    _scrollView.pagingEnabled = NO;
    _scrollView.scrollsToTop = YES;
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 64, 0);
    //_scrollView.backgroundColor = [UIColor yellowColor];
    
    [theView addSubview:_scrollView];
    
    
    
    replyBar = [[UIView alloc]init];
    replyBar.frame = CGRectMake(0, APP_FRAME_HEIGHT-44-KEYPAD_HEIGHT-44, 320, 44);
    replyBar.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    replyBar.clipsToBounds = YES;
    [theView addSubview:replyBar];
    replyBar.center = CGPointMake(160, APP_FRAME_HEIGHT);
    
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
    
    
    
    footer = [UIView new];
    footer.frame = CGRectMake(0, 0, 320, 49);
    
    answerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    answerButton.frame = CGRectMake(0, 0, 160, 49);
    [answerButton setBackgroundImage:[UIImage imageNamed:@"giveadvicebtn"] forState:UIControlStateNormal];
    [answerButton addTarget:self action:@selector(adviseTapped) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:answerButton];
    
    laterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    laterButton.frame = CGRectMake(160, 0, 160, 49);
    [laterButton setBackgroundImage:[UIImage imageNamed:@"maybelaterbtn"] forState:UIControlStateNormal];
    [laterButton addTarget:self action:@selector(maybeLatertapped) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:laterButton];
    
    
    [theView addSubview:footer];
    footer.center = CGPointMake(160, APP_FRAME_HEIGHT - 44 - (49/2));
    
    
    self.view = theView;
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDefaultBackButton];
    
    shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 49, 49);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    shareButton.backgroundColor = [UIColor clearColor];
    [shareButton addTarget:self action:@selector(shareTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    
    self.navigationItem.title = @"GIVE ADVICE";
}

- (void)viewDidAppear:(BOOL)animated{
    if (self.questionID){
        //load the question
        PFQuery *query = [PFQuery queryWithClassName:@"Question"];
        _question = [query getObjectWithId:self.questionID];
        
        [self initWithQuestion];
        
        /*
        NSArray *questions;
        [[ATQuestionController shared] getPopularQuestions:^(NSArray *objects, NSError *error) {
            NSLog(@"questions: %@", objects);
        }];
        NSLog(@"questions: %@", questions);
        */
    
        [self refreshAnswers];
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}













#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"_replies=%@", _replies);
    //NSLog(@"_replies.count=%d", _replies.count);
    NSInteger numberOfRows = _answers.count;
    return numberOfRows;
    
    //return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell;
    
    cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    
    //cell.delegate = self;
    //[cell setIndexPath:indexPath withTable:tableView];
    
    PFObject *answer = (PFObject*)[_answers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [answer objectForKey:kATAnswerBodyKey];
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

/*
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
*/





















#pragma mark - Custom

- (void)initWithQuestion{
    
    NSString *title = [_question objectForKey:kATQuestionTitleKey];
    NSString *body = [_question objectForKey:kATQuestionBodyKey];
    
    /*
     NSString *html = [NSString stringWithFormat:@"<b>%@</b><br/>%@", title, body];
     [questionWebView loadHTMLString:html baseURL:nil];
     */
    
    CGRect oriFrame;

    titleTextView.text = title;
    oriFrame = titleTextView.frame;
    oriFrame.size.height = titleTextView.contentSize.height + 10;
    titleTextView.frame = oriFrame;
    
    bodyTextView.text = body;
    oriFrame = bodyTextView.frame;
    oriFrame.origin.y = titleTextView.bottom;
    oriFrame.size.height = bodyTextView.contentSize.height + 10;
    bodyTextView.frame = oriFrame;
    
    oriFrame = _tableView.frame;
    oriFrame.origin.y = bodyTextView.bottom;
    _tableView.frame = oriFrame;
    
    
    oriFrame = emptyLabel.frame;
    oriFrame.origin.y = bodyTextView.bottom;
    emptyLabel.frame = oriFrame;
    
    

}

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
        
        submitButton.enabled = YES;
        
        [HUD hide:YES]; [SHARED_APPLICATION setNetworkActivityIndicatorVisible:NO];
        [self refreshAnswers];
    }];

}

- (void)refreshAnswers{
    
    [[ATQuestionController shared] getAnswersWithQuestion:_question onComplete:^(NSArray *objects, NSError *error) {
        _answers = objects;
        [self displayAnswers];
    }];
}

- (void)displayAnswers{
    [_tableView reloadData];
    if (_answers.count == 0){
        emptyLabel.alpha = 1.0;
        _tableView.alpha = 0.0;
    }else{
        emptyLabel.alpha = 0.0;
        _tableView.alpha = 1.0;
        
        CGRect oriFrame = _tableView.frame;
        oriFrame.size.height = _answers.count * 44;
        _tableView.frame = oriFrame;
    }
}

- (void) adviseTapped{
    [replyTextView becomeFirstResponder];
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        replyBar.center = CGPointMake(160, APP_FRAME_HEIGHT - 44 - KEYPAD_HEIGHT - 22);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)maybeLatertapped{
    [self cancelOut];
}

- (void)cancelOut{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
