//
//  MachineViewController.m
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 5/10/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import "MachineViewController.h"


@implementation MachineViewController
@synthesize changeMachineName;
@synthesize changeLocation;
@synthesize changeAddress;
@synthesize changeCity;
@synthesize changeState;
@synthesize changeZipCode;
@synthesize updateAddMachineStatus;
@synthesize toggleAddMachineButton;
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
    [changeMachineName release];
    [changeLocation release];
    [changeAddress release];
    [changeCity release];
    [changeState release];
    [changeZipCode release];
    [updateAddMachineStatus release];
    [toggleAddMachineButton release];
    [super dealloc];
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
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.2) 
            {
                self.adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
            }
            else
            {
                self.adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;   
            }
			[self.view addSubview:self.adView];
		}
	}
    self.title = @"Add Machine";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setChangeMachineName:nil];
    [self setChangeLocation:nil];
    [self setChangeAddress:nil];
    [self setChangeCity:nil];
    [self setChangeState:nil];
    [self setChangeZipCode:nil];
    [self setUpdateAddMachineStatus:nil];
    [self setToggleAddMachineButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

- (IBAction)enableAddMachineButton
{
    //If form is filled out completely, enable add machine button.
    if([changeMachineName.text length] != 0 &&
       [changeLocation.text length] != 0 &&
       [changeAddress.text length] != 0 &&
       [changeCity.text length] != 0 &&
       [changeState.text length] != 0 &&
       [changeZipCode.text length] != 0)
    {
        //NSLog(@"Add Machine Button Enabled");
        toggleAddMachineButton.enabled = true;
        toggleAddMachineButton.alpha = 1;
    }
    else
    {
        //NSLog(@"Add Machine Button Disabled");
        toggleAddMachineButton.enabled = false;
        toggleAddMachineButton.alpha = .5;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)slideFrame:(BOOL)up
{
    const int movementDistance = 12; 
    const float movementDuration = 0.3f;
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"SlideFrame" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}

- (IBAction)slideFrameUp;
{
    [self slideFrame:YES];
}

- (IBAction)slideFrameDown;
{
    [self slideFrame:NO];
}

- (IBAction)addMachine:(id)sender 
{
    
    //Build URL to add machine
    NSString* strCommand = @"";
    strCommand = [strCommand stringByAppendingString:@"http://www.louisvillepinball.com/AddMachine_IOS.php?MachineName="];
    strCommand = [strCommand stringByAppendingString:[(NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)changeMachineName.text, NULL, (CFStringRef)@":/?#[]@!$&'()*+,;= ", kCFStringEncodingUTF8) autorelease]];
    strCommand = [strCommand stringByAppendingString:@"&Location="];
    strCommand = [strCommand stringByAppendingString:[(NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)changeLocation.text, NULL, (CFStringRef)@":/?#[]@!$&'()*+,;= ", kCFStringEncodingUTF8) autorelease]];
    strCommand = [strCommand stringByAppendingString:@"&Address="];
    strCommand = [strCommand stringByAppendingString:[(NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)changeAddress.text, NULL, (CFStringRef)@":/?#[]@!$&'()*+,;= ", kCFStringEncodingUTF8) autorelease]];
    strCommand = [strCommand stringByAppendingString:@"&City="];
    strCommand = [strCommand stringByAppendingString:[(NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)changeCity.text, NULL, (CFStringRef)@":/?#[]@!$&'()*+,;= ", kCFStringEncodingUTF8) autorelease]];
    strCommand = [strCommand stringByAppendingString:@"&State="];
    strCommand = [strCommand stringByAppendingString:[(NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)changeState.text, NULL, (CFStringRef)@":/?#[]@!$&'()*+,;= ", kCFStringEncodingUTF8) autorelease]];
    strCommand = [strCommand stringByAppendingString:@"&ZipCode="];
    strCommand = [strCommand stringByAppendingString:[(NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)changeZipCode.text, NULL, (CFStringRef)@":/?#[]@!$&'()*+,;= ", kCFStringEncodingUTF8) autorelease]];
    
    //NSLog(@"%@",strCommand);
    
    //Execute remote php statement to add machine to website.  If successful, the result is SUCCESS
    //Use status label to let user know if machine was added.
    NSString* strMessage = [NSString stringWithContentsOfURL:[NSURL URLWithString:strCommand] usedEncoding:NULL error:NULL];
    if ([strMessage isEqualToString:@"SUCCESS"])
    {
        updateAddMachineStatus.text = @"Machine Added Successfully!";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MachineAdded" object:self];
    }
    else
    {
        updateAddMachineStatus.text = @"Failed to Add Machine!";
    }
    
    //Disable Add Machine Button after attempt to add new machine.
    //NSLog(@"Add Machine Button Disabled");
    toggleAddMachineButton.enabled = false;
    toggleAddMachineButton.alpha = .5;
    
}

@end
