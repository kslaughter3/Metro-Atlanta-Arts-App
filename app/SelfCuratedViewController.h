//
//  SelfCuratedView.h
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 11/14/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelfCuratedViewController : UIViewController <UIWebViewDelegate>{
	IBOutlet UIWebView *myWebView;
}

@property(nonatomic, retain) IBOutlet UIWebView *myWebView;

@end
