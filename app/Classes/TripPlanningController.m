//
// NextView.m
// Metro-Atlanta-Arts-App
//
// Created by Drew on 9/29/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TripPlanningController.h"
#import "Content.h"


@implementation TripPlanningController
@synthesize myTableView,
myTripController,
checkedIndexPath,
integers,
myTripMapController;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[myTableView setDelegate: self];
	[myTableView setDataSource: self];
	
	Content *content = [Content getInstance];
	Event *temp = [[Event alloc] initTestEvent:@"jun2" Description: @"jun2" ];
	[content addEvent: temp];
	
	integers = [[NSMutableArray alloc] init];
	
	[super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	[myTableView reloadData];
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
	}
	
	if([self.checkedIndexPath isEqual:indexPath])
	{
		cell.accessoryType = UITableViewCellAccessoryCheckmark;

	}
	else 
	{
		cell.accessoryType = UITableViewCellAccessoryNone;
	}

	Content *content = [Content getInstance];
	Event *event = (Event *)[content getEventAtIndex: indexPath.row];
	cell.textLabel.text = [event getEventName];
	
	return cell;
}

-(void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	//int idx = indexPath.row;
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryNone)
	{
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		NSNumber* intRow = [NSNumber numberWithInt:indexPath.row];
		[integers addObject: intRow];
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
		NSNumber* intRow = [NSNumber numberWithInt:indexPath.row];
		[integers removeObjectIdenticalTo: intRow];
	}

	self.checkedIndexPath = indexPath;
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

-(IBAction)plan:(id)sender;
{
	for(id num in integers) {
		NSLog([NSString stringWithFormat:@"Index: %d", [num intValue]]);
	}
	if(myTripMapController == nil){
		self.myTripMapController = [[TripPlanningMapController alloc] initWithNibName: @"TripPlanningMapView" bundle: nil];
	}
	[self presentModalViewController: self.myTripMapController animated:YES];
}


@end
