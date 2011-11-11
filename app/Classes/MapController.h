//
//  Metro_Atlanta_Arts_AppViewController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Drew on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Content.h"
#import "Event.h"
#import "EventController.h"
#import "EventAnnotation.h"
#import "json/SBJson.h"
#import <objc/runtime.h>
#import <objc/message.h>

@class SBJsonStreamParser;
@class SBJsonStreamParserAdapter;

@class MapController;


//TODO: Change these to sylvie's types
typedef enum EventType {
	EventTypeOne =		0,
	FirstEventType = EventTypeOne,
	EventTypeTwo,
	EventTypeThree,
	EventTypeFour,
	EventTypeFive,
	EventTypeSix,
	LastEventType = EventTypeSix
} EventType;

@interface MapController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate> {
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITextView *tweet;
	IBOutlet MKMapView* myMapView;
	IBOutlet UINavigationBar *myTitleBar;
	IBOutlet UIBarButtonItem *previousButton;
	IBOutlet UIBarButtonItem *nextButton;
	IBOutlet UISegmentedControl *mySelectionBar;
    NSURLConnection *theConnection;
    SBJsonStreamParser *parser;
    SBJsonStreamParserAdapter *adapter;
	NSMutableArray *mapAnnotations;
	CLLocationManager *locationManager;
	int myEventType;
	int myPage;
	int lastPage;
}

@property (nonatomic, retain) IBOutlet MKMapView* myMapView;
@property (nonatomic, retain) NSMutableArray *mapAnnotations;
@property (nonatomic, retain) Event *globalEvent;
@property (nonatomic, retain) CLLocationManager *locationManager;

-(void)displayMyMap;
-(void)setUpAnnotations;
-(IBAction)loadEventDetails:(id)sender;
-(IBAction)previousPage:(id)sender;
-(IBAction)nextPage:(id)sender;
-(void)changeEventType:(id)sender;
-(void)enabledNavigationButtons;
- (void)locationManager:(CLLocationManager *)manager 
	didUpdateToLocation:(CLLocation *) newLocation
		   fromLocation:(CLLocation *) oldLocation;


@end

