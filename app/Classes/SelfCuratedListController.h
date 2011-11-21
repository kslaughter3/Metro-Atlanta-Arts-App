//
//  SelfCuratedListController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Content.h"
#import "DetailsController.h"

@class SelfCuratedListController;

@interface SelfCuratedListController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *myTableView;
	DetailsController *mySelfCuratedViewController;
	IBOutlet UIBarButtonItem *previousButton;
	IBOutlet UIBarButtonItem *nextButton;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) DetailsController *mySelfCuratedViewController;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *previousButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextButton;

-(IBAction)previousPage:(id)sender;
-(IBAction)nextPage:(id)sender;
-(void)enableNavigationButtons;
@end
