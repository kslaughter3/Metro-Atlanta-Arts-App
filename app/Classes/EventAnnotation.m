//
//  EventAnnotation.m
//  Metro-Atlanta-Arts-App
//
//  Created by Slaughter, Kevin P on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventAnnotation.h"


@implementation EventAnnotation

@synthesize image;
@synthesize latitude;
@synthesize longitude;
@synthesize event;

-(EventAnnotation *)initAnnotationWithEvent: (Event *) e{
	self = [super init];
	
	if(self != nil) {
		pool = [[NSAutoreleasePool alloc] init];
		[self setEvent:e];
		NSNumber *lat = [NSNumber numberWithDouble:[[e getLocation] getCoordinates].latitude];
		NSNumber *lon = [NSNumber numberWithDouble:[[e getLocation] getCoordinates].longitude];
		[self setLatitude: lat];
		[self setLongitude: lon];
		return self;
	}
	
	return nil;
}


- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = [latitude doubleValue];
    theCoordinate.longitude = [longitude doubleValue];
    return theCoordinate; 
}


- (void)dealloc
{
    [image release];
	[latitude release];
	[longitude release];
	[event release];
	[pool release];
    [super dealloc];
}

- (NSString *)title
{
	if(event != nil) return [event getEventName];
    return @"Atlanta";
}

// optional
- (NSString *)subtitle
{
	if(event != nil) {
		if([event getLocation] != nil) {
			if([[event getLocation] getName] != nil && 
			   [[[event getLocation] getName] isEqualToString: @""] == NO) {
				return [[event getLocation] getName];
			}
			else if ([[event getLocation] getStreetAddress] != nil && 
					 [[[event getLocation] getStreetAddress] isEqualToString: @""] == NO) {
				return [[event getLocation] getStreetAddress];
			}
		}
		return [event getDescription];
    }
	return @"Needs better coordinate";
}

-(BOOL)isEqual:(id)object {
	EventAnnotation *temp = (EventAnnotation *)object;
	return [event isEventIDEqual: temp.event];
}

@end
