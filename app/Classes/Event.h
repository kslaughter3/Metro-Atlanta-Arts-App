//
// Event.h
// Metro-Atlanta-Arts-App
//
// Created by Gendreau, Anthony S on 9/28/11.
// Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/******************************************************
 * Event Class
 *
 * Holds all the information about an event: id, type,
 * name, artists, description, website, location, 
 * start Date, end Date, duration, cost, availability, 
 * and an image 
 *
 ******************************************************/

#import <Foundation/Foundation.h>
#import "EventArtist.h"
#import "EventAvailability.h"
#import "EventLocation.h"
#import "EventDate.h"

//TODO: Change these to sylvie's types
typedef enum EventType {
	EventTypeAll =		0,
	FirstEventType = EventTypeAll,
	EventTypeTwo,
	EventTypeThree,
	EventTypeFour,
	EventTypeFive,
	EventTypeSix,
	LastEventType = EventTypeSix
} EventType;

#define EVENTTYPEALL		"All"
#define EVENTTYPETWO		"Two"
#define EVENTTYPETHREE		"Three"
#define EVENTTYPEFOUR		"Four"
#define EVENTTYPEFIVE		"Five"
#define EVENTTYPESIX		"Six"

@interface Event : NSObject {
	int eventID;						/* Events unique id */
	EventType type;						/* Type of Event */
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

-(BOOL)isEventIDEqual: (Event *)other;

/* Getters and Setters */

-(void)setEventID:(int)num;
-(int)getEventID;

-(void)setEventType:(EventType)t;
-(EventType)getEventType;

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

@end