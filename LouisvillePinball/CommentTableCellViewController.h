//
//  CommentTableCellViewController.h
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 6/27/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CommentTableCellViewController : UITableViewCell {
    UILabel *lblPlayer;
    UILabel *lblEntryDate;
    UILabel *lblComment;
}

@property (nonatomic, retain) IBOutlet UILabel *lblPlayer;
@property (nonatomic, retain) IBOutlet UILabel *lblEntryDate;
@property (nonatomic, retain) IBOutlet UILabel *lblComment;

@end
