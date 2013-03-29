//
//  ViewController.m
//  AskMe
//
//  Created by Zenan on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController.h"
#import "ATPopularViewController.h"
#import "ATChooseGenderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *userGender = [[NSUserDefaults standardUserDefaults] objectForKey:USER_GENDER_KEY];
    if ([userGender isEqualToString:MALE]) {
        NSLog(@"male");
        [self pushChooseGenderViewController];
        [self pushPopularQuestionsViewController];
    } else if ([userGender isEqualToString:FEMALE]) {
        NSLog(@"female");
        [self pushChooseGenderViewController];
        [self pushPopularQuestionsViewController];
    } else {
        NSLog(@"nil");
        [self pushChooseGenderViewController];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (IBAction)fbLoginBtn:(id)sender {
//    self.loginController = [[LoginController alloc] init];
//    self.loginController.delegate = self;
//    [self.loginController loginWithFacebook];
//}
//
//- (void)userLoginSuccess
//{
//    ATPopularViewController *popularQuestions = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"PopularQuestions"];
//    [self.navigationController pushViewController:popularQuestions animated:YES];
//}
//
//- (void)userLoginFail
//{
//    
//    [[NSUserDefaults standardUserDefaults] setObject:@"male" forKey:@"gender"];
//    
//    [[NSUserDefaults standardUserDefaults] objectForKey:@"gender"];
//    
//}
//
//- (void)newUserSignUp
//{
//    
//}
//
//- (void)newUserSignUpFail
//{
//    
//}

- (void)pushChooseGenderViewController{
    ATChooseGenderViewController *chooseGender = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ChooseGender"];
    [self.navigationController pushViewController:chooseGender animated:YES];
}

- (void)pushPopularQuestionsViewController{
    [[ATQuestionController shared] getPopularQuestions:^(NSArray *objects, NSError *error) {
        ATPopularViewController *popularQuestionsController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"PopularQuestions"];
        popularQuestionsController.popularQuestions = objects;
        [self.navigationController pushViewController:popularQuestionsController animated:YES];
    }];
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
