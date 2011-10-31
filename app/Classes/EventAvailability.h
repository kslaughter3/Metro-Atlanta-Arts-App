//
//  EventAvailability.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventAvailability : NSObject {
	NSMutableArray *days;
	int startTime;
	int endTime;
}

+(int)buildTime: (NSString *)string;
+(NSString *)timeString: (int) time;

/* Initializers */
-(EventAvailability *)initEmptyAvailability;

-(EventAvailability *)initWithAvailability: (EventAvailability *) avail;

-(EventAvailability *)initWithDay: (NSMutableArray *) d Start: (int) start End: (int) end;

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

-(BOOL)availableDuring: (int) time;

@end
