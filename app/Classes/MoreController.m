//
//  MoreController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "MoreController.h"


@implementation MoreController
@synthesize myTitleBar,
			tripPlanningButton,
			aboutUsButton,
			myTripPlanner,
			myAboutUsController;

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
- (void)viewDidLoad {
	pool = [[NSAutoreleasePool alloc] init];
    [super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

-(IBAction)openTripPlanning: (id) sender {
	if(myTripPlanner == nil) {
		self.myTripPlanner = [[TripPlanningController alloc] initWithNibName: @"TripPlanningView" bundle: nil];
	}
	[self presentModalViewController:self.myTripPlanner animated:YES];
}

-(IBAction)openAboutUs: (id) sender {
	if(myAboutUsController == nil) {
		self.myAboutUsController = [[DetailsController alloc] initWithNibName: @"DetailsView" bundle: nil];
	}
	[myAboutUsController setDetailsType: AboutUsDetails];	
	[self presentModalViewController:self.myAboutUsController animated:YES];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[myTitleBar release];
	[tripPlanningButton release];
	[aboutUsButton release];
}


- (void)dealloc {
	[myTripPlanner release];
	[myAboutUsController release];
	[myTitleBar release];
	[tripPlanningButton release];
	[aboutUsButton release];
	[pool release];
	[super dealloc];
}	


@end
