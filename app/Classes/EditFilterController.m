//
//  AddFilterController.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/10/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "EditFilterController.h"
#import "FilterListController.h"
#import "Content.h"

@implementation EditFilterController
@synthesize typeLabel,
			typeField,
			topLabel,
			topField,
			middleLabel,
			middleField,
			bottomLabel, 
			bottomField,
			types,
			myFilter;

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

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	if(myFilter == nil) {
		NSLog(@"Error Filter Not Set");
		return;
	}
	
	FilterType type = [myFilter getFilterType];
	typeField.text = [Filter getFilterTypeString:type];
	[self setUpFields: type];
	[self setValues];
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
	[self setUpFields: type];
	
}

-(void) setUpFields: (FilterType) type {
	switch(type) {
		case NameFilterType:
			topLabel.hidden = NO;
			topField.hidden = NO;
			middleLabel.hidden = YES;
			middleField.hidden = YES;
			bottomLabel.hidden = YES;
			bottomField.hidden = YES;
			topLabel.text = @"Name:";
			break;
		case ArtistFilterType:
			topLabel.hidden = NO;
			topField.hidden = NO;
			middleLabel.hidden = YES;
			middleField.hidden = YES;
			bottomLabel.hidden = YES;
			bottomField.hidden = YES;
			topLabel.text = @"Name:";
			break;
		case TimeFilterType:
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
			topLabel.hidden = NO;
			topField.hidden = NO;
			middleLabel.hidden = NO;
			middleField.hidden = NO;
			bottomLabel.hidden = YES;
			bottomField.hidden = YES;
			topLabel.text = @"Day of the Week:";
			middleLabel.text = @"Time:";
			break;
		default:
			//Should never happen
			break;
	}
}

-(void)setValues {
	double minC, maxC, rad;
	int minD, maxD, time;
	NSDate *start, *end;	EventLocation *loc;
	FilterType type = [myFilter getFilterType];
	switch(type) {
		case NameFilterType:
			topField.text = [myFilter getFiltererName];
			break;
		case ArtistFilterType:
			topField.text = [myFilter getFiltererArtist];
			break;
		case TimeFilterType:
			start = [myFilter getFiltererStartTime];
			end = [myFilter getFiltererEndTime];
			
			break;
		case CostFilterType:
			minC = [myFilter getFiltererMinCost];
			maxC = [myFilter getFiltererMaxCost];
			topField.text = [NSString stringWithFormat: @"%f", minC];
			middleField.text = [NSString stringWithFormat: @"%f", maxC];
			break;
		case DurationFilterType:
			minD = [myFilter getFiltererMinDuration];
			maxD = [myFilter getFiltererMaxDuration];
			topField.text = [NSString stringWithFormat:@"%i", minD];
			middleField.text = [NSString stringWithFormat: @"%i", maxD];
			break;
		case LocationFilterType:
			loc = [myFilter getFiltererLocation];
			rad = [myFilter getFiltererRadius];
			topField.text = [loc getStreetAddress];
			middleField.text = [loc getZip];
			bottomField.text = [NSString stringWithFormat:@"%f", rad];
			break;
		case AvailabilityFilterType:
			time = [myFilter getFiltererAvailabilityTime];
			topField.text = [myFilter getFiltererAvailabilityDay];
			middleField.text = [NSString stringWithFormat:@"%i", time];
			break;
		default:
			//Should never happen
			break;
	}
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

-(IBAction)save: (id)sender {
	NSLog(@"OK Clicked\n");
	Filter *filter;
	FilterType t;
	NSDate *start;
	NSDate *end;
	double minCost;
	double maxCost;
	int minLength;
	int maxLength;
	EventLocation *loc;
	double radius;
	int time;
	Content *content;
	
	t = [Filter getFilterTypeFromString: typeField.text];
	
	switch(t) {
		case NameFilterType:
			filter = [[Filter alloc] initializeNameFilter: topField.text];
			break;
		case ArtistFilterType:
			filter = [[Filter alloc] initializeArtistFilter: topField.text];
			break;
		case TimeFilterType:
			start = [self buildDate: topField.text Time: middleField.text];
			end = [self buildDate: topField.text Time: bottomField.text];
			filter = [[Filter alloc] initializeTimeFilterStart:start End:end];
			break;
		case CostFilterType:
			minCost = [topField.text doubleValue];
			maxCost = [middleField.text doubleValue];
			filter = [[Filter alloc] initializeCostFilterMin:minCost Max:maxCost];
			break;
		case DurationFilterType:
			minLength = [topField.text intValue];
			maxLength = [middleField.text intValue];
			filter = [[Filter alloc] initializeDurationFilterMin:minLength Max:maxLength];
			break;
		case LocationFilterType:
			loc = [loc initializeWithAddress:topField.text
										City: @"Atlanta" State: @"GA" Zip: middleField.text];
			radius = [bottomField.text doubleValue];
			filter = [[Filter alloc] initializeLocationFilter:loc Radius: radius];
			break;
		case AvailabilityFilterType:
			time = [self buildTime: middleField.text];
			filter = [[Filter alloc] initializeAvailabilityFilter: topField.text Time: time];
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
		content = [Content getInstance];
		
	/*	if([content addFilter: filter AndFilter: YES] == NO) {
			NSLog(@"Error: Add Filter Failed with a Valid Filter");
		}
	*/	
		[self.parentViewController dismissModalViewControllerAnimated: YES];
	}
}

-(IBAction)remove: (id) sender {
	NSLog(@"Delete Clicked");
	
	//TODO: delete the filter
}

-(IBAction)pickerDoneClicked: (id) sender {
	[typeField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

-(NSDate *)buildDate: (NSString *) date Time: (NSString *)time {
	return nil;
}

-(int)buildTime:(NSString *)time {
	return -1;
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
