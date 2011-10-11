//
//  filterController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterListController;

@interface FilterListController : UIViewController <UITableViewDelegate> {
	IBOutlet UITableView *myFilterTableView;
}

@property (nonatomic, retain) IBOutlet UITableView* myFilterTableView;

-(IBAction)addFilter:(id)sender;
-(IBAction)editFilter:(id)sender;
-(IBAction)removeFilter:(id)sender;
@end
