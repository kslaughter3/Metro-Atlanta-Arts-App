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
		pool = [[NSAutoreleasePool alloc] init];
		return self;
	}
	
	return nil;
}

-(EventLocation *)initWithLocation:(EventLocation *)loc {	
	self = [super init];
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
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

-(NSString *)getLocationFilterString {
	if(name != nil && [name isEqualToString: @""] == NO) {
		return [NSString stringWithFormat: @"name=%@", name];
	}
	
	return [NSString stringWithFormat:@"street=%@,city=%@,state=%@,zip=%@",
			streetAddress, city, state, zip];
}

-(BOOL)hasAddress {
	if((streetAddress == nil) || ([streetAddress isEqualToString:@""]) || 
	   (city == nil) || ([city isEqualToString:@""]) ||
	   (state == nil) || ([state isEqualToString: @""]) ||
	   (zip == nil) || ([zip isEqualToString: @""])) {
		return NO;
	}
	return YES;
}

-(NSString *)getAddress {
	return [NSString stringWithFormat: @"%@\n%@ %@, %@",
			streetAddress, city, state, zip];
}

-(BOOL)isLocationIDEqual:(EventLocation *)other {
	return locationID == [other getLocationID];
}

/* getters and setters */
-(void)setLocationID:(int)num {
	locationID = num;
}

-(int)getLocationID {
	return locationID;
}

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

-(void)setDescription: (NSString *)str {
	description = str;
}

-(NSString *)getDescription {
	return description;
}

-(void)setWebsite: (NSString *)url {
	website = url;
}

-(NSString *)getWebsite {
	return website;
}

-(void)setImage: (NSString *)img {
	image = img;
}

-(NSString *)getImage {
	return image;
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
	
	if(locationID != [other getLocationID]) {
		return NO;
	}

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

-(void)dealloc {
	[name release];
	[streetAddress release];
	[city release];
	[state release];
	[zip release];
	[description release];
	[website release];
	[image release];
	[pool release];
	[super dealloc];
}

@end
