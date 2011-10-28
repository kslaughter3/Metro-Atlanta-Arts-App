//
//  SearchController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/26/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

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
