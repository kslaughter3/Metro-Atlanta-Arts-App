//
//  Metro_Atlanta_Arts_AppViewController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Drew on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapController.h"

@interface MapController () <SBJsonStreamParserAdapterDelegate>
@end

@implementation MapController

@synthesize myMapView, mapAnnotations, globalEvent, locationManager, myEventController;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
	pool = [[NSAutoreleasePool alloc] init];
	[super viewDidLoad];
	
	// We don't want *all* the individual messages from the
	// SBJsonStreamParser, just the top-level objects. The stream
	// parser adapter exists for this purpose.
	adapter = [[SBJsonStreamParserAdapter alloc] init];
	
	// Set ourselves as the delegate, so we receive the messages
	// from the adapter.
	adapter.delegate = self;
	
	// Create a new stream parser..
	parser = [[SBJsonStreamParser alloc] init];
	
	// .. and set our adapter as its delegate.
	parser.delegate = adapter;
	
	// Normally it's an error if JSON is followed by anything but
	// whitespace. Setting this means that the parser will be
	// expecting the stream to contain multiple whitespace-separated
	// JSON documents.
	parser.supportMultipleDocuments = YES;
	
	NSString *url = @"http://meta.gimmefiction.com/?count=3";
	
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:60.0];
	
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	//[self.view addSubview:myMapView];
	[NSThread detachNewThreadSelector:@selector(displayMyMap) toTarget:self withObject:nil];
	
	//try to update location
	
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLDistanceFilterNone;
	locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
	[locationManager startUpdatingLocation];
}


//does not work with iPhone Simulator
- (void)locationManager:(CLLocationManager *)manager 
	didUpdateToLocation:(CLLocation *) newLocation
		   fromLocation:(CLLocation *) oldLocation
{
	NSLog(@"called");
	MKCoordinateRegion region; 
	MKCoordinateSpan span;
	span.latitudeDelta=0.2; 
	span.longitudeDelta=0.2; 
	region.span = span;
	CLLocationCoordinate2D userCoordinate = locationManager.location.coordinate;
	region.center = userCoordinate;
	[myMapView setCenterCoordinate:userCoordinate animated:YES];
	[myMapView setShowsUserLocation:YES];
	[myMapView setRegion:region animated:TRUE]; 
	[myMapView regionThatFits:region];
	NSLog(@"updated");
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	Content *content = [Content getInstance];
	[content populateEvents];
	[self enableNavigationButtons];
	[self displayMyMap];
}

-(void)displayMyMap {
	[self setUpAnnotations];
	[self calibrateRegion];
}

-(void)setUpAnnotations {
	if(self.mapAnnotations == nil) {
		self.mapAnnotations = [[NSMutableArray alloc] init];
	}
	
	Content *content = [Content getInstance];
	NSMutableArray *events = [content getEvents];
	
	for(id event in events) {
		EventAnnotation *eventAnnotation = [[EventAnnotation alloc] initAnnotationWithEvent: event];
		if([self.mapAnnotations containsObject: eventAnnotation] == NO) {
			[self.mapAnnotations addObject:eventAnnotation];
			[myMapView addAnnotation:eventAnnotation];
		}
		[eventAnnotation release];   
	}
			
}

-(void)calibrateRegion {
	Content *content = [Content getInstance];
	NSMutableArray *events = [content getEvents];
	EventLocation *loc;
	double latMin = 9999, longMin = 9999;
	double latMax = -9999, longMax = -9999;
	int numCoords = 0;
	for(id event in events) {
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
	[myMapView setRegion:region animated:TRUE]; 
	[myMapView regionThatFits:region]; 
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
						action:@selector(loadEventDetails:)
		  forControlEvents:UIControlEventTouchDown];
		[eventButton setTitle:@"More" forState:UIControlStateNormal];
		eventButton.frame = CGRectMake(40.0, 105.0, 40.0, 40.0);
	
		// Set the button as the callout view
		retval.leftCalloutAccessoryView = eventButton;
	}	
	if(retval.annotation != nil) {
		id annotation = retval.annotation;
		if([annotation isMemberOfClass:[EventAnnotation class]]) {
			globalEvent = ((EventAnnotation*)annotation).event;
		}
	}
}

-(IBAction)loadEventDetails:(id)sender {
	if(myEventController == nil) {
		myEventController = [[DetailsController alloc] 
			initWithNibName: @"DetailsView" bundle: nil];
	}
	
	[myEventController setDetailsType: EventDetails];
	myEventController.event = globalEvent;
	[self presentModalViewController: self.myEventController animated:YES];
	
}

-(IBAction)previousPage:(id)sender {
	Content *content = [Content getInstance];
	int myPage = [content getEventPage];
	
	if(myPage > 1) {
		[content changeEventPage: NO];
		[self enableNavigationButtons];
		[content populateEvents];
		[self displayMyMap];
	}
}

-(IBAction)nextPage:(id)sender {
	Content *content = [Content getInstance];
	int myPage = [content getEventPage];
	int lastPage = [content getEventLastPage];
	
	if(myPage < lastPage) {
		[content changeEventPage: YES];
		[self enableNavigationButtons];
		[content populateEvents];
		[self displayMyMap];
	}
}

-(void)changeEventType:(id)sender {
	Content *content = [Content getInstance];
	EventType type = (EventType)[mySelectionBar selectedSegmentIndex];
	[content resetEventPage];
	[content setEventType: type];
	[self enableNavigationButtons];
	[self displayMyMap];
}



-(void)enableNavigationButtons {
	Content *content = [Content getInstance];
	int myPage = [content getEventPage];
	int lastPage = [content getEventLastPage];
	if(myPage == 1) {
		previousButton.enabled = NO;
	}
	else {
		previousButton.enabled = YES;
	}
	
	if(myPage == lastPage) { 
		nextButton.enabled = NO;
	}
	else {
		nextButton.enabled = YES;
	}
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[super viewDidUnload];
	[username release];
	[password release];
	[tweet release];
	[myMapView release];
	[myTitleBar release];
	[previousButton release];
	[nextButton release];
	[mySelectionBar release];
}


- (void)dealloc {
	[username release];
	[password release];
	[tweet release];
	[myMapView release];
	[myTitleBar release];
	[previousButton release];
	[nextButton release];
	[mySelectionBar release];
	[theConnection release];
	[parser release];
	[adapter release];
	[mapAnnotations release];
	[locationManager release];
	[myEventController release];
	[pool release];
    [super dealloc];
}


- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
    [NSException raise:@"unexpected" format:@"Should not get here"];
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {
	tweet.text = [dict objectForKey:@"text"];
}

#pragma mark NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Connection didReceiveResponse: %@ - %@", response, [response MIMEType]);
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"Connection didReceiveAuthenticationChallenge: %@", challenge);
	
	NSURLCredential *credential = [NSURLCredential credentialWithUser:username.text
															 password:password.text
														  persistence:NSURLCredentialPersistenceForSession];
	
	[[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"Connection didReceiveData of length: %u", data.length);
	
	// Parse the new chunk of data. The parser will append it to
	// its internal buffer, then parse from where it left off in
	// the last chunk.
	NSString *payloadAsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(payloadAsString);
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
}

@end
