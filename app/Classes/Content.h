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
#import "EventLocation.h"

@class Content;

@interface Content : NSObject {
	NSMutableArray *events;
//	NSMutableArray *filteredEvents;
//	NSMutableArray *oldEvents; /* Holds the events that are filtered because they are no longer valid */
	NSMutableArray *filters;
	NSMutableArray *artists;
	NSMutableArray *locations;
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

/* adding event and artist */
-(BOOL)addArtist:(EventArtist *)artist;
-(BOOL)addEvent:(Event *)event;
-(BOOL)addLocation: (EventLocation *)location;

/* Type is true if this is an AND Filter and false if this is an OR filter */
-(BOOL)addFilter: (Filter *) filter;
-(BOOL)removeFilter: (Filter *) filter;
-(BOOL)replaceFilter: (Filter *) oldFilter WithFilter: (Filter *) newFilter;

/*-(BOOL)addFilter: (Filter *) filter AndFilter: (BOOL) type;
-(BOOL)removeFilter: (Filter *) filter AndFilter: (BOOL) type;
-(BOOL)replaceFilter: (Filter *) oldFilter WithFilter: (Filter *) newFilter AndFilter: (BOOL) type;
*/

/* These methods are private */
/*-(void)addAndFilter: (Filter *) filter;
-(void)removeAndFilter;
-(void)addOrFilter: (Filter *) filter;
-(void)removeOrFilter;
*/

/* Filter Mode methods */
/*-(void)switchToAndFilters;
-(void)switchToOrFilters;
*/

/* Filtering Helper Methods these methods are private */
/*-(BOOL)checkName: (Event *) event withFilter: (Filter *) filter;
-(BOOL)checkArtist: (Event *) event withFilter: (Filter *) filter;
-(BOOL)checkTime: (Event *) event withFilter: (Filter *) filter;
-(BOOL)checkCost: (Event *) event withFilter: (Filter *) filter;
-(BOOL)checkDuration: (Event *) event withFilter: (Filter *) filter;
-(BOOL)checkLocation: (Event *) event withFilter: (Filter *) filter;
*/

-(Event *)getEventAtIndex: (int) index;
-(EventArtist *)getArtistAtIndex: (int) index;
-(Filter *)getFilterAtIndex: (int) index;
-(EventLocation *)getLocationAtIndex: (int) index;

-(NSMutableArray *)getEvents;
//-(NSMutableArray *)getFilteredEvents;
-(NSMutableArray *)getFilters;
-(NSMutableArray *)getArtists;
-(NSMutableArray *)getLocations;

-(NSInteger)getEventCount;
//-(NSInteger)getDisplayedEventCount;
//-(NSInteger)getFilteredEventCount;
-(NSInteger)getFilterCount;
-(NSInteger)getArtistCount;
-(NSInteger)getLocationCount;

@end
