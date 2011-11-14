//
//  EventController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/12/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "EventController.h"


@implementation EventController
@synthesize myWebView, myTitleBar;

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
    [super viewDidLoad];
	myWebView.delegate = self;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if(myEvent == nil)
	{
		return;
	}
	myTitleBar.topItem.title = [myEvent getEventName];
	
	NSString *html = [self buildHTMLString];
	[myWebView loadHTMLString:html baseURL:[NSURL URLWithString: @"http://www.apple.com"]];

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
		if(([[myEvent getLocation] getName] != nil) && ([[myEvent getLocation] getName] != @"")) {
			temp = [NSString stringWithFormat:@"<p><b>Location</b><br/>%@</p>", 
							  [[myEvent getLocation] getName]];
		}
		else {
			temp = [NSString stringWithFormat:@"<p><b>Location</b><br/>%@<br/>%@, %@ %@ </p>", 
							  [[myEvent getLocation] getStreetAddress], 
							  [[myEvent getLocation] getCity],
							  [[myEvent getLocation] getState],
							  [[myEvent getLocation] getZip]];
		}
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEvent getStartDate] != nil && [myEvent getEndDate] != nil) {
		if([[myEvent getStartDate] isEqualTime: [myEvent getEndDate]]) {
			temp = [NSString stringWithFormat:@"<p><b>Availability</b><br/>"\
					"%@-%@<br/>All Day</p>", 
					[[myEvent getStartDate] getDate], [[myEvent getEndDate] getDate]];
		}
		else {
			temp = [NSString stringWithFormat:@"<p><b>Availability</b><br/>"\
					"%@-%@<br/>%@-%@</p>", 
					[[myEvent getStartDate] getDate], [[myEvent getEndDate] getDate], 
					[[myEvent getStartDate] getTimeStandardFormat],
					[[myEvent getEndDate] getTimeStandardFormat]];
		}
		
		html = [html stringByAppendingString: temp];
	}
	else if([myEvent getAvailability] != nil) {
		if([[myEvent getAvailability] availableAllDay] == YES) {
			temp = [NSString stringWithFormat:@"<p><b>Availability</b><br/>"\
					"%@<br/>All Day</p>",
					[[myEvent getAvailability] getDayRange]];
		}
		else {
			temp = [NSString stringWithFormat:@"<p><b>Availability</b><br/>"\
					"%@<br/>%@-%@</p>",
					[[myEvent getAvailability] getDayRange],
					[[myEvent getAvailability] getStartTimeString],
					[[myEvent getAvailability] getEndTimeString]];
		}
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEvent getDescription] != nil && [myEvent getDescription] != @"") {
		temp = [NSString stringWithFormat:@"<p><b>Description</b><br/>%@</p>", 
				[myEvent getDescription]];
		
		html = [html stringByAppendingString: temp];
	}
	
	NSMutableArray *artists = [myEvent getArtists];
	
	if([artists count] >= 1) {
		if([artists count] == 1) {
			EventArtist *art = (EventArtist *)[artists objectAtIndex: 0];
			temp = [NSString stringWithFormat: @"<p><b>Artist</b><br/>%@</p>",
					[art getName]];
		}
		else {
			temp = [NSString stringWithFormat: @"<p><b>Artists</b>"];
			for(id a in artists) {
				EventArtist *art = (EventArtist *)a;
				NSString *artistString = [NSString stringWithFormat:@"<br/>%@", 
										  [art getName]];
				temp = [temp stringByAppendingString: artistString];
			}
			temp = [temp stringByAppendingString:@"</p>"];
		}
		html = [html stringByAppendingString: temp];
	}
	
	
	if(([myEvent getMaxCost] >= 0) || ([myEvent getMaxCost] >= 0)) {
		
		if([myEvent getMinCost] == 0) {
			if([myEvent getMaxCost] == 0) {
				temp = [NSString stringWithFormat:@"<p><b>Price</b><br/>Free</p>"];
			}
			else {
				temp = [NSString stringWithFormat:@"<p><b>Price</b><br/>Free-$%.2f</p>",
						[myEvent getMaxCost]];
			}
		}
		else if(([myEvent getMinCost] < 0) || ([myEvent getMinCost] == [myEvent getMaxCost]))  {
			temp = [NSString stringWithFormat:@"<p><b>Price</b><br/>$%.2f</p>", 
					[myEvent getMaxCost]];
		}
		else {
			temp = [NSString stringWithFormat:@"<p><b>Price</b><br/>$%.2f-$%.2f</p>",
					[myEvent getMinCost], [myEvent getMaxCost]];
		}
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEvent getDuration] > 0) {
		temp = [NSString stringWithFormat:@"<p><b>Duration</b><br/>%d minutes</p>",
				[myEvent getDuration]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEvent getWebsite] != nil && [myEvent getWebsite] != @"") {
		temp = [NSString stringWithFormat:@"<center><p><a href=\"%@\">View Website</a></p></center>",
				[myEvent getWebsite]];
		
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
	[myTitleBar release];
	[myWebView release];
	[myEvent release];
    [super dealloc];
}


@end
