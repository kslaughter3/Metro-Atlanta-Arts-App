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
#import "AboutUs.h"
#import "SelfCuratedEntry.h"

@class SBJsonStreamParser;
@class SBJsonStreamParserAdapter;

@class Content;

//TODO: Change these to sylvie's types
typedef enum EventType {
	EventTypeAll =		0,
	FirstEventType = EventTypeAll,
	EventTypeTwo,
	EventTypeThree,
	EventTypeFour,
	EventTypeFive,
	EventTypeSix,
	LastEventType = EventTypeSix
} EventType;

#define EVENTTYPEALL		"All"
#define EVENTTYPETWO		"Two"
#define EVENTTYPETHREE		"Three"
#define EVENTTYPEFOUR		"Four"
#define EVENTTYPEFIVE		"Five"
#define EVENTTYPESIX		"Six"

@interface Content : NSObject {
	NSMutableArray *events;
	//	NSMutableArray *filteredEvents;
	//	NSMutableArray *oldEvents; /* Holds the events that are filtered because they are no longer valid */
	NSMutableArray *filters;
	NSMutableArray *artists;
	NSMutableArray *locations;
	NSMutableArray *selfCuratedEntries;
	AboutUs *myAboutUs; //Stores the one copy of about us from the server
    NSURLConnection *theConnection;
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITextView *tweet;
    SBJsonStreamParser *parser;
    SBJsonStreamParserAdapter *adapter;
	EventType myEventType;
	int lastEventPage;
	int lastArtistPage;
	int lastLocationPage;
	int lastSelfCuratedPage;
	int myEventPage;
	int myArtistPage;
	int myLocationPage;
	int mySelfCuratedPage;
}

/* Gets the current instance of the content if there is one 
 if there isn't an instance yet it tries to instaniate one then returns that */
+(Content *)getInstance;
-(void)populateEvents;
-(void)populateArtists; 
-(void)populateLocations;
-(void)populateSelfCurated;
-(void)populateAboutUs;

-(NSString *)buildEventRequest;
-(NSString *)buildArtistRequest;
-(NSString *)buildLocationRequest;
-(NSString *)buildSelfCuratedRequest;


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
-(BOOL)addSelfCuratedEntry:(SelfCuratedEntry *)selfCuratedEntry;

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
-(SelfCuratedEntry *)getSelfCuratedEntryAtIndex: (int) index;
-(AboutUs *)getAboutUs;

-(NSMutableArray *)getEvents;
//-(NSMutableArray *)getFilteredEvents;
-(NSMutableArray *)getFilters;
-(NSMutableArray *)getArtists;
-(NSMutableArray *)getLocations;
-(NSMutableArray *)getSelfCuratedEntries;

-(NSMutableArray *)getEventsForArtist: (EventArtist *)artist;
-(NSMutableArray *)getEventsForLocation: (EventLocation *)location;


-(NSInteger)getEventCount;
//-(NSInteger)getDisplayedEventCount;
//-(NSInteger)getFilteredEventCount;
-(NSInteger)getFilterCount;
-(NSInteger)getArtistCount;
-(NSInteger)getLocationCount;
-(NSInteger)getSelfCuratedEntryCount;

//READ ONLY 
-(int)getEventLastPage;
-(int)getArtistLastPage;
-(int)getLocationLastPage;
-(int)getSelfCuratedLastPage;

-(int)getEventPage;
-(void)changeEventPage: (BOOL) increment;
-(void)resetEventPage;
-(int)getArtistPage;
-(void)changeArtistPage: (BOOL) increment;
-(void)resetArtistPage;
-(int)getLocationPage;
-(void)changeLocationPage: (BOOL) increment;
-(void)resetLocationPage;
-(int)getSelfCuratedPage;
-(void)changeSelfCuratedPage: (BOOL) increment;
-(void)resetSelfCuratedPage;

-(EventType)getEventType;
-(void)setEventType: (EventType)type;
-(NSString *)getEventTypeString;

@end
