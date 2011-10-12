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
			myAddFilterController, 
			myEditFilterController, 
			myRemoveFilterController,
			listData;

/* // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"initReached");
	return self;
}*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero 
		style: UITableViewStylePlain];
	
	[tableView setDelegate: self];
	[tableView setDataSource: self];
	myTableView = tableView;
	[tableView release];
	
	NSArray *list = [[NSArray alloc] initWithObjects: @"Test", @"Hello", @"World", nil];
	self.listData = list;
	[list release];
    [super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//Content *content = [Content getInstance];
	//return [content getFilterCount];
	if([self.listData count] > 0) {
		return [self.listData count];
	}
	return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	//Content *content = [Content getInstance];
	//Filter *f = (Filter *)[[content getFilters] objectAtIndex:indexPath.row];
	
	NSUInteger row = [indexPath row];
	cell.textLabel.text = [listData objectAtIndex: row];
	
	//cell.textLabel.text = [f getTypeName];
	//TODO: set the detailed text based on the filterer's values 
	//cell.textLabel.text = @"Hello World";
	
	return cell;
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

-(IBAction)editFilter: (id) sender {
	NSLog(@"Edit Filter Clicked\n");
	
	/*TODO: Make sure that there is a filter selected */
	
	if(self.myEditFilterController == nil) {
		EditFilterController *new_view = [[EditFilterController alloc] 
			initWithNibName: @"EditFilterView" bundle: nil];
		self.myEditFilterController = new_view;
		[new_view release];
	}
	
	[self presentModalViewController: self.myEditFilterController animated:YES];
	[self.myEditFilterController.description setText:@"Hello World"];
	
}

-(IBAction)removeFilter: (id) sender {
	NSLog(@"Remove Filter Clicked\n");
	
	/* TODO: Make sure that there is a filter selected */
	
	if(self.myRemoveFilterController == nil) {
		RemoveFilterController *new_view = [[RemoveFilterController alloc] 
			initWithNibName:@"RemoveFilterView" bundle:nil];
		self.myRemoveFilterController = new_view;
		[new_view release];
	}
	
	[self presentModalViewController: self.myRemoveFilterController animated:YES];
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
