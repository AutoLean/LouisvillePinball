//
//  LouisvilleMapViewController.m
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 4/28/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import "LouisvilleMapViewController.h"
#import "MachineAnnotation.h"

@implementation LouisvilleMapViewController
@synthesize adView;
@synthesize bannerIsVisible;

- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	//NSLog(@"Parser is now parsing Machines.xml");
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
    machineLocationData = [[NSMutableArray alloc] init];
    NSURL *xmlURL = [NSURL URLWithString:URL];
	xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	[xmlParser setDelegate:self];
	[xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
    [xmlParser parse];
}

- (void)parseXMLFileWithData:(NSData *)data
{
    machineLocationData = [[NSMutableArray alloc] init];
    xmlParser = [[NSXMLParser alloc] initWithData:data];
	[xmlParser setDelegate:self];
	[xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
    [xmlParser parse];
}

- (void)initializePinballMachineMap
{
    //This is called from viewDidLoad and if application becomes active.
    //initializePinballMachineMap will update the map
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 361)];
    mapView.mapType = MKMapTypeStandard;    
    
    CLLocationCoordinate2D coord = {.latitude =  38.17, .longitude =  -85.70};
    MKCoordinateSpan span = {.latitudeDelta =  0.1, .longitudeDelta =  0.3};
    MKCoordinateRegion region = {coord, span};
    mapView.showsUserLocation = YES;
    [mapView setRegion:region];
    
    //Create array of pinball machine objects.  Objects contain coordinate positions, machine name, and location name;
    machineLocationData = [[NSMutableArray array] retain];
    
    //URL of pinball machine locations data file.  
    //NSString * path = @"http://www.louisvillepinball.com/Machines.xml";
    //[self parseXMLFileAtURL:path];
    
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:@"http://www.louisvillepinball.com/Machines.xml"];
    NSData *dataEstablishments = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    if (error)
        NSLog(@"Download error: %@",error);
    
    [self parseXMLFileWithData:dataEstablishments];
    
    
    [mapView addAnnotations: machineLocationData];
    
    [self.view addSubview:mapView];
    //Badges show how many machines are on the map.
    [[[[[self tabBarController] tabBar] items] objectAtIndex:0] setBadgeValue:[NSString stringWithFormat:@"%d",[machineLocationData count]]];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Check network settings, unable to download pinball machine locations for Louisville KY!", [parseError code]];
	//NSLog(@"Error parsing XML: %@", errorString);
	
    //If unable to connect to website, then app is pointless.  Notify user of error and send app to background.
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
    [errorAlert autorelease];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        exit(0);
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
    //NSLog(@"found this element: %@", elementName);
	currentMachine = [elementName copy];
	if ([elementName isEqualToString:@"Machine"]) {
		// clear out our story item caches...
		pinballMachine = [[NSMutableDictionary alloc] init];
		currentMachineName = [[NSMutableString alloc] init];
		currentLocation = [[NSMutableString alloc] init];
		currentLatitude = [[NSMutableString alloc] init];
		currentLongitude = [[NSMutableString alloc] init];
        pinballMachineAnnotation = [[MachineAnnotation alloc] init];
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	//NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"Machine"]) {
		// save values to an item, then store that item into the array...
		[pinballMachine setObject:currentMachineName forKey:@"MachineName"];
		[pinballMachine setObject:currentLocation forKey:@"Location"];
		[pinballMachine setObject:currentLatitude forKey:@"Latitude"];
		[pinballMachine setObject:currentLongitude forKey:@"Longitude"];
        
        pinballMachineAnnotation.latitude = [[pinballMachine objectForKey:@"Latitude"] floatValue];
        pinballMachineAnnotation.longitude = [[pinballMachine objectForKey:@"Longitude"] floatValue];
		pinballMachineAnnotation.title = [pinballMachine objectForKey:@"MachineName"];
        pinballMachineAnnotation.subtitle = [pinballMachine objectForKey:@"Location"];
        
        [machineLocationData addObject:pinballMachineAnnotation];
		//NSLog(@"Adding pinball machine: %@", currentMachineName);
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([currentMachine isEqualToString:@"MachineName"]) {
		[currentMachineName appendString:string];
	} else if ([currentMachine isEqualToString:@"Location"]) {
		[currentLocation appendString:string];
	} else if ([currentMachine isEqualToString:@"Latitude"]) {
		[currentLatitude appendString:string];
	} else if ([currentMachine isEqualToString:@"Longitude"]) {
		[currentLongitude appendString:string];
	}
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	//NSLog(@"COMPLETE!");
	//NSLog(@"Machine array has %d items", [machineLocationData count]);

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    //Enable notification for when app becomes active.  This is used to update map.
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(becomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    //Enable notification for when a new machine is added.  This is used to update map.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(machineAdded:) 
                                                 name:@"MachineAdded"
                                               object:nil];
    
    [super viewDidLoad];
    self.title = @"Louisville Pinball";
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
    [self initializePinballMachineMap];
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

- (void) machineAdded:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"MachineAdded"])
    {
        [self initializePinballMachineMap];
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

- (void)becomeActive:(NSNotification *)notification 
{
    //NSLog(@"Activating Louisville Pinball Application");
    [self initializePinballMachineMap];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [mapView release];
    [xmlParser release];
    [machineLocationData release];
    [pinballMachine release];
    [pinballMachineAnnotation release];
    [currentMachine release];
    [currentMachineName release];
    [currentLocation release];
    [currentLatitude release];
    [currentLongitude release];
    [super dealloc];
}

@end
