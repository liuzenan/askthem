//
//  ViewController.m
//  AskMe
//
//  Created by Zenan on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController.h"
#import "ATPopularViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fbLoginBtn:(id)sender {
    self.loginController = [[LoginController alloc] init];
    self.loginController.delegate = self;
    [self.loginController loginWithFacebook];
}

- (void)userLoginSuccess
{
    ATPopularViewController *popularQuestions = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"PopularQuestions"];
    [self.navigationController pushViewController:popularQuestions animated:YES];
}

- (void)userLoginFail
{
    
}

- (void)newUserSignUp
{
    
}

- (void)newUserSignUpFail
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
@end
