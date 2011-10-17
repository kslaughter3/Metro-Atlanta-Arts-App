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
	if((add == nil) || (c == nil) || (s == nil) || (z == nil) || (loc == nil)) {
		return nil;
	}
	
	self = [super init];
	
	if(self != nil) {
		[self setStreetAddress: add];
		[self setCity: c];
		[self setState: s];
		[self setZip: z];
		[self setLocation: loc];
		
		return self;
	}
	
	return nil;
}

-(EventLocation *)initializeWithAddress: (NSString *) add City: (NSString *) c State: (NSString *) s 
									Zip: (NSString *) z {
	if((add == nil) || (c == nil) || (s == nil) || (z == nil)) {
		return nil;
	}
	
	self = [super init];
	
	if(self != nil) {
		[self setStreetAddress: add];
		[self setCity: c];
		[self setState: s];
		[self setZip: z];
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
