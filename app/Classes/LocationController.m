//
//  LocationController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "LocationController.h"


@implementation LocationController
@synthesize myTitleBar,
			myWebView;

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


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	if(location == nil) {
		return;
	}
	
	if(([location getName] != nil) && ([[location getName] isEqualToString: @""] == NO)) {
		myTitleBar.topItem.title = [location getName];
	}
	else {
		myTitleBar.topItem.title = [location getStreetAddress];
	}
	
	NSString *html = [self buildHTMLString];
	[myWebView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.apple.com"]];
}

-(NSString *)buildHTMLString {
	NSString *html = [NSString stringWithFormat:@"<html>"\
					  "<head><meta name=""viewport"" content=""width=320""/>"\
					  "</head><body>"];
	NSString *temp;
	
	/* Add the fields that are there */
	if([location getImage] != nil && [location getImage] != @"") {
		temp= [NSString stringWithFormat:@"<center><p><img src=\"%@\" "\
			   "height=\"%d\"></p></center>", [location getImage], 100];
		html = [html stringByAppendingString: temp];
	}
	
	if([location hasAddress] == YES) {
		temp = [NSString stringWithFormat:@"<p><b>Address</b><br/>%@</p>", 
				[location getAddress]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([location getDescription] != nil && [location getDescription] != @"") {
		temp = [NSString stringWithFormat:@"<p><b>Description</b><br/>%@</p>", 
				[location getDescription]];
		
		html = [html stringByAppendingString: temp];
	}
	
	NSMutableArray *events = [[Content getInstance] getEventsForLocation: location];
	
	if([events count] >= 1) {
		if([events count] == 1) {
			Event *event = (Event *)[events objectAtIndex:0];
			temp = [NSString stringWithFormat:@"<p><b>Event</b><br/>%@</p>",
					[event getEventName]];
		}
		else {
			temp = [NSString stringWithFormat: @"<p><b>Events</b>"];
			for(id e in events) {
				Event *event = (Event *)e;
				NSString *eventString = [NSString stringWithFormat:@"<br/>%@",
										 [event getEventName]];
				temp = [temp stringByAppendingString:eventString];
			}
			temp = [temp stringByAppendingString:@"</p>"];
		}
		html = [html stringByAppendingString: temp];
	}
	
	
	if([location getWebsite] != nil && [location getWebsite] != @"") {
		temp = [NSString stringWithFormat:@"<center><p><a href=\"%@\">View Website</a></p></center>",
				[location getWebsite]];
		
		html = [html stringByAppendingString: temp];
	}
	
	html = [html stringByAppendingString: @"</body></html>"];
	
	return html;
}

-(BOOL)webView:(UIWebView *)descriptionTextView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (UIWebViewNavigationTypeLinkClicked == navigationType) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

-(IBAction)close: (id)sender {
	NSLog(@"Close Clicked\n");
	[self.parentViewController dismissModalViewControllerAnimated: YES];
}

-(void)setLocation:(EventLocation *)loc {
	location = loc;
}
-(EventLocation	*)getLocation{
	return location;
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
