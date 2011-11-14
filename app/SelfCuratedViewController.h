//
//  SelfCuratedView.h
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 11/14/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"SelfCuratedEntry.h"

@interface SelfCuratedViewController : UIViewController <UIWebViewDelegate>{
	IBOutlet UIWebView *myWebView;
	IBOutlet UINavigationBar *myTitleBar;
	SelfCuratedEntry *myEntry;
}

@property(nonatomic, retain) IBOutlet UIWebView *myWebView;
@property(nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;

-(void)setEntry:(SelfCuratedEntry *)entry;
-(SelfCuratedEntry *)getEntry;

-(IBAction)close:(id)sender;
-(NSString *)buildHTMLString;


@end
