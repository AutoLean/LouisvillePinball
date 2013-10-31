//
//  CommentsTableViewController.h
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 6/27/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"


@interface CommentsTableViewController : UITableViewController {
    NSMutableArray *arrayComments;
    Comment *comment;
}

@property (nonatomic,retain) NSMutableArray *arrayComments;
@property (nonatomic,retain) Comment *comment;
@end
