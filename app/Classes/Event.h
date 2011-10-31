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
#import "EventDate.h"

@interface Event : NSObject {
	NSString *name;						/* Name of the Event */
	EventArtist *artist;				/* Name of the Artist (where applicable) */
	NSString *description;				/* Description of Event */
	NSURL *website;						/* Website URL */
	EventLocation *location;			/* The location of Event (both street and lat/lon */
	EventDate *startDate;				/* Start Date and Time */
	EventDate *endDate;					/* End Date and Time */
	int duration;						/* Duration of the Event (in minutes)*/
	double cost;						/* Cost of the Event */
	EventAvailability *availability;	/* The availability of the event */
}

-(Event *)initTestEvent:(NSString *)n Description:(NSString *)desc;

/* Initializer */
-(Event *)initEmptyEvent;

-(Event *)initWithEvent: (Event *)event;

-(Event *)initEventWithName: (NSString *) n Artist: (EventArtist *) a Description: (NSString *) desc
					Website: (NSURL *) url Location: (EventLocation *) loc Start: (EventDate *) start End: (EventDate *) end
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

-(void)setStartDate: (EventDate *) date;
-(EventDate *)getStartDate;

-(void)setEndDate: (EventDate *) date;
-(EventDate *)getEndDate;

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

/* Returns YES if the event's name begins with the given name NO otherwise */
-(BOOL)NameFilter: (NSString *) str;

/* Returns YES if the event's artist begins with the given artist NO otherwise */
-(BOOL)ArtistFilter: (NSString *) str;

/* Returns YES if the time of this event occurs between the given start and end times */
-(BOOL)TimeFilterStart: (EventDate *) start andEnd: (EventDate *) end;

/* Returns YES if the cost of this event is between the given min and max costs */
-(BOOL)CostFilterMin: (double) min andMax: (double) max;

/* Returns YES if the duration of this event is between the given min and max durations */
-(BOOL)DurationFilterMin:(int)min andMax:(int)max;

/* Returns YES if the location of this event is within the given radius (in miles)
   of the given Location */
-(BOOL)LocationFilterLoc: (EventLocation *) loc andRadius: (double) rad;

/* Takes a day of the week and a time (24 hr format) and returns whether this event 
   is available at the day and time */
-(BOOL)AvailabilityFilter: (NSString *) day Time: (int) time;

/* End Filter Methods */

@end