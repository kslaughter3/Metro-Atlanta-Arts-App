//
//  SearchController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/26/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/*******************************************************
 * Search Controller Class
 *
 * Handles the search functionality
 * Allows the user to create a query and filter the events
 * displayed based on that query
 * Allows the user to open a list of the current filters
 *
 *******************************************************/

#import <UIKit/UIKit.h>
#import "FilterListController.h"
#import "Content.h"

@interface SearchController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField *mySearchField;
	FilterListController *myFilterListController;
}

@property (nonatomic, retain) IBOutlet UITextField *mySearchField;
@property (nonatomic, retain) FilterListController *myFilterListController;

-(IBAction)search: (id) sender;
-(IBAction)clearAll: (id) sender;
-(IBAction)advancedSearch: (id) sender;

@end
