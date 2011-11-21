//
// NextView.h
// Metro-Atlanta-Arts-App
//
// Created by Drew on 9/29/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) DetailsController	*myDetailsController;
@property (nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;
@property (nonatomic, retain) IBOutlet UISegmentedControl *mySelectionBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *previousButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextButton;

-(void)setListTitle;
-(void)enableNavigationButtons;

-(void)changeListType:(id)sender;
-(IBAction)previousPage:(id)sender;
-(IBAction)nextPage:(id)sender;
-(int)getTablePage;
-(int)getLastPage;
-(void)changePage: (BOOL)increment;

@end

