//
//  ATBaseViewController.h
//  AskMe
//
//  Created by Minitheory Design on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATBaseViewController : UIViewController {
    MBProgressHUD *HUD;
}

- (void)initDefaultBackButton;

@end
