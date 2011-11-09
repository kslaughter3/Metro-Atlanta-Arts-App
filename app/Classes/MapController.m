//
//  Metro_Atlanta_Arts_AppViewController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Drew on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapController.h"
#import "EventListController.h"
#import "EventAnnotation.h"
#import "AddFilterController.h"
#import "json/SBJson.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface MapController () <SBJsonStreamParserAdapterDelegate>
@end

@implementation MapController

@synthesize myMapView, mapAnnotations, globalEvent;


-(IBAction)next:(id)sender {
	EventListController *NView = [[EventListController alloc] initWithNibName:nil bundle:nil];
	[self presentModalViewController:NView animated:YES];
}

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
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	[self displayMyMap];
}

-(void)displayMyMap
{
	MKCoordinateRegion region; 
	MKCoordinateSpan span; 
	span.latitudeDelta=0.2; 
	span.longitudeDelta=0.2; 
	
	[self setUpAnnotations];
	
	CLLocationCoordinate2D location; 
	location.latitude = 33.7728837; /* We should make these constants*/
	location.longitude = -84.393816;
	region.span=span; 
	region.center=location; 
	
	[myMapView setRegion:region animated:TRUE]; 
	[myMapView regionThatFits:region]; 
}

-(void)setUpAnnotations
{
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
	
		// Set the image for the button
		//[eventButton setImage:[UIImage imageNamed:@"Event.png"] forState:UIControlStateNormal];
	
		// Set the button as the callout view
		retval.leftCalloutAccessoryView = eventButton;
		[eventButton release];
	}	
	
	if(retval.annotation != nil) {
		id annotation = retval.annotation;
		if([annotation isMemberOfClass:[EventAnnotation class]]) {
			globalEvent = ((EventAnnotation*)annotation).event;
		}
	}
}

-(IBAction)loadEventDetails:(id)sender
{

	EventController *eventView = [[EventController alloc] 
								  initWithNibName: @"EventView" bundle: nil];
	[eventView setEvent: globalEvent];
	[self presentModalViewController: eventView animated:YES];
	
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[username release];
	[password release];
	[tweet release];
	[myMapView release];
	[theConnection release];
	[parser release];
	[adapter release];
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
