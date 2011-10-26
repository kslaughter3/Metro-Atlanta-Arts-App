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
	int myRow;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet UINavigationBar *myNavigationBar;
@property (nonatomic, retain) AddFilterController *myAddFilterController;
@property (nonatomic, retain) EditFilterController *myEditFilterController;

-(IBAction)addFilter:(id)sender;
-(IBAction)editFilter:(id)sender;
-(IBAction)back:(id)sender;

@end
