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
	[myWebView loadHTMLString:html baseURL:[NSURL URLWithString: @"http:://www.apple.com"]];
}

-(NSString *)buildHTMLString 
{
	if([artist hasImage] == YES)
	{
		return [NSString stringWithFormat:@"<html><head><meta name=""viewport"" content=""width=320""/></head>"\
					  "<body>"\
					  "<center><p><img src=\"%@\" height=\"%d\"></p></center>"\
					  "<h3>Description</h3><p>%@</p>"\
					  "</body></html>", [[artist getImageURL]absoluteString], 100,
				  [artist getDescription]];
	}
	
	return [NSString stringWithFormat:@"<html><head><meta name=""viewport"" content=""width=320""/></head>"\
			  "<body><h3>Description</h3><p>%@</p></body></html>", [artist getDescription]];
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

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

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

-(void)setArtist: (EventArtist *) a {
	artist = a;
}

-(EventArtist *)getArtist {
	return artist;
}

@end
