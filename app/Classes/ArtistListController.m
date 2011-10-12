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
			myArtistController, 
			listData;

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
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero 
		style: UITableViewStylePlain];
	
	[tableView setDelegate: self];
	[tableView setDataSource: self];
	myTableView = tableView;
	[tableView release];
	
	NSArray *list = [[NSArray alloc] initWithObjects: @"Artist" , @"List", nil];
	self.listData = list;
	[list release];
	
    [super viewDidLoad];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//Content *content = [Content getInstance];
	//return [content getFilterCount];
	if([self.listData count] > 0) {
		return [self.listData count];
	}
	return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	//Content *content = [Content getInstance];
	//Filter *f = (Filter *)[[content getFilters] objectAtIndex:indexPath.row];
	
	NSUInteger row = [indexPath row];
	cell.textLabel.text = [listData objectAtIndex: row];
	
	//cell.textLabel.text = [f getTypeName];
	//TODO: set the detailed text based on the filterer's values 
	//cell.textLabel.text = @"Hello World";
	
	return cell;
}

-(void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	//int idx = indexPath.row;
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	/*Content *content = [Content getInstance];
	if(content == nil) {
		//Something bad happened handle it 
		return;
	}*/
	
	if(myArtistController == nil) {
		self.myArtistController = [[ArtistController alloc] initWithNibName: @"ArtistView" bundle: nil];
	}
	
	myArtistController.myTitleBar.topItem.title = @"Hello World";
	
	//[myArtistController setArtist: [[content getArtists] objectAtIndex: idx]];
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
