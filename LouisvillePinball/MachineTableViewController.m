//
//  MachineTableViewController.m
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 6/27/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import "MachineTableViewController.h"
#import "PinballComments.h"
#import "MachineCommentTableCellViewController.h"
#import "CommentsTableViewController.h"

@implementation MachineTableViewController

- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	//NSLog(@"Parser is now parsing Machines.xml");
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
    machineCommentsData = [[NSMutableArray alloc] init];
    machineComments = [[NSMutableArray alloc] init];
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
    machineCommentsData = [[NSMutableArray alloc] init];
    machineComments = [[NSMutableArray alloc] init];
    xmlParser = [[NSXMLParser alloc] initWithData:data];
	[xmlParser setDelegate:self];
	[xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
    [xmlParser parse];
}



- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Check network settings, unable to download pinball machine locations for Louisville KY!", [parseError code]];
	//NSLog(@"Error parsing XML: %@", errorString);
	
    //If unable to connect to website, then app is pointless.  Notify user of error and send app to background.
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
    [errorAlert release];
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
		dictMachine = [[NSMutableDictionary alloc] init];
		currentMachineName = [[NSMutableString alloc] init];
		currentLocation = [[NSMutableString alloc] init];
		currentMachineID = [[NSMutableString alloc] init];
        dictComment = [[NSMutableDictionary alloc] init];
        pinballComments = [[PinballComments alloc] init];
        machineComments = [[NSMutableArray alloc] init];
    }
    
    currentComment = [elementName copy];
    if ([elementName isEqualToString:@"Comment"])
    {
        comment = [[Comment alloc] init];
        currentCommentName = [[NSMutableString alloc] init];
        currentCommentText = [[NSMutableString alloc] init];
        currentCommentDate = [[NSMutableString alloc] init];
    }
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	//NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"Machine"]) {
		// save values to an item, then store that item into the array...
		[dictMachine setObject:currentMachineName forKey:@"MachineName"];
		[dictMachine setObject:currentLocation forKey:@"Location"];
		[dictMachine setObject:currentMachineID forKey:@"MachineID"];
        
        pinballComments.machineName = [dictMachine objectForKey:@"MachineName"];
        pinballComments.machineLocation = [dictMachine objectForKey:@"Location"];
		pinballComments.machineID = [dictMachine objectForKey:@"MachineID"];
        pinballComments.arrayMachineComments = machineComments;
        
        //NSLog(@"Adding pinball machine: %@", currentMachineName);
        [machineCommentsData addObject:pinballComments];
	}
    
    if ([elementName isEqualToString:@"Comment"])
    {
        [dictComment setObject:currentCommentName forKey:@"Name"];
        [dictComment setObject:currentCommentText forKey:@"Text"];
        [dictComment setObject:currentCommentDate forKey:@"EntryDate"];
        
        comment.commentName = [dictComment objectForKey:@"Name"];
        comment.commentText = [dictComment objectForKey:@"Text"];
        comment.commentDate = [dictComment objectForKey:@"EntryDate"];
        
        //NSLog(comment.commentName);
        
        [machineComments addObject:comment];
    }
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([currentMachine isEqualToString:@"MachineName"]) {
		[currentMachineName appendString:string];
	} else if ([currentMachine isEqualToString:@"MachineID"]) {
		[currentMachineID appendString:string];
	} else if ([currentMachine isEqualToString:@"Location"]) {
		[currentLocation appendString:string];
	}
    
    if ([currentComment isEqualToString:@"Name"]) {
        [currentCommentName appendString:string];
    } else if ([currentComment isEqualToString:@"Text"]) {
        [currentCommentText appendString:string];
    } else if ([currentComment isEqualToString:@"EntryDate"]) {
        [currentCommentDate appendString:string];
    }
    
    //NSLog(currentCommentName);
	//NSLog(currentCommentDate);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	//NSLog(@"COMPLETE!");
	//NSLog(@"Machine ARRAY has %d items", [machineCommentsData count]);
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
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
    machineCommentsData = [[NSMutableArray array] retain];
    machineComments = [[NSMutableArray array] retain];
    //URL of pinball machine locations data file.  
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:@"http://www.louisvillepinball.com/Machines.xml"];
    NSData *dataEstablishments = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    if (error)
        NSLog(@"Download error: %@",error);
    
    [self parseXMLFileWithData:dataEstablishments];

    self.title = @"Comments";
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [machineCommentsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CustomCellIdentifier = @"MachineCommentTableViewCellController";
	MachineCommentTableCellViewController *machineCommentCell = (MachineCommentTableCellViewController *)[tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
	if (machineCommentCell == nil) 
    { 
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MachineCommentTableCellViewController"
													 owner:self options:nil];
		for (id oneObject in nib) if ([oneObject isKindOfClass:[MachineCommentTableCellViewController class]])
			machineCommentCell = (MachineCommentTableCellViewController *)oneObject;
	}
    
    //PinballComments *aPinballMachine = [[PinballComments alloc] init];
    aPinballMachine = [machineCommentsData objectAtIndex:indexPath.row];
    [aPinballMachine autorelease];
    
    machineCommentCell.lblMachineName.text = aPinballMachine.machineName;
    machineCommentCell.lblMachineLocation.text = aPinballMachine.machineLocation;
    machineCommentCell.lblMachineID.text = aPinballMachine.machineID;
    
    return machineCommentCell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //PinballComments *thePinballMachine = [[PinballComments alloc] init];
    thePinballMachine = (PinballComments *)[machineCommentsData objectAtIndex:indexPath.row];
    //NSLog((NSString *) thePinballMachine.machineName);
    CommentsTableViewController *commentsTableViewController = [[CommentsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    commentsTableViewController.arrayComments = thePinballMachine.arrayMachineComments;
    UINavigationController *navCommentController = [[[UINavigationController alloc] initWithRootViewController:commentsTableViewController] autorelease];
    navCommentController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    commentsTableViewController.title = thePinballMachine.machineName;
    [self.navigationController pushViewController:commentsTableViewController animated:YES];
    //[thePinballMachine release];
    [commentsTableViewController release];
}

@end
