//
//  Metro_Atlanta_Arts_AppViewController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Drew on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Metro_Atlanta_Arts_AppViewController.h"
#import "NextView.h"
#import "EventAnnotation.h"

@implementation Metro_Atlanta_Arts_AppViewController

@synthesize myMapView, mapAnnotations;


-(IBAction)next:(id)sender {
	NextView *NView = [[NextView alloc] initWithNibName:nil bundle:nil];
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
	
	[self.view addSubview:myMapView];
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
	location.latitude = 33.7728837;
	location.longitude = -84.393816;
	region.span=span; 
	region.center=location; 
	
	[myMapView setRegion:region animated:TRUE]; 
	[myMapView regionThatFits:region]; 
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
