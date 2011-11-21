//
//  EventDate.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/21/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/*******************************************************
 * Event Date Class
 * 
 * Holds all the information to specify a date and time:
 * day, month, year, hour, minute, and second 
 *
 *******************************************************/

#import <Foundation/Foundation.h>

//Supports Dates Jan 1 1900 00:00:00 and later
//Stored as a military time
@interface EventDate : NSObject {
	int month;
	int day; 
	int year;
	int hour;
	int minute;
	int second;
}

+(BOOL)checkDate: (EventDate *)date;
+(BOOL)isNumeric: (NSString *) str;

-(EventDate *)initEmptyDate;

//Copy Constructor
-(EventDate *)initWithDate: (EventDate *) date;

-(BOOL)isEqualTime:(EventDate *)other;

-(BOOL)earlierDate: (EventDate *)other;

-(void)setDate: (NSString *)date;
-(void)setTime: (NSString *)time;

-(NSString *)getDateTimeFormatMilitary;
-(NSString *)getDateTimeFormatStandard;
-(NSString *)getDate;
-(NSString *)getTimeMilitaryFormat;
-(NSString *)getTimeStandardFormat;

-(BOOL)checkYear;
-(BOOL)checkMonth;
-(BOOL)checkDay;
-(BOOL)checkHour;
-(BOOL)checkMinute;
-(BOOL)checkSecond;
-(BOOL)checkLeapYear;

-(void)setMonth: (int) m;
-(int)getMonth;
-(void)setDay: (int) d;
-(int)getDay;
-(void)setYear: (int) y;
-(int)getYear;
-(void)setHour: (int) h;
-(int)getHour;
-(void)setMinute: (int) m;
-(int)getMinute;
-(void)setSecond: (int) s;
-(int)getSecond;

@end
