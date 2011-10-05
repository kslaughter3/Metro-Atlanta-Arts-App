//
//  Content.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Filter.h"
#import "Event.h"

@interface Content : NSObject {
	NSMutableArray *displayedEvents;
	NSMutableArray *filteredEvents;
	NSMutableArray *oldEvents; /* Holds the events that are filtered because they are no longer valid */
	NSMutableArray *filters;
	
}

/* Gets all the events from the database and stores them in the events array 
   Also calls filterOldEvents to remove any events in the database that are out of date 
   Returns true if the update was successful false otherwise */
-(Content *)getContent; /* TODO: Fix this to connect to the database/web service */

/* Filters all the events that are no longer valid */
-(void)filterOldEvents;

/* Filtering methods */

/* Type is true if this is an AND Filter and false if this is an OR filter */
-(bool)addFilter: (Filter *) filter AndFilter: (bool) type;
-(bool)removeFilter: (Filter *) filter AndFilter: (bool) type;

/* These methods are private */
-(void)addAndFilter: (Filter *) filter;
-(void)removeAndFilter;
-(void)addOrFilter: (Filter *) filter;
-(void)removeOrFilter;

/* Filter Mode methods */
-(void)switchToAndFilters;
-(void)switchToOrFilters;

/* Filtering Helper Methods these methods are private */
-(bool)checkName: (Event *) event withFilter: (Filter *) filter;
-(bool)checkArtist: (Event *) event withFilter: (Filter *) filter;
-(bool)checkTime: (Event *) event withFilter: (Filter *) filter;
-(bool)checkCost: (Event *) event withFilter: (Filter *) filter;
-(bool)checkDuration: (Event *) event withFilter: (Filter *) filter;
-(bool)checkLocation: (Event *) event withFilter: (Filter *) filter;

-(NSMutableArray *)getDisplayedEvents;

-(NSMutableArray *)getFilteredEvents;

@end
