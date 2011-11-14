//
//  SelfCuratedListController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfCuratedListController.h"
#import "SelfCuratedViewController.h"

@class SelfCuratedListController;

@interface SelfCuratedListController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *myTableView;
	SelfCuratedViewController *mySelfCuratedViewController;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) SelfCuratedViewController *mySelfCuratedViewController;

@end
