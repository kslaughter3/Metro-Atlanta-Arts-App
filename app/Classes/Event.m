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
		pool = [[NSAutoreleasePool alloc] init];
		return self;
	}
	
	return nil;
}

-(Event *)initWithEvent:(Event *)event {
	self = [super init];
	
	if (self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		name = [[NSString alloc] initWithString: [event getEventName]];
		artists = [[NSMutableArray alloc] initWithArray: [event getArtists]];
		description = [[NSString alloc] initWithString: [event getDescription]];
		imageURL = [[NSString alloc] initWithString: [event getImageURL]];
		website = [[NSString alloc] initWithString: [event getWebsite]];
		location = [[EventLocation alloc] initWithLocation: [event getLocation]];
		startDate = [[EventDate alloc] initWithDate: [event getStartDate]];
		endDate = [[EventDate alloc] initWithDate: [event getEndDate]];
		duration = [event getDuration];
		minCost = [event getMinCost];
		availability = [[EventAvailability alloc] initWithAvailability: [event getAvailability]];
		return self;
	}
	
	return nil;
}
 
-(BOOL)isEventIDEqual:(Event *)other {
	return (eventID == [other getEventID]);
}

-(void)parseType:(NSString *)t {
	if([t isEqualToString: @EVENTTYPETWO]) {
		type = EventTypeTwo;
	}
	else if([t isEqualToString: @EVENTTYPETHREE]) {
		type = EventTypeThree;
	}
	else if([t isEqualToString: @EVENTTYPEFOUR]) {
		type = EventTypeFour;
	}
	else if([t isEqualToString: @EVENTTYPEFIVE]) {
		type = EventTypeFive;
	}
	else if([t isEqualToString: @EVENTTYPESIX]) {
		type = EventTypeSix;
	}
	else {
		type = EventTypeAll;
	}
}

-(void)parseDate:(NSString *)date Time:(NSString *)time Start:(BOOL)start {
	if(start) {
		[startDate setDate: date];
		[startDate setTime: time];
	}
	else {
		[endDate setDate: date];
		[endDate setTime: time];
	}
}


/*Getters and Setters */

-(void)setEventID:(int)num {
	eventID = num;
}

-(int)getEventID	{
	return eventID;
}

-(void)setEventType:(EventType)t {
	type = t;
}

-(EventType)getEventType {
	return type;
}

-(void) setEventName: (NSString *) str {
	name = str;
}

-(NSString *)getEventName {
	return name;
}

-(void) addArtist: (EventArtist *) str {
	if(artists == nil) {
		artists = [[NSMutableArray alloc] init];
	}
	
	if([artists containsObject: str] == NO) {
		[artists addObject: str];
	}
}

-(EventArtist *)getArtistAtIndex: (int)index {
	if(artists == nil) {
		artists = [[NSMutableArray alloc] init];
	}
	
	if(index < 0 || index >= [artists count]) {
		return nil;
	}
	
	return [artists objectAtIndex: index] ;
}

-(void)setArtists:(NSMutableArray *)arts {
	artists = arts;
}

-(NSMutableArray *)getArtists {
	return artists;
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

-(void) setMinCost: (double) price {
	//Keep the order correct
	if(price > maxCost) {
		minCost = maxCost;
		maxCost = price;
		return;
	}
	minCost = price;
}

-(double)getMinCost {
	return minCost;
}

-(void) setMaxCost:(double)price {
	//Keep the order correct
	if(price < minCost) {
		maxCost = minCost;
		minCost = price;
		return;
	}
	maxCost = price;
}
	
-(double)getMaxCost {
	return maxCost;
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
	
	if(eventID != [other getEventID]) {
		return NO;
	}
	
	if(((name == nil) && ([other getEventName] != nil)) || ((name != nil) && ([other getEventName] == nil))) {
		return NO;
	}
	if((name != nil) && ([name isEqualToString: [other getEventName]] == NO)) {
		return NO;
	}
	
	if(((artists == nil) && ([other getArtists] != nil)) || ((artists != nil) && ([other getArtists] == nil))) {
		return NO;
	}
	if((artists != nil) && ([artists isEqual: [other getArtists]] == NO)) {
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
	
	if(minCost != [other getMinCost]) {
		return NO;
	}
	if(maxCost != [other getMaxCost]) {
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

-(void)dealloc {
	[name release];
	[artists release];
	[description release];
	[website release];
	[location release];
	[startDate release];
	[endDate release];
	[availability release];
	[imageURL release];
	[pool release];
	[super dealloc];
}

@end

