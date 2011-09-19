//
//  Metro_Atlanta_Arts_AppAppDelegate.h
//  Metro-Atlanta-Arts-App
//
//  Created by Drew on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Metro_Atlanta_Arts_AppViewController;

@interface Metro_Atlanta_Arts_AppAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Metro_Atlanta_Arts_AppViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Metro_Atlanta_Arts_AppViewController *viewController;

@end

