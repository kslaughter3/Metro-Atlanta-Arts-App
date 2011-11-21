//
//  SearchController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/26/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "SearchController.h"


@implementation SearchController
@synthesize mySearchField,
			myFilterListController;

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
    [super viewDidLoad];
	
	mySearchField.delegate = self;
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	
	mySearchField.text = @"";
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


-(IBAction)search: (id) sender {
	Content *content;
	Filter *filter;
	if([mySearchField.text isEqualToString: @""]) {
		filter = nil;
	}
	else {
		//filter = nil;
		filter = [[Filter alloc] initSearchFilter: mySearchField.text];
	}
	
	if(filter == nil) {
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Invalid Filter" 
							  message: @"The filter's values are not valid" 
							  delegate: nil 
							  cancelButtonTitle: @"OK" 
							  otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
	else {
		content = [Content getInstance];
		
		if([content addFilter: filter] == NO) {
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"Filter Not Added" 
								  message: @"An identical filter already exists filter not added" 
								  delegate: nil 
								  cancelButtonTitle: @"OK" 
								  otherButtonTitles: nil];
			[alert show];
			[alert release];
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"Search Added" 
								  message: @"The search was added" 
								  delegate: nil 
								  cancelButtonTitle: @"OK" 
								  otherButtonTitles: nil];
			[alert show];
			[alert release];
		}
	}
}

-(IBAction)clearAll: (id) sender {
	Content *content;
	NSMutableArray *filters;
	
	content = [Content getInstance];
	
	filters = [content getFilters];
	
	for(id filter in filters) {
		[filter setEnabled: NO];
	}
	
	UIAlertView *alert = [[UIAlertView alloc] 
						  initWithTitle:@"Cleared all Filters" 
						  message: @"All the filters have been disabled" 
						  delegate: nil 
						  cancelButtonTitle: @"OK" 
						  otherButtonTitles: nil];
	[alert show];
	[alert release];
	
	mySearchField.text = @"";
}

-(IBAction)advancedSearch: (id) sender {
	if(self.myFilterListController == nil) {
		FilterListController *new_view = [[FilterListController alloc] 
										 initWithNibName: @"FilterListView" bundle: nil];
		self.myFilterListController = new_view;
		[new_view release];
	}
	
	[self presentModalViewController: self.myFilterListController animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[mySearchField release];
}


- (void)dealloc {
	[mySearchField release];
	[myFilterListController release];
    [super dealloc];
}


@end
