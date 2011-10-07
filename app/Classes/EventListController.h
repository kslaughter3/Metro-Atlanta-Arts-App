//
// NextView.h
// Metro-Atlanta-Arts-App
//
// Created by Drew on 9/29/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventListController;

@interface EventListController : UIViewController <UITableViewDelegate> {
	IBOutlet UITableView* myTableView;
	
}

@property (nonatomic, retain) IBOutlet UITableView* myTableView;

@end

