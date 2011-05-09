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
- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"Parser is now parsing Machines.xml");
	
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
	machineLocationData = [[NSMutableArray alloc] init];
	
    //you must then convert the path to a proper NSURL or it won't work
    NSURL *xmlURL = [NSURL URLWithString:URL];
	
    // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
    // this may be necessary only for the toolchain
    xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [xmlParser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
	
    [xmlParser parse];
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download Machines.xml (Error code %i )", [parseError code]];
	NSLog(@"Error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
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
        
		//[machineLocationData addObject:[pinballMachine copy]];
        [machineLocationData addObject:pinballMachineAnnotation];
		NSLog(@"Adding pinball machine: %@", currentMachineName);
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
	
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	
	NSLog(@"COMPLETE!");
	NSLog(@"Machine array has %d items", [machineLocationData count]);

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeStandard;

    CLLocationCoordinate2D coord = {.latitude =  38.17, .longitude =  -85.70};
    MKCoordinateSpan span = {.latitudeDelta =  0.1, .longitudeDelta =  0.3};
    MKCoordinateRegion region = {coord, span};
    mapView.showsUserLocation = YES;
    [mapView setRegion:region];
    
    machineLocationData = [[NSMutableArray array] retain];
    
    NSString * path = @"http://www.louisvillepinball.com/Machines.xml";
    [self parseXMLFileAtURL:path];
    
    [mapView addAnnotations: machineLocationData];
    
    [self.view addSubview:mapView];
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

- (void)dealloc
{
    [super dealloc];
}

@end
