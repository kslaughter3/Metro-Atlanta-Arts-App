//
//  Metro_Atlanta_Arts_AppViewController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Drew on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Event.h"

@class SBJsonStreamParser;
@class SBJsonStreamParserAdapter;

@class MapController;

@interface MapController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate> {
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITextView *tweet;
	IBOutlet MKMapView* myMapView;
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

-(IBAction)next:(id)sender;
-(void)displayMyMap;
-(void)setUpAnnotations;
-(IBAction)loadEventDetails:(id)sender;
- (void)locationManager:(CLLocationManager *)manager 
	didUpdateToLocation:(CLLocation *) newLocation
		   fromLocation:(CLLocation *) oldLocation;


@end

