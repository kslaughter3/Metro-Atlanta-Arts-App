//
//  EventLocation.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface EventLocation : NSObject {
	NSString *streetAddress;
	NSString *city;
	NSString *state;
	NSString *zip;
	CLLocation *location;
	
	NSMutableArray *events;	 /* List of Events at this location */
}

/* Initializer */
-(EventLocation *)initializeWithAddress: (NSString *) add City: (NSString *) c State: (NSString *) s 
								Zip: (NSString *) z Location: (CLLocation *) loc;

/* getters and setters */
-(void)setStreetAddress: (NSString *) str;
-(NSString *)getStreetAddress; 

-(void)setCity: (NSString *) str;
-(NSString *)getCity;

-(void)setState: (NSString *) str;
-(NSString *)getState;

-(void)setZip: (NSString *) str;
-(NSString *)getZip;

-(void)setLocation: (CLLocation *) loc;
-(CLLocation *)getLocation;

/* end getters and setters */


/* distance to method */
-(double)distanceFromLocation: (EventLocation *) loc;

-(CLLocationCoordinate2D)getCoordinates;

@end
