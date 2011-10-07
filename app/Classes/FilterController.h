//
//  filterController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterController;

@interface FilterController : UIViewController <UITableViewDelegate> {
	IBOutlet UITableView* myFilterTableView;

}
@property (nonatomic, retain) IBOutlet UITableView* myFilterTableView;

@end
