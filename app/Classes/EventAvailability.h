//
//  EventAvailability.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/******************************************************
 * Event Availability Class
 *
 * Holds all the information to specify when an event is
 * available: the days of the week, the start time, and
 * the end time
 *
 ******************************************************/

#import <Foundation/Foundation.h>
#import "EventDate.h"

typedef enum WeekDays {
	Sunday = 0,
	Monday,
	Tuesday,
	Wednesday,
	Thursday, 
	Friday,
	Saturday
} WeekDays;

@interface EventAvailability : NSObject {
	NSMutableArray *days;
	int startTime;
	int endTime;
	NSAutoreleasePool *pool;
}

+(int)buildTime: (NSString *)string;
+(int)buildTimeFromMilitary:(NSString *)string;
+(NSString *)timeString: (int) time;

/* Initializers */
-(EventAvailability *)initEmptyAvailability;

-(EventAvailability *)initWithAvailability: (EventAvailability *) avail;


-(NSString *)getDayRange;
-(NSString *)getStartTimeString;
-(NSString *)getEndTimeString;


-(BOOL)availableAllDay;
-(void)setAvailableAllDay; //both startTime and endTime are set to 0
/* Getters and Setters */
-(void)setDays: (NSMutableArray *) d;
-(NSMutableArray *)getDays;

-(void)setStartTime: (int) time;
-(int)getStartTime;

-(void)setEndTime: (int) time;
-(int)getEndTime;

/* end Getters and Setters */

-(void)addDay: (NSString *) day;
-(void)removeDay: (NSString *) day;

-(BOOL)containsDay: (NSString *) day;
-(BOOL)containsEveryDay;

-(BOOL)availableDuring: (int) time;

@end
