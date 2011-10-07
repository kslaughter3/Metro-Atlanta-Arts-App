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

/* Initializers */
-(EventAvailability *)initiaize: (NSMutableArray *) d Start: (int) start End: (int) end;

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

-(bool)containsDay: (NSString *) day;

-(bool)availableDuring: (int) time;

@end
