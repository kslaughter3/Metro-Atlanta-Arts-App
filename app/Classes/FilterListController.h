//
//  filterController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"AddFilterController.h"
#import "EditFilterController.h"
#import "RemoveFilterController.h"

@class FilterListController;

@interface FilterListController : UIViewController <UITableViewDelegate> {
	IBOutlet UITableView *myFilterTableView;
	IBOutlet AddFilterController *myAddFilterController;
	IBOutlet EditFilterController *myEditFilterController;
	IBOutlet RemoveFilterController *myRemoveFilterController;
}

@property (nonatomic, retain) IBOutlet UITableView* myFilterTableView;
@property (nonatomic, retain) IBOutlet AddFilterController *myAddFilterController;
@property (nonatomic, retain) IBOutlet EditFilterController *myEditFilterController;
@property (nonatomic, retain) IBOutlet RemoveFilterController *myRemoveFilterController;

-(IBAction)addFilter:(id)sender;
-(IBAction)editFilter:(id)sender;
-(IBAction)removeFilter:(id)sender;
@end
