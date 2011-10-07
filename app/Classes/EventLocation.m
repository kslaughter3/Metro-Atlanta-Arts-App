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
-(EventLocation *)initializeWithAddress: (NSString *) add City: (NSString *) c State: (NSString *) s 
								Zip: (NSString *) z Location: (CLLocation *) loc {
	if((add == NULL) || (c == NULL) || (s == NULL) || (z == NULL) || (loc == NULL)) {
		return NULL;
	}
	
	self = [super init];
	
	if(self != NULL) {
		[self setStreetAddress: add];
		[self setCity: c];
		[self setState: s];
		[self setZip: z];
		[self setLocation: loc];
		
		return self;
	}
	
	return NULL;
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

-(void)setLocation: (CLLocation *) loc {
	location = loc;
}

-(CLLocation *)getLocation {
	return location;
}

/* end getters and setters */


/* distance to method */
-(double)distanceFromLocation: (EventLocation *) loc {
	return [[self getLocation] distanceFromLocation: [loc getLocation]];
}

-(CLLocationCoordinate2D)getCoordinates {
	return location.coordinate;
}

@end
