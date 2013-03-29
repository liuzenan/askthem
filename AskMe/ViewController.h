//
//  ViewController.h
//  AskMe
//
//  Created by Zenan on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"

@interface ViewController : UIViewController<LoginDelegate>

@property (nonatomic, strong) LoginController *loginController;
- (IBAction)fbLoginBtn:(id)sender;

@end
