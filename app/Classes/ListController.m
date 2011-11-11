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
			myEventController,
			myArtistController,
			myLocationController,
			myTitleBar,
			mySelectionBar,
			previousButton,
			nextButton;

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
	 
	 [myTableView setDelegate: self];
	 [myTableView setDataSource: self];
	 tablePage = 1;
	 listType = EVENTLIST;
	 lastPage = 10; //TODO: Set this based on the number of pages
	 [self setListTitle];
	 
	 Content *content = [Content getInstance];
	 
//TEST EVENT	 
	 Event *event = [[Event alloc] initEmptyEvent];
	 [event setEventName: @"Test"];
	 [event setImageURL:@"http://4.bp.blogspot.com/_rtOXMZlMTkg/TKgII4-qwRI/AAAAAAAADuQ/mnQicdtiE3U/s1600/sn_MuslimStarryNight.jpg"];

	 EventLocation *loc = [[EventLocation alloc] initEmptyLocation];
//	 [loc setName: @"Atlanta Museum of Modern Art"];
	 [loc setStreetAddress:@"123456 Georgia Tech Station"];
	 [loc setCity: @"Atlanta"];
	 [loc setState:@"GA"];
	 [loc setZip:@"30332"];
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
	 [end setTime: @"5:00pm"];
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
	 [avail setStartTime: 900];
	 [avail setEndTime: 1700];
	 [event setAvailability: avail];

	 [event setDescription: @"This is a long description that should take more than "\
	  "one line and I want to see if that is a problem for the "\
	  "text view to handle also I'm inserting a newline character "\
	  "here\nto see if that works as well lets make this even longer "\
	  "so it goes beyond the size of the visible box "\
	  "so I'm just going to keep on typing until such a time that "\
	  "I feel like this is pretty long\n so the scrolling works "];
	 EventArtist *art = [[EventArtist alloc] initEmptyArtist];
	 [art setName: @"Van Goh"];
	 [event setArtist: art];
	 [event setCost: 10.0];
	 [event setDuration: 20];
	 [event setWebsite: @"http://www.apple.com"];
	 
	 //Event *event= [[Event alloc] initTestEvent: @"test" Description: @"1 2 3 4"];
	 [content addEvent: event];
	 
//TEST ARTIST
	 EventArtist *temp = [[EventArtist alloc] initWithArtistName: @"jun"
													 Description: @"This is a long description that should take more than "\
						  "one line and I want to see if that is a problem for the "\
						  "text view to handle also I'm inserting a newline character "\
						  "here\nto see if that works as well lets make this even longer "\
						  "so it goes beyond the size of the visible box "\
						  "so I'm just going to keep on typing until such a time that "\
						  "I feel like this is pretty long\n so the scrolling works" 
						   ImageURL: @"http://gra217b.files.wordpress.com/2011/09/apple-mac-logo.jpg"];
	 [temp setWebsite: @"http://www.apple.com"];
	 [content addArtist: temp];
	 
//TEST LOCATION
	 EventLocation *testLoc = [[EventLocation alloc] initEmptyLocation];
	 [testLoc setName: @"Atlanta High Muesem"];
	 [testLoc setStreetAddress: @"1290 Peachtree Street NE"];
	 [testLoc setCity: @"Atlanta"];
	 [testLoc setState: @"GA"];
	 [testLoc setZip: @"30309"];
	 [testLoc setDescription: @"The High Museum of Art is the leading art museum in the southeastern United States. "\
	  "Located in Midtown Atlanta’s arts and business district, the High has more than 12,000 works of art "\
	  "in its permanent collection. The Museum has an extensive anthology of 19th- and 20th-century American art; "\
	  "significant holdings of European paintings and decorative art; a growing collection of African American art; "\
	  "and burgeoning collections of modern and contemporary art, photography and African art. "\
	  "The High is also dedicated to supporting and collecting works by Southern artists and is distinguished "\
	  "as the only major museum in North America to have a curatorial department specifically devoted "\
	  "to the field of folk and self-taught art."];
	 [testLoc setImage: @"http://hugomartinezart.com/wp-content/uploads/2011/02/high-museum-of-art-2265.jpg"];
	 [testLoc setWebsite: @"http://www.high.org/"];
	 
	 [content addLocation: testLoc];
	 [super viewDidLoad];
 }

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	
	[self setListTitle];
	[self enabledNavigationButtons];
	
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
		case EVENTLIST:
			return [content getEventCount];
			break;
		case ARTISTLIST:
			return [content getArtistCount];
			break;
		case LOCATIONLIST:
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
	}
	
	Content *content = [Content getInstance];
	
	switch (listType) {
		case EVENTLIST:
		{
			Event *event = (Event *)[content getEventAtIndex: indexPath.row];
			cell.textLabel.text = [event getEventName];
			break;
		}
		case ARTISTLIST:
		{
			EventArtist *artist = (EventArtist *)[content getArtistAtIndex: indexPath.row];
			cell.textLabel.text = [artist getName];
			break;
		}
		case LOCATIONLIST:
		{
			EventLocation *loc = (EventLocation *)[content getLocationAtIndex: indexPath.row];
			if([loc getName] != nil && [[loc getName] isEqualToString: @""] == NO) {
				cell.textLabel.text = [loc getName];
			}
			else {
				cell.textLabel.text = [loc getStreetAddress];
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
	
	switch (listType) {
		case EVENTLIST:
		{
			Event *event = (Event *)[content getEventAtIndex: indexPath.row];
			if(myEventController == nil) {
				self.myEventController = [[EventController alloc] initWithNibName: @"EventView" bundle: nil];
			}
			[myEventController setEvent: event];
			[self presentModalViewController: self.myEventController animated:YES];
			break;
		}
		case ARTISTLIST:
		{
			EventArtist *artist = (EventArtist *)[content getArtistAtIndex: indexPath.row];
			if(myArtistController == nil) {
				self.myArtistController = [[ArtistController alloc] initWithNibName: @"ArtistView" bundle:nil];
			}
			[myArtistController setArtist: artist];
			[self presentModalViewController:self.myArtistController animated:YES];
			break;
		}
		case LOCATIONLIST:
		{
			EventLocation *loc = (EventLocation *)[content getLocationAtIndex: indexPath.row];
			if(myLocationController == nil) {
				self.myLocationController = [[LocationController alloc] initWithNibName: @"LocationView" bundle:nil];
			}
			[myLocationController setLocation: loc];
			[self presentModalViewController:self.myLocationController animated:YES];
			break;
		}
		default:
		{
			Event *event = [content getEventAtIndex: indexPath.row];
			if(myEventController == nil) {
				self.myEventController = [[EventController alloc] initWithNibName: @"EventView" bundle: nil];
			}
			[myEventController setEvent: event];
			[self presentModalViewController: self.myEventController animated:YES];
			break;
		}
	}
}

-(void)setListTitle {
	switch (listType) {
		case EVENTLIST:
			myTitleBar.topItem.title = @"Events";
			break;
		case ARTISTLIST:
			myTitleBar.topItem.title = @"Artists";
			break;
		case LOCATIONLIST:
			myTitleBar.topItem.title = @"Locations";
			break;
		default:
			myTitleBar.topItem.title = @"Events";
			break;
	}
}

-(void)enabledNavigationButtons {
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
	listType = [mySelectionBar selectedSegmentIndex];
	[self setListTitle];
	tablePage = 1;
	[self enabledNavigationButtons];
	[myTableView reloadData];
}

-(IBAction)previousPage:(id)sender {
	if(tablePage > 1) {
		tablePage--;
		[self enabledNavigationButtons];
		//TODO: Get page from server 
		//[myTableView reloadData];
	}
}

-(IBAction)nextPage:(id)sender {
	if(tablePage < lastPage) {
		tablePage++;
		[self enabledNavigationButtons];
		//TODO: Get page from server 
		//[myTableView reloadData];
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[myTableView release];
	[myEventController release];
    [super dealloc];
}


@end