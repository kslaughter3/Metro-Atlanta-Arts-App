//
//  EventController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/12/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "EventController.h"


@implementation EventController
@synthesize descriptionView, detailView, imageView, myTitleBar;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	myEvent = [[Event alloc] initTestEvent: @"test" Description: @"1 2 3 4"];
	if(myEvent == nil)
	{
		return;
	}
	myTitleBar.topItem.title = [myEvent getEventName];
	
	NSString *deschtml = [self buildDescriptionHTMLString];
	[descriptionView loadHTMLString:deschtml baseURL:[NSURL URLWithString: @"http:://www.apple.com"]];

}

-(NSString *)buildDescriptionHTMLString 
{
	NSString *locationString = [NSString stringWithFormat: @"%@", [[myEvent getLocation] getStreetAddress]];
	NSString *timeString = [NSString stringWithFormat:@"%@-%@", [[myEvent getStartDate] getTimeStandardFormat],
							[[myEvent getEndDate] getTimeStandardFormat]];
	NSString *costString = [NSString stringWithFormat: @"%d",[myEvent getCost]];
	
	NSString *html = [NSString stringWithFormat:@"<html><head><meta name=""viewport"" content=""width=320""/></head>"\
					  "<body><h3>Location</h3><p>%@</p><h3>Time</h3><p>%@</p> <h3> Cost </h3> <p>%@</p> <h3>Description</h3><p>%@</p> </body></html>", 
					  locationString, timeString, costString, [myEvent getDescription]];
	
	NSLog(html);
	
	return html;
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
