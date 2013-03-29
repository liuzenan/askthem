//
//  ATNewQuestionViewController.m
//  AskMe
//
//  Created by Minitheory Design on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ATNewQuestionViewController.h"
#import "ATQuestionController.h"
#import "UIColor-Expanded.h"

@interface ATNewQuestionViewController ()

@end


#define kTagForDiscardConfirm 9716231

@implementation ATNewQuestionViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView{
    UIView *theView = [[UIView alloc]init];
    theView.frame = CGRectMake(0, 0, 320, APP_FRAME_HEIGHT);
    theView.backgroundColor = [UIColor colorWithRGBHex:0xe8e8e8];
    
    /*
    // Backing for textView
    UIImageView *textViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 14, 320, APP_FRAME_HEIGHT-44-14-216)];
    textViewBack.image = [[UIImage imageNamed:@"table_solo"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [theView addSubview:textViewBack];
    */
    
    titleTextField = [[UITextField alloc] init];
    titleTextField.frame = CGRectMake(0, 0, 320, 44);
    titleTextField.delegate = self;
    bodyTextView.font = [UIFont systemFontOfSize:14.0];
    [theView addSubview:titleTextField];
    
    
    bodyTextView = [[UITextView alloc]initWithFrame:CGRectMake(14, 14+14, 320-14-14, APP_FRAME_HEIGHT-44-14-14-216)];
    bodyTextView.backgroundColor = [UIColor clearColor];
    bodyTextView.returnKeyType = UIReturnKeyDefault;
    bodyTextView.delegate = self;
    bodyTextView.font = [UIFont systemFontOfSize:14.0];
    [theView addSubview:bodyTextView];
    
    self.view = theView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //GA Stuff
    //self.trackedViewName = @"Profile About Me VC";
    
    self.navigationItem.title = @"New Question";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 60, 44);
    [backButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeueLTStd-MdCn" size:14.0];
    backButton.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    [backButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    
    UIButton *btnDone = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 44)];
    //[btnDone setTitle:@"" forState:UIControlStateNormal];
    [btnDone setBackgroundImage:[UIImage imageNamed:@"navbtnDone"] forState:UIControlStateNormal];
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
    return !isSaving;
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
                [self backButtonTapped:nil];
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
    if (self.delegate){
        
        
        NSDictionary *params = @{@"data" : @{@"about" : bodyTextView.text}};
        
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
        
        QuestionModel *newQuestion = [[ATQuestionController shared] createQuestion:bodyTextView.text title:titleTextField.text];
        
        [newQuestion saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"succeeded:%@, error:%@", (succeeded?@"YES":@"NO"), error);
            
            [HUD hide:YES]; [SHARED_APPLICATION setNetworkActivityIndicatorVisible:NO];
            
            
        }];
        
        /*
        [[LDAPIClient sharedClient] postPath:kAPIPathProfileUpdate parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [HUD hide:YES]; [SHARED_APPLICATION setNetworkActivityIndicatorVisible:NO];
            isSaving = false;
            
            NSLog(@"Success updating profile (about me): %@", responseObject);
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [HUD hide:YES]; [SHARED_APPLICATION setNetworkActivityIndicatorVisible:NO];
            isSaving = false;
            
            NSLog(@"Error while updating profile (about me): %@", error);
            
            if (error.code == -1009){
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Oops" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
            }else{
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Oops" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
            }
        }];
        */
    }
}

-(void)cancelButtonTapped:(id)sender{
    
    if (![aboutMeTextView.text isEqualToString:self.aboutMe]){
        //there are changes
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:nil message:@"Discard changes?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"No", nil];
        av.tag = kTagForDiscardConfirm;
        [av show];
    }else{
        [self backButtonTapped:sender];
    }
}

@end
