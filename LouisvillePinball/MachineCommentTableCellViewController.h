//
//  MachineCommentTableCellViewController.h
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 6/27/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MachineCommentTableCellViewController : UITableViewCell {
    UILabel *lblMachineName;
    UILabel *lblMachineLocation;
    UILabel *lblMachineID;
}

@property (nonatomic, retain) IBOutlet UILabel *lblMachineName;
@property (nonatomic, retain) IBOutlet UILabel *lblMachineLocation;
@property (nonatomic, retain) IBOutlet UILabel *lblMachineID;

@end
