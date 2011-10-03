//
// Event.h
// Metro-Atlanta-Arts-App
//
// Created by Gendreau, Anthony S on 9/28/11.
// Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Event : NSObject {
	NSString *name; /* Name of the Event */
	NSString *artist; /* Name of the Artist (where applicable) */
	NSString *description; /* Description of Event */
	NSURL *website; /* Website URL */
	NSString *address; /* Street Address of Event */
	NSString *city; /* City of Address (Atlanta) */
	NSString *state; /* State of Address (Georgia) */
	NSString *zip; /* Zip of Address */
	CLLocation *location; /* Location of Event (Lat/Lon) */
	NSDate *startDate; /* Start Date and Time */
	NSDate *endDate; /* End Date and Time */
	int duration; /* Duration of the Event (in minutes)*/
	double cost; /* Cost of the Event */
}

/* Initializer */
-(Event *)initEventWithName: (NSString *) n Artist: (NSString *) a Description: (NSString *) desc
					Website: (NSURL *) url Address: (NSString *) add City: (NSString *) c State: (NSString *) s
						Zip: (NSString *) z Start: (NSDate *) start End: (NSDate *) end
				   Duration: (int) length Cost: (double) price;

/* I don't know if this makes sense but I wrote it anyway */
-(void)print;

/* Getters and Setters */

-(void)setEventName: (NSString *) str;
-(NSString *)getEventName;

-(void)setArtist: (NSString *) str;
-(NSString *)getArtist;

-(void)setDescription: (NSString *) str;
-(NSString *)getDescription;

-(void)setWebsite: (NSURL *) url;
-(NSURL *)getWebsite;

-(void)setAddress: (NSString *) str;
-(NSString *)getAddress;

-(void)setCity: (NSString *) str;
-(NSString *)getCity;

-(void)setState: (NSString *) str;
-(NSString *)getState;

-(void)setZip: (NSString *) str;
-(NSString *)getZip;

-(void)setLocation: (CLLocation *) loc;
-(CLLocation * )getLocation;

-(void)setStartDate: (NSDate *) date;
-(NSDate *)getStartDate;

-(void)setEndDate: (NSDate *) date;
-(NSDate *)getEndDate;

-(void)setDuration: (int) length;
-(int)getDuration;

-(void)setCost: (double) price;
-(double)getCost;

/* End Getters and Setters */

/* Helper Methods */

/*Sets the location (lat/lon) based on the street address */
-(void)setLocationFromAddress;

/* End Helper Methods */

/* Filter Methods */

/* Returns true if the event's name begins with the given name false otherwise */
-(bool)NameFilter: (NSString *) str;

/* Returns true if the event's artist begins with the given artist false otherwise */
-(bool)ArtistFilter: (NSString *) str;

/* Returns true if the time of this event occurs between the given start and end times */
-(bool)TimeFilterStart: (NSDate *) start andEnd: (NSDate *) end;

/* Returns true if the cost of this event is between the given min and max costs */
-(bool)CostFilterMin: (double) min andMax: (double) max;

/* Returns true if the duration of this event is between the given min and max durations */
-(bool)DurationFilterMin:(int)min andMax:(int)max;

/*Returns true if the location of this event is within the given radius of the given Location */
-(bool)LocationFilterLoc: (CLLocation *) loc andRadius: (double) rad;

/* End Filter Methods */

@end

