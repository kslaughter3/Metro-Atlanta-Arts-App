//
// NextView.m
// Metro-Atlanta-Arts-App
//
// Created by Drew on 9/29/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventListController.h"


@implementation EventListController
@synthesize myTableView,
			myEventController;

// The designated initializer. Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
	 
	 [myTableView setDelegate: self];
	 [myTableView setDataSource: self];
	 
	 Content *content = [Content getInstance];
	 Event *event= [[Event alloc] initTestEvent: @"test" Description: @"1 2 3 4"];
	 [content addEvent: event];
	 
	 [super viewDidLoad];
 }


 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
	 return YES;
// return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	Content *content = [Content getInstance];
	return [content getDisplayedEventCount];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	Content *content = [Content getInstance];
	Event *event = (Event *)[[content getDisplayedEvents] objectAtIndex:indexPath.row];

	cell.textLabel.text = [event getEventName];
	
	return cell;
}

-(void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	//int idx = indexPath.row;
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	Content *content = [Content getInstance];
	
	Event *event = [[content getDisplayedEvents] objectAtIndex: indexPath.row];
	
	if(myEventController == nil) {
		self.myEventController = [[EventController alloc] initWithNibName: @"EventView" bundle: nil];
	}
	
	[myEventController setEvent: event];
	
	[self presentModalViewController: self.myEventController animated:YES];
	//[self.view addSubview:[myEventController view]];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
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