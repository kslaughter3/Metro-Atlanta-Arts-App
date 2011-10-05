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

@implementation Content

-(Content *)getContent {
	self = [super init];
	
	if(self != NULL)
	{
		[self->displayedEvents initWithCapacity: 10];
		[self->filteredEvents initWithCapacity: 10];
		[self->oldEvents initWithCapacity: 10];
		[self->filters initWithCapacity: 10];
	
		/* TODO: Get events from database */
	
		[self filterOldEvents];
	
		return self;
	}
	
	return NULL;
}

-(void)filterOldEvents {
}


-(bool)addFilter: (Filter *) filter AndFilter: (bool) type {
	
	/* Check to see if the filter is NULL or invalid */
	if(filter == NULL) {
		return false;
	}
	
	Filterer *filterer = [filter getFilterer];
	
	if([filter checkFilterer: filterer] == false) {
		return false;
	}
	
	/* Add the filter */
	[filters addObject: filter];

	/* Add the filter as either an AND filter or an OR Filter based on type */
	if(type == true) {
		[self addAndFilter: filter];
	}
	else {
		[self addOrFilter: filter];
	}
	
	return true;
}

-(bool)removeFilter: (Filter *) filter AndFilter: (bool) type {
	
	/* Check to see if the filter is NULL or invalid */
	if(filter == NULL) {
		return false;
	}
	
	Filterer *filterer = [filter getFilterer];
	
	if([filter checkFilterer: filterer] == false) {
		return false;
	}
	
	
	/* Remove the filter */
	[filters removeObjectIdenticalTo: filter];
	
	/* Remove the filter as either an AND Filter or an OR Filter based on type */
	if(type == true) {
		[self removeAndFilter];
	}
	else {
		[self removeOrFilter];
	}
	
	return true;
}

/* This method should only be called by addFilter */
-(void)addAndFilter: (Filter *) filter {
	
	for(id event in displayedEvents) {
		/* Check the displayed events and if it fails remove this object from the displayed list
		   and add it to the filtered list */
		switch ([filter getFilterType])
		{
			case NameFilterType:
				if([self checkName: event withFilter: filter] == false) {
					[displayedEvents removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case ArtistFilterType:
				if([self checkArtist: event withFilter: filter] == false) {
					[displayedEvents removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case TimeFilterType:
				if([self checkTime: event withFilter: filter] == false) {
					[displayedEvents removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case CostFilterType:
				if([self checkCost: event withFilter: filter] == false) {
					[displayedEvents removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case DurationFilterType:
				if([self checkDuration: event withFilter: filter] == false) {
					[displayedEvents removeObjectIdenticalTo: event];
					[filteredEvents addObject: event];
				}
				break;
			case LocationFilterType:
				if([self checkLocation: event withFilter: filter] == false) {
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
	bool failed = false;
	
	/* Loop over the filtered out events for ones that no longer fail any of the filters */
	for(id event in filteredEvents) {
		for(id f in filters) {
			switch ([(Filter *)f getFilterType]) {
				case NameFilterType:
					if([self checkName: event withFilter: f] == false) {
						failed = true;
					}
					break;
				case ArtistFilterType:
					if([self checkArtist: event withFilter: f] == false) {
						failed = true;
					}
					break;
				case TimeFilterType:
					if([self checkTime: event withFilter: f] == false) {
						failed = true;
					}
					break;
				case CostFilterType:
					if([self checkCost: event withFilter: f] == false) {
						failed = true;
					}
					break;
				case DurationFilterType:
					if([self checkDuration: event withFilter: f] == false) {
						failed = true;
					}
					break;
				case LocationFilterType:
					if([self checkLocation: event withFilter: f] == false) {
						failed = true;
					}
					break;
				default:
					/* Should never happen */
					break;
			}
			
			/* failed go to the next event */
			if(failed == true) {
				break;
			}
		}
		
		/* Check to see if it passed all the filters and move the event if necessary*/
		if(failed == false) {
			[filteredEvents removeObjectIdenticalTo: event];
			[displayedEvents addObject: event];
		}
		
		/* reset the failed flag */
		failed = false;
	}
}

-(void)addOrFilter: (Filter *) filter {
	
	for(id event in filteredEvents) {
		/* Check the filtered events and if it passes remove this object from the filtered list
		 and add it to the displayed list */
		switch ([filter getFilterType])
		{
			case NameFilterType:
				if([self checkName: event withFilter: filter] == true) {
					[filteredEvents removeObjectIdenticalTo: event];
					[displayedEvents addObject: event];
				}
				break;
			case ArtistFilterType:
				if([self checkArtist: event withFilter: filter] == true) {
					[filteredEvents removeObjectIdenticalTo: event];
					[displayedEvents addObject: event];
				}
				break;
			case TimeFilterType:
				if([self checkTime: event withFilter: filter] == true) {
					[filteredEvents removeObjectIdenticalTo: event];
					[displayedEvents addObject: event];
				}
				break;
			case CostFilterType:
				if([self checkCost: event withFilter: filter] == true) {
					[filteredEvents removeObjectIdenticalTo: event];
					[displayedEvents addObject: event];
				}
				break;
			case DurationFilterType:
				if([self checkDuration: event withFilter: filter] == true) {
					[filteredEvents removeObjectIdenticalTo: event];
					[displayedEvents addObject: event];
				}
				break;
			case LocationFilterType:
				if([self checkLocation: event withFilter: filter] == true) {
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
	bool passed = false;
	
	/* Loop over the displayed out events for ones that no longer pass any of the filters */
	for(id event in displayedEvents) {
		for(id f in filters) {
			switch ([(Filter *)f getFilterType]) {
				case NameFilterType:
					if([self checkName: event withFilter: f] == true) {
						passed = true;
					}
					break;
				case ArtistFilterType:
					if([self checkArtist: event withFilter: f] == true) {
						passed = true;
					}
					break;
				case TimeFilterType:
					if([self checkTime: event withFilter: f] == true) {
						passed = true;
					}
					break;
				case CostFilterType:
					if([self checkCost: event withFilter: f] == true) {
						passed = true;
					}
					break;
				case DurationFilterType:
					if([self checkDuration: event withFilter: f] == true) {
						passed = true;
					}
					break;
				case LocationFilterType:
					if([self checkLocation: event withFilter: f] == true) {
						passed = true;
					}
					break;
				default:
					/* Should never happen */
					break;
			}
			
			/* failed go to the next event */
			if(passed == true) {
				break;
			}
		}
		
		/* Check to see if it passed all the filters and move the event if necessary*/
		if(passed == false) {
			[displayedEvents removeObjectIdenticalTo: event];
			[filteredEvents addObject: event];
		}
		
		/* reset the failed flag */
		passed = false;
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

-(bool)checkName: (Event *) event withFilter: (Filter *) filter {
	return [event NameFilter: [filter getFiltererName]];
}

-(bool)checkArtist: (Event *) event withFilter: (Filter *) filter {
	return [event ArtistFilter: [filter getFiltererArtist]];
}
	
-(bool)checkTime: (Event *) event withFilter: (Filter *) filter {
	return [event TimeFilterStart: [filter getFiltererStartTime] 
						   andEnd: [filter getFiltererEndTime]];
}
	
-(bool)checkCost: (Event *) event withFilter: (Filter *) filter {
	return [event CostFilterMin: [filter getFiltererMinCost] 
						 andMax: [filter getFiltererMaxCost]]; 
}
	
-(bool)checkDuration: (Event *) event withFilter: (Filter *) filter {
	return [event DurationFilterMin: [filter getFiltererMinDuration]
							 andMax: [filter getFiltererMaxDuration]];
}
	
-(bool)checkLocation: (Event *) event withFilter: (Filter *) filter {
	return [event LocationFilterLoc: [filter getFiltererLocation]
						  andRadius: [filter getFiltererRadius]];
}
	
-(NSMutableArray *)getDisplayedEvents {
	return displayedEvents;
}

-(NSMutableArray *)getFilteredEvents {
	return filteredEvents;
}

@end
