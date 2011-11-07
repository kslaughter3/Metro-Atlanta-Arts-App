//
//  TripPlanningMapController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Park, Hyuk J on 10/28/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Content.h"

@interface TripPlanningMapController : UIViewController<MKMapViewDelegate> {
	IBOutlet MKMapView* myTripMapView;
	int time;
	int speed;
	NSMutableArray *myEvents;
}

@property (nonatomic, retain) IBOutlet MKMapView* myTripMapView;

-(void)setTime: (int) min;
-(int)getTime;

-(void)setSpeed: (int) mph;
-(int)getSpeed;

-(void)setEvents: (NSMutableArray *)indices;
-(void)planTrip;
-(NSMutableArray *)getEvents;

-(IBAction)close: (id)sender;

@end
