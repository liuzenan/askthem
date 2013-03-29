//
//  ATChooseGenderViewController.m
//  AskMe
//
//  Created by Zenan on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ATChooseGenderViewController.h"
#import "ATPopularViewController.h"

@interface ATChooseGenderViewController ()

@end

@implementation ATChooseGenderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseMale:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:MALE forKey:USER_GENDER_KEY];
    [self pushPopularQuestionsViewController];
}

- (IBAction)chooseFemale:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:FEMALE forKey:USER_GENDER_KEY];
    [self pushPopularQuestionsViewController];
}

- (void)pushPopularQuestionsViewController{
    ATPopularViewController *popularQuestions = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"PopularQuestions"];
    [self.navigationController pushViewController:popularQuestions animated:YES];

}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *gender = [[NSUserDefaults standardUserDefaults] objectForKey:USER_GENDER_KEY];
    
    if ([gender isEqualToString:MALE]) {
        NSLog(@"male");
    } else if ([gender isEqualToString:FEMALE]) {
        NSLog(@"female");
    } else {
        NSLog(@"null");
    }
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
}
@end
