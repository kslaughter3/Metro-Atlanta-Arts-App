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

static Content *instance;

@interface Content () <SBJsonStreamParserAdapterDelegate>
@end


@implementation Content

+(Content *)getInstance {
	if(instance == nil) {
		instance = [[Content alloc] getContent];
	}
	
	if(instance != nil) {
		[instance populateEvents];
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

-(Content *)getContent {
	self = [super init];
	
	if(self != nil)
	{
		NSLog(@"object didnt exist");
		events = [[NSMutableArray alloc] init];
		locations = [[NSMutableArray alloc] init];
		artists = [[NSMutableArray alloc] init];
		filters = [[NSMutableArray alloc] init];
		
		/* TODO: Get events from database */
		NSLog(@"Call populate");
		[self populateEvents];
		//[self filterOldEvents];
		
		return self;
	}
	
	return nil;
}

//-(void)filterOldEvents {
//}
-(BOOL)addArtist: (EventArtist *) artist{
	/* Check to see if the filter is nil or invalid */
	if(artist == nil) {
		return NO;
	}

	if([artists	 containsObject: artist] == NO) {
		[artists addObject: artist];
	}
	
	return YES;
}
-(BOOL)addEvent: (Event *) event{
	/* Check to see if the filter is nil or invalid */
	if(event == nil) {
		return NO;
	}
	
	if([events containsObject: event] == NO) {
		[events addObject: event];
	}
	
	return YES;
}

-(BOOL)addLocation: (EventLocation *) location {
	if(location == nil) {
		return NO;
	}
	
	if([locations containsObject: location] == NO) {
		[locations addObject: location];
	}
	
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
	}
	
	return YES;
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
	
	int index = [filters indexOfObjectIdenticalTo: oldFilter];
	
	if(index == -1) {
		return NO;
	}
	
	[filters replaceObjectAtIndex:index withObject:newFilter];
	
	return YES;
}

/* And Filters
-(void)addAndFilter: (Filter *) filter {
	
	for(id event in events) {
		switch ([filter getFilterType])
		{
			case NameFilterType:
				if([self checkName: event withFilter: filter] == NO) {
					[events removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case ArtistFilterType:
				if([self checkArtist: event withFilter: filter] == NO) {
					[events removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case TimeFilterType:
				if([self checkTime: event withFilter: filter] == NO) {
					[events removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case CostFilterType:
				if([self checkCost: event withFilter: filter] == NO) {
					[events removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case DurationFilterType:
				if([self checkDuration: event withFilter: filter] == NO) {
					[events removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case LocationFilterType:
				if([self checkLocation: event withFilter: filter] == NO) {
					[events removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			default:
				// Should never happen 
				break;
		}
	}
}

-(void)removeAndFilter {
	BOOL failed = NO;
	
	// Loop over the filtered out events for ones that no longer fail any of the filters 
	for(id event in filteredEvents) {
		for(id f in filters) {
			switch ([(Filter *)f getFilterType]) {
				case NameFilterType:
					if([self checkName: event withFilter: f] == NO) {
						failed = YES;
					}
					break;
				case ArtistFilterType:
					if([self checkArtist: event withFilter: f] == NO) {
						failed = YES;
					}
					break;
				case TimeFilterType:
					if([self checkTime: event withFilter: f] == NO) {
						failed = YES;
					}
					break;
				case CostFilterType:
					if([self checkCost: event withFilter: f] == NO) {
						failed = YES;
					}
					break;
				case DurationFilterType:
					if([self checkDuration: event withFilter: f] == NO) {
						failed = YES;
					}
					break;
				case LocationFilterType:
					if([self checkLocation: event withFilter: f] == NO) {
						failed = YES;
					}
					break;
				default:
					// Should never happen 
					break;
			}
			
			// failed go to the next event 
			if(failed == YES) {
				break;
			}
		}
		
		// Check to see if it passed all the filters and move the event if necessary
		if(failed == NO) {
			[filteredEvents removeObjectIdenticalTo: event];
			[events addObject: event];
		}
		
		// reset the failed flag 
		failed = NO;
	}
}

/* OR Filter
-(void)addOrFilter: (Filter *) filter {
	
	for(id event in filteredEvents) {
		switch ([filter getFilterType])
		{
			case NameFilterType:
				if([self checkName: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[events addObject: event];
				}
				break;
			case ArtistFilterType:
				if([self checkArtist: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[events addObject: event];
				}
				break;
			case TimeFilterType:
				if([self checkTime: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[events addObject: event];
				}
				break;
			case CostFilterType:
				if([self checkCost: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[events addObject: event];
				}
				break;
			case DurationFilterType:
				if([self checkDuration: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[events addObject: event];
				}
				break;
			case LocationFilterType:
				if([self checkLocation: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[events addObject: event];
				}
				break;
			default:
				// Should never happen 
				break;
		}
	}
}

-(void)removeOrFilter {
	BOOL passed = NO;
	
	// Loop over the displayed out events for ones that no longer pass any of the filters 
	for(id event in events) {
		for(id f in filters) {
			switch ([(Filter *)f getFilterType]) {
				case NameFilterType:
					if([self checkName: event withFilter: f] == YES) {
						passed = YES;
					}
					break;
				case ArtistFilterType:
					if([self checkArtist: event withFilter: f] == YES) {
						passed = YES;
					}
					break;
				case TimeFilterType:
					if([self checkTime: event withFilter: f] == YES) {
						passed = YES;
					}
					break;
				case CostFilterType:
					if([self checkCost: event withFilter: f] == YES) {
						passed = YES;
					}
					break;
				case DurationFilterType:
					if([self checkDuration: event withFilter: f] == YES) {
						passed = YES;
					}
					break;
				case LocationFilterType:
					if([self checkLocation: event withFilter: f] == YES) {
						passed = YES;
					}
					break;
				default:
					// Should never happen
					break;
			}
			
			// failed go to the next event 
			if(passed == YES) {
				break;
			}
		}
		
		// Check to see if it passed all the filters and move the event if necessary
		if(passed == NO) {
			[events removeObjectIdenticalTo: event];
			[filteredEvents addObject: event];
		}
		
		// reset the failed flag
		passed = NO;
	}
}

/* Switch the filter mode
-(void)switchToAndFilters {
	[events addObjectsFromArray: filteredEvents];
	[filteredEvents removeAllObjects];
	
	for(id f in filters) {
		[self addAndFilter: (Filter *)f];
	}
}


-(void)switchToOrFilters {
	[events addObjectsFromArray: filteredEvents];
	[filteredEvents removeAllObjects];
	
	for(id f in filters) {
		[self addOrFilter: (Filter *)f];
	}
}*/

/*
-(BOOL)checkName: (Event *) event withFilter: (Filter *) filter {
	return [event NameFilter: [filter getFiltererName]];
}

-(BOOL)checkArtist: (Event *) event withFilter: (Filter *) filter {
	return [event ArtistFilter: [filter getFiltererArtist]];
}
	
-(BOOL)checkTime: (Event *) event withFilter: (Filter *) filter {
	return [event TimeFilterStart: [filter getFiltererStartTime] 
						   andEnd: [filter getFiltererEndTime]];
}
	
-(BOOL)checkCost: (Event *) event withFilter: (Filter *) filter {
	return [event CostFilterMin: [filter getFiltererMinCost] 
						 andMax: [filter getFiltererMaxCost]]; 
}
	
-(BOOL)checkDuration: (Event *) event withFilter: (Filter *) filter {
	return [event DurationFilterMin: [filter getFiltererMinDuration]
							 andMax: [filter getFiltererMaxDuration]];
}
	
-(BOOL)checkLocation: (Event *) event withFilter: (Filter *) filter {
	return [event LocationFilterLoc: [filter getFiltererLocation]
						  andRadius: [filter getFiltererRadius]];
}
*/

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

-(AboutUs *)getAboutUs {
	[self populateAboutUs]; //For Testing remove once the server does this
	return myAboutUs;
}

-(NSMutableArray *)getEvents {
	return events;
}

/*-(NSMutableArray *)getFilteredEvents {
	return filteredEvents;
}*/

-(NSMutableArray *)getFilters {
	return filters;
}

-(NSMutableArray *)getArtists {
	return artists;
}

-(NSMutableArray *)getLocations {
	return locations;
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

/*-(NSInteger)getDisplayedEventCount {
	return events.count;
}

-(NSInteger)getFilteredEventCount {
	return filteredEvents.count;
}
*/

-(NSInteger)getFilterCount {
	return filters.count;
}

-(NSInteger)getArtistCount {
	return artists.count;
}

-(NSInteger)getLocationCount {
	return locations.count;
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

@end
