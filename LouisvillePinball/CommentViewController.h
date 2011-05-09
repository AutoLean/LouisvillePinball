//
//  CommentViewController.h
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 5/8/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>


@interface CommentViewController : UIViewController <ADBannerViewDelegate> {
    ADBannerView *adView;
	BOOL bannerIsVisible;
}

@property(nonatomic, retain) ADBannerView *adView;
@property(nonatomic, assign) BOOL bannerIsVisible;

- (void)bannerViewDidLoadAd:(ADBannerView *)banner;
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;

@end
