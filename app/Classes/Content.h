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

@interface Content : NSObject {
	NSMutableArray *events;
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

/* Don't call used to set up the singleton use getInstance instead */
-(Content *)getContent; 


/* adding event and artist */
-(BOOL)addArtist:(EventArtist *)artist;
-(BOOL)addEvent:(Event *)event;
-(BOOL)addLocation: (EventLocation *)location;
-(BOOL)addSelfCuratedEntry:(SelfCuratedEntry *)selfCuratedEntry;

/* Type is true if this is an AND Filter and false if this is an OR filter */
-(BOOL)addFilter: (Filter *) filter;
-(BOOL)removeFilter: (Filter *) filter;
-(BOOL)replaceFilter: (Filter *) oldFilter WithFilter: (Filter *) newFilter;

-(Event *)getEventAtIndex: (int) index;
-(EventArtist *)getArtistAtIndex: (int) index;
-(Filter *)getFilterAtIndex: (int) index;
-(EventLocation *)getLocationAtIndex: (int) index;
-(SelfCuratedEntry *)getSelfCuratedEntryAtIndex: (int) index;
-(AboutUs *)getAboutUs;

-(NSMutableArray *)getEvents;
-(NSMutableArray *)getFilters;
-(NSMutableArray *)getArtists;
-(NSMutableArray *)getLocations;
-(NSMutableArray *)getSelfCuratedEntries;

-(NSMutableArray *)getEventsForArtist: (EventArtist *)artist;
-(NSMutableArray *)getEventsForLocation: (EventLocation *)location;


-(NSInteger)getEventCount;
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
