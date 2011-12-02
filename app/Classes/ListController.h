//
// NextView.h
// Metro-Atlanta-Arts-App
//
// Created by Gendreau, Anthony S on 9/29/11.
// Copyright 2011 ARTS PAPERS, INC. All rights reserved.
//

/*******************************************************
 * List Controller Class
 * 
 * Handles the List format for the Events, Artists and
 * Locations in the database 
 * Allows the user to navigate through the pages and select
 * an Event, Artist, or Location to view details about 
 *
 *******************************************************/

#import <UIKit/UIKit.h>
#import "DetailsController.h"
#import "Content.h"
#import	"Event.h"

@class ListController;


@interface ListController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *myTableView;
	DetailsController *myDetailsController;
	IBOutlet UINavigationBar *myTitleBar;
	IBOutlet UISegmentedControl *mySelectionBar;
	IBOutlet UIBarButtonItem *previousButton;
	IBOutlet UIBarButtonItem *nextButton;
	DetailsType listType;
	NSAutoreleasePool *pool;
	NSTimer * timer;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) DetailsController	*myDetailsController;
@property (nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;
@property (nonatomic, retain) IBOutlet UISegmentedControl *mySelectionBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *previousButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextButton;
@property (nonatomic, retain) NSTimer * timer;

-(void)setListTitle;
-(void)enableNavigationButtons;
-(void)refreshDataView;
-(void)changeListType:(id)sender;
-(IBAction)previousPage:(id)sender;
-(IBAction)nextPage:(id)sender;
-(int)getTablePage;
-(int)getLastPage;
-(void)changePage: (BOOL)increment;
-(void)populateList;

@end

