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

@implementation MapController

@synthesize myMapView, mapAnnotations;


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
	//myMapView.mapType = MKMapTypeSatellite;
	//myMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 100, 500, 400)];
	//myMapView.delegate=self;
	
	//[self.view addSubview:myMapView];
	[NSThread detachNewThreadSelector:@selector(displayMYMap) toTarget:self withObject:nil];
}


-(void)displayMYMap
{
	MKCoordinateRegion region; 
	MKCoordinateSpan span; 
	span.latitudeDelta=0.2; 
	span.longitudeDelta=0.2; 
	
	self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:1];
    EventAnnotation *eventAnnotation = [[EventAnnotation alloc] init];
    [self.mapAnnotations insertObject:eventAnnotation atIndex:0];
	[myMapView addAnnotation:eventAnnotation];
    [eventAnnotation release];    
		
	CLLocationCoordinate2D location; 
	location.latitude = 33.7728837; /* We should make these constants*/
	location.longitude = -84.393816;
	region.span=span; 
	region.center=location; 
	
	[myMapView setRegion:region animated:TRUE]; 
	[myMapView regionThatFits:region]; 
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	static NSString *defaultPinID = @"EventAnnotation";
	MKPinAnnotationView *retval = nil;
	
	if ([annotation isMemberOfClass:[EventAnnotation class]]) {
		(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		
		if (retval == nil) {
			retval = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
			
			// Set up the Left callout
			UIButton *eventButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[eventButton addTarget:self 
					   action:@selector(loadEventDetails:)
			 forControlEvents:UIControlEventTouchDown];
			[eventButton setTitle:@"More" forState:UIControlStateNormal];
			eventButton.frame = CGRectMake(40.0, 105.0, 40.0, 40.0);
			[retval addSubview:eventButton];
			
			
			// Set the image for the button
			//[eventButton setImage:[UIImage imageNamed:@"Event.png"] forState:UIControlStateNormal];
			
			// Set the button as the callout view
			retval.leftCalloutAccessoryView = eventButton;
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

-(IBAction)loadEventDetails:(id)sender
{
	AddFilterController *addFilterView = [[AddFilterController alloc] 
										  initWithNibName: @"AddFilterView" bundle: nil];
	[self presentModalViewController: addFilterView animated:YES];
	
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
    [super dealloc];
	[myMapView release];
}

@end
