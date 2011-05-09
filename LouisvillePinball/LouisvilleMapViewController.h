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

@interface LouisvilleMapViewController : UIViewController <MKMapViewDelegate, NSXMLParserDelegate> {
    MKMapView *mapView;
    UIActivityIndicatorView * activityIndicator;
    
    NSXMLParser *xmlParser;
	NSMutableArray *machineLocationData;
	
	// a temporary item; added to the "LocationData" array one at a time, and cleared for the next one
	NSMutableDictionary *pinballMachine;
    MachineAnnotation *pinballMachineAnnotation;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString *currentMachine;
	NSMutableString *currentMachineName;
    NSMutableString *currentLocation;
    NSMutableString *currentLatitude;
    NSMutableString *currentLongitude;
    
}

@end
