//
//  AddFilterController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/10/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AddFilterController;

@interface AddFilterController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, 
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

-(IBAction)cancel:(id)sender;
-(IBAction)ok:(id)sender;
-(IBAction)pickerDoneClicked:(id)sender;

-(NSDate *)buildDate: (NSString *)date Time: (NSString *)time;
-(int)buildTime: (NSString *)time;

//-(void)setInputType: (UITextField *) field Type: (int) type;

@end
