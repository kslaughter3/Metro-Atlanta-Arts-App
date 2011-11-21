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
#import "DetailsController.h"
#import "EventAnnotation.h"
#import "json/SBJson.h"
#import <objc/runtime.h>
#import <objc/message.h>

@class SBJsonStreamParser;
@class SBJsonStreamParserAdapter;

@class MapController;

@interface MapController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate> {
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITextView *tweet;
	IBOutlet MKMapView* myMapView;
	IBOutlet UINavigationBar *myTitleBar;
	IBOutlet UIBarButtonItem *previousButton;
	IBOutlet UIBarButtonItem *nextButton;
	IBOutlet UISegmentedControl *mySelectionBar;
	DetailsController *myEventController;
    NSURLConnection *theConnection;
    SBJsonStreamParser *parser;
    SBJsonStreamParserAdapter *adapter;
	NSMutableArray *mapAnnotations;
	CLLocationManager *locationManager;
}

@property (nonatomic, retain) IBOutlet MKMapView* myMapView;
@property (nonatomic, retain) NSMutableArray *mapAnnotations;
@property (nonatomic, retain) Event *globalEvent;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) DetailsController *myEventController;

-(void)displayMyMap;
-(void)setUpAnnotations;
-(void)calibrateRegion;
-(IBAction)loadEventDetails:(id)sender;
-(IBAction)previousPage:(id)sender;
-(IBAction)nextPage:(id)sender;
-(void)changeEventType:(id)sender;
-(void)enableNavigationButtons;
- (void)locationManager:(CLLocationManager *)manager 
	didUpdateToLocation:(CLLocation *) newLocation
		   fromLocation:(CLLocation *) oldLocation;


@end

