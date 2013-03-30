//
//  ATNewQuestionViewController.m
//  AskMe
//
//  Created by Minitheory Design on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ATNewQuestionViewController.h"
#import "ATQuestionViewController.h"

#import "ATQuestionController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor-Expanded.h"

@interface ATNewQuestionViewController ()

@end


#define kTagForDiscardConfirm 9716231

@implementation ATNewQuestionViewController

@synthesize delegate;

- (void)loadView{
    UIView *theView = [[UIView alloc]init];
    theView.frame = CGRectMake(0, 0, 320, APP_FRAME_HEIGHT);
    //theView.backgroundColor = [UIColor colorWithRGBHex:0xe8e8e8];
    theView.backgroundColor = [UIColor colorWithRGBHex:0x999999];
    
    /*
    // Backing for textView
    UIImageView *textViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 14, 320, APP_FRAME_HEIGHT-44-14-216)];
    textViewBack.image = [[UIImage imageNamed:@"table_solo"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [theView addSubview:textViewBack];
    */
    
    UIView *textViewBacking = [UIView new];
    textViewBacking.frame = CGRectMake(8, 8, 320-8-8, 44);
    textViewBacking.layer.cornerRadius = 8.0;
    textViewBacking.backgroundColor = [UIColor whiteColor];
    [theView addSubview:textViewBacking];
    
    titleTextField = [[UITextField alloc] init];
    titleTextField.frame = CGRectMake(16, 16, 320-16-16, 44-8);
    titleTextField.delegate = self;
    titleTextField.placeholder = @"Title";
    titleTextField.font = [UIFont systemFontOfSize:16.0];
    [theView addSubview:titleTextField];
    
    
    textViewBacking = [UIView new];
    textViewBacking.frame = CGRectMake(8, 44+8+8, 320-8-8, APP_FRAME_HEIGHT-44-44-8-16-KEYPAD_HEIGHT);
    textViewBacking.layer.cornerRadius = 5.0;
    textViewBacking.backgroundColor = [UIColor whiteColor];
    [theView addSubview:textViewBacking];
    
    bodyTextView = [[UITextView alloc]initWithFrame:CGRectMake(8, textViewBacking.frame.origin.y + 4, textViewBacking.frame.size.width-8-8, textViewBacking.frame.size.height-8-8)];
    bodyTextView.backgroundColor = [UIColor clearColor];
    bodyTextView.returnKeyType = UIReturnKeyDefault;
    bodyTextView.delegate = self;
    bodyTextView.font = [UIFont systemFontOfSize:16.0];
    [theView addSubview:bodyTextView];
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    testButton.frame = CGRectMake(320-70, 44, 70, 40);
    [testButton setTitle:@"Test" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(testTapped) forControlEvents:UIControlEventTouchUpInside];
    [theView addSubview:testButton];
    
    self.view = theView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //GA Stuff
    //self.trackedViewName = @"Profile About Me VC";
    
    self.navigationItem.title = @"New Question";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 49, 49);
//    [backButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
//    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeueLTStd-MdCn" size:14.0];
    //backButton.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    [backButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(0, 0, 49, 49);
    [btnDone setBackgroundImage:[UIImage imageNamed:@"okaybtn"] forState:UIControlStateNormal];
    //[btnDone setBackgroundImage:[UIImage imageNamed:@"navbtnDone"] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnDone];
    
    
    bodyTextView.text = @"";
}

-(void)viewWillAppear:(BOOL)animated{
    [titleTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}












#pragma mark - UITextView delegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    return !isSaving;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    //[self doneButtonTapped:nil];
    return YES;
}








#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == kTagForDiscardConfirm){
        switch (buttonIndex) {
            case 0:
                //yes, discard
                [self _cancelOut];
                break;
                
            case 1:
                //no, do not discard
                break;
                
            default:
                break;
        }
    }
}











#pragma mark - Custom


- (void)doneButtonTapped:(id)sender{
    NSLog(@"doneButtonTapped");

        
    
    //[titleTextField resignFirstResponder];
    //[bodyTextView resignFirstResponder];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Saving";
    [SHARED_APPLICATION setNetworkActivityIndicatorVisible:YES];
    
    
    
    //TODO: Title and body are compulsory, do checks
    
    BOOL hasMissingFields = NO;
    if (bodyTextView.text.length == 0){
        hasMissingFields = YES;
    }
    if (titleTextField.text.length == 0){
        hasMissingFields = YES;
    }
    
    if (hasMissingFields){
        NSLog(@"hasMissingFields");
    }else{
        NSLog(@"noMissingFields");
        
        /*
        [Parse setApplicationId:@"XPaKZc3rfrzwo4zoLsvNlSQ2aZj8hxwmFDz7PTc7"
                      clientKey:@"QxwkCOy1dzjG7DC935BDn04E7pQAYYm9x5mSqCk8"];
        
        PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
        [testObject setObject:@"bar" forKey:@"foo"];
        [testObject save];
        */
        
        PFObject *question = [PFObject objectWithClassName:kATQuestionClassKey];
        [question setObject:titleTextField.text forKey:kATQuestionTitleKey];
        [question setObject:bodyTextView.text forKey:kATQuestionBodyKey];
        
        //QuestionModel *newQuestion = [[ATQuestionController shared] createQuestion:bodyTextView.text title:titleTextField.text];
        
        [question saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"succeeded:%@, error:%@", (succeeded?@"YES":@"NO"), error);
            
            [HUD hide:YES]; [SHARED_APPLICATION setNetworkActivityIndicatorVisible:NO];
            
            
        }];
    }
    
}

-(void)cancelButtonTapped:(id)sender{
    
    if (titleTextField.text.length + bodyTextView.text.length > 0){
        //there are changes
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:nil message:@"Discard changes?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"No", nil];
                av.tag = kTagForDiscardConfirm;
                [av show];
    }else{
        [self _cancelOut];
    }
    
}

- (void)_cancelOut{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)testTapped{
    
    ATQuestionViewController *questionView = [[ATQuestionViewController alloc] init];
    questionView.questionID = @"DVau2uoXym";
    [self.navigationController pushViewController:questionView animated:YES];
    
}

@end
