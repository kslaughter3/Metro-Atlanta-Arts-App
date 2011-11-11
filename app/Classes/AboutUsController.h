//
//  AboutUsController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Content.h"
#import "AboutUs.h"

@interface AboutUsController : UIViewController <UIWebViewDelegate> {
	IBOutlet UIWebView *myWebView;
}

@property (nonatomic, retain) IBOutlet UIWebView *myWebView;

-(IBAction)close:(id)sender;
-(NSString *)buildHTMLString;

@end
