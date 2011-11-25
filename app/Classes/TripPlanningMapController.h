//
//  TripPlanningMapController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/28/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/*******************************************************
 * Trip Planning Map Controller
 *
 * Displays the map of the planned trip with the events
 * Connected in order by a line (as the crow flies)
 *
 ******************************************************/

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Content.h"
#import "DetailsController.h"
#import "EventAnnotation.h"

@interface TripPlanningMapController : UIViewController<MKMapViewDelegate> {
	IBOutlet MKMapView* myTripMapView;
	Event *tripGlobalEvent;
	int time;
	int speed;
	NSMutableArray *myEvents;
	NSMutableArray *myEventsLocation;
	NSMutableArray *tripMapAnnotations;
	MKPolyline *routeLine;
	MKPolylineView *routeLineView;
	DetailsController *myEventController;
	NSAutoreleasePool *pool;
}

@property (nonatomic, retain) IBOutlet MKMapView *myTripMapView;
@property (nonatomic, retain) Event *tripGlobalEvent;
@property (nonatomic, retain) NSMutableArray *tripMapAnnotations;
@property (nonatomic, retain) MKPolyline *routeLine;
@property (nonatomic, retain) MKPolylineView *routeLineView;
@property (nonatomic, retain) DetailsController *myEventController;

-(void)setTime: (int) min;
-(int)getTime;

-(void)setSpeed: (int) mph;
-(int)getSpeed;

-(void)displayTripMap;
-(void)calibrateTripRegion;
-(void)setUpTripAnnotations;
-(IBAction)loadTripEventDetails:(id)sender;

-(void)setEvents: (NSMutableArray *)events;
-(void)planTrip;
-(NSMutableArray *)getEvents;

-(IBAction)close: (id)sender;

-(void)loadRoute;


@end
