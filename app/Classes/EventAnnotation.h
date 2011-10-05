//
//  EventAnnotation.h
//  Metro-Atlanta-Arts-App
//
//  Created by Slaughter, Kevin P on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface EventAnnotation : NSObject <MKAnnotation>
{
    UIImage *image;
    NSNumber *latitude;
    NSNumber *longitude;
	
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;

@end