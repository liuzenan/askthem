//
//  ATAnswerController.m
//  AskMe
//
//  Created by Minitheory Design on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ATAnswerController.h"

@implementation ATAnswerController

// Singletonify this class
+ (ATAnswerController *)shared{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        NSLog(@"Initializing ATAnswerController");
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}



@end
