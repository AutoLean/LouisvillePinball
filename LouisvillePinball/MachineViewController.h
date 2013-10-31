//
//  MachineViewController.h
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 5/10/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface MachineViewController : UIViewController <ADBannerViewDelegate> {
    ADBannerView *adView;
	BOOL bannerIsVisible;
    UITextField *changeMachineName;
    UITextField *changeLocation;
    UITextField *changeAddress;
    UITextField *changeCity;
    UITextField *changeState;
    UITextField *changeZipCode;
    UILabel *updateAddMachineStatus;
    UIButton *toggleAddMachineButton;
}

@property(nonatomic, retain) ADBannerView *adView;
@property(nonatomic, assign) BOOL bannerIsVisible;

- (void)bannerViewDidLoadAd:(ADBannerView *)banner;
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;

@property (nonatomic, retain) IBOutlet UITextField *changeMachineName;
@property (nonatomic, retain) IBOutlet UITextField *changeLocation;
@property (nonatomic, retain) IBOutlet UITextField *changeAddress;
@property (nonatomic, retain) IBOutlet UITextField *changeCity;
@property (nonatomic, retain) IBOutlet UITextField *changeState;
@property (nonatomic, retain) IBOutlet UITextField *changeZipCode;
@property (nonatomic, retain) IBOutlet UILabel *updateAddMachineStatus;
@property (nonatomic, retain) IBOutlet UIButton *toggleAddMachineButton;

- (IBAction)enableAddMachineButton;
- (void)slideFrame:(BOOL)up;
- (IBAction)slideFrameUp;
- (IBAction)slideFrameDown;
- (IBAction)addMachine:(id)sender;

@end
