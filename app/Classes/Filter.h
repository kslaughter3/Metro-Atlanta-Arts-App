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
	NSString		*name;		/* Name Filter */
	NSString		*artist;	/* Artist Filter */
	NSDate			*start;		/* Time Filter */
	NSDate			*end;		/* Time Filter */
	double			minCost;	/* Cost Filter */
	double			maxCost;	/* Cost Filter */
	int				minLength;	/* Duration Filter */
	int				maxLength;	/* Duration Filter */
	CLLocation		*loc;		/* Location Filter */
	double			radius;		/* Location Filter */
} Filterer;

@interface Filter : NSObject {
	FilterType		type;
	Filterer		*filterer;
}

/* Initializers */

/* Attempts to build a filter if the filter structure does not match the filter type no filter 
   is created and NULL is returned */
-(Filter *)initializeFilterWithType: (FilterType) t andFilterer: (Filterer *) f;

/* Filterer Checkers */
-(bool)checkFilterer: (Filterer *) f;
-(bool)checkNameFilterer: (Filterer *) f;
-(bool)checkArtistFilterer: (Filterer *) f;
-(bool)checkTimeFilterer: (Filterer *) f;
-(bool)checkCostFilterer: (Filterer *) f;
-(bool)checkDurationFilterer: (Filterer *) f;
-(bool)checkLocationFilterer: (Filterer *) f;

/* Getters and Setters */
-(void)setFilterType: (FilterType) t;
-(FilterType)getFilterType;

-(bool)setFilterer: (Filterer *) f;
-(Filterer *)getFilterer;

@end
