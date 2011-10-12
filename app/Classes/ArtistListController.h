//
//  ArtistListController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtistController.h"

@class ArtistListController;

@interface ArtistListController : UIViewController <UITableViewDelegate> {
	IBOutlet UITableView *myTableView;
	IBOutlet ArtistController *artistController;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet ArtistController *artistController;
@end