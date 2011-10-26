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
		case SearchFilterType:
			return @SEARCHSTRING;
			break;
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
	if([str isEqualToString: @SEARCHSTRING]) {
		return SearchFilterType;
	}
	
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

-(Filter *)initWithFilter:(Filter *)filter {
	self = [super init];
	
	if(self != nil) {
		[self setFilterType: [filter getFilterType]];
		if([self checkFilterer: [filter getFilterer]] == YES) {
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				[self copyFilterer: [filter getFilterer]];
				isEnabled = [filter isEnabled];
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initWithType: (FilterType) t AndFilterer: (Filterer *) f {
	self = [super init];
	
	if(self != nil) {
		[self setFilterType: t];
		if([self checkFilterer: f] == YES) {
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				[self copyFilterer: f];
				isEnabled = YES;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initWithType: (FilterType) t AndFilterer: (Filterer *) f Enabled: (BOOL) enabled {
	self = [super init];
	
	if(self != nil) {
		[self setFilterType: t];
		if([self checkFilterer: f] == YES) {
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				[self copyFilterer: f];
				isEnabled = enabled;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

/*Builds the specified filter if the data is valid */

-(Filter *)initSearchFilter: (NSString *)query {
	self = [super init];
	
	if(self != nil) {
		if([self checkSearchFilterer: query] == YES) {
			[self setFilterType: SearchFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->query = [[NSString alloc] initWithString: query];
				isEnabled = YES;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initNameFilter: (NSString *)name {
	self = [super init];
	
	if(self != nil) {
		if([self checkNameFilterer: name] == YES) {
			[self setFilterType: NameFilterType];
		
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->name = [[NSString alloc] initWithString: name];
				isEnabled = YES;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initArtistFilter: (NSString *) artist {
	self = [super init];
	
	if(self != nil) {
		if([self checkArtistFilterer: artist] == YES) {
			[self setFilterType: ArtistFilterType];
		
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->artist = [[NSString alloc] initWithString: artist];
				isEnabled = YES;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initTimeFilterStart: (EventDate *) start End: (EventDate *) end {
	self = [super init];
	
	if(self != nil) {
		if([self checkTimeFiltererStart: start End: end] == YES) {
			[self setFilterType: TimeFilterType];
		
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->start = [[EventDate alloc] initWithDate: start];
				filterer->end = [[EventDate alloc] initWithDate: end];
				isEnabled = YES;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initCostFilterMin: (double) min Max: (double) max {
	self = [super init];
	
	if(self != nil) {
		if([self checkCostFiltererMin: min Max: max] == YES) {
			[self setFilterType: CostFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->minCost = min;
				filterer->maxCost = max;
				isEnabled = YES;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initDurationFilterMin: (int) min Max: (int) max {
	self = [super init]; 
	
	if(self != nil) {
		if([self checkDurationFiltererMin: min Max: max] == YES) {
			[self setFilterType: DurationFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->minDuration = min;
				filterer->maxDuration = max;
				isEnabled = YES;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initLocationFilter: (EventLocation *) loc Radius: (double) rad {
	self = [super init];
	
	if(self != nil) {
		if([self checkLocationFilterer: loc Radius: rad] == YES) {
			[self setFilterType: LocationFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				filterer->loc = [[EventLocation alloc] initWithLocation: loc];
				filterer->radius = rad;
				isEnabled = YES;
				return self;
			}
		}
		
		[self dealloc];
	}
	
	return nil;
}

-(Filter *)initAvailabilityFilter:(NSString *) d Start: (int) start End: (int) end {
	self = [super init];
	NSLog(@"Reached Init Availability");
	
	if(self != nil) {
		NSLog(@"Not Nil");
		if([self checkAvailabilityFilterer: d Start: start End: end] == YES) {
			NSLog(@"Filter Passed");
			[self setFilterType: AvailabilityFilterType];
			
			filterer = (Filterer *)malloc(sizeof(Filterer));
			if(filterer != nil) {
				NSLog(@"Filterer Not Nil");
				filterer->day = [[NSString alloc] initWithString: d];
				filterer->startTime = start;
				filterer->endTime = end;
				isEnabled = YES;
			//	NSLog([NSString stringWithFormat: @"Day: %@ Start: %d End: %d",
			//		  filterer->day, filterer->startTime, filterer->endTime]);
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
		case SearchFilterType:
			return [self checkSearchFilterer: f->query];
			break;
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
			return [self checkAvailabilityFilterer: f->day Start: f->startTime End: f->endTime];
			break;
		default:
			return NO;
			break;
	}
	
	return NO;
}

-(BOOL)checkSearchFilterer: (NSString *) query {
	return ((query != nil) && ([query isEqualToString: @""]) == NO);
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

-(BOOL)checkAvailabilityFilterer:(NSString *) day Start: (int) start End: (int) end {
	NSLog(@"Reached Check Availability Filter");
	if([self checkDayString: day] == NO) {
		return NO;
	}
	
	if((start >= 0) && (end <= 2359) && (start <= end)) {	
		return YES;
	}
	
	return NO;
}

-(BOOL)checkDayString: (NSString *) str {
	NSLog(@"Reached check Day String");
	str = [str uppercaseString];
	
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

-(void)setFilterer: (Filterer *) f {
	filterer = f;
}

-(Filterer *)getFilterer {
	return filterer;
}

-(void)setEnabled: (BOOL) enabled {
	isEnabled = enabled;
}

-(BOOL)isEnabled {
	return isEnabled;
}

-(NSString *)getFiltererQuery {
	return filterer->query;
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

-(int)getFiltererAvailabilityStartTime {
	return filterer->startTime;
}

-(int)getFiltererAvailabilityEndTime {
	return filterer->endTime;
}

-(NSString *)getTypeName {
	switch(type) {
		case SearchFilterType:
			return @SEARCHSTRING;
			break;
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
-(NSString *)searchString {
	return [NSString stringWithFormat:@"Query: %@", filterer->query];
}

-(NSString *)nameString {
	return [NSString stringWithFormat:@"Name: %@", filterer->name];
}

-(NSString *)artistString {
	return[NSString stringWithFormat:@"Artist: %@", filterer->artist];
}

-(NSString *)timeString {
	return [NSString stringWithFormat:@"%@ %@-%@", 
			[filterer->start getDate], [filterer->start getTimeStandardFormat],
			[filterer->end getTimeStandardFormat]];
}

-(NSString *)costString {
	if(filterer->minCost == 0 && filterer->maxCost == 0)
	{
		return @"Cost: FREE";
	}
	return [NSString stringWithFormat:@"Cost: $%.2f-$%.2f",
			filterer->minCost, filterer->maxCost];
}

-(NSString *)durationString {
	return [NSString stringWithFormat:@"Duration: %d-%d minutes", 
			filterer->minDuration, filterer->maxDuration];
}

-(NSString *)locationString {
	return [NSString stringWithFormat:@"Within %.2f miles of %@", 
			filterer->radius, [filterer->loc getStreetAddress]];
}

-(NSString *)availabilityString {
	NSLog(@"Reached Availability String");
	int startH = (filterer->startTime / 100);
	int startM = filterer->startTime % 100;
	if(startH > 12) {
		startH -= 12;
	}
	
	int endH = (filterer->endTime / 100);
	int endM = filterer->endTime % 100;
	if(endH > 12) {
		endH -= 12;
	}
	
	if(filterer->startTime >= 1200) {
		return [NSString stringWithFormat:@"Day: %@ Time: %02d:%02dpm-%02d:%02dpm", 
				filterer->day, startH, startM, endH, endM];
	}
	else if(filterer->endTime >= 1200) {
		return [NSString stringWithFormat:@"Day: %@ Time: %02d:%02dam-%02d:%02dpm", 
				filterer->day, startH, startM, endH, endM];
	}
	return [NSString stringWithFormat:@"Day: %@ Time: %02d:%02dam-%02d:%02dam", 
			filterer->day, startH, startM, endH, endM];
}

-(void)copyFilterer: (Filterer *) f {
	filterer->name = [[NSString alloc] initWithString: f->name];
	filterer->artist = [[NSString alloc] initWithString: f->artist];
	filterer->start = [[EventDate alloc] initWithDate: f->start];
	filterer->end = [[EventDate alloc] initWithDate: f->end];
	filterer->minCost = f->minCost;
	filterer->maxCost = f->maxCost;
	filterer->minDuration = f->minDuration;
	filterer->maxDuration = f->maxDuration;
	filterer->loc = [[EventLocation alloc] initWithLocation: f->loc];
	filterer->radius = f->radius;
	filterer->day = [[NSString alloc] initWithString: f->day];
	filterer->startTime = f->startTime;
	filterer->endTime = f->endTime;
}

@end
