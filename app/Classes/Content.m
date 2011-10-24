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

static Content *instance;

@implementation Content

+(Content *)getInstance {
	if(instance == nil) {
		instance = [[Content alloc] getContent];
	}
	
	if(instance != nil) {
		return instance;
	}
		
	//Something bad happened 
	return nil;
}

-(Content *)getContent {
	self = [super init];
	
	if(self != nil)
	{
		displayedEvents = [[NSMutableArray alloc] init];
		filteredEvents = [[NSMutableArray alloc] init];
		artists = [[NSMutableArray alloc] init];
		filters = [[NSMutableArray alloc] init];
	
		/* TODO: Get events from database */
	
		//[self filterOldEvents];
	
		return self;
	}
	
	return nil;
}

//-(void)filterOldEvents {
//}


-(BOOL)addFilter: (Filter *) filter AndFilter: (BOOL) type {
	/* Check to see if the filter is nil or invalid */
	if(filter == nil) {
		return NO;
	}

	Filterer *filterer = [filter getFilterer];
	
	if([filter checkFilterer: filterer] == NO) {
		return NO;
	}
	
	/* Add the filter */
	[filters addObject: filter];
	
	NSLog([NSString stringWithFormat:@"Number of Filters: %d", [filters count]]); 

	/* Add the filter as either an AND filter or an OR Filter based on type */
/*	if(type == YES) {
		[self addAndFilter: filter];
	}
	else {
		[self addOrFilter: filter];
	}
*/	
	return YES;
}

-(BOOL)removeFilter: (Filter *) filter AndFilter: (BOOL) type {
	
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
	
	/* Remove the filter as either an AND Filter or an OR Filter based on type */
/*	if(type == YES) {
		[self removeAndFilter];
	}
	else {
		[self removeOrFilter];
	}
*/	
	return YES;
}

-(BOOL)replaceFilter:(Filter *)oldFilter WithFilter:(Filter *)newFilter AndFilter:(BOOL)type {
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

/* This method should only be called by addFilter */
-(void)addAndFilter: (Filter *) filter {
	
	for(id event in displayedEvents) {
		/* Check the displayed events and if it fails remove this object from the displayed list
		   and add it to the filtered list */
		switch ([filter getFilterType])
		{
			case NameFilterType:
				if([self checkName: event withFilter: filter] == NO) {
					[displayedEvents removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case ArtistFilterType:
				if([self checkArtist: event withFilter: filter] == NO) {
					[displayedEvents removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case TimeFilterType:
				if([self checkTime: event withFilter: filter] == NO) {
					[displayedEvents removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case CostFilterType:
				if([self checkCost: event withFilter: filter] == NO) {
					[displayedEvents removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case DurationFilterType:
				if([self checkDuration: event withFilter: filter] == NO) {
					[displayedEvents removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case LocationFilterType:
				if([self checkLocation: event withFilter: filter] == NO) {
					[displayedEvents removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			default:
				/* Should never happen */
				break;
		}
	}
}

-(void)removeAndFilter {
	BOOL failed = NO;
	
	/* Loop over the filtered out events for ones that no longer fail any of the filters */
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
					/* Should never happen */
					break;
			}
			
			/* failed go to the next event */
			if(failed == YES) {
				break;
			}
		}
		
		/* Check to see if it passed all the filters and move the event if necessary*/
		if(failed == NO) {
			[filteredEvents removeObjectIdenticalTo: event];
			[displayedEvents addObject: event];
		}
		
		/* reset the failed flag */
		failed = NO;
	}
}

-(void)addOrFilter: (Filter *) filter {
	
	for(id event in filteredEvents) {
		/* Check the filtered events and if it passes remove this object from the filtered list
		 and add it to the displayed list */
		switch ([filter getFilterType])
		{
			case NameFilterType:
				if([self checkName: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[displayedEvents addObject: event];
				}
				break;
			case ArtistFilterType:
				if([self checkArtist: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[displayedEvents addObject: event];
				}
				break;
			case TimeFilterType:
				if([self checkTime: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[displayedEvents addObject: event];
				}
				break;
			case CostFilterType:
				if([self checkCost: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[displayedEvents addObject: event];
				}
				break;
			case DurationFilterType:
				if([self checkDuration: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[displayedEvents addObject: event];
				}
				break;
			case LocationFilterType:
				if([self checkLocation: event withFilter: filter] == YES) {
					[filteredEvents removeObjectIdenticalTo: event];
					[displayedEvents addObject: event];
				}
				break;
			default:
				/* Should never happen */
				break;
		}
	}
}

-(void)removeOrFilter {
	BOOL passed = NO;
	
	/* Loop over the displayed out events for ones that no longer pass any of the filters */
	for(id event in displayedEvents) {
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
					/* Should never happen */
					break;
			}
			
			/* failed go to the next event */
			if(passed == YES) {
				break;
			}
		}
		
		/* Check to see if it passed all the filters and move the event if necessary*/
		if(passed == NO) {
			[displayedEvents removeObjectIdenticalTo: event];
			[filteredEvents addObject: event];
		}
		
		/* reset the failed flag */
		passed = NO;
	}
}

/* Switch the filter mode */
-(void)switchToAndFilters {
	/* Disable the filters by adding all the objects to the displayed list
       And removing them from the filtered list */
	[displayedEvents addObjectsFromArray: filteredEvents];
	[filteredEvents removeAllObjects];
	
	/* Add all the fitlers as AND filters */
	for(id f in filters) {
		[self addAndFilter: (Filter *)f];
	}
}

-(void)switchToOrFilters {
	/* Disable the filters by adding all the objects to the displayed list
	 And removing them from the filtered list */
	[displayedEvents addObjectsFromArray: filteredEvents];
	[filteredEvents removeAllObjects];
	
	/* Add all the fitlers as OR filters */
	for(id f in filters) {
		[self addOrFilter: (Filter *)f];
	}
}

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

-(Event *)getEventAtIndex:(int)index {
	if(index >= [self getDisplayedEventCount]) {
		return nil;
	}
	
	return (Event *)[displayedEvents objectAtIndex: index];
}

-(EventArtist *)getArtistAtIndex:(int)index {
	if(index >= [self getArtistCount]) {
		return nil;
	}
	
	return (EventArtist *)[artists objectAtIndex: index];
}

-(Filter *)getFilterAtIndex:(int)index {
	if(index >= [self getFilterCount]) {
		return nil;
	}
	
	return (Filter *)[filters objectAtIndex: index];
}

-(NSMutableArray *)getDisplayedEvents {
	return displayedEvents;
}

-(NSMutableArray *)getFilteredEvents {
	return filteredEvents;
}

-(NSMutableArray *)getFilters {
	return filters;
}

-(NSMutableArray *)getArtists {
	return artists;
}

-(NSInteger)getEventCount {
	return [self getDisplayedEventCount] + [self getFilteredEventCount];
}

-(NSInteger)getDisplayedEventCount {
	return displayedEvents.count;
}

-(NSInteger)getFilteredEventCount {
	return filteredEvents.count;
}

-(NSInteger)getFilterCount {
	return filters.count;
}

-(NSInteger)getArtistCount {
	return artists.count;
}

@end
