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
	 
//TEST EVENT	 
	 Event *event = [[Event alloc] initEmptyEvent];
	 [event setEventName: @"Test"];
	 [event setImageURL:@"http://gra217b.files.wordpress.com/2011/09/apple-mac-logo.jpg"];
	 EventLocation *loc = [[EventLocation alloc] initEmptyLocation];
	 [loc setName: @"Atlanta Museum of Modern Art"];
	 [event setLocation: loc];
	 EventDate *start = [[EventDate alloc] initEmptyDate];
	 [start setDate: @"11/04/2011"];
	 [start setTime: @"9:00am"];
	 EventDate *end = [[EventDate alloc] initEmptyDate];
	 [end setDate: @"11/11/2011"];
	 [end setTime: @"5:00pm"];
	 [event setStartDate: start];
	 [event setEndDate: end];
	 
/*	 EventAvailability *avail = [[EventAvailability alloc] initEmptyAvailability];
	 [avail addDay: @"Monday"];
	 [avail addDay: @"Friday"];
	 [avail setStartTime: 900];
	 [avail setEndTime: 1700];
	 [event setAvailability: avail];
*/
	 [event setDescription: @"This is a long description that should take more than "\
	  "one line and I want to see if that is a problem for the "\
	  "text view to handle also I'm inserting a newline character "\
	  "here\nto see if that works as well lets make this even longer"\
	  "so it goes beyond the size of the visible box"\
	  "so I'm just going to keep on typing until such a time that"\
	  "I feel like this is pretty long\n so the scrolling works"];
	 EventArtist *art = [[EventArtist alloc] initEmptyArtist];
	 [art setName: @"Van Goh"];
	 [event setArtist: art];
	 [event setCost: 10.0];
	 [event setDuration: 20];
	 [event setWebsite: @"http:://www.apple.com"];
	 
	 //Event *event= [[Event alloc] initTestEvent: @"test" Description: @"1 2 3 4"];
	 [content addEvent: event];
	 
	 [super viewDidLoad];
 }

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	[myTableView reloadData];
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
	return [content getEventCount];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	Content *content = [Content getInstance];
	Event *event = (Event *)[[content getEvents] objectAtIndex:indexPath.row];

	cell.textLabel.text = [event getEventName];
	
	return cell;
}

-(void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	//int idx = indexPath.row;
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	Content *content = [Content getInstance];
	
	Event *event = [[content getEvents] objectAtIndex: indexPath.row];
	
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