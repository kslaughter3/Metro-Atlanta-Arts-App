//
//  EventController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/12/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "DetailsController.h"


@implementation DetailsController
@synthesize myWebView, 
			myTitleBar,
			event,
			artist,
			location,
			selfCurated,
			aboutUs;

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
	myWebView.delegate = self;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self setUpTitle];
	
	NSString *html = [self buildHTMLString];
	[myWebView loadHTMLString:html baseURL:[NSURL URLWithString: @"http://www.apple.com"]];

}

-(void)setUpTitle {
	switch (detailsType) {
		case EventDetails:
			myTitleBar.topItem.title = [event getEventName];
			break;
		case ArtistDetails:
			myTitleBar.topItem.title = [artist getName];
			break;
		case LocationDetails:
			if([location getName] != nil && ![[location getName] isEqualToString: @""]) {
				myTitleBar.topItem.title = [location getName];
			}
			else {
				myTitleBar.topItem.title = [location getStreetAddress];
			}
			break;
		case SelfCuratedDetails:
			myTitleBar.topItem.title = [selfCurated getName];
			break;
		case AboutUsDetails:
			myTitleBar.topItem.title = @"About Us";
			break;
		default:
			myTitleBar.topItem.title = [event getEventName];
			break;
	}
}

-(NSString *)buildHTMLString {
	switch (detailsType) {
		case EventDetails:
			return [self buildEventString];
			break;
		case ArtistDetails:
			return [self buildArtistString];
			break;
		case LocationDetails:
			return [self buildLocationString];
			break;
		case SelfCuratedDetails:
			return [self buildSelfCuratedString];
			break;
		case AboutUsDetails:
			return [self buildAboutUsString];
			break;
		default:
			return [self buildEventString];
			break;
	}
}

-(NSString *)buildEventString  {
	NSString *html = [NSString stringWithFormat:@"<html>"\
					  "<head><meta name=""viewport"" content=""width=320""/>"\
					  "</head><body>"];
	NSString *temp;
	
	/* Add the fields that are there */
	if([event getImageURL] != nil && ![[event getImageURL] isEqualToString: @""]) {
		temp= [NSString stringWithFormat:@"<center><p><img src=\"%@\" "\
						 "height=\"%d\"></p></center>", [event getImageURL], 100];
		html = [html stringByAppendingString: temp];
	}
	
	if([event getLocation] != nil) {
		if(([[event getLocation] getName] != nil) && (![[[event getLocation] getName] isEqualToString: @""])) {
			temp = [NSString stringWithFormat:@"<p><b>Location</b><br/>%@</p>", 
							  [[event getLocation] getName]];
		}
		else {
			temp = [NSString stringWithFormat:@"<p><b>Location</b><br/>%@<br/>%@, %@ %@ </p>", 
							  [[event getLocation] getStreetAddress], 
							  [[event getLocation] getCity],
							  [[event getLocation] getState],
							  [[event getLocation] getZip]];
		}
		
		html = [html stringByAppendingString: temp];
	}
	
	if([event getStartDate] != nil && [event getEndDate] != nil) {
		if([[event getStartDate] isEqualTime: [event getEndDate]]) {
			temp = [NSString stringWithFormat:@"<p><b>Availability</b><br/>"\
					"%@-%@<br/>All Day</p>", 
					[[event getStartDate] getDate], [[event getEndDate] getDate]];
		}
		else {
			temp = [NSString stringWithFormat:@"<p><b>Availability</b><br/>"\
					"%@-%@<br/>%@-%@</p>", 
					[[event getStartDate] getDate], [[event getEndDate] getDate], 
					[[event getStartDate] getTimeStandardFormat],
					[[event getEndDate] getTimeStandardFormat]];
		}
		
		html = [html stringByAppendingString: temp];
	}
	else if([event getAvailability] != nil) {
		if([[event getAvailability] availableAllDay] == YES) {
			temp = [NSString stringWithFormat:@"<p><b>Availability</b><br/>"\
					"%@<br/>All Day</p>",
					[[event getAvailability] getDayRange]];
		}
		else {
			temp = [NSString stringWithFormat:@"<p><b>Availability</b><br/>"\
					"%@<br/>%@-%@</p>",
					[[event getAvailability] getDayRange],
					[[event getAvailability] getStartTimeString],
					[[event getAvailability] getEndTimeString]];
		}
		
		html = [html stringByAppendingString: temp];
	}
	
	if([event getDescription] != nil && ![[event getDescription] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<p><b>Description</b><br/>%@</p>", 
				[event getDescription]];
		
		html = [html stringByAppendingString: temp];
	}
	
	NSMutableArray *artists = [event getArtists];
	
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
	
	
	if(([event getMaxCost] >= 0) || ([event getMaxCost] >= 0)) {
		
		if([event getMinCost] == 0) {
			if([event getMaxCost] == 0) {
				temp = [NSString stringWithFormat:@"<p><b>Price</b><br/>Free</p>"];
			}
			else {
				temp = [NSString stringWithFormat:@"<p><b>Price</b><br/>Free-$%.2f</p>",
						[event getMaxCost]];
			}
		}
		else if(([event getMinCost] < 0) || ([event getMinCost] == [event getMaxCost]))  {
			temp = [NSString stringWithFormat:@"<p><b>Price</b><br/>$%.2f</p>", 
					[event getMaxCost]];
		}
		else {
			temp = [NSString stringWithFormat:@"<p><b>Price</b><br/>$%.2f-$%.2f</p>",
					[event getMinCost], [event getMaxCost]];
		}
		
		html = [html stringByAppendingString: temp];
	}
	
	if([event getDuration] > 0) {
		temp = [NSString stringWithFormat:@"<p><b>Duration</b><br/>%d minutes</p>",
				[event getDuration]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([event getWebsite] != nil && ![[event getWebsite] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<center><p><a href=\"%@\">View Website</a></p></center>",
				[event getWebsite]];
		
		html = [html stringByAppendingString: temp];
	}
	
	html = [html stringByAppendingString: @"</body></html>"];
	
	return html;
}

-(NSString *)buildArtistString {
	NSString *html = [NSString stringWithFormat:@"<html>"\
					  "<head><meta name=""viewport"" content=""width=320""/>"\
					  "</head><body>"];
	NSString *temp;
	
	/* Add the fields that are there */
	if([artist getImageURL] != nil && ![[artist getImageURL] isEqualToString: @""]) {
		temp= [NSString stringWithFormat:@"<center><p><img src=\"%@\" "\
			   "height=\"%d\"></p></center>", [artist getImageURL], 100];
		html = [html stringByAppendingString: temp];
	}
	
	if([artist getDescription] != nil && ![[artist getDescription] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<p><b>Description</b><br/>%@</p>", 
				[artist getDescription]];
		
		html = [html stringByAppendingString: temp];
	}
	
	NSMutableArray *events = [[Content getInstance] getEventsForArtist: artist];
	
	if([events count] >= 1) {
		if([events count] == 1) {
			Event *ev = (Event *)[events objectAtIndex:0];
			temp = [NSString stringWithFormat:@"<p><b>Event</b><br/>%@</p>",
					[ev getEventName]];
		}
		else {
			temp = [NSString stringWithFormat: @"<p><b>Events</b>"];
			for(id e in events) {
				Event *ev = (Event *)e;
				NSString *eventString = [NSString stringWithFormat:@"<br/>%@",
										 [ev getEventName]];
				temp = [temp stringByAppendingString:eventString];
			}
			temp = [temp stringByAppendingString:@"</p>"];
		}
		html = [html stringByAppendingString: temp];
	}
	
	if([artist getWebsite] != nil && ![[artist getWebsite] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<center><p><a href=\"%@\">View Website</a></p></center>",
				[artist getWebsite]];
		
		html = [html stringByAppendingString: temp];
	}
	
	html = [html stringByAppendingString: @"</body></html>"];
	
	return html;
}

-(NSString *)buildLocationString {
	NSString *html = [NSString stringWithFormat:@"<html>"\
					  "<head><meta name=""viewport"" content=""width=320""/>"\
					  "</head><body>"];
	NSString *temp;
	
	/* Add the fields that are there */
	if([location getImage] != nil && ![[location getImage] isEqualToString: @""]) {
		temp= [NSString stringWithFormat:@"<center><p><img src=\"%@\" "\
			   "height=\"%d\"></p></center>", [location getImage], 100];
		html = [html stringByAppendingString: temp];
	}
	
	if([location hasAddress] == YES) {
		temp = [NSString stringWithFormat:@"<p><b>Address</b><br/>%@</p>", 
				[location getAddress]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([location getDescription] != nil && ![[location getDescription] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<p><b>Description</b><br/>%@</p>", 
				[location getDescription]];
		
		html = [html stringByAppendingString: temp];
	}
	
	NSMutableArray *events = [[Content getInstance] getEventsForLocation: location];
	
	if([events count] >= 1) {
		if([events count] == 1) {
			Event *ev = (Event *)[events objectAtIndex:0];
			temp = [NSString stringWithFormat:@"<p><b>Event</b><br/>%@</p>",
					[ev getEventName]];
		}
		else {
			temp = [NSString stringWithFormat: @"<p><b>Events</b>"];
			for(id e in events) {
				Event *ev = (Event *)e;
				NSString *eventString = [NSString stringWithFormat:@"<br/>%@",
										 [ev getEventName]];
				temp = [temp stringByAppendingString:eventString];
			}
			temp = [temp stringByAppendingString:@"</p>"];
		}
		html = [html stringByAppendingString: temp];
	}
	
	
	if([location getWebsite] != nil && ![[location getWebsite] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<center><p><a href=\"%@\">View Website</a></p></center>",
				[location getWebsite]];
		
		html = [html stringByAppendingString: temp];
	}
	
	html = [html stringByAppendingString: @"</body></html>"];
	
	return html;
}

-(NSString *)buildSelfCuratedString {
	NSString *html = [NSString stringWithFormat:@"<html>"\
					  "<head><meta name=""viewport"" content=""width=320""/>"\
					  "</head><body>"];
	NSString *temp;
	
	/* Add the fields that are there */
	if([selfCurated getImage] != nil && ![[selfCurated getImage] isEqualToString: @""]) {
		temp= [NSString stringWithFormat:@"<center><p><img src=\"%@\" "\
			   "height=\"%d\"></p></center>", [selfCurated getImage], 100];
		html = [html stringByAppendingString: temp];
	}
	
	if([selfCurated getOccupation] != nil && ![[selfCurated getOccupation] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<p><b>Occupation</b><br/>%@</p>", 
				[selfCurated getOccupation]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([selfCurated getPlan] != nil && ![[selfCurated getPlan] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<p><b>Plan</b><br/>%@</p>", 
				[selfCurated getPlan]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([selfCurated getWebsite] != nil && ![[selfCurated getWebsite] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<center><p><a href=\"%@\">View Website</a></p></center>",
				[selfCurated getWebsite]];
		
		html = [html stringByAppendingString: temp];
	}
	
	html = [html stringByAppendingString: @"</body></html>"];
	
	return html;
}

-(NSString *)buildAboutUsString {
	NSString *html = [NSString stringWithFormat:@"<html>"\
					  "<head><meta name=""viewport"" content=""width=320""/>"\
					  "</head><body>"];
	Content *content = [Content getInstance];
	aboutUs = [content getAboutUs];
	NSString *temp;
	
	/* Add the fields that are there */
	if([aboutUs getImage] != nil && ![[aboutUs getImage] isEqualToString: @""]) {
		temp= [NSString stringWithFormat:@"<center><p><img src=\"%@\" "\
			   "height=\"%d\"></p></center>", [aboutUs getImage], 100];
		html = [html stringByAppendingString: temp];
	}
	
	if([aboutUs getName] != nil && ![[aboutUs getName] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<p><b>Name</b><br/>%@</p>", 
				[aboutUs getName]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([aboutUs getDescription] != nil && ![[aboutUs getDescription] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<p><b>Description</b><br/>%@</p>", 
				[aboutUs getDescription]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([aboutUs getWebsite] != nil && ![[aboutUs getWebsite] isEqualToString: @""]) {
		temp = [NSString stringWithFormat:@"<center><p><a href=\"%@\">View Website</a></p></center>",
				[aboutUs getWebsite]];
		
		html = [html stringByAppendingString: temp];
	}
	
	html = [html stringByAppendingString: @"</body></html>"];	
	return html;
}

-(void)setDetailsType:(DetailsType)type {
	detailsType = type;
}

-(BOOL)webView:(UIWebView *)descriptionTextView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (UIWebViewNavigationTypeLinkClicked == navigationType) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

-(IBAction)close: (id)sender {
	[self.parentViewController dismissModalViewControllerAnimated: YES];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[myTitleBar release];
	[myWebView release];
}


- (void)dealloc {
	[myTitleBar release];
	[myWebView release];
	[event release];
	[artist release];
	[location release];
	[selfCurated release];
	[aboutUs release];
	[pool release];
    [super dealloc];
}


@end
