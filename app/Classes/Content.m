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

//event 1
//artist 2
//location 3
//selfcurated 4
int type=0;

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
	listReady=0;
	mapReady=0;
	[events removeAllObjects];
	NSString *url = [self buildEventRequest];
	type=1;
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
}

-(void)populateArtists {
	listReady = 0;
	[artists removeAllObjects];
	NSString *url = [self buildArtistRequest];
	type=2;
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];	
	
}

-(void)populateLocations {
	listReady = 0;
	[locations removeAllObjects];
	NSString *url = [self buildLocationRequest];
	type=3;
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
}

-(int)getListReady{
	return listReady;
}
-(void)setListReady: (int) arg{
	listReady=arg;
}

-(int)getMapReady{
	return mapReady;
}
-(void)setMapReady: (int) arg{
	mapReady=arg;
}

-(int)getSelfCuratedReady{
	return selfCuratedReady;
}
-(void)setSelfCuratedReady: (int) arg{
	selfCuratedReady=arg;
}

-(void)populateSelfCurated {
	selfCuratedReady = 0;
	[selfCuratedEntries removeAllObjects];
	NSString *url = [self buildSelfCuratedRequest];
	type=4;
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
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
	NSString *request = [NSString stringWithFormat: @"http://meta.gimmefiction.com/?type=event&page=%d", myEventPage];
	
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
	NSString *request = [NSString stringWithFormat: @"http://meta.gimmefiction.com/?type=artist&page=%d", myArtistPage];
	return request;
}

-(NSString *)buildLocationRequest {
	//Request Looks like "LocationRequest:page=<page>;"
	NSString *request = [NSString stringWithFormat: @"http://meta.gimmefiction.com/?type=location&page=%d", myLocationPage];
	
	return request;
}

-(NSString *)buildSelfCuratedRequest {
	//Request Looks like "SelfCuratedRequest:page=<page>;"
	NSString *request = [NSString stringWithFormat:@"http://meta.gimmefiction.com/?type=selfcurated&page=%d", mySelfCuratedPage];
	
	return request;
}

-(Content *)getContent {
	self = [super init];
	
	if(self != nil)
	{
		pool = [[NSAutoreleasePool alloc] init];
		events = [[NSMutableArray alloc] init];
		locations = [[NSMutableArray alloc] init];
		artists = [[NSMutableArray alloc] init];
		filters = [[NSMutableArray alloc] init];
		selfCuratedEntries = [[NSMutableArray alloc] init];
		
		//Set up connection stuff
		adapter = [[SBJsonStreamParserAdapter alloc] init];
		adapter.delegate = self;
		parser = [[SBJsonStreamParser alloc] init];
		parser.delegate = adapter;
		parser.supportMultipleDocuments = YES;
		
		//Start on the first page
		myEventPage = 1;
		myArtistPage = 1;
		myLocationPage = 1;
		mySelfCuratedPage = 1;
		
		//Start with the first type
		myEventType = FirstEventType;

	/*  Don't Do this until the data is requested
		[self populateEvents];
		[self populateArtists];
		[self populateLocations];
		[self populateSelfCurated];
		[self populateAboutUs];
	*/	
		//TODO: Get these from server
		lastEventPage = 3;
		lastArtistPage = 3;
		lastLocationPage = 3;
		lastSelfCuratedPage = 3;

		return self;
	}
	
	return nil;
}

-(BOOL)addArtist: (EventArtist *) artist{
	/* Check to see if the filter is nil or invalid */
	if(artist == nil) {
		return NO;
	}
	
	for(id a in artists) 
	{
		if([artist isArtistIDEqual:(EventArtist *)a]) {
			return NO;
		}
	}
		
	[artists addObject: artist];
		return YES;
}
-(BOOL)addEvent: (Event *) event{
	/* Check to see if the filter is nil or invalid */
	if(event == nil) {
		return NO;
	}
	
	for(id e in events)
	{
		if([event isEventIDEqual:(Event *)e]) {
			return NO;
		}
	}
	
	[events addObject: event];
	return YES;
}

-(BOOL)addLocation: (EventLocation *) location {
	if(location == nil) {
		return NO;
	}
	
	for(id l in locations)
	{
		if([location isLocationIDEqual:(EventLocation *)l]) {
			return NO;
		}
	}
	
	[locations addObject: location];
	return YES;
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
		if(type==1){
			if(![dic objectForKey: @"event_id"]){
				continue;
			}
			NSLog(@"Event");
			NSLog(@"event struct=%@",dic);
			NSString* idstring = [[NSString alloc] initWithString:(NSString *)[dic objectForKey: @"event_id"]];
			NSString* astr=[[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"name"]];
			NSLog(@"idstring=%@",idstring);
			NSString* astr2;
			NSString* astr3;
			NSString* astr5;
			NSString* astr6;
			NSString* locId;
			if(![dic objectForKey:@"description"]){
				astr2=@"null";
			} else {
				NSLog(@"%@",[dic objectForKey:@"description"]);
				astr2=[[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"description"]];
			}
			if(![dic objectForKey:@"address"]){
				astr3=@"null";
			} else {
				NSLog(@"%@",[dic objectForKey:@"address"]);
				astr3=[[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"address"]];
			}
			locId = [[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"location_id"]];
			if(![dic objectForKey:@"lat"]){
				astr5=@"null";
			} else {
				NSLog(@"%@",[dic objectForKey:@"lat"]);
				astr5=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"lat"]  ]];
			}
			if(![dic objectForKey:@"lng"]){
				astr6=@"null";
			} else {
				NSLog(@"%@",[dic objectForKey:@"lng"]);
				astr6=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"lng"]  ]];
			}
			Event* eve=[[Event alloc] initEmptyEvent];
			EventLocation* loc=[[EventLocation alloc] initEmptyLocation];
			[eve setEventID:[idstring intValue]];
			[eve setEventName:astr];
			[eve setDescription:astr2];
			[loc setLocationID:[locId intValue]];
			[loc setName:astr3];
			[loc setDescription:astr2];
			CLLocationCoordinate2D coord;
			coord.latitude = [astr5 floatValue];
			coord.longitude = [astr6 floatValue];
			[loc setCoordinates:coord];
			[eve setLocation:loc];
			[self addEvent:eve];
		} else if(type==2) {
			if(![dic objectForKey: @"artist_id"]){
				continue;
			}
			NSLog(@"Artist");
			NSLog(@"artist struct=%@",dic);
			NSString* astr=[[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"name"]];
			if(astr==NULL) { astr=@"null"; }
			NSString* astr2=[[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"description"]];
			if(astr2==NULL) { astr2=@"null"; }
			NSString* astr3=[[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"image"]];
			if(astr3==NULL) { astr3=@"null"; }
			NSString* astr4=[[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"website"]];
			if(astr4==NULL) { astr4=@"null"; }
			NSString* astr5=[[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"website"]];
			if(astr5==NULL) { astr5=@"null"; }
			int aint=[astr5 intValue];
			EventArtist* art=[[EventArtist alloc] initEmptyArtist];
			[art setName:astr];
			[art setDescription:astr2];
			[art setImageURL:astr3];
			[art setWebsite:astr4];
			[art setArtistID:aint];
			[self addArtist:art];
		} else if(type==3) {
			if(![dic objectForKey: @"location_id"]){
				continue;
			}
			NSLog(@"Location");
			NSLog(@"location struct=%@",dic);
			NSString* astr=[[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"name"]];
			if(astr==NULL) { astr=@"null"; }
			NSString* astr2;
			NSString* astr3;
			NSString* astr4;
			NSString* astr5;
			NSString* astr6;
			NSString* locID;
			locID = [[NSString alloc] initWithString:(NSString *)[dic objectForKey:@"location_id"]];
			
			if(![dic objectForKey:@"address"]){
				astr2=@"null";
			} else {
				NSLog(@"%@",[dic objectForKey:@"address"]);
				astr2=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]]];
			}
			
			if(![dic objectForKey:@"description"]){
				astr3=@"null";
			} else {
				NSLog(@"%@",[dic objectForKey:@"description"]);
				astr3=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"description"]]];
			}
			
			if(![dic objectForKey:@"image"]){
				astr4=@"null";
			} else {
				NSLog(@"%@",[dic objectForKey:@"image"]);
				astr4=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"image"]]];
			}
			
			if(![dic objectForKey:@"lat"]){
				astr5=@"null";
			} else {
				NSLog(@"%@",[dic objectForKey:@"lat"]);
				astr5=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"lat"]]];
			}
			if(![dic objectForKey:@"lng"]){
				astr6=@"null";
			} else {
				NSLog(@"%@",[dic objectForKey:@"lng"]);
				astr6=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"lng"]  ]];
			}
			
			EventLocation* loc=[[EventLocation alloc] initEmptyLocation];
			[loc setLocationID: [locID intValue]];
			[loc setName:astr];
			[loc setDescription:astr2];
			[loc setImage:astr3];
			[loc setWebsite:astr4];
			CLLocationCoordinate2D coord;
			coord.latitude = [astr5 floatValue];
			coord.longitude = [astr6 floatValue];
			[loc setCoordinates:coord];
			[self addLocation:loc];
		} else if(type==4) {
			//TODO: Handle the SelfCurated list
		}
	}
	
	//TODO: Should these be set based on the type of response
	selfCuratedReady=1;
	listReady=1;
	mapReady=1;
	
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
	[pool release];
	[super dealloc];
}

@end
