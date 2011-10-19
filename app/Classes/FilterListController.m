//
//  filterController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FilterListController.h"
#import "Content.h"
#import "Filter.h"
 
@implementation FilterListController
@synthesize myTableView,
			myNavigationBar,
			myAddFilterController, 
			myEditFilterController, 
			listData;

/* // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"initReached");
	return self;
}*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"View Did Load");
	//myTableView = [[UITableView alloc] initWithFrame:CGRectZero
	//	style: UITableViewStylePlain];
	
	[myTableView setDelegate: self];
	[myTableView setDataSource: self];
	//myTableView = tableView;
	//[tableView release];
	
	if(listData == nil)
		self.listData = [[NSMutableArray alloc] initWithObjects: @"Test", @"Hello", @"World", nil];
	//Content *content = [Content getInstance];
	//listData = [content getFilters];
	//self.listData = list;
	//[list release];
	
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
	NSLog(@"View will Appear");
	NSLog([NSString stringWithFormat:@"data: %d", [listData count]]);
	[myTableView reloadData];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"Rows in Section Reached");
	//Content *content = [Content getInstance];
	//return [content getFilterCount];
	//if([self.listData count] > 0) {
		return [self.listData count];
	//}
//	return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";

	NSLog(@"Table view reached");
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	NSLog(cell.description);
	
	//Content *content = [Content getInstance];
	
	//If there are no filters return the empty cell
	//if([listData count] == 0) {
	//	return cell;
	//}
	
	//Filter *f = (Filter *)[listData objectAtIndex:indexPath.row];
	
	//[cell setData: [listData objectAtIndex:[indexPath row]]];
	
//	NSUInteger row = [indexPath row];
	cell.textLabel.text = [self.listData objectAtIndex: indexPath.row];
/*	cell.textLabel.text = [f getTypeName];
	
	switch ([f getFilterType]) {
		case NameFilterType:
			cell.detailTextLabel.text = [f getFiltererName];
			break;
		default:
			break;
	}
*/	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"Row Selected Clicked\n");
	
	/*TODO: Make sure that there is a filter selected */
	
	if(self.myEditFilterController == nil) {
		EditFilterController *new_view = [[EditFilterController alloc] 
										  initWithNibName: @"EditFilterView" bundle: nil];
		self.myEditFilterController = new_view;
		[new_view release];
	}
	
	Content *content = [Content getInstance];
	Filter *filter = [content getFilterAtIndex: [indexPath row]];
	
	if(filter == nil) {
		NSLog(@"Error: Invalid Filter");
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Error: Invalid Filter" 
							  message: @"The filter is not valid" 
							  delegate: nil 
							  cancelButtonTitle: @"OK" 
							  otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
	else {
		self.myEditFilterController.myFilter = filter;
		[self presentModalViewController: self.myEditFilterController animated:YES];
	}
}
		
-(IBAction)addFilter: (id) sender {
	NSLog(@"Add Filter Clicked\n");
	
	if(self.myAddFilterController == nil) {
		AddFilterController *new_view = [[AddFilterController alloc] 
			initWithNibName: @"AddFilterView" bundle: nil];
		self.myAddFilterController = new_view;
		[new_view release];
	}
	
	[self presentModalViewController: self.myAddFilterController animated:YES];

}

-(void)add:(NSObject *)obj {
	NSString *string = [NSString stringWithFormat:@"Number of Items: %d", 
						[self.listData count]];
	NSLog(string);
	[self.listData addObject: obj];
	string = [NSString stringWithFormat:@"Number of Items: %d", 
						[self.listData count]];
	NSLog(string);
 
	[self.myTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[listData dealloc];
    [super dealloc];
}


@end
