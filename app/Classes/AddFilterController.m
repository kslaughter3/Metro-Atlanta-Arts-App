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
#import "Content.h"

@implementation AddFilterController
@synthesize typeLabel,
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
		[types addObject: [Filter getFilterTypeString: t]];
	}
	
	
	//Add the picker as the input device
	UIPickerView *typePickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
	typePickerView.delegate = self;
	typePickerView.dataSource = self;
	[typePickerView setShowsSelectionIndicator:YES];
	typeField.inputView = typePickerView;
	[typePickerView release];	
	
	//Add the Done button 
	UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
	keyboardDoneButtonView.barStyle = UIBarStyleBlack;
	keyboardDoneButtonView.translucent = YES;
	keyboardDoneButtonView.tintColor = nil;
	[keyboardDoneButtonView sizeToFit];
	UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done"
		style:UIBarButtonItemStyleBordered target:self
		action:@selector(pickerDoneClicked:)] autorelease];
	
	[keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
	typeField.inputAccessoryView = keyboardDoneButtonView;
	
	topField.delegate = self;
	middleField.delegate = self;
	bottomField.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	/* Hide the label/fields that are not used for this type and set the text of the 
	 displayed labels/fields */
	typeField.text = [Filter getFilterTypeString: FirstFilterType];

	//Reselect the name filter from the picker view
	UIPickerView *picker = (UIPickerView *)typeField.inputView;
	[picker selectRow: 0 inComponent: 0 animated: NO];
	
	topLabel.hidden = NO;
	topField.hidden = NO;
	middleLabel.hidden = YES;
	middleField.hidden = YES;
	bottomLabel.hidden = YES;
	bottomField.hidden = YES;
	topLabel.text = @"Name:";
	
	//Clear all the old fields
	topField.text = @"";
	middleField.text = @"";
	bottomField.text = @"";
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
	FilterType type;
	typeField.text = (NSString *)[types objectAtIndex:row];
	
	type = [Filter getFilterTypeFromString: typeField.text];
	
	/* Hide the label/fields that are not used for this type and set the text of the 
	 displayed labels/fields */
	switch(type) {
		case NameFilterType:
//			[self setInputType: topField Type: NameFilterType];
			topLabel.hidden = NO;
			topField.hidden = NO;
			middleLabel.hidden = YES;
			middleField.hidden = YES;
			bottomLabel.hidden = YES;
			bottomField.hidden = YES;
			topLabel.text = @"Name:";
			break;
		case ArtistFilterType:
//			[self setInputType: topField Type: ArtistFilterType];
			topLabel.hidden = NO;
			topField.hidden = NO;
			middleLabel.hidden = YES;
			middleField.hidden = YES;
			bottomLabel.hidden = YES;
			bottomField.hidden = YES;
			topLabel.text = @"Name:";
			break;
		case TimeFilterType:
//			[self setInputType: topField Type: TimeFilterType];
			topLabel.hidden = NO;
			topField.hidden = NO;
			middleLabel.hidden = NO;
			middleField.hidden = NO;
			bottomLabel.hidden = NO;
			bottomField.hidden = NO;
			topLabel.text = @"Date";
			middleLabel.text = @"Start Time:";
			bottomLabel.text = @"End Time:";
			
			break;
		case CostFilterType:
//			[self setInputType: topField Type: CostFilterType];
			topLabel.hidden = NO;
			topField.hidden = NO;
			middleLabel.hidden = NO;
			middleField.hidden = NO;
			bottomLabel.hidden = YES;
			bottomField.hidden = YES;
			topLabel.text = @"Min Price:";
			middleLabel.text = @"Max Price:";
			break;
		case DurationFilterType:
//			[self setInputType: topField Type: DurationFilterType];
			topLabel.hidden = NO;
			topField.hidden = NO;
			middleLabel.hidden = NO;
			middleField.hidden = NO;
			bottomLabel.hidden = YES;
			bottomField.hidden = YES;
			topLabel.text = @"Min Length (minutes):";
			middleLabel.text = @"Max Length (minutes):";
			break;
		case LocationFilterType:
//			[self setInputType: topField Type: LocationFilterType];
			topLabel.hidden = NO;
			topField.hidden = NO;
			middleLabel.hidden = NO;
			middleField.hidden = NO;
			bottomLabel.hidden = NO;
			bottomField.hidden = NO;
			topLabel.text = @"Street Address:";
			middleLabel.text = @"Zip:";
			bottomLabel.text = @"Radius (miles):";
			break;
		case AvailabilityFilterType:
//			[self setInputType: topField Type: AvailabilityFilterType];
			topLabel.hidden = NO;
			topField.hidden = NO;
			middleLabel.hidden = NO;
			middleField.hidden = NO;
			bottomLabel.hidden = NO;
			bottomField.hidden = NO;
			topLabel.text = @"Day of the Week:";
			middleLabel.text = @"Start Time:";
			bottomLabel.text = @"End Time:";
			break;
		default:
			//Should never happen
			break;
	}
	
}

/*-(void)setInputType: (UITextField *) field Type: (int) type {
	if(type == TimeFilterType) {
		field.inputView = nil;
		field.inputAccessoryView = nil;
	}
	else if(type == AvailabilityFilterType) {
		UIPickerView *typePickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
		typePickerView.delegate = self;
		typePickerView.dataSource = self;
		[typePickerView setShowsSelectionIndicator:YES];
		field.inputView = typePickerView;
		[typePickerView release];	
		
		//Add the Done button 
		UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
		keyboardDoneButtonView.barStyle = UIBarStyleBlack;
		keyboardDoneButtonView.translucent = YES;
		keyboardDoneButtonView.tintColor = nil;
		[keyboardDoneButtonView sizeToFit];
		UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done"
																		style:UIBarButtonItemStyleBordered target:self
																	   action:@selector(pickerDoneClicked:)] autorelease];
		
		[keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
		field.inputAccessoryView = keyboardDoneButtonView;
	}
	else {
		field.inputView = nil;
		field.inputAccessoryView = nil;
	}
}*/

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
	Filter *filter;
	FilterType t;
	EventDate *start;
	EventDate *end;
	double minCost;
	double maxCost;
	int minLength;
	int maxLength;
	EventLocation *loc;
	double radius;
	int startTime;
	int endTime;
	Content *content;
	
	t = [Filter getFilterTypeFromString: typeField.text];
	
	switch(t) {
		case NameFilterType:
			filter = [[Filter alloc] initNameFilter: topField.text];
			break;
		case ArtistFilterType:
			filter = [[Filter alloc] initArtistFilter: topField.text];
			break;
		case TimeFilterType:
			start = [[EventDate alloc] initEmptyDate];
			end = [[EventDate alloc] initEmptyDate];
			[start setDate: topField.text];
			[start setTime: middleField.text];
			[end setDate: topField.text];
			[end setTime: bottomField.text];
			filter = [[Filter alloc] initTimeFilterStart:start End:end];
			break;
		case CostFilterType:
			minCost = [topField.text doubleValue];
			maxCost = [middleField.text doubleValue];
			filter = [[Filter alloc] initCostFilterMin:minCost Max:maxCost];
			break;
		case DurationFilterType:
			minLength = [topField.text intValue];
			maxLength = [middleField.text intValue];
			filter = [[Filter alloc] initDurationFilterMin:minLength Max:maxLength];
			break;
		case LocationFilterType:
			loc = [[EventLocation alloc] initWithAddress:topField.text
				City: @"Atlanta" State: @"GA" Zip: middleField.text];
			radius = [bottomField.text doubleValue];
			filter = [[Filter alloc] initLocationFilter:loc Radius: radius];
			break;
		case AvailabilityFilterType:
			startTime = [EventAvailability buildTime: middleField.text];
			endTime = [EventAvailability buildTime: bottomField.text];
			filter = [[Filter alloc] initAvailabilityFilter: topField.text 
				Start: startTime End: endTime];
			break;
		default:
			//Should never happen
			break;
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
		NSLog(@"Filter Created");
		content = [Content getInstance];
		
		if([content addFilter: filter AndFilter: YES] == NO) {
			NSLog(@"Error: Add Filter Failed with a Valid Filter");
		}
		
		NSLog(@"Filter Added");

		[self.parentViewController dismissModalViewControllerAnimated: YES];
	}
}

-(IBAction)pickerDoneClicked: (id) sender {
	[typeField resignFirstResponder];
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
