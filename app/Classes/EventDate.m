//
//  EventDate.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/21/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "EventDate.h"


@implementation EventDate

+(BOOL)checkDate:(EventDate *)date {
	if(([date checkYear] == YES) && ([date checkMonth] == YES) && ([date checkDay] == YES) && 
	   ([date checkHour] == YES) && ([date checkMinute] == YES) && ([date checkSecond] == YES))
	{
		return YES;
	}
	return NO;
}

+(BOOL)isNumeric:(NSString *)str {
	NSUInteger len = [str length];
	NSUInteger i;
	BOOL status = NO;
	
	for(i=0; i < len; i++)
	{
		unichar singlechar = [str characterAtIndex: i];
		if ( (singlechar == ' ') && (!status) ) {
			continue;
		}
		if ( ( singlechar >= '0' ) && ( singlechar <= '9' ) ) {
			status = YES;
		} 
		else {
			return NO;
		}
	}
	return (i == len) && status;					 
}

-(EventDate *)initializeEmptyDate {
	self = [super init];
	return self;
}

//Builds a date from a string the in the format "MM-DD-YYYY HH:MM:SS(pm/am)" or the format "MM/DD/YYYY HH:MM:SS(pm/am)"
-(EventDate *)initializeFromString: (NSString *) string {
	self = [super init];
	
	if(self != nil) {
		
		NSArray *components = [string componentsSeparatedByString:@" "];
	
		//Should have 2 components (date and time) to be a valid string
		if([components count] != 2) {
			[components dealloc];
			[self dealloc];
			return nil;
		}
		
		[self setDate: (NSString *)[components objectAtIndex: 0]];
		[self setTime: (NSString *)[components objectAtIndex: 1]];
		
		[components dealloc];
		
		if([EventDate checkDate: self] == NO) {
			[self dealloc];
			return nil;
		}
	
		return self;
	}
	
	return nil;
}

-(EventDate *)initializeWithMonth: (int) mon Day: (int) d Year: (int) y Hour: (int) h Minute: (int) min Second: (int) s {
	self = [super init];
	
	if(self != nil) {
		[self setYear: y];
		[self setMonth: mon];
		[self setDay: d];
		[self setHour: h];
		[self setMinute: min];
		[self setSecond: s];
		
		if([EventDate checkDate: self] == NO) {
			[self dealloc];
			return nil;
		}
		
		return self;
	}
	
	return nil;
}

-(BOOL)earlierDate: (EventDate *)other {
	if([other getYear] < year) {
		return NO;
	}
	else if([other getYear] > year) {
		return YES;
	}
	else if([other getMonth] < month) {
		return NO;
	}
	else if([other getMonth] > month) {
		return YES;
	}
	else if([other getDay] < day) {
		return NO;
	}
	else if([other getDay] > day) {
		return YES;
	}
	else if([other getHour] < hour) {
		return NO;
	}
	else if([other getHour] > hour) {
		return YES;
	}
	else if([other getMinute] < minute) {
		return NO;
	}
	else if([other getMinute] > minute) {
		return YES;
	}
	else if([other getSecond] < second) {
		return NO;
	}
	else if([other getSecond] > second) {
		return YES;
	}
	
	//Exactly Equal
	return NO;
}

-(void)setDate: (NSString *)date {
	NSString *temp;
	NSArray *components = [date componentsSeparatedByString:@"/"];
	
	//Should have 3 components (month, day, year)
	if([components count] != 3) {
		//Try the other format
		[components dealloc];
		components = [date componentsSeparatedByString:@"-"];
	}
	
	if([components count] == 3) {
		temp = (NSString *)[components objectAtIndex: 0];
		if([EventDate isNumeric: temp] == YES) {
			month = [temp intValue];
			temp = (NSString *)[components objectAtIndex: 1];
			if([EventDate isNumeric: temp] == YES) {
				day = [temp intValue];
				temp = (NSString *)[components objectAtIndex: 2];
				if([EventDate isNumeric: temp] == YES) {
					year = [temp intValue];
					return;
				}
			}
		}
	}
	
	//Invalidate the date
	month = -1;
	day = -1;
	year = -1;
}

-(void)setTime: (NSString *)time {
	NSString *temp, *suffix;
	NSArray *components = [time componentsSeparatedByString:@":"];
	
	if([components count] == 3) {
		temp = (NSString *)[components objectAtIndex: 0];
		if([EventDate isNumeric: temp] == YES) {
			hour = [temp intValue];
			temp = (NSString *)[components objectAtIndex: 1];
			if([EventDate isNumeric: temp] == YES) {
				minute = [temp intValue];
				temp = (NSString *)[components objectAtIndex: 2];
				temp = [temp lowercaseString];
				if(([temp hasSuffix:@"pm"] == YES) || ([temp hasSuffix: @"am"] == YES)) {
					suffix = [temp substringFromIndex:([temp length] - 2)];
					temp = [temp substringToIndex:([temp length] -2)];
				}
				if([EventDate isNumeric: temp] == YES) {
					second = [temp intValue];
					if([suffix compare: @"pm"] == 0) {
						hour = hour + 12;
					}
					return;
				}
			}
		}
	}
	
	//Invalidate the date
	hour = -1;
	minute = -1;
	second = -1;
}

-(NSString *)getDateTimeFormatMilitary {
	return [NSString stringWithFormat:@"%d/%d/%d %d:%d:%d", month, day, year, hour, minute, second];
}

-(NSString *)getDateTimeFormatStandard {
	if(hour > 12) {
		return [NSString stringWithFormat:@"%d/%d/%d %d:%d:%dpm", month, day, year, (hour-12), minute, second];
	}
	else if(hour == 12) {
		return [NSString stringWithFormat:@"%d/%d/%d %d:%d:%dpm", month, day, year, hour, minute, second];
	}
	return [NSString stringWithFormat:@"%d/%d/%d %d:%d:%dam", month, day, year, hour, minute, second];
}

-(NSString *)getDate {
	return [NSString stringWithFormat:@"%d/%d/%d", month, day, year];
}

-(NSString *)getTimeMilitaryFormat {
	return [NSString stringWithFormat:@"%d:%d:%d", hour, minute, second];
}

-(NSString *)getTimeStandardFormat {
	if(hour > 12) {
		return [NSString stringWithFormat:@"%d:%d:%dpm", (hour-12), minute, second];
	}
	else if(hour == 12) {
		return [NSString stringWithFormat:@"%d:%d:%dpm", hour, minute, second];
	}
	return [NSString stringWithFormat:@"%d:%d:%dam", hour, minute, second];
}

-(BOOL)checkYear {
	if(year >= 1900) {
		return YES;
	}
	return NO;
}

-(BOOL)checkMonth {
	if(month >=1 && month <= 12) {
		return YES;
	}
	return NO;
}

//Requires Month and Year to be set
-(BOOL)checkDay {
	//Check for the month first year is after 1900
	if((month >= 1) && (month <= 12) && (year >= 1900) && (day >= 1)) {
		switch(month) {
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:
				if(day <= 31) {
					return YES;
				}
				break;
			case 4:
			case 6:
			case 9:
			case 11:
				if(day <= 30) {
					return YES;
				}
				break;
			case 2:
				if([self checkLeapYear] == YES) {
					if(day <= 29) {
						return YES;
					}
				}
				else {
					if(day <= 28) {
						return YES;
					}
				}
				break;
			default:
				return NO;
				break;
		}
	}
	
	return NO;
}

-(BOOL)checkHour {
	if(hour >= 0 && hour <= 23) {
		return YES;
	}
	return NO;
}

-(BOOL)checkMinute {
	if(minute >= 0 && minute <= 59) {
		return YES;
	}
	return NO;
}

-(BOOL)checkSecond {
	if(second >= 0 && second <= 59) {
		return YES;
	}
	return NO;
}

-(BOOL)checkLeapYear {
	if(year >= 1900) {
		if((year/4) == 0) {
			if((year/100) == 0) {
				if((year/400) == 0) {
					return YES;
				}
				return NO;
			}
			return YES;
		}
	}
	return NO;
}

-(void)setMonth: (int) m {
	month = m;
}

-(int)getMonth {
	return month;
}

-(void)setDay: (int) d {
	day = d;
}

-(int)getDay {
	return day;
}

-(void)setYear: (int) y {
	year = y;
}

-(int)getYear {
	return year;
}

-(void)setHour: (int) h {
	hour = h;
}

-(int)getHour {
	return hour;
}

-(void)setMinute: (int) m {
	minute = m;
}

-(int)getMinute {
	return minute;
}

-(void)setSecond: (int) s {
	second = s;
}

-(int)getSecond {
	return second;
}

@end
