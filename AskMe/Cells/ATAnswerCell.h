//
//  ATAnswerCell.h
//  AskMe
//
//  Created by Minitheory Design on 29/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATAnswerCell : UITableViewCell{
    
    NSDictionary *_thingDict;
    
    // UI
    
    UIImageView *bgImage;
    //UIImageView *thumbnailImage;
    UIImageView *arrowImage;
    
    UILabel *titleLabel;
    UILabel *subtitleLabel;
    UIButton *editButton;
}

@end
