//
//  LouisvilleMapViewController.h
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 4/28/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MachineAnnotation.h"
#import <iAd/iAd.h>

@interface LouisvilleMapViewController : UIViewController <MKMapViewDelegate, NSXMLParserDelegate, UIAlertViewDelegate, ADBannerViewDelegate> {
    MKMapView *mapView;

    NSXMLParser *xmlParser;
	NSMutableArray *machineLocationData;
	
	NSMutableDictionary *pinballMachine;
    MachineAnnotation *pinballMachineAnnotation;
    
	NSString *currentMachine;
	NSMutableString *currentMachineName;
    NSMutableString *currentLocation;
    NSMutableString *currentLatitude;
    NSMutableString *currentLongitude;
    
    ADBannerView *adView;
	BOOL bannerIsVisible;
}

- (void)initializePinballMachineMap;
- (void) machineAdded:(NSNotification *) notification;

@property(nonatomic, retain) ADBannerView *adView;
@property(nonatomic, assign) BOOL bannerIsVisible;

- (void)bannerViewDidLoadAd:(ADBannerView *)banner;
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;

@end
