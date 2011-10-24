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
			myEditFilterController;
//@synthesize checkedIndexPath;

/* // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"initReached");
	return self;
}*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[myTableView setDelegate: self];
	[myTableView setDataSource: self];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
	NSLog(@"Reached View Will Appear");
	[myTableView reloadData];
	[super viewWillAppear: animated];
	NSLog(@"End of View Will Appear");
}

-(void)viewDidAppear:(BOOL)animated {
	NSLog(@"Reached View Did Appear");
	[super viewDidAppear: animated];
	NSLog(@"End View Did Appear");
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	Content *content = [Content getInstance];
	return [content getFilterCount];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	
	NSString *string;
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		cell.textLabel.font = [UIFont fontWithName:@"ArialMT" size:16];
	}
	
	/*if([self.checkedIndexPath isEqual:indexPath]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}*/
	
	Content *content = [Content getInstance];
	NSMutableArray *filters = [content getFilters];	
	Filter *f = (Filter *)[filters objectAtIndex:indexPath.row];
	
//	NSLog(@"Got Filters");
	
	switch ([f getFilterType]) {
		case NameFilterType:
			string = [f nameString];
			cell.textLabel.text = string;
			break;
		case ArtistFilterType:
			string = [f artistString];
			cell.textLabel.text = string;
			break;
		case TimeFilterType:
			string = [f timeString];
			cell.textLabel.text = string;
			break;
		case CostFilterType:
			string = [f costString];
			cell.textLabel.text = string;
			break;
		case DurationFilterType:
			string = [f durationString];
			cell.textLabel.text = string;
			break;
		case LocationFilterType:
			string = [f locationString];
			cell.textLabel.text = string;
			break;
		case AvailabilityFilterType:
			string = [f availabilityString];
			cell.textLabel.text = string;
			break;
		default:
			break;
	}
	
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
	
	/*UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryNone) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}*/
	
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
    [super dealloc];
}


@end
