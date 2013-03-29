//
//  AnwserModel.h
//  AskMe
//
//  Created by Zenan on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Parse/Parse.h>


#pragma mark - PFObject Question Class
// Class key
extern NSString *const kATAnswerClassKey;

// Field keys
extern NSString *const kATAnswerBodyKey;
extern NSString *const kATAnswerUserKey;
extern NSString *const kATAnswerQuestionKey;

@interface AnwserModel : PFObject {
    
}

@end
