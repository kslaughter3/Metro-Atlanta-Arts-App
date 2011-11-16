//
//  TripPlanningMapViewController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 10/28/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "TripPlanningMapController.h"


@implementation TripPlanningMapController

@synthesize myTripMapView,
			tripGlobalEvent,
			tripMapAnnotations;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	[NSThread detachNewThreadSelector:@selector(displayTripMap) toTarget:self withObject:nil];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	[self displayTripMap];
}

-(void)displayTripMap {
	[self setUpTripAnnotations];
	[self calibrateTripRegion];
}

-(void)setUpTripAnnotations {
	if(self.tripMapAnnotations == nil) {
		self.tripMapAnnotations = [[NSMutableArray alloc] init];
	}
	
	for(id event in myEvents) {
		EventAnnotation *eventAnnotation = [[EventAnnotation alloc] initAnnotationWithEvent: event];
		if([self.tripMapAnnotations containsObject: eventAnnotation] == NO) {
			[self.tripMapAnnotations addObject:eventAnnotation];
			[myTripMapView addAnnotation:eventAnnotation];
		}
		[eventAnnotation release];   
	}	
}

-(void)calibrateTripRegion {
	EventLocation *loc = [EventLocation alloc];
	double latMin = 9999, longMin = 9999;
	double latMax = -9999, longMax = -9999;
	int numCoords = 0;
	for(id event in myEvents) {
		loc = [event getLocation];
		if (loc != nil){
			if([loc getCoordinates].latitude < latMin) latMin = [loc getCoordinates].latitude;
			if([loc getCoordinates].longitude < longMin) longMin = [loc getCoordinates].longitude;
			if([loc getCoordinates].latitude > latMax) latMax = [loc getCoordinates].latitude;
			if([loc getCoordinates].longitude > longMax) longMax = [loc getCoordinates].longitude;
			numCoords++;
		}
	}
	
	
	MKCoordinateRegion region; 
	MKCoordinateSpan span; 
	CLLocationCoordinate2D location; 
	
	if(numCoords == 0){
		span.latitudeDelta=0.2; 
		span.longitudeDelta=0.2; 
		location.latitude = 33.7728837; /* We should make these constants*/
		location.longitude = -84.393816;
	}
	else {
		location.latitude = ( latMax + latMin )/ 2;
		location.longitude = ( longMax + longMin )/ 2;
		span.latitudeDelta=1.2*(latMax - latMin); 
		span.longitudeDelta=1.1*(longMax - longMin); 
	}
	
	if(span.latitudeDelta < 0.0125) {
		span.latitudeDelta = 0.0125;
	}
	
	if(span.longitudeDelta < 0.0125) {
		span.longitudeDelta = 0.0125;
	}
	
	
	region.span=span; 
	region.center=location; 
	[myTripMapView setRegion:region animated:TRUE]; 
	[myTripMapView regionThatFits:region]; 	
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	static NSString *defaultPinID = @"EventAnnotation";
	MKPinAnnotationView *retval = nil;
	
	if ([annotation isMemberOfClass:[EventAnnotation class]]) {
		retval = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if (retval == nil) {
			retval = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
		}
		
		// Set a bunch of other stuff
		if (retval) {
			[retval setPinColor:MKPinAnnotationColorGreen];
			retval.animatesDrop = YES;
			retval.canShowCallout = YES;
		}
	}
	
	return retval;
}

-(void)mapView: (MKMapView *)mapView didSelectAnnotationView: (MKAnnotationView *) retval {	
	if(retval.leftCalloutAccessoryView == nil)
	{
		// Set up the Left callout
		UIButton *eventButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[eventButton addTarget:self 
						action:@selector(loadTripEventDetails:)
			  forControlEvents:UIControlEventTouchDown];
		[eventButton setTitle:@"More" forState:UIControlStateNormal];
		eventButton.frame = CGRectMake(40.0, 105.0, 40.0, 40.0);
		
		// Set the image for the button
		//[eventButton setImage:[UIImage imageNamed:@"Event.png"] forState:UIControlStateNormal];
		
		// Set the button as the callout view
		retval.leftCalloutAccessoryView = eventButton;
	}	
	
	if(retval.annotation != nil) {
		id annotation = retval.annotation;
		if([annotation isMemberOfClass:[EventAnnotation class]]) {
			tripGlobalEvent = ((EventAnnotation*)annotation).event;
		}
	}
}

-(IBAction)loadTripEventDetails:(id)sender
{
	
	EventController *eventView = [[EventController alloc] 
								  initWithNibName: @"EventView" bundle: nil];
	[eventView setEvent: tripGlobalEvent];
	[self presentModalViewController: eventView animated:YES];
	
}


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
	
	[myTripMapView removeAnnotations: self.tripMapAnnotations];
	[self.tripMapAnnotations removeAllObjects];
	
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
	[myEvents release];
	[myTripMapView release];
	[tripGlobalEvent release];
	[tripMapAnnotations release];
    [super dealloc];
}


@end
