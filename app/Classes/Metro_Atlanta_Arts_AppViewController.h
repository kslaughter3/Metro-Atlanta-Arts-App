//
//  Metro_Atlanta_Arts_AppViewController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Drew on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Metro_Atlanta_Arts_AppViewController : UIViewController<MKMapViewDelegate> {
	IBOutlet MKMapView* myMapView;
}

@property (nonatomic, retain) IBOutlet MKMapView* myMapView;

-(void)displayMYMap;

@end

