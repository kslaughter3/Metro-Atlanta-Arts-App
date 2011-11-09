//
//  EventController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/12/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventController : UIViewController <UIWebViewDelegate> {
	IBOutlet UINavigationBar *myTitleBar;
	IBOutlet UIWebView *myWebView;
	Event *myEvent;
}

@property(nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;
@property(nonatomic, retain) IBOutlet UIWebView *myWebView;

//-(NSString *)buildDetailHTMLString;
-(NSString *)buildHTMLString;
-(IBAction)close:(id)sender;
-(void)setEvent:(Event *)event;
-(Event *)getEvent;

@end
