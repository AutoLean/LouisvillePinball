//
//  PinballComments.h
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 6/27/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PinballComments : NSObject {
    NSString *machineName;
    NSString *machineLocation;
    NSString *machineID;
    NSMutableArray *arrayMachineComments;
}

@property (nonatomic,copy) NSString *machineName;
@property (nonatomic,copy) NSString *machineLocation;
@property (nonatomic,copy) NSString *machineID;
@property (nonatomic,copy) NSMutableArray *arrayMachineComments;

@end
