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
#import "Content.h"

//Store these in meters per minute because distanceTo returns meters and time is in minutes
#define WALKING_SPEED	3 
#define BIKING_SPEED	9
#define DRIVING_SPEED	20

@class TripPlanningController;

@interface TripPlanningController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *myTableView;
	NSMutableArray* myEvents;
	IBOutlet TripPlanningMapController *myTripMapController;
	IBOutlet UIBarButtonItem *previousButton;
	IBOutlet UIBarButtonItem *nextButton;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray* myEvents;
@property (nonatomic, retain) IBOutlet TripPlanningMapController *myTripMapController;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *previousButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextButton;

-(void)pickMode:(id)sender;
-(IBAction)plan:(id)sender;
-(IBAction)viewPlan:(id)sender;
-(IBAction)close:(id)sender;
-(IBAction)previousPage:(id)sender;
-(IBAction)nextPage:(id)sender;
-(void)enableNavigationButtons;

@end
