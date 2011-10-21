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
			return @NAMESTRING;
			break;
		case ArtistFilterType:
			return @ARTISTSTRING;
			break;
		case TimeFilterType:
			return @TIMESTRING;
			break;
		case CostFilterType:
			return @COSTSTRING;
			break;
		case DurationFilterType:
			return @DURATIONSTRING;
			break;
		case LocationFilterType:
			return @LOCATIONSTRING;
			break;
		case AvailabilityFilterType:
			return @AVAILABILITYSTRING;
			break;
		default:
			return @INVALIDSTRING;
			break;
	}
}

+(FilterType)getFilterTypeFromString: (NSString *) str {
	if([str isEqualToString: @NAMESTRING]) {
		return NameFilterType;
	}
	
	if([str isEqualToString: @ARTISTSTRING]) {
		return ArtistFilterType;
	}
	
	if([str isEqualToString: @TIMESTRING]) {
		return TimeFilterType;
	}
	
	if([str isEqualToString: @COSTSTRING]) {
		return CostFilterType;
	}
	
	if([str isEqualToString: @DURATIONSTRING]) {
		return DurationFilterType;
	}
	
	if([str	isEqualToString: @LOCATIONSTRING]) {
		return LocationFilterType;
	}
	
	if([str isEqualToString: @AVAILABILITYSTRING]) {
		return AvailabilityFilterType;
	}

	return InvalidFilterType;
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

-(Filter *)initializeTimeFilterStart: (EventDate *) start End: (EventDate *) end {
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

-(Filter *)initializeAvailabilityFilter:(NSString *) d Time: (int) t {
	self = [super init];
	
	if(self != nil) {
		if([self checkAvailabilityFilterer: d Time: t] == YES) {
			[self setFilterType: AvailabilityFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->day = d;
				filterer->time = t;
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
			return [self checkAvailabilityFilterer: f->day Time: f->time];
			break;
		default:
			return NO;
			break;
	}
	
	return NO;
}

-(BOOL)checkNameFilterer: (NSString *) name {
	return ((name != nil) && ([name isEqualToString: @""]) == NO);
}

-(BOOL)checkArtistFilterer: (NSString *) artist {
	return ((artist != nil) && ([artist isEqualToString: @""]) == NO);
}

-(BOOL)checkTimeFiltererStart: (EventDate *) start End: (EventDate *) end {
	if((start != nil) && (end != nil)) {
		/* Check if the start is before the end date */
		return ([start earlierDate: end] == YES);
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
/*	if(loc != nil) {
		CLLocationCoordinate2D coord = [loc getCoordinates];
*/		/* Check to make sure the lat lon is within the bounds */
/*		if((coord.latitude >= MINLAT) && (coord.latitude <= MAXLAT) && 
		   (coord.longitude >= MINLON) && (coord.longitude <= MAXLON)) {
			return (rad >= 0);
		}
	}
	
	return NO;*/
	return YES;
}

-(BOOL)checkAvailabilityFilterer:(NSString *) day Time: (int) time {

		
	if([self checkDayString: day] == NO) {
		return NO;
	}
	
	if(time >= 0 && time <= 2359) {	
		return YES;
	}
	
	return NO;
}

-(BOOL)checkDayString: (NSString *) str {
	
	if(([str isEqualToString: @"SUNDAY"]) || ([str isEqualToString: @"MONDAY"]) || 
	   ([str isEqualToString: @"TUESDAY"]) || ([str isEqualToString: @"WEDNESDAY"]) ||  
	   ([str isEqualToString: @"THURSDAY"]) || ([str isEqualToString: @"FRIDAY"]) || 
	   ([str isEqualToString: @"SATURDAY"])) {
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

-(EventDate *)getFiltererStartTime {
	return filterer->start;
}

-(EventDate *)getFiltererEndTime {
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

-(NSString *)getFiltererAvailabilityDay {
	return filterer->day;
}

-(int)getFiltererAvailabilityTime {
	return filterer->time;
}

-(NSString *)getTypeName {
	switch(type) {
		case NameFilterType:
			return @NAMESTRING;
			break;
		case ArtistFilterType:
			return @ARTISTSTRING;
			break;
		case TimeFilterType:
			return @TIMESTRING;
			break;
		case CostFilterType:
			return @COSTSTRING;
			break;
		case DurationFilterType:
			return @DURATIONSTRING;
			break;
		case LocationFilterType:
			return @LOCATIONSTRING;
			break;
		case AvailabilityFilterType:
			return @AVAILABILITYSTRING;
			break;
		default:
			return @INVALIDSTRING;
			break;
	}
}

//toString methods
-(NSString *)nameString {
	return [NSString stringWithFormat:@"Name: %@", filterer->name];
}

-(NSString *)artistString {
	return[NSString stringWithFormat:@"Artist: %@", filterer->artist];
}

-(NSString *)timeString {
	return [NSString stringWithFormat:@"Date: %@ Start: %@ End: %@", 
			[filterer->start getDate], [filterer->start getTimeStandardFormat],
			[filterer->end getTimeStandardFormat]];
}

-(NSString *)costString {
	return [NSString stringWithFormat:@"Min: $%f Max: $%f",
			filterer->minCost, filterer->maxCost];
}

-(NSString *)durationString {
	return [NSString stringWithFormat:@"Min: %d Max: %d", 
			filterer->minDuration, filterer->maxDuration];
}

-(NSString *)locationString {
	return [NSString stringWithFormat:@"Address: %@ Radius: %f", 
			[filterer->loc getStreetAddress], filterer->radius];
}

-(NSString *)availabilityString {
	int time = (filterer->time / 100) % 12;
	int min = filterer->time % 100;
	if(filterer->time > 1200) {
		return [NSString stringWithFormat:@"Day: %@ Time: %d:%dpm", 
				filterer->day, time, min];
	}

	return [NSString stringWithFormat:@"Day: %@ Time: %d:%dam", 
			filterer->day, time, min];
}

@end
