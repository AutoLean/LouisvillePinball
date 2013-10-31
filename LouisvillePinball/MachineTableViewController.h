//
//  MachineTableViewController.h
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 6/27/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinballComments.h"
#import "Comment.h"
#import <iAd/iAd.h>

@interface MachineTableViewController : UITableViewController <NSXMLParserDelegate, ADBannerViewDelegate> {
    
    NSXMLParser *xmlParser;
    
	NSMutableArray *machineCommentsData;
    PinballComments *pinballComments;
    
	NSMutableDictionary *dictMachine;
    
	NSString *currentMachine;
	NSMutableString *currentMachineName;
    NSMutableString *currentMachineID;
    NSMutableString *currentLocation;
    
    NSMutableDictionary *dictComment;
    Comment *comment;
    
    NSString *currentComment;
    NSMutableArray *machineComments;
    NSMutableString *currentCommentName;
    NSMutableString *currentCommentText;
    NSMutableString *currentCommentDate;
    
    PinballComments *aPinballMachine;
    PinballComments *thePinballMachine;
}

@end
