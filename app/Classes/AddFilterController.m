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
@synthesize typePickerView,
			typeLabel,
			typeField,
			topLabel,
			topField,
			middleLabel,
			middleField,
			bottomLabel, 
			bottomField,
			types;

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
	
	types = [[NSMutableArray alloc] init];
	
	for(t = FirstFilterType; t <= LastFilterType; t++) {
		if(t == FirstFilterType) {
			typeField.text = [Filter getFilterTypeString: t];
		}
		[types addObject: [Filter getFilterTypeString: t]];
	}
	
	
	//Add the picker as the input device
	typePickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
	typePickerView.delegate = self;
	typePickerView.dataSource = self;
	[typePickerView setShowsSelectionIndicator:YES];
	typeField.inputView = typePickerView;
	[typePickerView release];	
	
	//Add the Done button 
	UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
	keyboardDoneButtonView.barStyle = UIBarStyleBlack;
	keyboardDoneButtonView.translucent = YES;
	keyboardDoneButtonView.tintColor = nil;
	[keyboardDoneButtonView sizeToFit];
	UIBarButtonItem* doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done"
		style:UIBarButtonItemStyleBordered target:self
		action:@selector(pickerDoneClicked:)] autorelease];
	
	[keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
	typeField.inputAccessoryView = keyboardDoneButtonView;
	
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
	typeField.text = (NSString *)[types objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:
(NSInteger)component
{
	return [types count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:
(NSInteger)component
{
	return [types objectAtIndex: row];
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

-(IBAction)pickerDoneClicked: (id) sender {
	[typeField resignFirstResponder];
	//TODO: Set other fields based on the value in typeField
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
