//
//  Filter.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Filter.h"

@implementation Filter

+(NSString *)getFilterTypeString: (FilterType) t {
	switch(t) {
		case NameFilterType:
			return @"Name Filter";
			break;
		case ArtistFilterType:
			return @"Artist Filter";
			break;
		case TimeFilterType:
			return @"Time Filter";
			break;
		case CostFilterType:
			return @"Cost Filter";
			break;
		case DurationFilterType:
			return @"Duration Filter";
			break;
		case LocationFilterType:
			return @"Location Filter";
			break;
		case AvailabilityFilterType:
			return @"Availability Filter";
			break;
		default:
			return @"Invalid Filter";
			break;
	}
}

-(Filter *)initializeFilterWithType: (FilterType) t andFilterer: (Filterer *) f {
	self = [super init];
	
	if(self != nil) {
		[self setFilterType: t];
		if([self setFilterer: f]) {
			return self;
		}
		
		[self dealloc];
	
	}
	
	return nil;
}

/*Builds the specified filter if the data is valid */

-(Filter *)initializeNameFilter: (NSString *)name {	
	self = [super init];
	
	if(self != nil) {		
		if([self checkNameFilterer: name] == YES) {
			[self setFilterType: NameFilterType];
		
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->name = name;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initializeArtistFilter: (NSString *) artist {
	self = [super init];
	
	if(self != nil) {
		if([self checkArtistFilterer: artist] == YES) {
			[self setFilterType: ArtistFilterType];
		
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->artist = artist;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)iniitializeTimeFilterStart: (NSDate *) start End: (NSDate *) end {
	self = [super init];
	
	if(self != nil) {
		if([self checkTimeFiltererStart: start End: end] == YES) {
			[self setFilterType: TimeFilterType];
		
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->start = start;
				filterer->end = end;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initializeCostFilterMin: (double) min Max: (double) max {
	self = [super init];
	
	if(self != nil) {
		if([self checkCostFiltererMin: min Max: max] == YES) {
			[self setFilterType: CostFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->minCost = min;
				filterer->maxCost = max;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initializeDurationFilterMin: (int) min Max: (int) max {
	self = [super init]; 
	
	if(self != nil) {
		if([self checkDurationFiltererMin: min Max: max] == YES) {
			[self setFilterType: DurationFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->minDuration = min;
				filterer->maxDuration = max;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initializeLocationFilter: (EventLocation *) loc Radius: (double) rad {
	self = [super init];
	
	if(self != nil) {
		if([self checkLocationFilterer: loc Radius: rad] == YES) {
			[self setFilterType: LocationFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->loc = loc;
				filterer->radius = rad;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initializeAvailabilityFilter:(EventAvailability *) avail {
	self = [super init];
	
	if(self != nil) {
		if([self checkAvailabilityFilterer: avail] == YES) {
			[self setFilterType: AvailabilityFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->availability = avail;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}
		   
-(BOOL)checkFilterer: (Filterer *) f {
	
	if(f == nil) {
		return NO;
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
		case AvailabilityFilterType:
			return [self checkAvailabilityFilterer: f->availability];
			break;
		default:
			return NO;
			break;
	}
	
	return NO;
}

-(BOOL)checkNameFilterer: (NSString *) name {
	return (name != nil);
}

-(BOOL)checkArtistFilterer: (NSString *) artist {
	return (artist != nil);
}

-(BOOL)checkTimeFiltererStart: (NSDate *) start End: (NSDate *) end {
	if((start != nil) && (end != nil)) {
		/* Check if the start is before the end date */
		return ([start earlierDate: end] == start);
	}
	return NO;
}

-(BOOL)checkCostFiltererMin: (double) min Max: (double) max {
	/* Check to see if the max is greater than or equal to the min and that the min is 
	   greater than or equal to 0 */
	return ((min <= max) && (min >= 0));
}

-(BOOL)checkDurationFiltererMin: (int) min Max: (int) max {
	/* Check to see if the max is greater than or equal to the min and that the min is 
	   greater than or equal to 0 */
	return ((min <= max) && (min >= 0));
}

-(BOOL)checkLocationFilterer: (EventLocation *) loc Radius: (double) rad {
	/* Check to see if the location is set and the radius is not negative */
	if(loc != nil) {
		CLLocationCoordinate2D coord = [loc getCoordinates];
		/* Check to make sure the lat lon is within the bounds */
		if((coord.latitude >= MINLAT) && (coord.latitude <= MAXLAT) && 
		   (coord.longitude >= MINLON) && (coord.longitude <= MAXLON)) {
			return (rad >= 0);
		}
	}
	
	return NO;
}

-(BOOL)checkAvailabilityFilterer:(EventAvailability *)avail {
	NSString *temp;
	
	for(id day in [avail getDays])
	{
		temp = (NSString *)day;
		temp = [temp uppercaseString];
		
		if([self checkDayString: temp] == NO) {
			return NO;
		}
	}
	
	if([avail getStartTime] <= [avail getEndTime]) {	
		return YES;
	}
	
	return NO;
}

-(BOOL)checkDayString: (NSString *) str {
	
	if(([str compare: @"SUNDAY"]) || ([str compare: @"MONDAY"]) || ([str compare: @"TUESDAY"]) ||
	   ([str compare: @"WEDNESDAY"]) ||  ([str compare: @"THURSDAY"]) || 
	   ([str compare: @"FRIDAY"]) || ([str compare: @"SATURDAY"])) {
		return YES;
	}
	
	return NO;
}


-(void)setFilterType: (FilterType) t {
	type = t;
}

-(FilterType)getFilterType {
	return type;
}

-(BOOL)setFilterer: (Filterer *) f {
	if([self checkFilterer: f]) {
		filterer = f;
		return YES;
	}
	return NO;
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

-(EventAvailability *)getFiltererAvailability {
	return filterer->availability;
}

-(NSString *)getTypeName {
	switch(type) {
		case NameFilterType:
			return @"Name Filter";
			break;
		case ArtistFilterType:
			return @"Artist Filter";
			break;
		case TimeFilterType:
			return @"Time Filter";
			break;
		case CostFilterType:
			return @"Cost Filter";
			break;
		case DurationFilterType:
			return @"Duration Filter";
			break;
		case LocationFilterType:
			return @"Location Filter";
			break;
		case AvailabilityFilterType:
			return @"Availability Filter";
			break;
		default:
			return @"Invalid Filter";
			break;
	}
}

@end
