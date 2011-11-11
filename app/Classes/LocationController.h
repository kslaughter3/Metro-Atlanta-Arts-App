//
//  LocationController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventLocation.h"

@interface LocationController : UIViewController <UIWebViewDelegate> {
	EventLocation *location;
	IBOutlet UINavigationBar *myTitleBar;
	IBOutlet UIWebView *myWebView;
}

@property(nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;
@property(nonatomic, retain) IBOutlet UIWebView *myWebView;

-(NSString *)buildHTMLString;

-(IBAction)close:(id)sender;
-(void)setLocation:(EventLocation *)loc;
-(EventLocation *)getLocation;

@end
