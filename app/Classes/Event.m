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
					Website: (NSURL *) url Location: (EventLocation *) loc Start: (EventDate *) start 
					End: (EventDate *) end Duration: (int) length Cost: (double) price 
					Availability: (EventAvailability *) avail {
	
	/* Check all the data */
	if((n == nil) || (a == nil) || (desc == nil) || (url == nil) || (loc == nil) ||
	   (start == nil) || (end == nil) || (avail == nil) || 
	   (length < 0) || (price < 0) || ([start earlierDate: end] == NO)) {
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

-(void) setStartDate: (EventDate *) date {
	startDate = date;
}

-(EventDate *)getStartDate {
	return startDate;
}

-(void) setEndDate: (EventDate *) date {
	endDate = date;
}

-(EventDate *)getEndDate {
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

/* Returns YES if the event's name begins with the given name NO otherwise */
-(BOOL)NameFilter: (NSString *) str {
	if(str != nil && name != nil) {
		NSString * temp = [name uppercaseString];
		str = [str uppercaseString];
		if([temp hasPrefix: str]) {
			return YES;
		}
	}
	return NO;
}

/* Returns YES if the event's artist begins with the given artist NO otherwise */
-(BOOL)ArtistFilter: (NSString *) str {
	if(str != nil && artist != nil) {
		NSString * temp = [[artist getName] uppercaseString];
		str = [str uppercaseString];
		if([temp hasPrefix: str]) {
			return YES;
		}
	}
	return NO;
}

/* Returns YES if the time of this event occurs between the given start and end times */
-(BOOL)TimeFilterStart: (EventDate *) start andEnd: (EventDate *) end {
	/* If the endDate is before the start threshold or the startDate is after the end threshold
	   return NO otherwise return YES */
	if(([start earlierDate: endDate] == NO) || ([startDate earlierDate: end] == NO)) {
		return NO;
	}
	return YES;
}

/* Returns YES if the cost of this event is between the given min and max costs */
-(BOOL)CostFilterMin: (double) min andMax: (double) max {
	if((cost >= min) && (cost <= max)) {
		return YES;
	}
	return NO;
}

/* Returns YES if the duration of this event is between the given min and max durations */
-(BOOL)DurationFilterMin: (int) min andMax: (int) max {
	if((duration >= min) && (duration <= max)) {
		return YES;
	}
	return NO;
}

/*Returns YES if the location of this event is within the given radius of the given Location */
-(BOOL)LocationFilterLoc: (EventLocation *) loc andRadius: (double) rad {
	double distance = [location distanceFromLocation: loc];
	double radInMeters = rad * MILESTOMETERS;
	if(distance <= radInMeters) {
		return YES;
	}
	return NO; 
}

-(BOOL)AvailabilityFilter: (NSString *) day Time: (int) time {
	if([availability containsDay: day] == YES) {
		return ([availability availableDuring: time]);
	}
	return NO;
}

/* End Filter Methods */
@end

