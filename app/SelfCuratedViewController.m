//
//  SelfCuratedView.m
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 11/14/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "SelfCuratedViewController.h"


@implementation SelfCuratedViewController
@synthesize myWebView,
			myTitleBar;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	myWebView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	if(myEntry == nil) {
		return;
	}
	
	myTitleBar.topItem.title = [myEntry getName];
	
	NSString *html = [self buildHTMLString];
	[myWebView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://apple.com"]];
}

-(NSString *)buildHTMLString {
	NSString *html = [NSString stringWithFormat:@"<html>"\
					  "<head><meta name=""viewport"" content=""width=320""/>"\
					  "</head><body>"];
	NSString *temp;
	
	/* Add the fields that are there */
	if([myEntry getImage] != nil && [myEntry getImage] != @"") {
		temp= [NSString stringWithFormat:@"<center><p><img src=\"%@\" "\
			   "height=\"%d\"></p></center>", [myEntry getImage], 100];
		html = [html stringByAppendingString: temp];
	}
	
	if([myEntry getOccupation] != nil && [myEntry getOccupation] != @"") {
		temp = [NSString stringWithFormat:@"<p><b>Occupation</b><br/>%@</p>", 
				[myEntry getOccupation]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEntry getPlan] != nil && [myEntry getPlan] != @"") {
		temp = [NSString stringWithFormat:@"<p><b>Plan</b><br/>%@</p>", 
				[myEntry getPlan]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myEntry getWebsite] != nil && [myEntry getWebsite] != @"") {
		temp = [NSString stringWithFormat:@"<center><p><a href=\"%@\">View Website</a></p></center>",
				[myEntry getWebsite]];
		
		html = [html stringByAppendingString: temp];
	}
	
	html = [html stringByAppendingString: @"</body></html>"];
	
	return html;
}

-(void)setEntry: (SelfCuratedEntry *)entry {
	myEntry = entry;
}

-(SelfCuratedEntry *)getEntry {
	return myEntry;
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
