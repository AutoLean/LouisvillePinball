//
//  CommentViewController.m
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 5/8/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import "CommentViewController.h"


@implementation CommentViewController
@synthesize adView;
@synthesize bannerIsVisible;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.adView.delegate = nil;
	self.adView = nil;
    [super dealloc];
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


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
