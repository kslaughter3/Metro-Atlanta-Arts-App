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
-(Event *)initEventWithName: (NSString *) n Artist: (EventArtist *) a Description: (NSString *) desc
					Website: (NSURL *) url Location: (EventLocation *) loc Start: (NSDate *) start 
					End: (NSDate *) end Duration: (int) length Cost: (double) price 
					Availability: (EventAvailability *) avail {
	
	/* Check all the data */
	if((n == nil) || (a == nil) || (desc == nil) || (url == nil) || (loc == nil) ||
	   (start == nil) || (end == nil) || (avail == nil) || 
	   (length < 0) || (price < 0) || ([start earlierDate: end] == end)) {
		return nil;
	}
	
	self = [super init];
	
	if (self != nil) {
		[self setEventName: n];
		[self setArtist: a];
		[self setDescription: desc];
		[self setWebsite: url];
		[self setLocation: loc];
		[self setStartDate: start];
		[self setEndDate: end];
		[self setDuration: length];
		[self setCost: price];
		[self setAvailability: avail];
		
		return self;
	}
	
	return nil;
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

-(void) setArtist: (EventArtist *) str {
	artist = str;
}

-(EventArtist *)getArtist {
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

-(void)setLocation: (EventLocation *) loc {
	location = loc;
}

-(EventLocation *)getLocation {
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

-(void)setAvailability: (EventAvailability *) avail {
	availability = avail;
}

-(EventAvailability *)getAvailability {
	return availability;
}

/* End Getters and Setters */

/* Helper Methods */

/* End Helper Methods */

/* Filter Methods */

/* Returns true if the event's name begins with the given name false otherwise */
-(bool)NameFilter: (NSString *) str {
	if(str != nil && name != nil) {
		NSString * temp = [name uppercaseString];
		str = [str uppercaseString];
		return [temp hasPrefix: str];
	}
	return false;
}

/* Returns true if the event's artist begins with the given artist false otherwise */
-(bool)ArtistFilter: (NSString *) str {
	if(str != nil && artist != nil) {
		NSString * temp = [[artist getName] uppercaseString];
		str = [str uppercaseString];
		return [temp hasPrefix: str];
	}
	return false;
}

/* Returns true if the time of this event occurs between the given start and end times */
-(bool)TimeFilterStart: (NSDate *) start andEnd: (NSDate *) end {
	/* If the endDate is before the start threshold or the startDate is after the end threshold
	   return false otherwise return true */
	if(([endDate earlierDate: start] == endDate) || ([startDate earlierDate: end] == end)) {
		return false;
	}
	return true;
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
-(bool)LocationFilterLoc: (EventLocation *) loc andRadius: (double) rad {
	double distance = [location distanceFromLocation: loc];
	double radInMeters = rad * MILESTOMETERS;
	return (distance <= radInMeters);
}

-(bool)AvailabilityFilter: (NSString *) day Time: (int) time {
	if([availability containsDay: day] == true) {
		return ([availability availableDuring: time]);
	}
	return false;
}

/* End Filter Methods */
@end

