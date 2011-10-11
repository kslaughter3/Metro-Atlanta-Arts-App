//
//  filterController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FilterListController.h"
#import	"AddFilterController.h"

@implementation FilterListController
@synthesize myFilterTableView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"initReached");
	if ((self = [super initWithNibName:nil bundle:nil])) {
		addButton.target = self;
		addButton.action = @selector(addFilter: ); 
    }
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
	AddFilterController *addFilterView = [[AddFilterController alloc] 
		initWithNibName: @"AddFilterView" bundle: nil];
	[self presentModalViewController: addFilterView animated:YES];
}

-(IBAction)editFilter: (id) sender {
	NSLog(@"Edit Filter Clicked\n");
}

-(IBAction)removeFilter: (id) sender {
	NSLog(@"Remove Filter Clicked\n");
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
