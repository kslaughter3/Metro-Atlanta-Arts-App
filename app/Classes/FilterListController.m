//
//  filterController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FilterListController.h"

@implementation FilterListController
@synthesize myFilterTableView, 
			myAddFilterController, 
			myEditFilterController, 
			myRemoveFilterController;

/* // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"initReached");
	return self;
}*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    [super dealloc];
}


@end
