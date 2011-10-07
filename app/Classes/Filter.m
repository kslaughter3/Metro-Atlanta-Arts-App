//
//  Filter.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Filter.h"
#import <CoreLocation/CoreLocation.h>


@implementation Filter

-(Filter *)initializeFilterWithType: (FilterType) t andFilterer: (Filterer *) f {
	self = [super init];
	
	if(self != NULL) {
		[self setFilterType: t];
		if([self setFilterer: f]) {
			return self;
		}
		
		[self dealloc];
	
	}
	
	return NULL;
}

/*Builds the specified filter if the data is valid */

-(Filter *)initializeNameFilter: (NSString *)name {	
	self = [super init];
	
	if(self != NULL) {		
		if([self checkNameFilterer: name] == true) {
			[self setFilterType: NameFilterType];
		
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != NULL) {
				filterer->name = name;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return NULL;
}

-(Filter *)initializeArtistFilter: (NSString *) artist {
	self = [super init];
	
	if(self != NULL) {
		if([self checkArtistFilterer: artist] == true) {
			[self setFilterType: ArtistFilterType];
		
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != NULL) {
				filterer->artist = artist;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return NULL;
}

-(Filter *)iniitializeTimeFilterStart: (NSDate *) start End: (NSDate *) end {
	self = [super init];
	
	if(self != NULL) {
		if([self checkTimeFiltererStart: start End: end] == true) {
			[self setFilterType: TimeFilterType];
		
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != NULL) {
				filterer->start = start;
				filterer->end = end;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return NULL;
}

-(Filter *)initializeCostFilterMin: (double) min Max: (double) max {
	self = [super init];
	
	if(self != NULL) {
		if([self checkCostFiltererMin: min Max: max] == true) {
			[self setFilterType: CostFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != NULL) {
				filterer->minCost = min;
				filterer->maxCost = max;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return NULL;
}

-(Filter *)initializeDurationFilterMin: (int) min Max: (int) max {
	self = [super init]; 
	
	if(self != NULL) {
		if([self checkDurationFiltererMin: min Max: max] == true) {
			[self setFilterType: DurationFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != NULL) {
				filterer->minDuration = min;
				filterer->maxDuration = max;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return NULL;
}

-(Filter *)initializeLocationFilter: (EventLocation *) loc Radius: (double) rad {
	self = [super init];
	
	if(self != NULL) {
		if([self checkLocationFilterer: loc Radius: rad] == true) {
			[self setFilterType: LocationFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != NULL) {
				filterer->loc = loc;
				filterer->radius = rad;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return NULL;
}
		   
-(bool)checkFilterer: (Filterer *) f {
	
	if(f == NULL) {
		return false;
	}
	
	/* Check to see if the correct union member is specified */ 
	switch ([self getFilterType]) {
		case NameFilterType:
			return [self checkNameFilterer: f->name];
			break;
		case ArtistFilterType:
			return [self checkArtistFilterer: f->artist];
			break;
		case TimeFilterType:
			return [self checkTimeFiltererStart: f->start End: f->end];
			break;
		case CostFilterType:
			return [self checkCostFiltererMin: f->minCost Max: f->maxCost];
			break;
		case DurationFilterType:
			return [self checkDurationFiltererMin: f->minDuration Max: f->maxDuration];
			break;
		case LocationFilterType:
			return [self checkLocationFilterer: f->loc Radius: f->radius];
			break;
		default:
			return false;
			break;
	}
	
	return false;
}

-(bool)checkNameFilterer: (NSString *) name {
	return (name != NULL);
}

-(bool)checkArtistFilterer: (NSString *) artist {
	return (artist != NULL);
}

-(bool)checkTimeFiltererStart: (NSDate *) start End: (NSDate *) end {
	if((start != NULL) && (end != NULL)) {
		/* Check if the start is before the end date */
		return ([start earlierDate: end] == start);
	}
	return false;
}

-(bool)checkCostFiltererMin: (double) min Max: (double) max {
	/* Check to see if the max is greater than or equal to the min and that the min is 
	   greater than or equal to 0 */
	return ((min <= max) && (min >= 0));
}

-(bool)checkDurationFiltererMin: (int) min Max: (int) max {
	/* Check to see if the max is greater than or equal to the min and that the min is 
	   greater than or equal to 0 */
	return ((min <= max) && (min >= 0));
}

-(bool)checkLocationFilterer: (EventLocation *) loc Radius: (double) rad {
	/* Check to see if the location is set and the radius is not negative */
	if(loc != NULL) {
		CLLocationCoordinate2D coord = [loc getCoordinates];
		/* Check to make sure the lat lon is within the bounds */
		if((coord.latitude >= MINLAT) && (coord.latitude <= MAXLAT) && 
		   (coord.longitude >= MINLON) && (coord.longitude <= MAXLON)) {
			return (rad >= 0);
		}
	}
	
	return false;
}

-(void)setFilterType: (FilterType) t {
	type = t;
}

-(FilterType)getFilterType {
	return type;
}

-(bool)setFilterer: (Filterer *) f {
	if([self checkFilterer: f]) {
		filterer = f;
		return true;
	}
	return false;
}

-(Filterer *)getFilterer {
	return filterer;
}

-(NSString *)getFiltererName {
	return filterer->name;
}

-(NSString *)getFiltererArtist {
	return filterer->artist;
}

-(NSDate *)getFiltererStartTime {
	return filterer->start;
}

-(NSDate *)getFiltererEndTime {
	return filterer->end;
}

-(double)getFiltererMinCost {
	return filterer->minCost;
}

-(double)getFiltererMaxCost {
	return filterer->maxCost;
}

-(int)getFiltererMinDuration {
	return filterer->minDuration;
}

-(int)getFiltererMaxDuration {
	return filterer->maxDuration;
}

-(EventLocation *)getFiltererLocation {
	return filterer->loc;
}

-(double)getFiltererRadius {
	return filterer->radius;
}

@end
