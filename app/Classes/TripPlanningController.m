//
// NextView.m
// Metro-Atlanta-Arts-App
//
// Created by Drew on 9/29/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TripPlanningController.h"



@implementation TripPlanningController
@synthesize myTableView,
			myEvents,
			myTripMapController,
			previousButton,
			nextButton,
			timer;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	pool = [[NSAutoreleasePool alloc] init];
	[myTableView setDelegate: self];
	[myTableView setDataSource: self];
	myEvents = [[NSMutableArray alloc] init];
	timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(refreshDataView) userInfo:nil repeats: YES];
	[super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	[self enableNavigationButtons];
}

-(void) refreshDataView {
	Content *content = [Content getInstance];
	if([content getListReady]){
		[myTableView reloadData];
		[content setListReady:0];
	}	
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
	return [content getEventCount];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
		
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		cell.textLabel.textColor = [UIColor whiteColor];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	Content *content = [Content getInstance];
	Event *event = (Event *)[content getEventAtIndex: indexPath.row];
	cell.textLabel.text = [event getEventName];
	if([event getImageURL] != nil && [event getImageURL] != @"") {
		NSURL *url = [NSURL URLWithString: [event getImageURL]];
		NSData *data = [NSData dataWithContentsOfURL:url];
		UIImage *image = [UIImage imageWithData:data];
		cell.imageView.image = image;				
	}
	else {
		cell.imageView.image = [UIImage imageNamed: @"ipod-icon-unknown.jpg"];
	}
	
	if([myEvents containsObject: event]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	return cell;
}

-(void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {

	Event *event = [[Content getInstance] getEventAtIndex: indexPath.row];
	if([myEvents containsObject: event]) {
		[myEvents removeObjectIdenticalTo: event];
	}
	else {
		[myEvents addObject: event];
	}
	
	[tableView reloadData];
}

-(IBAction)close: (id)sender {
	[self.parentViewController dismissModalViewControllerAnimated: YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[myTableView release];
	[myTripMapController release];
	[previousButton release];
	[nextButton release];
}


- (void)dealloc {
	[myTableView release];
	[myTripMapController release];
	[myEvents release];
	[previousButton release];
	[nextButton release];
	[pool release];
	[timer release];
    [super dealloc];
}

-(IBAction)plan:(id)sender
{	
	UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Fill in Parameters:"
													 message:@"\n\n\n"
													delegate:self
										   cancelButtonTitle:@"Enter"
										   otherButtonTitles:@"Cancel", nil];

	UITextField *timeField = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
	[timeField setBackgroundColor:[UIColor whiteColor]];
	[timeField setPlaceholder:@"Time (minutes)"];
	[timeField setKeyboardAppearance:UIKeyboardAppearanceAlert];
	[prompt addSubview: timeField];
	
	/* Add the segmeneted control */
	NSArray *itemArray = [NSArray arrayWithObjects: @"Walk", @"Bike", @"Drive", nil];
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems: itemArray];
	segmentedControl.frame = CGRectMake(12, 80, 260, 25);
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.selectedSegmentIndex = 0;
	[segmentedControl addTarget:self action:@selector(pickMode:) forControlEvents:UIControlEventValueChanged];
	[prompt addSubview: segmentedControl];
	[segmentedControl release];

	// show the dialog box
	[prompt show];
	[prompt release];
	
}

-(void)pickMode:(id)sender 
{
	//Doesn't do anything
}

-(IBAction)previousPage:(id)sender {
	Content *content = [Content getInstance];
	int tablePage = [content getEventPage];
	if(tablePage > 1) {
		[content changeEventPage: NO];
		[self enableNavigationButtons];
		[content populateEvents];
	}
}

-(IBAction)nextPage:(id)sender {
	Content *content = [Content getInstance];
	int tablePage = [content getEventPage];
	int lastPage = [content getEventLastPage];
	if(tablePage < lastPage) {
		[content changeEventPage: YES];
		[self enableNavigationButtons];
		[content populateEvents]; 
	}
}

-(void)enableNavigationButtons {
	Content *content = [Content getInstance];
	int tablePage = [content getEventPage];
	int lastPage = [content getEventLastPage];
	
	if(tablePage == 1) {
		previousButton.enabled = NO;
	}
	else {
		previousButton.enabled = YES;
	}
	
	if(tablePage == lastPage) { 
		nextButton.enabled = NO;
	}
	else {
		nextButton.enabled = YES;
	}
}

-(IBAction)viewPlan:(id)sender
{
	if(myTripMapController == nil){
		self.myTripMapController = [[TripPlanningMapController alloc] initWithNibName: @"TripPlanningMapView" bundle: nil];
	}
	[self presentModalViewController: self.myTripMapController animated:YES];
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==0) {
		NSArray *subviews = alert.subviews;
		
		/* Get the time */
		UITextField *timeField = (UITextField *)[subviews objectAtIndex: 4];
		NSString *timeStr = timeField.text;
		int time = [timeStr intValue];
		
		/* Get the speed */
		UISegmentedControl *segmentedControl = (UISegmentedControl *)[subviews objectAtIndex: 5];
		int index = [segmentedControl selectedSegmentIndex];
		int speed; 
		
		switch(index)
		{
			case 0:
				speed = WALKING_SPEED;
				break;
			case 1:
				speed = BIKING_SPEED;
				break;
			case 2:
				speed = DRIVING_SPEED;
				break;
			default:
				speed = WALKING_SPEED;
				break;
		}
		
		if(time <= 0) {
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"Invalid Input" 
								  message: @"The amount of time specified is invalid" 
								  delegate: nil 
								  cancelButtonTitle: @"OK" 
								  otherButtonTitles: nil];
			[alert show];
			[alert release];
		}
		else {
		
			if(myTripMapController == nil){
				self.myTripMapController = [[TripPlanningMapController alloc] initWithNibName: @"TripPlanningMapView" bundle: nil];
			}

			[myTripMapController setTime: time];
			[myTripMapController setSpeed: speed];
			[myTripMapController setEvents: myEvents];
			
			[self presentModalViewController: self.myTripMapController animated:YES];
		}
	}
}

@end
