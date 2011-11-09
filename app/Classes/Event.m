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

/*Test Initialize Method*/
-(Event *)initTestEvent: (NSString *) n Description: (NSString *) desc{
	self = [super init];
	[self setEventName: n];
	[self setDescription: desc];
	return self;
}


/* Initialize Method */
-(Event *)initEmptyEvent {
	self = [super init];
	
	if(self != nil) {
		return self;
	}
	
	return nil;
}

-(Event *)initWithEvent:(Event *)event {
	self = [super init];
	
	if (self != nil) {
		name = [[NSString alloc] initWithString: [event getEventName]];
		artist = [[EventArtist alloc] initWithArtist: [event getArtist]];
		description = [[NSString alloc] initWithString: [event getDescription]];
		imageURL = [[NSString alloc] initWithString: [event getImageURL]];
		website = [[NSString alloc] initWithString: [event getWebsite]];
		location = [[EventLocation alloc] initWithLocation: [event getLocation]];
		startDate = [[EventDate alloc] initWithDate: [event getStartDate]];
		endDate = [[EventDate alloc] initWithDate: [event getEndDate]];
		duration = [event getDuration];
		cost = [event getCost];
		availability = [[EventAvailability alloc] initWithAvailability: [event getAvailability]];
		return self;
	}
	
	return nil;
}

-(Event *)initEventWithName: (NSString *) n Artist: (EventArtist *) a Description: (NSString *) desc
					Website: (NSString *) url Location: (EventLocation *) loc Start: (EventDate *) start 
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
		name = [[NSString alloc] initWithString: n];
		artist = [[EventArtist alloc] initWithArtist: a];
		description = [[NSString alloc] initWithString: desc];
		website = [[NSString alloc] initWithString: url];
		location = [[EventLocation alloc] initWithLocation: loc];
		startDate = [[EventDate alloc] initWithDate: start];
		endDate = [[EventDate alloc] initWithDate: end];
		duration = length;
		cost = price;
		availability = [[EventAvailability alloc] initWithAvailability: avail];
		
		return self;
	}
	
	return nil;
}		

-(Event *)initEventWithName: (NSString *) n Artist: (EventArtist *) a Description: (NSString *) desc
				   ImageURL: (NSString *) iURL Website: (NSString *) url Location: (EventLocation *) loc 
				   Start: (EventDate *) start End: (EventDate *) end Duration: (int) length Cost: (double) price 
				   Availability: (EventAvailability *) avail {
	
	/* Check all the data */
	if((n == nil) || (a == nil) || (desc == nil) || (url == nil) || (loc == nil) ||
	   (start == nil) || (end == nil) || (avail == nil) || 
	   (length < 0) || (price < 0) || ([start earlierDate: end] == NO)) {
		return nil;
	}
	
	self = [super init];
	
	if (self != nil) {
		name = [[NSString alloc] initWithString: n];
		artist = [[EventArtist alloc] initWithArtist: a];
		description = [[NSString alloc] initWithString: desc];
		imageURL = [[NSString alloc] initWithString: iURL];
		website = [[NSString alloc] initWithString: url];
		location = [[EventLocation alloc] initWithLocation: loc];
		startDate = [[EventDate alloc] initWithDate: start];
		endDate = [[EventDate alloc] initWithDate: end];
		duration = length;
		cost = price;
		availability = [[EventAvailability alloc] initWithAvailability: avail];
		
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

-(void) setWebsite: (NSString *) url {
	website = url;
}

-(NSString *)getWebsite {
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

-(void)setImageURL:(NSString *)url {
	imageURL = url;
}

-(NSString *)getImageURL {
	return imageURL;
}

-(BOOL)isEqual:(id)object {
	Event *other = (Event *)object;
	
	if(((name == nil) && ([other getEventName] != nil)) || ((name != nil) && ([other getEventName] == nil))) {
		return NO;
	}
	if((name != nil) && ([name isEqualToString: [other getEventName]] == NO)) {
		return NO;
	}
	
	if(((artist == nil) && ([other getArtist] != nil)) || ((artist != nil) && ([other getArtist] == nil))) {
		return NO;
	}
	if((artist != nil) && ([artist isEqual: [other getArtist]] == NO)) {
		return NO;
	}
	
	if(((description == nil) && ([other getDescription] != nil)) || ((description != nil) && ([other getDescription] == nil))) {
		return NO;
	}
	if((description != nil) && ([description isEqualToString: [other getDescription]] == NO)) {
		return NO;
	}
	
	if(((website == nil) && ([other getWebsite] != nil)) || ((website != nil) && ([other getWebsite] == nil))) {
		return NO;
	}
	if((website != nil) && ([website isEqualToString: [other getWebsite]] == NO)) {
		return NO;
	}
	
	if(((location == nil) && ([other getLocation] != nil)) ||  ((location != nil) && ([other getLocation] == nil))) {
		return NO;
	}
	if((location != nil) && ([location isEqual: [other getLocation]] == NO)) {
		return NO;
	}
	
	if(((startDate == nil) && ([other getStartDate] != nil)) || ((startDate != nil) && ([other getStartDate] == nil))) {
		return NO;
	}
	if((startDate != nil) && ([startDate isEqual: [other getStartDate]] == NO)) {
		return NO;
	}
	
	if(((endDate == nil) && ([other getEndDate] != nil)) || ((endDate != nil) && ([other getEndDate] == nil))) {
		return NO;
	}
	if((endDate != nil) && ([endDate isEqual: [other getEndDate]] == NO)) {
		return NO;
	}
	
	if(duration != [other getDuration]) {
		return NO;
	}
	
	if(cost != [other getCost]) {
		return NO;
	}
	
	if(((availability == nil) && ([other getAvailability] != nil)) || ((availability != nil) && ([other getAvailability] == nil))) {
		return NO;
	}
	if((availability != nil) && ([availability isEqual: [other getAvailability]] == NO)) {
		return NO;
	}
	
	if(((imageURL == nil) && ([other getImageURL] != nil)) || ((imageURL != nil) && ([other getImageURL] == nil))) {
		return NO;
	}
	if((imageURL != nil) && ([imageURL isEqualToString: [other getImageURL]] == NO)) {
		return NO;
	}
	
	return YES;
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

