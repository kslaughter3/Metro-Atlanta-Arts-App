//
//  EditFilterController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/12/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/*******************************************************
 * Edit Filter Controller
 * 
 * Handles the Editing of an existing filter
 * Allows the user to edit the type or values of the given 
 * filter
 * Also allows the user to remove the given filter 
 *
 *******************************************************/

#import <UIKit/UIKit.h>
#import "Filter.h"
#import "EventLocation.h"
#import "EventAvailability.h"

@class EditFilterController;

@interface EditFilterController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, 
UITextFieldDelegate> {
	IBOutlet UILabel *typeLabel;
	IBOutlet UITextField *typeField;
	IBOutlet UILabel *topLabel;
	IBOutlet UITextField *topField;
	IBOutlet UILabel *middleLabel;
	IBOutlet UITextField *middleField;
	IBOutlet UILabel *bottomLabel;
	IBOutlet UITextField *bottomField;
	NSMutableArray *types;
	Filter *myFilter;
	NSAutoreleasePool *pool;
}

@property (nonatomic, retain) IBOutlet UILabel *typeLabel;
@property (nonatomic, retain) IBOutlet UITextField *typeField;
@property (nonatomic, retain) IBOutlet UILabel *topLabel;
@property (nonatomic, retain) IBOutlet UITextField *topField;
@property (nonatomic, retain) IBOutlet UILabel *middleLabel;
@property (nonatomic, retain) IBOutlet UITextField *middleField;
@property (nonatomic, retain) IBOutlet UILabel *bottomLabel;
@property (nonatomic, retain) IBOutlet UITextField *bottomField;
@property (nonatomic, retain) NSMutableArray *types;
@property (nonatomic, retain) Filter *myFilter;

-(void)setUpFields: (FilterType) type;
-(void)setValues;

-(IBAction)cancel:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)remove:(id)sender;
-(IBAction)pickerDoneClicked:(id)sender;

@end
