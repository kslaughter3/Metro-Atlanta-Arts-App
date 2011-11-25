//
//  MoreController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/*******************************************************
 * More Controller 
 *
 * Handles all the views that are not handled by the tab
 * controller
 * Currently handles Trip Planning and About Us
 *
 ******************************************************/

#import <UIKit/UIKit.h>
#import "TripPlanningController.h"
#import "DetailsController.h"

@interface MoreController : UIViewController {
	IBOutlet UINavigationBar *myTitleBar;
	IBOutlet UIButton *tripPlanningButton;
	IBOutlet UIButton *aboutUsButton;
	TripPlanningController *myTripPlanner;
	DetailsController *myAboutUsController;
	NSAutoreleasePool *pool;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;
@property (nonatomic, retain) IBOutlet UIButton *tripPlanningButton;
@property (nonatomic, retain) IBOutlet UIButton *aboutUsButton;
@property (nonatomic, retain) TripPlanningController *myTripPlanner;
@property (nonatomic, retain) DetailsController *myAboutUsController;

-(IBAction)openTripPlanning:(id)sender;
-(IBAction)openAboutUs:(id)sender;

@end
