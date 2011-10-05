//
//  Filter.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/* All the different valid filter types */
typedef enum FilterType {
	NameFilterType, 
	ArtistFilterType, 
	TimeFilterType, 
	CostFilterType,
	DurationFilterType,
	LocationFilterType} FilterType;

typedef struct Filterer {
	NSString		*name;			/* Name Filter */
	NSString		*artist;		/* Artist Filter */
	NSDate			*start;			/* Time Filter */
	NSDate			*end;			/* Time Filter */
	double			minCost;		/* Cost Filter */
	double			maxCost;		/* Cost Filter */
	int				minDuration;	/* Duration Filter */
	int				maxDuration;	/* Duration Filter */
	CLLocation		*loc;			/* Location Filter */
	double			radius;			/* Location Filter */
} Filterer;

@interface Filter : NSObject {
	FilterType		type;
	Filterer		*filterer;
}

/* Initializers */

/* Attempts to build a filter if the filter structure does not match the filter type no filter 
   is created and NULL is returned */
-(Filter *)initializeFilterWithType: (FilterType) t andFilterer: (Filterer *) f;

/*Builds the specified filter if the data is valid */
-(Filter *)initializeNameFilter: (NSString *)name;
-(Filter *)initializeArtistFilter: (NSString *) artist;
-(Filter *)iniitializeTimeFilterStart: (NSDate *) start End: (NSDate *) end;
-(Filter *)initializeCostFilterMin: (double) min Max: (double) max;
-(Filter *)initializeDurationFilterMin: (int) min Max: (int) max;
-(Filter *)initializeLocationFilter: (CLLocation *) loc Radius: (double) rad;

/* Filterer Checkers */
-(bool)checkFilterer: (Filterer *) f;
-(bool)checkNameFilterer: (NSString *) name;
-(bool)checkArtistFilterer: (NSString *) artist;
-(bool)checkTimeFiltererStart: (NSDate *) start End: (NSDate *) end;
-(bool)checkCostFiltererMin: (double) min Max: (double) max;
-(bool)checkDurationFiltererMin: (int) min Max: (int) max;
-(bool)checkLocationFilterer: (CLLocation *) loc Radius: (double) radius;

/* Getters and Setters */
-(void)setFilterType: (FilterType) t;
-(FilterType)getFilterType;

-(bool)setFilterer: (Filterer *) f;
-(Filterer *)getFilterer;

-(NSString *)getFiltererName;
-(NSString *)getFiltererArtist;
-(NSDate *)getFiltererStartTime;
-(NSDate *)getFiltererEndTime;
-(double)getFiltererMinCost;
-(double)getFiltererMaxCost;
-(int)getFiltererMinDuration;
-(int)getFiltererMaxDuration;
-(CLLocation *)getFiltererLocation;
-(double)getFiltererRadius;

@end