//
//  EventArtist.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventArtist : NSObject {
	NSString *name;
	NSString *description;
	
	NSMutableArray *events; /* List of events for this artist */

}

/* Initializers */
-(EventArtist *)initializeArtist: (NSString *) n Description: (NSString *) desc;

/* Getters and Setters */
-(void)setName: (NSString *) str;
-(NSString *)getName;

-(void)setDescription: (NSString *) str;
-(NSString *)getDescription;

/* End Getters and Setters */

@end
