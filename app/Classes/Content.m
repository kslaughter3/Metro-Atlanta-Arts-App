//
//  Content.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Content.h"
#import "Filter.h"
#import "Event.h"
#import "EventArtist.h"
#import "json/SBJson.h"
#import "SelfCuratedEntry.h"

static Content *instance;
static NSString *instanceLock = @"instanceLock";

@interface Content () <SBJsonStreamParserAdapterDelegate>
@end


@implementation Content

+(Content *)getInstance {
	
	@synchronized(instanceLock) 
	{
		if(instance == nil) {
			instance = [[Content alloc] getContent];
		}
	}
	
	if(instance != nil) {
		return instance;
	}
	
	//Something bad happened 
	return nil;
}


-(void)populateEvents {
	adapter = [[SBJsonStreamParserAdapter alloc] init];
	adapter.delegate = self;
	parser = [[SBJsonStreamParser alloc] init];
	parser.delegate = adapter;
	parser.supportMultipleDocuments = YES;
	NSString *url = @"http://meta.gimmefiction.com/";
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
}

-(void)populateArtists {
}

-(void)populateLocations {
}

-(void)populateSelfCurated {
}

-(void)populateAboutUs {
	//TEST aboutUS 
	if(myAboutUs == nil) {
		myAboutUs = [[AboutUs alloc] initEmptyAboutUs];
	}
	
	[myAboutUs setName:@"Metro Atlanta Arts Foundation"];
	[myAboutUs setDescription:@"We are a non profit conglumorate of over twenty arts organizations "\
		"in the Atlanta area dedicated to bringing the arts to the those interested. "\
		"We developed this app to allow people to view the art events going on in the Atlanta area. "\
		"This app was developed as a Senior Design Project by five students from Georgia Institute of Technology. "\
		"Those students are: Anthony Gendreau, Drew Bratcher, Hyuk Jun Park, Kevin Slaughter, and Will Hancock. "\
		"The icons in used in this app were provided by Glyphish who can be found at http://glyphish.com."];
	
	[myAboutUs setImage:@"http://www.metroatlantaartsfund.org/images/maaf_logo.gif"];
	[myAboutUs setWebsite:@"http://www.metroatlantaartsfund.org/"];
}

-(NSString *)buildEventRequest {
	//Request looks like "EventRequest:type=<type>;page=<page>;<filterlist (semi colon separated)>;
	NSString *request = [NSString stringWithFormat: @"EventRequest:type=%@;page=%d;", 
						 [self getEventTypeString], myEventPage];
	
	for(id filter in filters) {
		if([(Filter *)filter isEnabled] == YES) {
			request = [request stringByAppendingString: 
				[Filter buildFilterString: filter]];
		}
	}
	
	return request;
}

-(NSString *)buildArtistRequest {
	//Request Looks like "ArtistRequest:page=<page>;"
	NSString *request = [NSString stringWithFormat:@"ArtistRequest:page=%d;",
						 myArtistPage];
	return request;
}

-(NSString *)buildLocationRequest {
	//Request Looks like "LocationRequest:page=<page>;"
	NSString *request = [NSString stringWithFormat:@"LocationRequest:page=%d;",
						 myLocationPage];
	
	return request;
}

-(NSString *)buildSelfCuratedRequest {
	//Request Looks like "SelfCuratedRequest:page=<page>;"
	NSString *request = [NSString stringWithFormat:@"SelfCuratedRequest:page=%d;",
						 mySelfCuratedPage];
	
	return request;
}

-(Content *)getContent {
	self = [super init];
	
	if(self != nil)
	{
		events = [[NSMutableArray alloc] init];
		locations = [[NSMutableArray alloc] init];
		artists = [[NSMutableArray alloc] init];
		filters = [[NSMutableArray alloc] init];
		selfCuratedEntries = [[NSMutableArray alloc] init];
		
		//Start on the first page
		myEventPage = 1;
		myArtistPage = 1;
		myLocationPage = 1;
		mySelfCuratedPage = 1;
		
		//Start with the first type
		myEventType = FirstEventType;

		[self populateEvents];
		[self populateArtists];
		[self populateLocations];
		[self populateSelfCurated];
		[self populateAboutUs];
		
		//TODO: Get these from server in the populate methods
		lastEventPage = 10;
		lastArtistPage = 10;
		lastLocationPage = 10;
		lastSelfCuratedPage = 10;

		return self;
	}
	
	return nil;
}

-(BOOL)addArtist: (EventArtist *) artist{
	/* Check to see if the filter is nil or invalid */
	if(artist == nil) {
		return NO;
	}

	if([artists	 containsObject: artist] == NO) {
		[artists addObject: artist];
		return YES;
	}
	
	return NO;
}
-(BOOL)addEvent: (Event *) event{
	/* Check to see if the filter is nil or invalid */
	if(event == nil) {
		return NO;
	}
	
	if([events containsObject: event] == NO) {
		[events addObject: event];
		return YES;
	}
	
	return NO;
}

-(BOOL)addLocation: (EventLocation *) location {
	if(location == nil) {
		return NO;
	}
	
	if([locations containsObject: location] == NO) {
		[locations addObject: location];
		return YES;
	}
	
	return NO;
}

-(BOOL)addFilter: (Filter *) filter {
	/* Check to see if the filter is nil or invalid */
	if(filter == nil) {
		return NO;
	}

	Filterer *filterer = [filter getFilterer];
	
	if([filter checkFilterer: filterer] == NO) {
		return NO;
	}
	
	/* Add the filter */
	if([filters containsObject: filter] == NO) {
		[filters addObject: filter];
		return YES;
	}
	
	return NO;
}

-(BOOL)addSelfCuratedEntry:	(SelfCuratedEntry *) selfCuratedEntry{
	if(selfCuratedEntry == nil){
		return NO;
	}
	
	if([selfCuratedEntries containsObject: selfCuratedEntry] == NO){
		[selfCuratedEntries addObject: selfCuratedEntry];
		return YES;
	}
	
	return NO;
}

-(BOOL)removeFilter: (Filter *) filter {
	
	/* Check to see if the filter is nil or invalid */
	if(filter == nil) {
		return NO;
	}
	
	Filterer *filterer = [filter getFilterer];
	
	if([filter checkFilterer: filterer] == NO) {
		return NO;
	}
	
	/* Remove the filter */
	[filters removeObjectIdenticalTo: filter];
	[filter release];
	
	return YES;
}

-(BOOL)replaceFilter:(Filter *)oldFilter WithFilter:(Filter *)newFilter {
	if(oldFilter == nil || newFilter == nil) {
		return NO;
	}
	
	Filterer *filterer = [newFilter getFilterer];
	
	if([newFilter checkFilterer: filterer] == NO) {
		return NO;
	}
	
	if([filters containsObject: newFilter]) {
		return NO;
	}
	
	int index = [filters indexOfObjectIdenticalTo: oldFilter];
	
	if(index == -1) {
		return NO;
	}
	
	[filters replaceObjectAtIndex:index withObject:newFilter];
	[oldFilter release];
	
	return YES;
}

-(Event *)getEventAtIndex:(int)index {
	if(index < 0 || index >= [self getEventCount]) {
		return nil;
	}
	
	return (Event *)[events objectAtIndex: index];
}

-(EventArtist *)getArtistAtIndex:(int)index {
	if(index < 0 || index >= [self getArtistCount]) {
		return nil;
	}
	
	return (EventArtist *)[artists objectAtIndex: index];
}

-(Filter *)getFilterAtIndex:(int)index {
	if(index < 0 || index >= [self getFilterCount]) {
		return nil;
	}
	
	return (Filter *)[filters objectAtIndex: index];
}

-(EventLocation *)getLocationAtIndex:(int)index {
	if(index < 0 || index >= [self getLocationCount]) {
		return nil;
	}
	
	return (EventLocation *)[locations objectAtIndex: index];
}

-(SelfCuratedEntry *)getSelfCuratedEntryAtIndex:(int)index {
	if(index < 0 || index >= [self getSelfCuratedEntryCount]) {
		return nil;
	}
	
	return (SelfCuratedEntry *)[selfCuratedEntries objectAtIndex: index];
}

-(AboutUs *)getAboutUs {
	return myAboutUs;
}

-(NSMutableArray *)getEvents {
	return events;
}

-(NSMutableArray *)getFilters {
	return filters;
}

-(NSMutableArray *)getArtists {
	return artists;
}

-(NSMutableArray *)getLocations {
	return locations;
}

-(NSMutableArray *)getSelfCuratedEntries {
	return selfCuratedEntries;
}

-(NSMutableArray *)getEventsForArtist:(EventArtist *)artist {
	NSMutableArray *temp = [[NSMutableArray alloc] init];
	
	for(id event in events) {
		for(id art in [(Event *)event getArtists]) {
			if([artist isArtistIDEqual:(EventArtist *)art]) {
				[temp addObject: event];
				break;
			}
		}
	}
	
	return temp;
}

-(NSMutableArray *)getEventsForLocation:(EventLocation *)location {
	NSMutableArray *temp = [[NSMutableArray alloc] init];
	
	for (id event in events) {
		if([location isLocationIDEqual:[(Event *)event getLocation]]) {
			[temp addObject: event];
		}
	}
	
	return temp;
}


-(NSInteger)getEventCount {
	return events.count;
}

-(NSInteger)getFilterCount {
	return filters.count;
}

-(NSInteger)getArtistCount {
	return artists.count;
}

-(NSInteger)getLocationCount {
	return locations.count;
}

-(NSInteger)getSelfCuratedEntryCount {
	return selfCuratedEntries.count;
}

//READ ONLY 
-(int)getEventLastPage {
	return lastEventPage;
}

-(int)getArtistLastPage {
	return lastArtistPage;
}

-(int)getLocationLastPage {
	return lastLocationPage;
}

-(int)getSelfCuratedLastPage {
	return lastSelfCuratedPage;
}

-(int)getEventPage {
	return myEventPage;
}

-(void)changeEventPage: (BOOL) increment {
	if(increment == YES) {
		myEventPage++;
	}
	else {
		myEventPage--;
	}
}

-(void)resetEventPage {
	myEventPage = 1;
}

-(int)getArtistPage { 
	return myArtistPage;
}

-(void)changeArtistPage: (BOOL) increment {
	if(increment == YES) {
		myArtistPage++;
	}
	else {
		myArtistPage--;
	}
}

-(void)resetArtistPage {
	myArtistPage = 1;
}

-(int)getLocationPage {
	return myLocationPage;
}

-(void)changeLocationPage: (BOOL) increment {
	if(increment == YES) {
		myLocationPage++;
	}
	else {
		myLocationPage--;
	}
}

-(void)resetLocationPage {
	myLocationPage = 1;
}

-(int)getSelfCuratedPage {
	return mySelfCuratedPage;
}

-(void)changeSelfCuratedPage: (BOOL) increment {
	if(increment == YES) {
		mySelfCuratedPage++;
	}
	else {
		mySelfCuratedPage--;
	}
}

-(void)resetSelfCuratedPage {
	mySelfCuratedPage = 1;
}

-(EventType)getEventType {
	return myEventType;
}

-(void)setEventType:(EventType)type {
	myEventType = type;
}

-(NSString *)getEventTypeString {
	switch(myEventType) {
		case EventTypeAll:
			return @EVENTTYPEALL;
			break;
		case EventTypeTwo:
			return @EVENTTYPETWO;
			break;
		case EventTypeThree:
			return @EVENTTYPETHREE;
			break;
		case EventTypeFour:
			return @EVENTTYPEFOUR;
			break;
		case EventTypeFive:
			return @EVENTTYPEFIVE;
			break;
		case EventTypeSix:
			return @EVENTTYPESIX;
			break;
		default:
			return @EVENTTYPEALL;
			break;
	}
}

- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
    [NSException raise:@"unexpected" format:@"Should not get here"];
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {
	tweet.text = [dict objectForKey:@"text"];
}

#pragma mark NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Connection didReceiveResponse: %@ - %@", response, [response MIMEType]);
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"Connection didReceiveAuthenticationChallenge: %@", challenge);
	
	NSURLCredential *credential = [NSURLCredential credentialWithUser:username.text
															 password:password.text
														  persistence:NSURLCredentialPersistenceForSession];
	
	[[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"Connection didReceiveData of length: %u", data.length);
	
	// Parse the new chunk of data. The parser will append it to
	// its internal buffer, then parse from where it left off in
	// the last chunk.
	NSString *payloadAsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSDictionary *jsonobj=[payloadAsString JSONValue];
	for(NSDictionary *dic in jsonobj) {
			NSString* astr=[[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"event_id"]];
		//	NSString* astr2=[[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"descr"]];
			[self addEvent:[[Event alloc] initTestEvent: astr Description: @"description"]];
	}
	NSLog(@"Connection data processed.");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
}

-(void)dealloc {
	[events release];
	[filters release];
	[artists release];
	[locations release];
	[selfCuratedEntries release];
	[myAboutUs release];
	[theConnection release];
	[username release];
	[password release];
	[tweet release];
	[parser release];
	[adapter release];
	[super dealloc];
}

@end
