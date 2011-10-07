//
// Event.h
// Metro-Atlanta-Arts-App
//
// Created by Gendreau, Anthony S on 9/28/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventArtist.h"
#import "EventAvailability.h"
#import "EventLocation.h"

#define MILESTOMETERS 1609

@interface Event : NSObject {
	NSString *name;						/* Name of the Event */
	EventArtist *artist;				/* Name of the Artist (where applicable) */
	NSString *description;				/* Description of Event */
	NSURL *website;						/* Website URL */
	EventLocation *location;			/* The location of Event (both street and lat/lon */
	NSDate *startDate;					/* Start Date and Time */
	NSDate *endDate;					/* End Date and Time */
	int duration;						/* Duration of the Event (in minutes)*/
	double cost;						/* Cost of the Event */
	EventAvailability *availability;	/* The availability of the event */
}

/* Initializer */
-(Event *)initEventWithName: (NSString *) n Artist: (EventArtist *) a Description: (NSString *) desc
					Website: (NSURL *) url Location: (EventLocation *) loc Start: (NSDate *) start End: (NSDate *) end
				   Duration: (int) length Cost: (double) price Availability: (EventAvailability *) avail;

/* I don't know if this makes sense but I wrote it anyway */
-(void)print;

/* Getters and Setters */

-(void)setEventName: (NSString *) str;
-(NSString *)getEventName;

-(void)setArtist: (EventArtist *) art;
-(EventArtist *)getArtist;

-(void)setDescription: (NSString *) str;
-(NSString *)getDescription;

-(void)setWebsite: (NSURL *) url;
-(NSURL *)getWebsite;

-(void)setLocation: (EventLocation *) loc;
-(EventLocation * )getLocation;

-(void)setStartDate: (NSDate *) date;
-(NSDate *)getStartDate;

-(void)setEndDate: (NSDate *) date;
-(NSDate *)getEndDate;

-(void)setDuration: (int) length;
-(int)getDuration;

-(void)setCost: (double) price;
-(double)getCost;

-(void)setAvailability: (EventAvailability *) avail;
-(EventAvailability *)getAvailability;

/* End Getters and Setters */

/* Helper Methods */

/* End Helper Methods */

/* Filter Methods */

/* Returns true if the event's name begins with the given name false otherwise */
-(bool)NameFilter: (NSString *) str;

/* Returns true if the event's artist begins with the given artist false otherwise */
-(bool)ArtistFilter: (NSString *) str;

/* Returns true if the time of this event occurs between the given start and end times */
-(bool)TimeFilterStart: (NSDate *) start andEnd: (NSDate *) end;

/* Returns true if the cost of this event is between the given min and max costs */
-(bool)CostFilterMin: (double) min andMax: (double) max;

/* Returns true if the duration of this event is between the given min and max durations */
-(bool)DurationFilterMin:(int)min andMax:(int)max;

/* Returns true if the location of this event is within the given radius (in miles)
   of the given Location */
-(bool)LocationFilterLoc: (EventLocation *) loc andRadius: (double) rad;

/* Takes a day of the week and a time (24 hr format) and returns whether this event 
   is available at the day and time */
-(bool)AvailabilityFilter: (NSString *) day Time: (int) time;

/* End Filter Methods */

@end

