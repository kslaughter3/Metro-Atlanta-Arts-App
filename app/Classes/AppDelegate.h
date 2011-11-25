//
//  Metro_Atlanta_Arts_AppAppDelegate.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 9/19/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/*******************************************************
 * Application Delegate Class
 *
 * Handles the main window and the tab controller
 *
 ******************************************************/

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface AppDelegate : NSObject <UIApplicationDelegate, UITabBarDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
	NSAutoreleasePool *pool;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabBarItem1;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabBarItem2;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabBarItem3;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabBarItem4;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabBarItem5;
@end

