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


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)search: (id) sender {
	Filter *filter = [[Filter alloc] initSearchFilter: mySearchField.text];
	Content *content;
	
	if(filter == nil) {
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Invalid Search" 
							  message: @"The query's values are not valid" 
							  delegate: nil 
							  cancelButtonTitle: @"OK" 
							  otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
	else {
		NSLog(@"Filter Created");
		content = [Content getInstance];
		
		if([content addFilter: filter AndFilter: YES] == NO) {
			NSLog(@"Error: Add Filter Failed with a Valid Filter");
		}
		
		NSLog(@"Filter Added");
		
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Search Added" 
							  message: @"The Search query has been added" 
							  delegate: nil 
							  cancelButtonTitle: @"OK" 
							  otherButtonTitles: nil];
		[alert show];
		[alert release];
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
}

-(IBAction)advancedSearch: (id) sender {
	NSLog(@"Advanced Search Clicked\n");
	
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
