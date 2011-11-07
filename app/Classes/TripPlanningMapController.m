//
//  TripPlanningMapViewController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 10/28/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "TripPlanningMapController.h"


@implementation TripPlanningMapController

@synthesize myTripMapView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/*- (void)viewDidLoad {
    [super viewDidLoad];
}*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)setTime:(int)min {
	time = min;
}

-(int)getTime {
	return time;
}

-(void)setSpeed:(int)mph {
	speed = mph;
}

-(int)getSpeed {
	return speed;
}

-(void)setEvents: (NSMutableArray *)indices
{
	Content *content = [Content getInstance];

	if(myEvents == nil) {
		myEvents = [[NSMutableArray alloc] init];
	}
	
	//Get rid of the old events
	[myEvents removeAllObjects];
	
	for(id index in indices) {
		[myEvents addObject: [content getEventAtIndex: [(NSNumber *)index intValue]]];
	}
	
	//[self planTrip];
}

-(void)planTrip 
{ 
	NSMutableArray *eventsLeft = [[NSMutableArray alloc] initWithArray: myEvents];
	NSMutableArray *sorted = [[NSMutableArray alloc] initWithCapacity: [myEvents count]];
	//TODO: get this to get my current location from the phone
	EventLocation *myLoc;
	double minDist = -1;
	Event *nextEvent;
	int timeTaken;
	
	while((timeTaken < time) && ([eventsLeft count] > 0)) {
		for(id e in eventsLeft) {
			Event *event = (Event *)e;
			double dist = [[event getLocation] distanceFromLocation: myLoc];
			if(minDist == -1 || dist < minDist) {
				minDist = dist;
				nextEvent = event;
			}
		}
		
		timeTaken += (minDist/speed);
		myLoc = [nextEvent getLocation];
		[eventsLeft removeObjectIdenticalTo: nextEvent];
		[sorted addObject: nextEvent];
		minDist = -1;
	}
	
	//Remove the events and add them back sorted
	[myEvents removeAllObjects];
	[myEvents addObjectsFromArray: sorted];
}

-(NSMutableArray *)getEvents
{
	return myEvents;
}

-(IBAction)close: (id)sender {
	NSLog(@"Close Clicked\n");
	[self.parentViewController dismissModalViewControllerAnimated: YES];
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
