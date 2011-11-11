//
//  AboutUsController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "AboutUsController.h"


@implementation AboutUsController
@synthesize myWebView;
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

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	
	NSString *html = [self buildHTMLString];
	[myWebView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.apple.com"]];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

-(NSString *)buildHTMLString {
	NSString *html = [NSString stringWithFormat:@"<html>"\
					  "<head><meta name=""viewport"" content=""width=320""/>"\
					  "</head><body>"];
	Content *content = [Content getInstance];
	AboutUs *myAboutUs = [content getAboutUs];
	NSString *temp;
	
	/* Add the fields that are there */
	if([myAboutUs getImage] != nil && [myAboutUs getImage] != @"") {
		temp= [NSString stringWithFormat:@"<center><p><img src=\"%@\" "\
			   "height=\"%d\"></p></center>", [myAboutUs getImage], 100];
		html = [html stringByAppendingString: temp];
	}
	
	if([myAboutUs getName] != nil && [myAboutUs getName] != @"") {
		temp = [NSString stringWithFormat:@"<p><b>Name</b><br/>%@</p>", 
				[myAboutUs getName]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myAboutUs getDescription] != nil && [myAboutUs getDescription] != @"") {
		temp = [NSString stringWithFormat:@"<p><b>Description</b><br/>%@</p>", 
				[myAboutUs getDescription]];
		
		html = [html stringByAppendingString: temp];
	}
	
	if([myAboutUs getWebsite] != nil && [myAboutUs getWebsite] != @"") {
		temp = [NSString stringWithFormat:@"<center><p><a href=\"%@\">View Website</a></p></center>",
				[myAboutUs getWebsite]];
		
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
