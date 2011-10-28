//
//  EventController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/12/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventController : UIViewController {
	IBOutlet UINavigationBar *myTitleBar;
	IBOutlet UIWebView *descriptionView;
	IBOutlet UIWebView *detailView;
	IBOutlet UIImageView *imageView;
	Event *myEvent;
}

@property(nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;
@property(nonatomic, retain) IBOutlet UIWebView *detailView;
@property(nonatomic, retain) IBOutlet UIWebView *descriptionView;
@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic, retain) Event *myEvent;

-(NSString *)buildDetailHTMLString;
-(NSString *)buildDescriptionHTMLString;
-(IBAction)close:(id)sender;

@end
