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

@interface MapController : UIViewController<MKMapViewDelegate> {
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITextView *tweet;
	IBOutlet MKMapView* myMapView;
    NSURLConnection *theConnection;
    SBJsonStreamParser *parser;
    SBJsonStreamParserAdapter *adapter;
}

@property (nonatomic, retain) IBOutlet MKMapView* myMapView;
@property (nonatomic, retain) NSMutableArray *mapAnnotations;
@property (nonatomic, retain) Event *globalEvent;

- (IBAction)go;

-(IBAction)next:(id)sender;
-(void)displayMYMap;
-(IBAction)loadEventDetails:(id)sender;

@end

