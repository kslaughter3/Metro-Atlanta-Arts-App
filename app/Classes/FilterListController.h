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


@class FilterListController;

@interface FilterListController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *myTableView;
	IBOutlet UINavigationBar *myNavigationBar;
	AddFilterController *myAddFilterController;
	EditFilterController *myEditFilterController;
	//NSIndexPath* checkedIndexPath;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet UINavigationBar *myNavigationBar;
@property (nonatomic, retain) AddFilterController *myAddFilterController;
@property (nonatomic, retain) EditFilterController *myEditFilterController;
//@property (nonatomic, retain) NSIndexPath* checkedIndexPath;

-(IBAction)addFilter:(id)sender;

@end
