//
//  Filterer.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/16/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/******************************************************
 * Filterer Class
 *
 * Holds all the values for a the various filterer types:
 * query (Search), name (Name), artist (Artist), start (Time),
 * end (Time), minCost (Cost), maxCost (Cost),
 * minDuration (Duration), maxDuration (Duration),
 * location (Location), radius (Location), day (Availability), 
 * startTime (Availability), and endTime (availability)
 *
 *******************************************************/

#import <Foundation/Foundation.h>
#import "EventDate.h"
#import "EventLocation.h"

@interface Filterer : NSObject {
	NSString				*query;				/* Search Filter */
	NSString				*name;				/* Name Filter */
	NSString				*artist;			/* Artist Filter */
	EventDate				*start;				/* Time Filter */
	EventDate				*end;				/* Time Filter */
	double					minCost;			/* Cost Filter */
	double					maxCost;			/* Cost Filter */
	int						minDuration;		/* Duration Filter */
	int						maxDuration;		/* Duration Filter */
	EventLocation			*loc;				/* Location Filter */
	double					radius;				/* Location Filter */
	NSString				*day;				/* Availability Filter */
	int 					startTime;			/* Availability Filter */
	int						endTime;			/* Availability Filter */
	NSAutoreleasePool		*pool;
}

-(Filterer *)initEmptyFilterer;

@property(nonatomic, retain)NSString *query;
@property(nonatomic, retain)NSString *name;
@property(nonatomic, retain)NSString *artist;
@property(nonatomic, retain)EventDate *start;
@property(nonatomic, retain)EventDate *end;
@property(nonatomic)double minCost;
@property(nonatomic)double maxCost;
@property(nonatomic)int minDuration;
@property(nonatomic)int maxDuration;
@property(nonatomic, retain)EventLocation *loc;
@property(nonatomic)double radius;
@property(nonatomic, retain)NSString *day;
@property(nonatomic)int startTime;
@property(nonatomic)int endTime;

@end
