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

+(NSString *)buildFilterString:(Filter *)filter	{
	//Format <type>:<FieldType>=<FieldValue>,[...];
	
	switch([filter getFilterType]) {
		case SearchFilterType:
			return [NSString stringWithFormat:@"&search_query=%@", [filter getFilterer].query];
			break;
		case NameFilterType:
			return [NSString stringWithFormat:@"&name=%@", [filter getFilterer].name];
			break;
		case ArtistFilterType:
			return [NSString stringWithFormat:@"&artist=%@", [filter getFilterer].artist];
			break;
		case TimeFilterType:
			return [NSString stringWithFormat:@"&start=%@&end=%@", 
					[[filter getFilterer].start getDateTimeFormatStandard], 
					[[filter getFilterer].end getDateTimeFormatStandard]];
			break;
		case CostFilterType:
			return [NSString stringWithFormat:@"&min_cost=%f&max_cost=%f", 
					[filter getFilterer].minCost, [filter getFilterer].maxCost];
			break;
		case DurationFilterType:
			return [NSString stringWithFormat:@"&min_dur=%d&max_dur=%d", 
					[filter getFilterer].minDuration, [filter getFilterer].maxDuration];
			break;
		case LocationFilterType:
			return [NSString stringWithFormat: @"&radius=%f",
					[[filter getFilterer].loc getLocationFilterString], [filter getFilterer].radius];
			break;
		case AvailabilityFilterType:
			return [NSString stringWithFormat: @"&avail_day=%@&start=%@&end=%@",
					[filter getFilterer].day, [EventAvailability timeString: [filter getFilterer].startTime],
					[EventAvailability timeString: [filter getFilterer].endTime]];
			break;
		default:
			return @"";
			break;
	}
}

-(Filter *)initEmptyFilter {
	self = [super init];
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		return self;
	}
	
	return nil;
}

-(Filter *)initWithFilter:(Filter *)filter {
	self = [super init];
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		[self setFilterType: [filter getFilterType]];
		if([self checkFilterer: [filter getFilterer]] == YES) {
			filterer = [[Filterer alloc] initEmptyFilterer];
			if(filterer != nil) {
				[self copyFilterer: [filter getFilterer]];
				isEnabled = [filter isEnabled];
				return self;
			}
		}
	}
	
	return nil;
}

/*Builds the specified filter if the data is valid */

-(Filter *)initSearchFilter: (NSString *)query {
	self = [super init];
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		if([self checkSearchFilterer: query] == YES) {
			[self setFilterType: SearchFilterType];
			filterer = [[Filterer alloc] initEmptyFilterer];
			if(filterer != nil) {
				filterer.query = [[NSString alloc] initWithString: query];
				[query release];
				isEnabled = YES;
				return self;
			}
		}
	}
	
	return nil;
}

-(Filter *)initNameFilter: (NSString *)name {
	self = [super init];
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		if([self checkNameFilterer: name] == YES) {
			[self setFilterType: NameFilterType];
		
			filterer = [[Filterer alloc] initEmptyFilterer];
			if(filterer != nil) {
				filterer.name = [[NSString alloc] initWithString: name];
				[name release];
				isEnabled = YES;
				return self;
			}
		}
	}
	
	return nil;
}

-(Filter *)initArtistFilter: (NSString *) artist {
	self = [super init];
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		if([self checkArtistFilterer: artist] == YES) {
			[self setFilterType: ArtistFilterType];
		
			filterer = [[Filterer alloc] initEmptyFilterer];
			if(filterer != nil) {
				filterer.artist = [[NSString alloc] initWithString: artist];
				[artist release];
				isEnabled = YES;
				return self;
			}
		}
	}
	
	return nil;
}

-(Filter *)initTimeFilterStart: (EventDate *) start End: (EventDate *) end {
	if((start == nil) || (end == nil)) {
		return nil;
	}
	
	self = [super init];
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		if([self checkTimeFiltererStart: start End: end] == YES) {
			[self setFilterType: TimeFilterType];
		
			filterer = [[Filterer alloc] initEmptyFilterer];
			if(filterer != nil) {
				filterer.start = [[EventDate alloc] initWithDate: start];
				filterer.end = [[EventDate alloc] initWithDate: end];
				[start release];
				[end release];
				isEnabled = YES;
				return self;
			}
		}
	}

	return nil;
}

-(Filter *)initCostFilterMin: (double) min Max: (double) max {
	self = [super init];
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		if([self checkCostFiltererMin: min Max: max] == YES) {
			[self setFilterType: CostFilterType];
			
			filterer = [[Filterer alloc] initEmptyFilterer];
			if(filterer != nil) {
				filterer.minCost = min;
				filterer.maxCost = max;
				isEnabled = YES;
				return self;
			}
		}

	}
	
	return nil;
}

-(Filter *)initDurationFilterMin: (int) min Max: (int) max {
	self = [super init]; 
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		if([self checkDurationFiltererMin: min Max: max] == YES) {
			[self setFilterType: DurationFilterType];
			
			filterer = [[Filterer alloc] initEmptyFilterer];
			if(filterer != nil) {
				filterer.minDuration = min;
				filterer.maxDuration = max;
				isEnabled = YES;
				return self;
			}
		}
	}
	
	return nil;
}

-(Filter *)initLocationFilter: (EventLocation *) loc Radius: (double) rad {
	if(loc == nil) {
		return nil;
	}
	
	self = [super init];
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		if([self checkLocationFilterer: loc Radius: rad] == YES) {
			[self setFilterType: LocationFilterType];
			
			filterer = [[Filterer alloc] initEmptyFilterer];
			if(filterer != nil) {
				filterer.loc = [[EventLocation alloc] initWithLocation: loc];
				filterer.radius = rad;
				[loc release];
				isEnabled = YES;
				return self;
			}
		}
	}
	
	return nil;
}

-(Filter *)initAvailabilityFilter:(NSString *) d Start: (int) start End: (int) end {
	self = [super init];

	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		if([self checkAvailabilityFilterer: d Start: start End: end] == YES) {
			[self setFilterType: AvailabilityFilterType];
			
			filterer = [[Filterer alloc] initEmptyFilterer];
			if(filterer != nil) {
				filterer.day = [[NSString alloc] initWithString: d];
				filterer.startTime = start;
				filterer.endTime = end;
				[d release];
				isEnabled = YES;
				return self;
			}
		}
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
			return [self checkSearchFilterer: f.query];
			break;
		case NameFilterType:
			return [self checkNameFilterer: f.name];
			break;
		case ArtistFilterType:
			return [self checkArtistFilterer: f.artist];
			break;
		case TimeFilterType:
			return [self checkTimeFiltererStart: f.start End: f.end];
			break;
		case CostFilterType:
			return [self checkCostFiltererMin: f.minCost Max: f.maxCost];
			break;
		case DurationFilterType:
			return [self checkDurationFiltererMin: f.minDuration Max: f.maxDuration];
			break;
		case LocationFilterType:
			return [self checkLocationFilterer: f.loc Radius: f.radius];
			break;
		case AvailabilityFilterType:
			return [self checkAvailabilityFilterer: f.day Start: f.startTime End: f.endTime];
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
	if([self checkDayString: day] == NO) {
		return NO;
	}
	
	if((start >= 0) && (end <= 2400) && (start <= end)) {	
		return YES;
	}
	
	return NO;
}

-(BOOL)checkDayString: (NSString *) str {
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
	return filterer.query;
}

-(NSString *)getFiltererName {
	return filterer.name;
}

-(NSString *)getFiltererArtist {
	return filterer.artist;
}

-(EventDate *)getFiltererStartTime {
	return filterer.start;
}

-(EventDate *)getFiltererEndTime {
	return filterer.end;
}

-(double)getFiltererMinCost {
	return filterer.minCost;
}

-(double)getFiltererMaxCost {
	return filterer.maxCost;
}

-(int)getFiltererMinDuration {
	return filterer.minDuration;
}

-(int)getFiltererMaxDuration {
	return filterer.maxDuration;
}

-(EventLocation *)getFiltererLocation {
	return filterer.loc;
}

-(double)getFiltererRadius {
	return filterer.radius;
}

-(NSString *)getFiltererAvailabilityDay {
	return filterer.day;
}

-(int)getFiltererAvailabilityStartTime {
	return filterer.startTime;
}

-(int)getFiltererAvailabilityEndTime {
	return filterer.endTime;
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
	return [NSString stringWithFormat:@"Query: %@", filterer.query];
}

-(NSString *)nameString {
	return [NSString stringWithFormat:@"Name: %@", filterer.name];
}

-(NSString *)artistString {
	return[NSString stringWithFormat:@"Artist: %@", filterer.artist];
}

-(NSString *)timeString {
	return [NSString stringWithFormat:@"%@ %@-%@", 
			[filterer.start getDate], [filterer.start getTimeStandardFormat],
			[filterer.end getTimeStandardFormat]];
}

-(NSString *)costString {
	if(filterer.minCost == 0 && filterer.maxCost == 0)
	{
		return @"Cost: FREE";
	}
	return [NSString stringWithFormat:@"Cost: $%.2f-$%.2f",
			filterer.minCost, filterer.maxCost];
}

-(NSString *)durationString {
	return [NSString stringWithFormat:@"Duration: %d-%d minutes", 
			filterer.minDuration, filterer.maxDuration];
}

-(NSString *)locationString {
	return [NSString stringWithFormat:@"Within %.2f miles of %@", 
			filterer.radius, [filterer.loc getStreetAddress]];
}

-(NSString *)availabilityString {
	NSString *start = [EventAvailability timeString: filterer.startTime];
	NSString *end = [EventAvailability timeString: filterer.endTime];
	
	return [NSString stringWithFormat:@"%@ %@-%@", 
			filterer.day, start, end];
}

-(void)copyFilterer: (Filterer *) f {
	filterer.query = [[NSString alloc] initWithString: f.query];
	filterer.name = [[NSString alloc] initWithString: f.name];
	filterer.artist = [[NSString alloc] initWithString: f.artist];
	filterer.start = [[EventDate alloc] initWithDate: f.start];
	filterer.end = [[EventDate alloc] initWithDate: f.end];
	filterer.minCost = f.minCost;
	filterer.maxCost = f.maxCost;
	filterer.minDuration = f.minDuration;
	filterer.maxDuration = f.maxDuration;
	filterer.loc = [[EventLocation alloc] initWithLocation: f.loc];
	filterer.radius = f.radius;
	filterer.day = [[NSString alloc] initWithString: f.day];
	filterer.startTime = f.startTime;
	filterer.endTime = f.endTime;
}

-(BOOL)isEqual:(id)object {
	Filter *other = (Filter *)object;
	
	if(type != [other getFilterType]) {
		return NO;
	}

	if([self isFiltererEqual: [other getFilterer]] == NO) {
		return NO;
	}
	
	if(isEnabled != [other isEnabled]) {
		return NO;
	}
	
	return YES;
}


-(BOOL)isFiltererEqual:(Filterer *)other
{
	if(((filterer.query == nil) && (other.query != nil)) || ((filterer.query != nil) && (other.query == nil))) {
		return NO;
	}
	if((filterer.query != nil) && ([filterer.query isEqualToString: other.query] == NO)) {
		return NO;
	}
	
	if(((filterer.name == nil) && (other.name != nil)) || ((filterer.name != nil) && (other.name == nil))) {
		return NO;
	}
	if((filterer.name != nil) && ([filterer.name isEqualToString: other.name] == NO)) {
		return NO;
	}
	
	if(((filterer.artist == nil) && (other.artist != nil)) || ((filterer.artist != nil) && (other.artist == nil))) {
		return NO;
	}
	if((filterer.artist != nil) && ([filterer.artist isEqualToString: other.artist] == NO)) {
		return NO;
	}
	
	if(((filterer.start == nil) && (other.start != nil)) || ((filterer.start != nil) && (other.start == nil))) {
		return NO;
	}
	if((filterer.start != nil) && ([filterer.start isEqual: other.start] == NO)) {
		return NO;
	}
	if(((filterer.end == nil) && (other.end != nil)) || ((filterer.end != nil) && (other.end == nil))) {
		return NO;
	}
	if((filterer.end != nil) && ([filterer.end isEqual: other.end] == NO)) {
		return NO;
	}
	
	if(filterer.minCost != other.minCost) {
		return NO;
	}
	if(filterer.maxCost != other.maxCost) {
		return NO;
	}
	
	if(filterer.minDuration != other.minDuration) {
		return NO;
	}
	if(filterer.maxDuration != other.maxDuration) {
		return NO;
	}
	
	if(((filterer.loc == nil) && (other.loc != nil)) || ((filterer.loc != nil) && (other.loc == nil))) {
		return NO;
	}
	if((filterer.loc != nil) && ([filterer.loc isLocationIDEqual: other.loc] == NO)) {
		return NO;
	}
	if(filterer.radius != other.radius) {
		return NO;
	}
	
	
	if(((filterer.day == nil) && (other.day != nil)) || ((filterer.day != nil) && (other.day == nil))) {
		return NO;
	}
	if((filterer.day != nil) && ([filterer.day isEqualToString: other.day] == NO)) {
		return NO;
	}
	if(filterer.startTime != other.startTime) {
		return NO;
	}
	if(filterer.endTime != other.endTime) {
		return NO;
	}
	
	return YES;
}

-(void)dealloc {
	[filterer release];
	[pool release];
	[super dealloc];
}

@end
