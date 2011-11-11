//
//  MoreController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripPlanningController.h"
#import "AboutUsController.h"

@interface MoreController : UIViewController {
	IBOutlet UINavigationBar *myTitleBar;
	IBOutlet UIButton *tripPlanningButton;
	IBOutlet UIButton *aboutUsButton;
	TripPlanningController *myTripPlanner;
	AboutUsController *myAboutUsController;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;
@property (nonatomic, retain) IBOutlet UIButton *tripPlanningButton;
@property (nonatomic, retain) IBOutlet UIButton *aboutUsButton;
@property (nonatomic, retain) TripPlanningController *myTripPlanner;
@property (nonatomic, retain) AboutUsController *myAboutUsController;

-(IBAction)openTripPlanning:(id)sender;
-(IBAction)openAboutUs:(id)sender;

@end
