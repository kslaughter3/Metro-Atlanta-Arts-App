//
//  Metro_Atlanta_Arts_AppAppDelegate.h
//  Metro-Atlanta-Arts-App
//
//  Created by Drew on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextView.h"

@class Metro_Atlanta_Arts_AppViewController;

@interface Metro_Atlanta_Arts_AppAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

