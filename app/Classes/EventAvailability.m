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
	if([days containsObject: day] == NO) {
		[days addObject: day];
	}
}

-(void)removeDay: (NSString *) day {
	if([days containsObject: day] == YES) {
		[days removeObjectIdenticalTo: day];
	}
}

-(BOOL)containsDay: (NSString *) day {
	return [days containsObject: day];
}

-(BOOL)availableDuring: (int) time {
	if((startTime <= time) && (endTime >= time)) {
		return YES;
	}
	return NO;
}

@end
