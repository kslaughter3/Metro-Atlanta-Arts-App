//
//  EventLocation.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventLocation.h"


@implementation EventLocation

/* Initializer */

-(EventLocation *)initWithLocation:(EventLocation *)loc {	
	self = [super init];
	
	if(self != nil) {
		streetAddress = [[NSString alloc] initWithString: [loc getStreetAddress]];
		city = [[NSString alloc] initWithString: [loc getCity]];
		state = [[NSString alloc] initWithString: [loc getState]];
		zip = [[NSString alloc] initWithString: [loc getZip]];
		coordinate.latitude = [loc getCoordinates].latitude;
		coordinate.longitude = [loc getCoordinates].longitude;
		
		return self;
	}
	
	return nil;
}

-(EventLocation *)initWithAddress: (NSString *) add City: (NSString *) c State: (NSString *) s 
								Zip: (NSString *) z Location: (CLLocationCoordinate2D) coord {
	if((add == nil) || (c == nil) || (s == nil) || (z == nil)) {
		return nil;
	}
	
	if((coord.latitude < MINLAT) || (coord.latitude > MAXLAT) || 
	   (coord.longitude < MINLON) || (coord.longitude > MAXLON)) {
		return nil;
	}
	
	self = [super init];
	
	if(self != nil) {
		streetAddress = [[NSString alloc] initWithString: add];
		city = [[NSString alloc] initWithString: c];
		state = [[NSString alloc] initWithString: s];
		zip = [[NSString alloc] initWithString: z];
		coordinate.latitude = coord.latitude;
		coordinate.longitude = coord.longitude;
		
		return self;
	}
	
	return nil;
}

-(EventLocation *)initWithAddress: (NSString *) add City: (NSString *) c State: (NSString *) s 
									Zip: (NSString *) z {
	if((add == nil) || (c == nil) || (s == nil) || (z == nil)) {
		return nil;
	}
	
	self = [super init];
	
	if(self != nil) {
		streetAddress = [[NSString alloc] initWithString: add];
		city = [[NSString alloc] initWithString: c];
		state = [[NSString alloc] initWithString: s];
		zip = [[NSString alloc] initWithString: z];
		//TODO: add call to database to get the CLLocations
		return self;
	}
	
	return nil;
}

/* getters and setters */
-(void)setStreetAddress: (NSString *) str {
	streetAddress = str;
}

-(NSString *)getStreetAddress {
	return streetAddress;
}

-(void)setCity: (NSString *) str {
	city = str;
}

-(NSString *)getCity {
	return city;
}

-(void)setState: (NSString *) str {
	state = str;
}

-(NSString *)getState {
	return state;
}

-(void)setZip: (NSString *) str {
	zip = str;
}

-(NSString *)getZip {
	return zip;
}

-(void)setCoordinates: (CLLocationCoordinate2D) coord {
	coordinate = coord;
}

-(CLLocationCoordinate2D)getCoordinates {
	return coordinate;
}

/* end getters and setters */


/* distance to method */
-(double)distanceFromLocation: (EventLocation *) loc {
	double distance;
	/*CLLocation *myLoc = [[CLLocation alloc] initWithLatitude:coordinate.latitude
						longitude: coordinate.longitude];
	CLLocation *otherLoc = [[CLLocation alloc] initWithLatitude:[loc getCoordinates].latitude
						longitude: [loc getCoordinates].longitude];
	
	distance = [myLoc distanceFromLocation: otherLoc];
	[myLoc release];
	[otherLoc release];
*/	
	return distance;
}


@end
