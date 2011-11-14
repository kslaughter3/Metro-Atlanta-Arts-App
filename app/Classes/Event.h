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
	int eventID;								/* Events unique id */
	NSString *name;						/* Name of the Event */
	NSMutableArray *artists;			/* List of EventArtists for this event */
	NSString *description;				/* Description of Event */
	NSString *website;					/* Website URL */
	EventLocation *location;			/* The location of Event (both street and lat/lon */
	EventDate *startDate;				/* Start Date and Time */
	EventDate *endDate;					/* End Date and Time */
	int duration;						/* Duration of the Event (in minutes)*/
	double minCost;						/* Min Cost of the Event */
	double maxCost;						/* Max Cost of the Event */
	EventAvailability *availability;	/* The availability of the event */
	NSString *imageURL;
}

-(Event *)initTestEvent:(NSString *)n Description:(NSString *)desc;

/* Initializer */
-(Event *)initEmptyEvent;

-(Event *)initWithEvent: (Event *)event;

-(Event *)initEventWithName: (NSString *) n Artist: (EventArtist *) a Description: (NSString *) desc
					Website: (NSString *) url Location: (EventLocation *) loc Start: (EventDate *) start End: (EventDate *) end
				   Duration: (int) length Cost: (double) price Availability: (EventAvailability *) avail;

-(Event *)initEventWithName: (NSString *) n Artist: (EventArtist *) a Description: (NSString *) desc
				   ImageURL: (NSString *) iURL Website: (NSString *) url Location: (EventLocation *) loc 
				   Start: (EventDate *) start End: (EventDate *) end Duration: (int) length 
				   Cost: (double) price Availability: (EventAvailability *) avail;

-(BOOL)isEventIDEqual: (Event *)other;

/* Getters and Setters */

-(void)setEventID:(int)num;
-(int)getEventID;

-(void)setEventName: (NSString *) str;
-(NSString *)getEventName;

-(void)addArtist: (EventArtist *) art;
-(EventArtist *)getArtistAtIndex: (int) index;

-(void)setArtists: (NSMutableArray *)arts;
-(NSMutableArray *)getArtists;

-(void)setDescription: (NSString *) str;
-(NSString *)getDescription;

-(void)setWebsite: (NSString *) url;
-(NSString *)getWebsite;

-(void)setLocation: (EventLocation *) loc;
-(EventLocation * )getLocation;

-(void)setStartDate: (EventDate *) date;
-(EventDate *)getStartDate;

-(void)setEndDate: (EventDate *) date;
-(EventDate *)getEndDate;

-(void)setDuration: (int) length;
-(int)getDuration;

-(void)setMinCost: (double) price;
-(double)getMinCost;

-(void)setMaxCost: (double) price;
-(double)getMaxCost;

-(void)setAvailability: (EventAvailability *) avail;
-(EventAvailability *)getAvailability;

-(void)setImageURL: (NSString *) url;
-(NSString *)getImageURL;

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