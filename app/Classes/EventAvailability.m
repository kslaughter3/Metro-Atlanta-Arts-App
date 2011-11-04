//
//  EventAvailability.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventAvailability.h"


@implementation EventAvailability

+(int)buildTime:(NSString *)string {
	BOOL afternoon = NO;
	NSRange colon = [string rangeOfString:@":"];
	
	//invalid
	if(colon.location == NSNotFound) {
		return -1;
	}
	
	NSRange end = [[string lowercaseString] rangeOfString:@"am"];
	
	if(end.location == NSNotFound) {
		end = [[string lowercaseString] rangeOfString:@"pm"];
		if(end.location == NSNotFound) {
			return -1;
		}
		afternoon = YES;
	}
	
	int time = [[string substringToIndex: colon.location] intValue];
	if((afternoon == YES) && (time != 12)) {
		time += 12;
	}
	time *= 100;
	
	NSString *temp = [string substringToIndex: end.location];
	int min = [[temp substringFromIndex: (colon.location+1)] intValue];
	
	time += min;
	
	return time;
}

+(NSString *)timeString:(int)time {
	int hour = time / 100;
	int min = time % 100;
	
	if(hour > 12) {
		hour -= 12;
	}
	
	if(time >= 1200) {
		return [NSString stringWithFormat:@"%d:%02dpm", hour, min];
	}
	
	return [NSString stringWithFormat:@"%d:%02dam", hour, min];
}

-(EventAvailability *)initEmptyAvailability {
	self = [super init];
	
	if(self != nil) {
		days = [[NSMutableArray alloc] init];
		return self;
	}
	
	return nil;
}

/* Initializers */
-(EventAvailability *)initWithAvailability:(EventAvailability *)avail {
	self = [super init];
	
	if(self != nil) {
		days = [[NSMutableArray alloc] init];
		[days addObjectsFromArray: [avail getDays]];
		startTime = [avail getStartTime];
		endTime = [avail getEndTime];
		
		return self;
	}
	
	return nil;
}

-(EventAvailability *)initWithDay: (NSMutableArray *) d Start: (int) start End: (int) end {
	if((d == nil) || (start < 0) || (start >= 2400) || (end < 0) || (end >= 2400)) {
		return nil;
	}
	
	self = [super init];
	
	if(self != nil) {
		days = [[NSMutableArray alloc] init];
		[days addObjectsFromArray: d];
		startTime = start;
		endTime = end;
		
		return self;
	}
	
	return nil;
}

-(NSString *)getDayRange {
	
	//TODO: This isn't right
	NSString *start;
	NSString *end;
	
	if([self containsEveryDay] == YES) {
		return [NSString stringWithFormat:@"Every Day"];
	}
	
	//Get The Start day
	if([self containsDay: @"SUNDAY"] == YES) {
		start = [[NSString alloc] initWithString: @"Sunday"];
	}
	else if([self containsDay: @"MONDAY"] == YES) {
		start = [[NSString alloc] initWithString: @"Monday"];
	}
	else if([self containsDay: @"TUESDAY"] == YES) {
		start = [[NSString alloc] initWithString: @"Tuesday"];
	}
	else if([self containsDay: @"WEDNESDAY"] == YES) {
		start = [[NSString alloc] initWithString: @"Wednesday"];
	}
	else if([self containsDay: @"THURSDAY"] == YES) {
		start = [[NSString alloc] initWithString: @"Thursday"];
	}
	else if([self containsDay: @"FRIDAY"] == YES) {
		start = [[NSString alloc] initWithString: @"Friday"];
	}
	else if([self containsDay: @"SATURDAY"] == YES) {
		start = [[NSString alloc] initWithString: @"Saturday"];
	}
	
	
	//Get the end day
	if([self containsDay: @"SATURDAY"] == YES) {
		end = [[NSString alloc] initWithString: @"Saturday"];
	}
	else if([self containsDay: @"FRIDAY"] == YES) {
		end = [[NSString alloc] initWithString: @"Friday"];
	}
	else if([self containsDay: @"THURSDAY"] == YES) {
		end = [[NSString alloc] initWithString: @"Thursday"];
	}
	else if([self containsDay: @"WEDNESDAY"] == YES) {
		end = [[NSString alloc] initWithString: @"Wednesday"];
	}
	else if([self containsDay: @"TUESDAY"] == YES) {
		end = [[NSString alloc] initWithString: @"Tuesday"];
	}
	else if([self containsDay: @"MONDAY"] == YES) {
		end = [[NSString alloc] initWithString: @"Monday"];
	}
	else if([self containsDay: @"SUNDAY"] == YES) {
		end = [[NSString alloc] initWithString: @"Sunday"];
	}
	
	if([start isEqualToString: end] == YES) {
		return start;
	}
	
	return [NSString stringWithFormat:@"%@-%@", start, end];
}

-(NSString *)getStartTimeString {
	return [EventAvailability timeString: startTime];
}

-(NSString *)getEndTimeString {
	return [EventAvailability timeString: endTime];
}

/* Getters and Setters */
-(void)setDays: (NSMutableArray *) d {
	days = d;
}

-(NSMutableArray *)getDays {
	return days;
}

-(void)setStartTime: (int) time {
	startTime = time;
}

-(int)getStartTime {
	return startTime;
}

-(void)setEndTime: (int) time {
	endTime = time;
}

-(int)getEndTime {
	return endTime;
}

/* end Getters and Setters */

-(void)addDay: (NSString *) day {
	NSString *d = [day uppercaseString];
	if([days containsObject: d] == NO) {
		[days addObject: d];
	}
}

-(void)removeDay: (NSString *) day {
	NSString *d = [day uppercaseString];
	if([days containsObject: d] == YES) {
		[days removeObjectIdenticalTo: d];
	}
}

-(BOOL)containsDay: (NSString *) day {
	NSString *d = [day uppercaseString];
	return [days containsObject: d];
}

-(BOOL)containsEveryDay {
	if([self containsDay: @"SUNDAY"] == NO) {
		return NO;
	}
	if([self containsDay: @"MONDAY"] == NO) {
		return NO;
	}
	if([self containsDay: @"TUESDAY"] == NO) {
		return NO;
	}
	if([self containsDay: @"WEDNESDAY"] == NO) {
		return NO;
	}
	if([self containsDay: @"THURSDAY"] == NO) {
		return NO;
	}
	if([self containsDay: @"FRIDAY"] == NO) {
		return NO;
	}
	if([self containsDay: @"SATURDAY"] == NO) {
		return NO;
	}

	return YES;
}

-(BOOL)availableDuring: (int) time {
	if((startTime <= time) && (endTime >= time)) {
		return YES;
	}
	return NO;
}

@end
