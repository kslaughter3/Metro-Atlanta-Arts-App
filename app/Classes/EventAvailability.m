//
//  EventAvailability.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventAvailability.h"


@implementation EventAvailability

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
