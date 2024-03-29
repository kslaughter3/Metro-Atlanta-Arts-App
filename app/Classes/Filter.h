//
//  Filter.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 9/30/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/*******************************************************
 * Filter Class
 *
 * Holds all the information to define a filter: the type,
 * the filterer values, and enabled/disabled
 *
 *******************************************************/

#import <Foundation/Foundation.h>
#import "EventLocation.h"
#import "EventDate.h"
#import "EventAvailability.h"
#import "Filterer.h"

#define SEARCHSTRING			"Search Filter"
#define NAMESTRING				"Name Filter"
#define ARTISTSTRING			"Artist Filter"
#define TIMESTRING				"Time Filter"
#define COSTSTRING				"Cost Filter"
#define DURATIONSTRING			"Duration Filter"
#define LOCATIONSTRING			"Location Filter"
#define AVAILABILITYSTRING		"Availability Filter"
#define INVALIDSTRING			"Invalid Filter"


/* All the different valid filter types */
typedef enum FilterType {
	InvalidFilterType = -1,
	SearchFilterType,
	FirstFilterType = SearchFilterType,
	NameFilterType,
	ArtistFilterType, 
	TimeFilterType, 
	CostFilterType,
	DurationFilterType,
	LocationFilterType,
	AvailabilityFilterType,
	LastFilterType = AvailabilityFilterType
} FilterType;

@interface Filter : NSObject {
	FilterType		type;
	Filterer		*filterer;
	BOOL			isEnabled;
	NSAutoreleasePool *pool;
}

+(NSString *)getFilterTypeString: (FilterType) t;
+(FilterType)getFilterTypeFromString: (NSString *) str;
+(NSString *)buildFilterString: (Filter *)filter;

/* Initializers */

-(Filter *)initEmptyFilter;
-(Filter *)initWithFilter: (Filter *)filter;

/*Builds the specified filter if the data is valid */
-(Filter *)initSearchFilter: (NSString *)query;
-(Filter *)initNameFilter: (NSString *)name;
-(Filter *)initArtistFilter: (NSString *) artist;
-(Filter *)initTimeFilterStart: (EventDate *) start End: (EventDate *) end;
-(Filter *)initCostFilterMin: (double) min Max: (double) max;
-(Filter *)initDurationFilterMin: (int) min Max: (int) max;
-(Filter *)initLocationFilter: (EventLocation *) loc Radius: (double) rad;
-(Filter *)initAvailabilityFilter: (NSString *) d Start: (int) start End: (int) end;

/* Filterer Checkers */
-(BOOL)checkFilterer: (Filterer *) f;
-(BOOL)checkSearchFilterer: (NSString *)query;
-(BOOL)checkNameFilterer: (NSString *) name;
-(BOOL)checkArtistFilterer: (NSString *) artist;
-(BOOL)checkTimeFiltererStart: (EventDate *) start End: (EventDate *) end;
-(BOOL)checkCostFiltererMin: (double) min Max: (double) max;
-(BOOL)checkDurationFiltererMin: (int) min Max: (int) max;
-(BOOL)checkLocationFilterer: (EventLocation *) loc Radius: (double) radius;
-(BOOL)checkAvailabilityFilterer: (NSString *)day Start: (int) start End: (int) end;

-(BOOL)checkDayString: (NSString *) str;

/* Getters and Setters */
-(void)setFilterType: (FilterType) t;
-(FilterType)getFilterType;

-(void)setFilterer: (Filterer *) f;
-(Filterer *)getFilterer;

-(void)setEnabled: (BOOL) enabled;
-(BOOL)isEnabled;

-(NSString *)getFiltererQuery;
-(NSString *)getFiltererName;
-(NSString *)getFiltererArtist;
-(EventDate *)getFiltererStartTime;
-(EventDate *)getFiltererEndTime;
-(double)getFiltererMinCost;
-(double)getFiltererMaxCost;
-(int)getFiltererMinDuration;
-(int)getFiltererMaxDuration;
-(EventLocation *)getFiltererLocation;
-(double)getFiltererRadius;
-(NSString *)getFiltererAvailabilityDay;
-(int)getFiltererAvailabilityStartTime;
-(int)getFiltererAvailabilityEndTime;
-(NSString *)getTypeName;
-(BOOL)isFiltererEqual: (Filterer *)other;

//toString methods for the filters
-(NSString *)searchString;
-(NSString *)nameString;
-(NSString *)artistString;
-(NSString *)timeString;
-(NSString *)costString;
-(NSString *)durationString;
-(NSString *)locationString;
-(NSString *)availabilityString;

-(void)copyFilterer: (Filterer *) f;

@end
