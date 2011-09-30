//
//  Content.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Content : NSObject {
	NSMutableArray *events;
	NSMutableArray *filteredEvents;
	NSMutableArray *filters;
	
}

/* Gets all the events from the database and stores them in the events array 
   Also calls filterOldEvents to remove any events in the database that are out of date 
   Returns true if the update was successful false otherwise */
-(void)getContent; /* TODO: Fix this to connect to the database/web service */

/* Filters all the events that are no longer valid */
-(void)filterOldEvents;

@end
