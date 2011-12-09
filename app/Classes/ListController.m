//
// NextView.m
// Metro-Atlanta-Arts-App
//
// Created by Drew on 9/29/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ListController.h"


@implementation ListController
@synthesize myTableView,
			myDetailsController,
			myTitleBar,
			mySelectionBar,
			previousButton,
			nextButton, 
			timer;

// The designated initializer. Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
	 pool = [[NSAutoreleasePool alloc] init];
	 [myTableView setDelegate: self];
	 [myTableView setDataSource: self];
	 listType = EventDetails;
	 [self setListTitle];
	 timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(refreshDataView) userInfo:nil repeats: YES];
	 [super viewDidLoad];
	 
 }

-(void) refreshDataView {
	Content *content = [Content getInstance];
	if([content getListReady]){
		[myTableView reloadData];
		[content setListReady:0];
	}	
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	[self setListTitle];
	[self enableNavigationButtons];
}


 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	 return YES;
 }

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	Content *content = [Content getInstance];
	switch (listType) {
		case EventDetails:
			return [content getEventCount];
			break;
		case ArtistDetails:
			return [content getArtistCount];
			break;
		case LocationDetails:
			return [content getLocationCount];
			break;
		default:
			return [content getEventCount];
			break;
	}
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		cell.textLabel.textColor = [UIColor whiteColor];
	}
	
	Content *content = [Content getInstance];
	
	switch (listType) {
		case EventDetails:
		{
			//cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
			Event *event = (Event *)[content getEventAtIndex: indexPath.row];
			cell.textLabel.text = [event getEventName];
			if([event getImageURL] != nil && [event getImageURL] != @"") {
				NSURL *url = [NSURL URLWithString: [event getImageURL]];
				NSData *data = [NSData dataWithContentsOfURL:url];
				UIImage *image = [UIImage imageWithData:data];
				cell.imageView.image = image;	
			}
			else {
				cell.imageView.image = [UIImage imageNamed: @"ipod-icon-unknown.jpg"];
			}
			break;
		}
		case ArtistDetails:
		{
			EventArtist *artist = (EventArtist *)[content getArtistAtIndex: indexPath.row];
			cell.textLabel.text = [artist getName];
			if([artist getImageURL] != nil && [artist getImageURL] != @"") {
				NSURL *url = [NSURL URLWithString: [artist getImageURL]];
				NSData *data = [NSData dataWithContentsOfURL:url];
				UIImage *image = [UIImage imageWithData:data];
				cell.imageView.image = image;				
			}
			else {
				cell.imageView.image = [UIImage imageNamed: @"ipod-icon-unknown.jpg"];
			}
			break;
		}
		case LocationDetails:
		{
			EventLocation *loc = (EventLocation *)[content getLocationAtIndex: indexPath.row];
			if([loc getName] != nil && [[loc getName] isEqualToString: @""] == NO) {
				cell.textLabel.text = [loc getName];
			}
			else {
				cell.textLabel.text = [loc getStreetAddress];
			}
			if([loc getImage] != nil && [loc getImage] != @"") {
				NSURL *url = [NSURL URLWithString: [loc getImage]];
				NSData *data = [NSData dataWithContentsOfURL:url];
				UIImage *image = [UIImage imageWithData:data];
				cell.imageView.image = image;				
			}
			else {
				cell.imageView.image = [UIImage imageNamed: @"ipod-icon-unknown.jpg"];
			}
			break;
		}
		default:
		{
			Event *event = (Event *)[content getEventAtIndex: indexPath.row];
			cell.textLabel.text = [event getEventName];
			break;
		}
	}
	
	return cell;
}

-(void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	//int idx = indexPath.row;
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	Content *content = [Content getInstance];
	
	if(myDetailsController == nil) {
		myDetailsController = [[DetailsController alloc] 
			initWithNibName: @"DetailsView" bundle: nil];
	}
	
	[myDetailsController setDetailsType: listType];
	
	switch (listType) {
		case EventDetails:
		{
			Event *event = (Event *)[content getEventAtIndex: indexPath.row];
			myDetailsController.event = event;
			[self presentModalViewController: self.myDetailsController animated:YES];
			break;
		}
		case ArtistDetails:
		{
			EventArtist *artist = (EventArtist *)[content getArtistAtIndex: indexPath.row];
			myDetailsController.artist = artist;
			[self presentModalViewController:self.myDetailsController animated:YES];
			break;
		}
		case LocationDetails:
		{
			EventLocation *loc = (EventLocation *)[content getLocationAtIndex: indexPath.row];
			myDetailsController.location = loc;
			[self presentModalViewController:self.myDetailsController animated:YES];
			break;
		}
		default:
		{
			Event *event = [content getEventAtIndex: indexPath.row];
			myDetailsController.event = event;
			[self presentModalViewController: self.myDetailsController animated:YES];
			break;
		}
	}
}

-(void)setListTitle {
	switch (listType) {
		case EventDetails:
			myTitleBar.topItem.title = @"Events";
			break;
		case ArtistDetails:
			myTitleBar.topItem.title = @"Artists";
			break;
		case LocationDetails:
			myTitleBar.topItem.title = @"Locations";
			break;
		default:
			myTitleBar.topItem.title = @"Events";
			break;
	}
}

-(void)enableNavigationButtons {
	int tablePage = [self getTablePage];
	int lastPage = [self getLastPage];
	
	if(tablePage == 1) {
		previousButton.enabled = NO;
	}
	else {
		previousButton.enabled = YES;
	}
	
	if(tablePage == lastPage) { 
		nextButton.enabled = NO;
	}
	else {
		nextButton.enabled = YES;
	}
}

-(void)changeListType:(id)sender {
	int sel = [mySelectionBar selectedSegmentIndex];
	
	switch(sel)
	{
		case 0:
			listType = EventDetails;
			break;
		case 1:
			listType = ArtistDetails;
			break;
		case 2:
			listType = LocationDetails;
			break;
		default:
			listType = EventDetails;
			break;
	}
	
	[self setListTitle];
	[self enableNavigationButtons];
	[self populateList];
}

-(IBAction)previousPage:(id)sender {
	int tablePage = [self getTablePage];
	if(tablePage > 1) {
		[self changePage: NO];
		[self enableNavigationButtons];
		[self populateList];
	}
}

-(IBAction)nextPage:(id)sender {
	int tablePage = [self getTablePage];
	int lastPage = [self getLastPage];
	if(tablePage < lastPage) {
		[self changePage: YES];
		[self enableNavigationButtons];
		[self populateList];
	}
}

-(int)getTablePage {
	Content *content = [Content getInstance];
	switch(listType) {
		case EventDetails:
			return [content getEventPage];
			break;
		case ArtistDetails:
			return [content getArtistPage];
			break;
		case LocationDetails:
			return [content getLocationPage];
			break;
		default:
			return [content getEventPage];
			break;
	}
}

-(int)getLastPage {
	Content *content = [Content getInstance];
	switch(listType) {
		case EventDetails:
			return [content getEventLastPage];
			break;
		case ArtistDetails:
			return [content getArtistLastPage];
			break;
		case LocationDetails:
			return [content getLocationLastPage];
			break;
		default:
			return [content getEventLastPage];
			break;
	}
}

-(void)changePage:(BOOL)increment {
	Content *content = [Content getInstance];
	
	switch(listType) {
		case EventDetails:
			[content changeEventPage: increment];
			break;
		case ArtistDetails:
			[content changeArtistPage: increment];
			break;
		case LocationDetails:
			[content changeLocationPage: increment];
			break;
		default:
			[content changeEventPage: increment];
			break;
	}
}

-(void)populateList {
	Content *content = [Content getInstance];
	
	switch (listType) {
		case EventDetails:
			[content populateEvents];
			break;
		case ArtistDetails:
			[content populateArtists];
			break;
		case LocationDetails:
			[content populateLocations];
			break;
		default:
			[content populateEvents];
			break;
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[myTableView release];
	[myTitleBar release];
	[mySelectionBar release];
	[previousButton release];
	[nextButton release];
}


- (void)dealloc {
	[myTableView release];
	[myDetailsController release];
	[myTitleBar release];
	[mySelectionBar release];
	[previousButton release];
	[nextButton release];
	[pool release];
	[timer release];
    [super dealloc];
}


@end