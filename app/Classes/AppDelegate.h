//
//  Metro_Atlanta_Arts_AppAppDelegate.h
//  Metro-Atlanta-Arts-App
//
//  Created by Drew on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventListController.h"

@class AppDelegate;

@interface AppDelegate : NSObject <UIApplicationDelegate, UITabBarDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabBarItem1;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabBarItem2;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabBarItem3;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabBarItem4;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabBarItem5;
//file://localhost/nethome/hpark68/Metro-Atlanta-Arts-App/app/Classes/filterController.xib
@end

