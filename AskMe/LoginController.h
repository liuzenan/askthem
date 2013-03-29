//
//  LoginController.h
//  AskMe
//
//  Created by Zenan on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginDelegate

- (void) userLoginSuccess;
- (void) newUserSignUp;
- (void) userLoginFail;
- (void) newUserSignUpFail;

@end

@interface LoginController : NSObject

@property (nonatomic, weak) id<LoginDelegate> delegate;

- (void) loginWithFacebook;

@end
