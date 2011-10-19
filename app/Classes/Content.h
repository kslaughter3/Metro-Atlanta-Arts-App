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

@class Content;

@interface Content : NSObject {
	NSMutableArray *displayedEvents;
	NSMutableArray *filteredEvents;
//	NSMutableArray *oldEvents; /* Holds the events that are filtered because they are no longer valid */
	NSMutableArray *filters;
	NSMutableArray *artists;
	
}

/* Gets the current instance of the content if there is one 
   if there isn't an instance yet it tries to instaniate one then returns that */
+(Content *)getInstance;


/* Gets all the events from the database and stores them in the events array 
   Also calls filterOldEvents to remove any events in the database that are out of date 
   Returns true if the update was successful false otherwise */
-(Content *)getContent; /* TODO: Fix this to connect to the database/web service */

/* Filters all the events that are no longer valid */
//-(void)filterOldEvents;

/* Filtering methods */

/* Type is true if this is an AND Filter and false if this is an OR filter */
-(BOOL)addFilter: (Filter *) filter AndFilter: (BOOL) type;
-(BOOL)removeFilter: (Filter *) filter AndFilter: (BOOL) type;

/* These methods are private */
-(void)addAndFilter: (Filter *) filter;
-(void)removeAndFilter;
-(void)addOrFilter: (Filter *) filter;
-(void)removeOrFilter;

/* Filter Mode methods */
-(void)switchToAndFilters;
-(void)switchToOrFilters;

/* Filtering Helper Methods these methods are private */
-(BOOL)checkName: (Event *) event withFilter: (Filter *) filter;
-(BOOL)checkArtist: (Event *) event withFilter: (Filter *) filter;
-(BOOL)checkTime: (Event *) event withFilter: (Filter *) filter;
-(BOOL)checkCost: (Event *) event withFilter: (Filter *) filter;
-(BOOL)checkDuration: (Event *) event withFilter: (Filter *) filter;
-(BOOL)checkLocation: (Event *) event withFilter: (Filter *) filter;

-(Event *)getEventAtIndex: (int) index;
-(EventArtist *)getArtistAtIndex: (int) index;
-(Filter *)getFilterAtIndex: (int) index;

-(NSMutableArray *)getDisplayedEvents;
-(NSMutableArray *)getFilteredEvents;
-(NSMutableArray *)getFilters;
-(NSMutableArray *)getArtists;

-(NSInteger)getEventCount;
-(NSInteger)getDisplayedEventCount;
-(NSInteger)getFilteredEventCount;
-(NSInteger)getFilterCount;
-(NSInteger)getArtistCount;

@end
