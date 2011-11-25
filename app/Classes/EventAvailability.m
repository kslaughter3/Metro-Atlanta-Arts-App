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
		pool = [[NSAutoreleasePool alloc] init];
		days = [[NSMutableArray alloc] init];
		return self;
	}
	
	return nil;
}

/* Initializers */
-(EventAvailability *)initWithAvailability:(EventAvailability *)avail {
	self = [super init];
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		days = [[NSMutableArray alloc] init];
		[days addObjectsFromArray: [avail getDays]];
		startTime = [avail getStartTime];
		endTime = [avail getEndTime];
		
		return self;
	}
	
	return nil;
}

-(NSString *)getDayRange {
	NSString *WeekDaysStored[] = {@"SUNDAY", @"MONDAY", @"TUESDAY", @"WEDNESDAY", 
		@"THURSDAY", @"FRIDAY", @"SATURDAY"};
	
	NSString *WeekDaysPrint[] = {@"Sunday", @"Monday", @"Tuesday", @"Wednesday", 
		@"Thursday", @"Friday", @"Saturday"};
	
	int start = Sunday;
	int end = Sunday;
	NSString *returnStr = [[NSString alloc] init];
	
	if([self containsEveryDay] == YES) {
		return [NSString stringWithFormat:@"Every Day"];
	}
	
	while(start <= Saturday) {
		for(; start <= Saturday; start++) {
			if([self containsDay: WeekDaysStored[start]] == YES) {
				break;
			}
		}
	
		end = start + 1;
		for(; end <= Saturday; end++) {
			if([self containsDay: WeekDaysStored[end]] == NO) {
				end--;
				break;
			}
		}
	
		if(start <= Saturday) {
			if([returnStr isEqualToString: @""] == NO) {
				NSString *temp = [NSString stringWithFormat:@", "];
				returnStr = [returnStr stringByAppendingString: temp];
			}
			
			if((start < end) && (end <= Saturday)) {
				NSString *temp = [NSString stringWithFormat: @"%@-%@",
								  WeekDaysPrint[start], WeekDaysPrint[end]];
				returnStr = [returnStr stringByAppendingString: temp];
			}
			else {
				NSString *temp = [NSString stringWithFormat:@"%@", 
								  WeekDaysPrint[start]];
				returnStr = [returnStr stringByAppendingString: temp];
			}
				
		}
			
		start = end + 1;
	}
	
	return returnStr;
}

-(NSString *)getStartTimeString {
	return [EventAvailability timeString: startTime];
}

-(NSString *)getEndTimeString {
	return [EventAvailability timeString: endTime];
}

-(BOOL)availableAllDay {
	return (startTime == 0) && (endTime == 0);
}

-(void)setAvailableAllDay {
	startTime = 0;
	endTime = 0;
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
	NSString *WeekDaysStored[] = {@"SUNDAY", @"MONDAY", @"TUESDAY", @"WEDNESDAY", 
		@"THURSDAY", @"FRIDAY", @"SATURDAY"};
	int day = Sunday;
	
	for(; day <= Saturday; day++) {
		if([self containsDay: WeekDaysStored[day]] == NO) {
			return NO;
		}
	}

	return YES;
}

-(BOOL)availableDuring: (int) time {
	if((startTime <= time) && (endTime >= time)) {
		return YES;
	}
	return NO;
}

-(BOOL)isEqual:(id)object {
	EventAvailability *other = (EventAvailability *)object;
	
	
	if(((days == nil) && ([other getDays] != nil)) || ((days != nil) && ([other getDays] == nil))) {
		return NO;
	}
	
	if(days != nil) {
		for(id day in days) {
			if([other containsDay: day] == NO) {
				return NO;
			}
		}
		
		for(id day in [other getDays]) {
			if([days containsObject: day] == NO) {
				return NO;
			}
		}
	}
	
	if(startTime != [other getStartTime]) {
		return NO;
	}
	
	if(endTime != [other getEndTime]) {
		return NO;
	}
	
	return YES;
}

-(void)dealloc {
	[days release];
	[pool release];
	[super dealloc];
}

@end
