//
//  filterController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 ARTS PAPERS, INC. All rights reserved.
//

/********************************************************
 * Filter List Class
 *
 * Displays the list of filters in the system 
 * Allows the user to enable/disable a filter
 * Allows the user to add/edit/remove a filter
 *
 ********************************************************/

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
-(IBAction)removeFilter:(id)sender;
-(IBAction)back:(id)sender;

@end
