//
//  ArtistListController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtistListController.h"
#import "Content.h"

@implementation ArtistListController
@synthesize myTableView, 
myArtistController;
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
	
	[myTableView setDelegate: self];
	[myTableView setDataSource: self];

	Content *content = [Content getInstance];
	EventArtist *temp = [[EventArtist alloc] initWithArtistName: @"jun"
													Description: @"This is a long description that should take more than "\
						 "one line and I want to see if that is a problem for the "\ 
						 "text view to handle also I'm inserting a newline character "\
						 "here\nto see if that works as well lets make this even longer"\
						 "so it goes beyond the size of the visible box"\ 
						 "so I'm just going to keep on typing until such a time that"\
						 "I feel like this is pretty long\n so the scrolling works" 
						 ImageURL: @"http://gra217b.files.wordpress.com/2011/09/apple-mac-logo.jpg"];
	[content addArtist: temp];
	
    [super viewDidLoad];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	Content *content = [Content getInstance];
	return [content getArtistCount];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	Content *content = [Content getInstance];
	EventArtist *ea = (EventArtist *)[content getArtistAtIndex: indexPath.row];
	cell.textLabel.text = [ea getName];
	
	return cell;
}

-(void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	//int idx = indexPath.row;
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if(myArtistController == nil) {
		self.myArtistController = [[ArtistController alloc] initWithNibName: @"ArtistView" bundle: nil];
	}
	Content *content = [Content getInstance];
	[myArtistController setArtist: [content getArtistAtIndex: indexPath.row]];
	[self presentModalViewController: self.myArtistController animated:YES];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
