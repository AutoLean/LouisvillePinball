//
//  MachineAnnotation.h
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 5/7/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MachineAnnotation : NSObject <MKAnnotation> {
    float latitude;
    float longitude;
    NSString *title; 
    NSString *subtitle;
    NSString *address;
    NSString *city;
    NSString *state;
    NSString *zipcode;
}

@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *state;
@property (nonatomic,copy) NSString *zipcode;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end
