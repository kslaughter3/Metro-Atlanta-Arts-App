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
-(EventAvailability *)initiaize: (NSMutableArray *) d Start: (int) start End: (int) end {
	if((d == NULL) || (start < 0) || (start >= 2400) || (end < 0) || (end >= 2400)) {
		return NULL;
	}
	
	self = [super init];
	
	if(self != NULL) {
		[self setDays: d];
		[self setStartTime: start];
		[self setEndTime: end];
		
		return self;
	}
	
	return NULL;
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
	if([days containsObject: day] == false) {
		[days addObject: day];
	}
}

-(void)removeDay: (NSString *) day {
	if([days containsObject: day] == true) {
		[days removeObjectIdenticalTo: day];
	}
}

-(bool)containsDay: (NSString *) day {
	return [days containsObject: day];
}

-(bool)availableDuring: (int) time {
	return ((startTime <= time) && (endTime >= time));
}

@end
