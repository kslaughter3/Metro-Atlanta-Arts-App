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
	NSString *name; 
	NSString *streetAddress;
	NSString *city;
	NSString *state;
	NSString *zip;
	NSString *description;
	NSString *website;
	NSString *image;
	CLLocationCoordinate2D coordinate;
	
	NSMutableArray *events;	 /* List of Events at this location */
}

/* Initializers */
-(EventLocation *)initEmptyLocation;

-(EventLocation *)initWithLocation: (EventLocation *) loc;

-(EventLocation *)initWithAddress: (NSString *) add City: (NSString *) c State: (NSString *) s 
								Zip: (NSString *) z Location: (CLLocationCoordinate2D) coord;

-(EventLocation *)initWithAddress:(NSString *)add City:(NSString *)c 
								State:(NSString *)s Zip:(NSString *)z;

-(EventLocation *)initWithName: (NSString *) n Address: (NSString *) add City: (NSString *) c State: (NSString *) s 
							  Zip: (NSString *) z Location: (CLLocationCoordinate2D) coord;

-(EventLocation *)initWithName: (NSString *) n Address:(NSString *)add City:(NSString *)c 
							State:(NSString *)s Zip:(NSString *)z;

-(BOOL)hasAddress;

-(NSString *)getAddress;

/* getters and setters */
-(void)setName: (NSString *)str;
-(NSString *)getName;

-(void)setStreetAddress: (NSString *) str;
-(NSString *)getStreetAddress; 

-(void)setCity: (NSString *) str;
-(NSString *)getCity;

-(void)setState: (NSString *) str;
-(NSString *)getState;

-(void)setZip: (NSString *) str;
-(NSString *)getZip;

-(void)setDescription: (NSString *)str;
-(NSString *)getDescription;

-(void)setWebsite: (NSString *)url;
-(NSString *)getWebsite;

-(void)setImage: (NSString *)img;
-(NSString *)getImage;

-(void)setCoordinates: (CLLocationCoordinate2D) coord;
-(CLLocationCoordinate2D)getCoordinates;

/* end getters and setters */


/* distance to method */
-(double)distanceFromLocation: (EventLocation *) loc;

@end
