//
//  ArtistController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/10/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "ArtistController.h"


@implementation ArtistController
@synthesize myTitleBar, myWebView;

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	if(artist == nil)
	{
		return;
	}
	myTitleBar.topItem.title = [artist getName];
	
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
	if([artist getImageURL] != nil && [artist getImageURL] != @"") {
		temp= [NSString stringWithFormat:@"<center><p><img src=\"%@\" "\
			   "height=\"%d\"></p></center>", [artist getImageURL], 100];
		html = [html stringByAppendingString: temp];
	}
	
	if([artist getDescription] != nil && [artist getDescription] != @"") {
		temp = [NSString stringWithFormat:@"<p><b>Description</b><br/>%@</p>", 
				[artist getDescription]];
		
		html = [html stringByAppendingString: temp];
	}
	
	NSMutableArray *events = [[Content getInstance] getEventsForArtist: artist];
	
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
	
	if([artist getWebsite] != nil && [artist getWebsite] != @"") {
		temp = [NSString stringWithFormat:@"<center><p><a href=\"%@\">View Website</a></p></center>",
				[artist getWebsite]];
		
		html = [html stringByAppendingString: temp];
	}
	
	html = [html stringByAppendingString: @"</body></html>"];
	
	return html;
}

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
	[artist release];
	[myTitleBar release];
	[myWebView release];
    [super dealloc];
}

-(void)setArtist: (EventArtist *) a {
	artist = a;
}

-(EventArtist *)getArtist {
	return artist;
}

@end
