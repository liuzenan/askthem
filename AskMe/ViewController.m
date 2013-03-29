//
//  ViewController.m
//  AskMe
//
//  Created by Zenan on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController.h"

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
    
}

- (void)newUserSignUp
{
    
}

@end
