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
	
	if(myEvent == nil)
	{
		return;
	}
	myTitleBar.topItem.title = [myEvent getEventName];
	
	NSString *html = [self buildHTMLString];
	[descriptionView loadHTMLString:html baseURL:[NSURL URLWithString: @"http:://www.apple.com"]];

}

-(NSString *)buildHTMLString 
{
	NSString *html = [NSString stringWithFormat:@"<html>"\
					  "<head><meta name=""viewport"" content=""width=320""/>"\
					  "</head><body>"];
	NSString *temp;
	
	/* Add the fields that are there */
	if([myEvent getImageURL] != nil && [myEvent getImageURL] != @"") {
		temp= [NSString stringWithFormat:@"<center><p><img src=\"%@\" "\
						 "height=\"%d\"></p></center>", [myEvent getImageURL], 100];
		html = [html stringByAppendingString: temp];
	}
	
	if([myEvent getLocation] != nil) {
		if([[myEvent getLocation] getName] != @"") {
			temp = [NSString stringWithFormat:@"<h3>Location</h3><p>%@</p>", 
							  [[myEvent getLocation] getName]];
		}
		else {
			temp = [NSString stringWithFormat:@"<h3>Location</h3><p>%@<br/>%@, %@ %@ </p>", 
							  [[myEvent getLocation] getStreetAddress], 
							  [[myEvent getLocation] getCity],
							  [[myEvent getLocation] getState],
							  [[myEvent getLocation] getZip]];
		}
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEvent getStartDate] != nil && [myEvent getEndDate] != nil) {
		temp = [NSString stringWithFormat:@"<h3>Availability</h3><h4>Dates</h4>"\
				"<p>%@-%@</p><h4>Times</h4><p>%@-%@</p>", 
				[[myEvent getStartDate] getDate], [[myEvent getEndDate] getDate], 
				[[myEvent getStartDate] getTimeStandardFormat],
				[[myEvent getEndDate] getTimeStandardFormat]];
		
		html = [html stringByAppendingString: temp];
	}
	else if([myEvent getAvailability] != nil) {
		temp = [NSString stringWithFormat:@"<h3>Availability</h3><h4>Days</h4>"\
				"<p>%@</p><h4>Times</h4><p>%@-%@</p>",
				[[myEvent getAvailability] getDayRange],
				[[myEvent getAvailability] getStartTimeString],
				[[myEvent getAvailability] getEndTimeString]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEvent getDescription] != nil && [myEvent getDescription] != @"") {
		temp = [NSString stringWithFormat:@"<h3>Description</h3><p>%@</p>", 
				[myEvent getDescription]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEvent getArtist] != nil && [[myEvent getArtist] getName] != @"") {
		temp = [NSString stringWithFormat:@"<h3>Artist</h3><p>%@</p>", 
						  [[myEvent getArtist] getName]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEvent getCost] > 0) {
		temp = [NSString stringWithFormat:@"<h3>Price</h3><p>$%.2f</p>",
				[myEvent getCost]];
		
		html = [html stringByAppendingString: temp];
	}
	else if([myEvent getCost] == 0) {
		temp = [NSString stringWithFormat:@"<h3>Price</h3><p>Free</p>"];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEvent getDuration] > 0) {
		temp = [NSString stringWithFormat:@"<h3>Duration</h3><p>%d minutes</p>",
				[myEvent getDuration]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEvent getWebsite] != nil && [myEvent getWebsite] != @"") {
		temp = [NSString stringWithFormat:@"<center><p><a href=\"%@\">View Website</a></p></center>",
				[myEvent getWebsite]];
		
		html = [html stringByAppendingString: temp];
	}
	
	html = [html stringByAppendingString: @"</body></html>"];
	
	NSLog(html);
	
	return html;
}


-(IBAction)close: (id)sender {
	NSLog(@"Close Clicked\n");
	[self.parentViewController dismissModalViewControllerAnimated: YES];
}

-(void)setEvent:(Event *)event {
	myEvent = event;
}
-(Event *)getEvent {
	return myEvent;
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
