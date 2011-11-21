//
//  SelfCuratedListController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "SelfCuratedListController.h"


@implementation SelfCuratedListController

@synthesize myTableView,
			mySelfCuratedViewController,
			previousButton,
			nextButton;

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
	SelfCuratedEntry *temp = [[SelfCuratedEntry alloc] initEmptySelfCuratedEntry];
	[temp setName: @"jun3"];
	[temp setImage: @"http://4.bp.blogspot.com/_rtOXMZlMTkg/TKgII4-qwRI/AAAAAAAADuQ/mnQicdtiE3U/s1600/sn_MuslimStarryNight.jpg"];
	[temp setOccupation: @"Editor of the Atlanta Journal of the Arts"];
	[temp setPlan: @"Visit these events: Test, Jun2, 22, 233, dashjklf"];
	[temp setWebsite: @"http://www.apple.com"];
	[content addSelfCuratedEntry: temp];
	
	[super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	[self enableNavigationButtons];
	[myTableView reloadData];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
	Content *content = [Content getInstance];
	return [content getSelfCuratedEntryCount];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		cell.textLabel.textColor = [UIColor whiteColor]; 
	}
	
	Content *content = [Content getInstance];
	SelfCuratedEntry *selfCuratedEntry = (SelfCuratedEntry *)[content getSelfCuratedEntryAtIndex: indexPath.row];
	cell.textLabel.text = [selfCuratedEntry getName];
	if([selfCuratedEntry getImage] != nil && [selfCuratedEntry getImage] != @"") {
		NSURL *url = [NSURL URLWithString: [selfCuratedEntry getImage]];
		NSData *data = [NSData dataWithContentsOfURL:url];
		UIImage *image = [UIImage imageWithData:data];
		cell.imageView.image = image;				
	}
	else {
		cell.imageView.image = [UIImage imageNamed: @"ipod-icon-unknown.jpg"];
	}
	
	return cell;
}

-(void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	Content *content = [Content getInstance];
	SelfCuratedEntry *entry = (SelfCuratedEntry *)[content getSelfCuratedEntryAtIndex: indexPath.row];
	if(mySelfCuratedViewController == nil) {
		self.mySelfCuratedViewController = [[DetailsController alloc] initWithNibName: @"DetailsView" bundle: nil];
	}
	
	[mySelfCuratedViewController setDetailsType: SelfCuratedDetails];
	
	mySelfCuratedViewController.selfCurated = entry;
	[self presentModalViewController: self.mySelfCuratedViewController animated:YES];
	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

-(IBAction)previousPage:(id)sender {
	Content *content = [Content getInstance];
	int myPage = [content getSelfCuratedPage];
	
	if(myPage > 1) {
		[content changeSelfCuratedPage: NO];
		[self enableNavigationButtons];
		//TODO: Get page from server
	}
}

-(IBAction)nextPage:(id)sender {
	Content *content = [Content getInstance];
	int myPage = [content getSelfCuratedPage];
	int lastPage = [content getSelfCuratedLastPage];
	
	if(myPage < lastPage) {
		[content changeSelfCuratedPage: YES];
		[self enableNavigationButtons];
		//TODO: Get page from server 
	}
}

-(void)enableNavigationButtons {
	Content *content = [Content getInstance];
	int myPage = [content getSelfCuratedPage];
	int lastPage = [content getSelfCuratedLastPage];
	if(myPage == 1) {
		previousButton.enabled = NO;
	}
	else {
		previousButton.enabled = YES;
	}
	
	if(myPage == lastPage) { 
		nextButton.enabled = NO;
	}
	else {
		nextButton.enabled = YES;
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [myTableView release];
	[previousButton release];
	[nextButton release];
}


- (void)dealloc {
	[myTableView release];
	[mySelfCuratedViewController release];
	[previousButton release];
	[nextButton release];
    [super dealloc];
}


@end
