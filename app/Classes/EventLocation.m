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

-(EventLocation *)initEmptyLocation {
	self = [super init];
	
	if(self != nil) {
		return self;
	}
	
	return nil;
}

-(EventLocation *)initWithLocation:(EventLocation *)loc {	
	self = [super init];
	
	if(self != nil) {
		name = [[NSString alloc] initWithString: [loc getName]];
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
		coordinate.latitude = 33.7728837;
		coordinate.longitude = -84.393816;
		return self;
	}
	
	return nil;
}

-(EventLocation *)initWithName: (NSString *) n Address: (NSString *) add City: (NSString *) c State: (NSString *) s 
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
		name = [[NSString alloc] initWithString: n];
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

-(EventLocation *)initWithName: (NSString *) n Address: (NSString *) add City: (NSString *) c State: (NSString *) s 
							  Zip: (NSString *) z {
	if((add == nil) || (c == nil) || (s == nil) || (z == nil)) {
		return nil;
	}
	
	self = [super init];
	
	if(self != nil) {
		name = [[NSString alloc] initWithString: n];
		streetAddress = [[NSString alloc] initWithString: add];
		city = [[NSString alloc] initWithString: c];
		state = [[NSString alloc] initWithString: s];
		zip = [[NSString alloc] initWithString: z];
		//TODO: add call to database to get the CLLocations
		coordinate.latitude = 33.7728837;
		coordinate.longitude = -84.393816;
		return self;
	}
	
	return nil;
}

/* getters and setters */
-(void)setName:(NSString *)str {
	name = str;
}

-(NSString *)getName {
	return name;
}

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
	CLLocation *myLoc = [[CLLocation alloc] initWithLatitude:coordinate.latitude
						longitude: coordinate.longitude];
	CLLocation *otherLoc = [[CLLocation alloc] initWithLatitude:[loc getCoordinates].latitude
						longitude: [loc getCoordinates].longitude];
	
	distance = [myLoc distanceFromLocation: otherLoc];
	[myLoc release];
	[otherLoc release];

	return distance;
}


-(BOOL)isEqual:(id)object {
	EventLocation *other = (EventLocation *)object;

	if(((name == nil) && ([other getName] != nil)) || ((name != nil) && ([other getName] == nil))) {
		return NO;
	}
	if((name != nil) && ([name isEqualToString:[other getName]] == NO)) {
		return NO;
	}
	
	if(((streetAddress == nil) && ([other getStreetAddress] != nil)) || ((streetAddress != nil) && ([other getStreetAddress] == nil))) {
		return NO;
	}
  	if((streetAddress != nil) && ([streetAddress isEqualToString: [other getStreetAddress]] == NO)) {
		return NO;
	}
	
	if(((city == nil) && ([other getCity] != nil)) || ((city != nil) && ([other getCity] == nil))) {
		return NO;
	}
	if((city != nil) && ([city isEqualToString: [other getCity]] == NO)) {
		return NO;
	}
	
	if(((state == nil) && ([other getState] != nil)) || ((state != nil) && ([other getState] == nil))) {
		return NO;
	}
	if((state != nil) && ([state isEqualToString: [other getState]] == NO)) {
		return NO;
	}
	
	if(((zip == nil) && ([other getZip] != nil)) || ((zip != nil) && ([other getZip] == nil))) {
		return NO;
	}
	if((zip != nil) && ([zip isEqualToString: [other getZip]] == NO)) {
		return NO;
	}
	
	if(coordinate.latitude != [other getCoordinates].latitude) {
		return NO;
	}
	if(coordinate.longitude != [other getCoordinates].longitude) {
		return NO;
	}
	
	return YES;
}

@end
