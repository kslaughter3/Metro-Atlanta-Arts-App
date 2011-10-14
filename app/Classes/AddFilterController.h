//
//  AddFilterController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/10/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddFilterController;

@interface AddFilterController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	IBOutlet UIPickerView *myPickerView;
	NSMutableArray *pickerData;
}

@property (nonatomic, retain) IBOutlet UIPickerView *myPickerView; 
@property (nonatomic, retain) NSMutableArray *pickerData;

-(IBAction)cancel:(id)sender;
-(IBAction)ok:(id)sender;

@end
