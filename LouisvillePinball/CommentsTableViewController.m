//
//  CommentsTableViewController.m
//  LouisvillePinball
//
//  Created by Jeffrey Jackson on 6/27/11.
//  Copyright 2011 AutoLean, Inc. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "Comment.h"
#import "CommentTableCellViewController.h"

@implementation CommentsTableViewController
@synthesize arrayComments;
@synthesize comment;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [arrayComments count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize constraintSize;
    constraintSize.width = 280.0f;
    constraintSize.height = MAXFLOAT;
    //Comment *comment = [[Comment alloc] init];
    comment = [arrayComments objectAtIndex:indexPath.row];
    CGSize theSize = [comment.commentText sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    if (theSize.height < 44)
    {
        return 60;
    }
    else
    {
        return theSize.height + 30;
    }
   // [comment release];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"CommentTableCellViewController";
	CommentTableCellViewController *commentCell = (CommentTableCellViewController *)[tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
	if (commentCell == nil) 
    { 
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentTableCellViewController"
													 owner:self options:nil];
		for (id oneObject in nib) if ([oneObject isKindOfClass:[CommentTableCellViewController class]])
			commentCell = (CommentTableCellViewController *)oneObject;
	}
    
    //Comment *comment = [[Comment alloc] init];
    comment = [arrayComments objectAtIndex:indexPath.row];
    commentCell.lblPlayer.text = comment.commentName;
    commentCell.lblEntryDate.text = comment.commentDate;
    commentCell.lblComment.text = comment.commentText;
    commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGRect labelFrame = commentCell.lblComment.frame;
    labelFrame.size.width = 280;
    if (labelFrame.size.height < 44)
    {
        labelFrame.size.height = 44;
    }
    else
    {
        labelFrame.size.height = labelFrame.size.height;
    }
    commentCell.lblComment.frame = labelFrame;
    [commentCell.lblComment sizeToFit];
    //[comment release];
    return commentCell;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
