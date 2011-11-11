//
// NextView.h
// Metro-Atlanta-Arts-App
//
// Created by Drew on 9/29/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripPlanningController.h"
#import "TripPlanningMapController.h"

//Store these in meters per minute because distanceTo returns meters and time is in minutes
#define WALKING_SPEED	3 
#define BIKING_SPEED	9
#define DRIVING_SPEED	20

@class TripPlanningController;

@interface TripPlanningController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *myTableView;
	NSIndexPath* checkedIndexPath;
	NSMutableArray* integers;
	IBOutlet TripPlanningMapController *myTripMapController;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSIndexPath* checkedIndexPath;
@property (nonatomic, retain) NSMutableArray* integers;
@property (nonatomic, retain) IBOutlet TripPlanningMapController *myTripMapController;

-(void)pickMode:(id)sender;
-(IBAction)plan:(id)sender;
-(IBAction)viewPlan:(id)sender;
-(IBAction)close:(id)sender;

@end
