//
//  EventAnnotation.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/3/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/*******************************************************
 * Event Annotation Class
 *
 * Holds the information displayed in a pin annotation
 * Holds a pointer to the event associated with the pin
 *
 *******************************************************/

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Event.h"


@interface EventAnnotation : NSObject <MKAnnotation>
{
    UIImage *image;
    NSNumber *latitude;
    NSNumber *longitude;
	Event *event;
	NSAutoreleasePool *pool;
}

-(EventAnnotation *)initAnnotationWithEvent: (Event *) event;

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) Event *event;

@end
