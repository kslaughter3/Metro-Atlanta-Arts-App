//
//  EventLocation.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define MINLAT -90
#define MAXLAT 90
#define MINLON -180
#define MAXLON 180
#define MILESTOMETERS 1609

@interface EventLocation : NSObject {
	NSString *streetAddress;
	NSString *city;
	NSString *state;
	NSString *zip;
	CLLocationCoordinate2D coordinate;
	
	NSMutableArray *events;	 /* List of Events at this location */
}

/* Initializers */

-(EventLocation *)initWithLocation: (EventLocation *) loc;

-(EventLocation *)initWithAddress: (NSString *) add City: (NSString *) c State: (NSString *) s 
								Zip: (NSString *) z Location: (CLLocationCoordinate2D) coord;

-(EventLocation *)initWithAddress:(NSString *)add City:(NSString *)c 
								State:(NSString *)s Zip:(NSString *)z;

/* getters and setters */
-(void)setStreetAddress: (NSString *) str;
-(NSString *)getStreetAddress; 

-(void)setCity: (NSString *) str;
-(NSString *)getCity;

-(void)setState: (NSString *) str;
-(NSString *)getState;

-(void)setZip: (NSString *) str;
-(NSString *)getZip;

-(void)setCoordinates: (CLLocationCoordinate2D) coord;
-(CLLocationCoordinate2D)getCoordinates;

/* end getters and setters */


/* distance to method */
-(double)distanceFromLocation: (EventLocation *) loc;

@end
