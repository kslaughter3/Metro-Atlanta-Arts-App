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
	 Content *content = [Content getInstance];
	 
//TEST EVENT	 
	 Event *event = [[Event alloc] initEmptyEvent];
	 [event setEventID: 1];
	 [event setEventName: @"Test"];
	 [event setImageURL:@"http://4.bp.blogspot.com/_rtOXMZlMTkg/TKgII4-qwRI/AAAAAAAADuQ/mnQicdtiE3U/s1600/sn_MuslimStarryNight.jpg"];

	 EventLocation *loc = [[EventLocation alloc] initEmptyLocation];
	 [loc setLocationID: 1];
	 [loc setName: @"Atlanta High Muesem"];
	 [loc setStreetAddress: @"1290 Peachtree Street NE"];
	 [loc setCity: @"Atlanta"];
	 [loc setState: @"GA"];
	 [loc setZip: @"30309"];
	 [loc setDescription: @"The High Museum of Art is the leading art museum in the southeastern United States. "\
	  "Located in Midtown Atlanta’s arts and business district, the High has more than 12,000 works of art "\
	  "in its permanent collection. The Museum has an extensive anthology of 19th- and 20th-century American art; "\
	  "significant holdings of European paintings and decorative art; a growing collection of African American art; "\
	  "and burgeoning collections of modern and contemporary art, photography and African art. "\
	  "The High is also dedicated to supporting and collecting works by Southern artists and is distinguished "\
	  "as the only major museum in North America to have a curatorial department specifically devoted "\
	  "to the field of folk and self-taught art."];
	 [loc setImage: @"http://hugomartinezart.com/wp-content/uploads/2011/02/high-museum-of-art-2265.jpg"];
	 [loc setWebsite: @"http://www.high.org/"];
	 CLLocationCoordinate2D coord;
	 coord.latitude = 33.7728837;
	 coord.longitude = -84.393816;
	 [loc setCoordinates: coord];
	 [event setLocation: loc];
	 
/*	 EventDate *start = [[EventDate alloc] initEmptyDate];
	 [start setDate: @"11/04/2011"];
	 [start setTime: @"9:00am"];
	 EventDate *end = [[EventDate alloc] initEmptyDate];
	 [end setDate: @"11/11/2011"];
	 [end setTime: @"9:00am"];
	 [event setStartDate: start];
	 [event setEndDate: end];
*/
	 
	 EventAvailability *avail = [[EventAvailability alloc] initEmptyAvailability];
	 [avail addDay: @"Sunday"];
	 //[avail addDay: @"Monday"];
	 [avail addDay: @"Tuesday"];
	 [avail addDay: @"WEDNeSDAy"];
	 [avail addDay: @"Thursday"];
	 //[avail addDay: @"Friday"];
	 [avail addDay: @"Saturday"];
	 [avail setAvailableAllDay];
	 [event setAvailability: avail];

	 [event setDescription: @"This is a long description that should take more than "\
	  "one line and I want to see if that is a problem for the "\
	  "text view to handle also I'm inserting a newline character "\
	  "here\nto see if that works as well lets make this even longer "\
	  "so it goes beyond the size of the visible box "\
	  "so I'm just going to keep on typing until such a time that "\
	  "I feel like this is pretty long\n so the scrolling works "];
	 [event setMinCost: 10.0];
	 [event setDuration: 20];
	 [event setWebsite: @"http://www.apple.com"];
	 [content addEvent: event];
	 
//TEST ARTIST
	 EventArtist *temp = [[EventArtist alloc] initEmptyArtist];
	 [temp setName: @"jun"];
	 [temp setDescription:@"This is a long description that should take more than "\
	  "one line and I want to see if that is a problem for the "\
	  "text view to handle also I'm inserting a newline character "\
	  "here\nto see if that works as well lets make this even longer "\
	  "so it goes beyond the size of the visible box "\
	  "so I'm just going to keep on typing until such a time that "\
	  "I feel like this is pretty long\n so the scrolling works"];
	 [temp setImageURL:@"http://gra217b.files.wordpress.com/2011/09/apple-mac-logo.jpg"];
	 [temp setWebsite:@"http://www.apple.com"];
	 [content addArtist: temp];
	 [event addArtist: temp];
	 
//TEST LOCATION

	 [content addLocation: loc];
	 timer = [NSTimer scheduledTimerWithTimeInterval: 2.0 target:self selector:@selector(refreshDataView) userInfo:nil repeats: YES];
	 [super viewDidLoad];
 }

-(void) refreshDataView {
	[myTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	
	[self setListTitle];
	[self enableNavigationButtons];
	[self populateList];
	[myTableView reloadData];
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
	[myTableView reloadData];
}

-(IBAction)previousPage:(id)sender {
	int tablePage = [self getTablePage];
	if(tablePage > 1) {
		[self changePage: NO];
		[self enableNavigationButtons];
		[self populateList];
		[myTableView reloadData];
	}
}

-(IBAction)nextPage:(id)sender {
	int tablePage = [self getTablePage];
	int lastPage = [self getLastPage];
	if(tablePage < lastPage) {
		[self changePage: YES];
		[self enableNavigationButtons];
		[self populateList];
		[myTableView reloadData];
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
    [super dealloc];
}


@end