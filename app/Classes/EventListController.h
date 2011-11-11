//
// NextView.h
// Metro-Atlanta-Arts-App
//
// Created by Drew on 9/29/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventController.h"
#import "ArtistController.h"
#import	"LocationController.h"
#import "Content.h"
#import	"Event.h"

@class EventListController;

#define EVENTLIST		0
#define ARTISTLIST		1
#define LOCATIONLIST	2

@interface EventListController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *myTableView;
	EventController *myEventController;
	ArtistController *myArtistController;
	LocationController *myLocationController;
	IBOutlet UINavigationBar *myTitleBar;
	IBOutlet UISegmentedControl *mySelectionBar;
	IBOutlet UIBarButtonItem *previousButton;
	IBOutlet UIBarButtonItem *nextButton;
	int listType;
	int tablePage;
	int lastPage;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) EventController *myEventController;
@property (nonatomic, retain) ArtistController *myArtistController;
@property (nonatomic, retain) LocationController *myLocationController;
@property (nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;
@property (nonatomic, retain) IBOutlet UISegmentedControl *mySelectionBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *previousButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextButton;

-(void)setListTitle;
-(void)enabledNavigationButtons;

-(void)changeListType:(id)sender;
-(IBAction)previousPage:(id)sender;
-(IBAction)nextPage:(id)sender;

@end

