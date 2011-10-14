//
//  AddFilterController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/10/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "AddFilterController.h"
#import "FilterListController.h"
#import "Filter.h"

@implementation AddFilterController
@synthesize myPickerView, 
			pickerData;

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
    FilterType t;
	
	[super viewDidLoad];
	
	pickerData = [[NSMutableArray alloc] init];
	
	for(t = FirstFilterType; t <= LastFilterType; t++) {
		[pickerData addObject: [Filter getFilterTypeString: t]];
	}
	
	[myPickerView selectRow:0 inComponent:0 animated:NO];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row 
inComponent:(NSInteger)component 
{
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:
(NSInteger)component
{
	return [pickerData count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:
(NSInteger)component
{
	return [pickerData objectAtIndex: row];
}


-(IBAction)cancel: (id)sender {
	NSLog(@"Cancel Clicked\n");
	[self.parentViewController dismissModalViewControllerAnimated: YES];
}

-(IBAction)ok: (id)sender {
	NSLog(@"OK Clicked\n");
	
	/* TODO: Check the filter fields make sure they are valid if not display toast
	   and don't remove the view */
	
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
