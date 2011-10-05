//
// Event.m
// Metro-Atlanta-Arts-App
//
// Created by Gendreau, Anthony S on 9/28/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Event.h"
#import <stdio.h>
#import <stdlib.h>
#import <CoreLocation/CoreLocation.h>

@implementation Event

/* Initialize Method */
-(Event *)initEventWithName: (NSString *) n Artist: (NSString *) a Description: (NSString *) desc
					Website: (NSURL *) url Address: (NSString *) add City: (NSString *) c 
					State: (NSString *) s Zip: (NSString *) z Start: (NSDate *) start 
					End: (NSDate *) end Duration: (int) length Cost: (double) price {
	
	/* Check all the data */
	if((n == NULL) || (a == NULL) || (desc == NULL) || (url == NULL) || (add == NULL) ||
	   (c == NULL) || (s == NULL) || (z == NULL) || (start == NULL) || (end == NULL) ||
	   (length < 0) || (price < 0) || ([start earlierDate: end] == end)) {
		return NULL;
	}
	
	self = [super init];
	
	if (self != NULL) {
		[self setEventName: n];
		[self setArtist: a];
		[self setDescription: desc];
		[self setWebsite: url];
		[self setAddress: add];
		[self setCity: c];
		[self setState: s];
		[self setZip: z];
		[self setStartDate: start];
		[self setEndDate: end];
		[self setDuration: length];
		[self setCost: price];
		[self setLocationFromAddress];
		
		return self;
	}
	
	return NULL;
}


-(void) print {
}

/*Getters and Setters */
-(void) setEventName: (NSString *) str {
	name = str;
}

-(NSString *)getEventName {
	return name;
}

-(void) setArtist: (NSString *) str {
	artist = str;
}

-(NSString *)getArtist {
	return artist;
}

-(void) setDescription: (NSString *) str {
	description = str;
}

-(NSString *)getDescription {
	return description;
}

-(void) setWebsite: (NSURL *) url {
	website = url;
}

-(NSURL *)getWebsite {
	return website;
}

-(void) setAddress: (NSString *) str {
	address = str;
}

-(NSString *)getAddress {
	return address;
}

-(void) setCity: (NSString *) str {
	city = str;
}

-(NSString *)getCity {
	return city;
}

-(void) setState: (NSString *) str {
	state = str;
}

-(NSString *)getState {
	return state;
}

-(void) setZip: (NSString *) str {
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

-(void) setStartDate: (NSDate *) date {
	startDate = date;
}

-(NSDate *)getStartDate {
	return startDate;
}

-(void) setEndDate: (NSDate *) date {
	endDate = date;
}

-(NSDate *)getEndDate {
	return endDate;
}

-(void) setDuration: (int) length {
	duration = length;
}

-(int)getDuration {
	return duration;
}

-(void) setCost: (double) price {
	cost = price;
}

-(double)getCost {
	return cost;
}

/* End Getters and Setters */

/* Helper Methods */
/*Sets the location (lat/lon) based on the street address */
-(void)setLocationFromAddress {
}

/* End Helper Methods */

/* Filter Methods */

/* Returns true if the event's name begins with the given name false otherwise */
-(bool)NameFilter: (NSString *) str {
	if(str != NULL && name != NULL) {
		NSString * temp = [name uppercaseString];
		str = [str uppercaseString];
		return [temp hasPrefix: str];
	}
	return false;
}

/* Returns true if the event's artist begins with the given artist false otherwise */
-(bool)ArtistFilter: (NSString *) str {
	if(str != NULL && artist != NULL) {
		NSString * temp = [artist uppercaseString];
		str = [str uppercaseString];
		return [temp hasPrefix: str];
	}
	return false;
}

/* Returns true if the time of this event occurs between the given start and end times */
-(bool)TimeFilterStart: (NSDate *) start andEnd: (NSDate *) end {
	return false;
}

/* Returns true if the cost of this event is between the given min and max costs */
-(bool)CostFilterMin: (double) min andMax: (double) max {
	return (cost >= min && cost <= max);
}

/* Returns true if the duration of this event is between the given min and max durations */
-(bool)DurationFilterMin: (int) min andMax: (int) max {
	return (duration >= min && duration <= max);
}

/*Returns true if the location of this event is within the given radius of the given Location */
-(bool)LocationFilterLoc: (CLLocation *) loc andRadius: (double) rad {
	return false;
}

/* End Filter Methods */
@end
