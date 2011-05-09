//
//  MachineViewController.m
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 4/28/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import "MachineViewController.h"


@implementation MachineViewController
@synthesize adView;
@synthesize bannerIsVisible;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    static NSString * const kADBannerViewClass = @"ADBannerView";
	if (NSClassFromString(kADBannerViewClass) != nil) {
		if (self.adView == nil) {
			self.adView = [[[ADBannerView alloc] init] autorelease];
			self.adView.delegate = self;
			self.adView.frame = CGRectMake(0, 460, 320, 50);
			self.adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
			[self.view addSubview:self.adView];
		}
	}
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
	if (!self.bannerIsVisible) {
		[UIView beginAnimations:nil context:NULL];
		banner.frame = CGRectOffset(banner.frame, 0, -100);
		[UIView commitAnimations];
		self.bannerIsVisible = YES;
	}
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	if (self.bannerIsVisible) {
		[UIView beginAnimations:nil context:NULL];
		banner.frame = CGRectOffset(banner.frame, 0, 100);
		[UIView commitAnimations];
		self.bannerIsVisible = NO;
	}
}


- (void)dealloc
{
    self.adView.delegate = nil;
	self.adView = nil;
    [super dealloc];
}

@end
