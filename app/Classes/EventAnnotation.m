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
	[self setEvent:e];
	return self;
}

- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 33.7728837;
    theCoordinate.longitude = -84.393816;;
    return theCoordinate; 
}


- (void)dealloc
{
    [image release];
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
	if(event != nil) return [event getDescription];
    return @"Needs better coordinate";
}

@end
