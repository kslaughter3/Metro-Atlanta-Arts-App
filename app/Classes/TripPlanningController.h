//
// NextView.h
// Metro-Atlanta-Arts-App
//
// Created by Drew on 9/29/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripPlanningController.h"

@class TripPlanningController;

@interface TripPlanningController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *myTableView;
	IBOutlet TripPlanningController *myTripController;
	NSIndexPath* checkedIndexPath;
	NSMutableArray* integers;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet TripPlanningController *myTripController;
@property (nonatomic, retain) NSIndexPath* checkedIndexPath;
@property (nonatomic, retain) NSMutableArray* integers;

-(IBAction)plan:(id)sender;

@end
