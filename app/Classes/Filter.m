//
//  Filter.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Filter.h"
#import <CoreLocation/CoreLocation.h>


@implementation Filter

-(Filter *)initializeFilterWithType: (FilterType) t andFilterer: (Filterer *) f {
	self = [super init];
	
	if( self ) {
		[self setFilterType: t];
		if([self setFilterer: f]) {
			return self;
		}
	}
	
	return NULL;
}
		   
-(bool)checkFilterer: (Filterer *) f {
	/* Check to see if the correct union member is specified */ 
	switch ([self getFilterType]) {
		case NameFilterType:
			return [self checkNameFilterer: f];
			break;
		case ArtistFilterType:
			return [self checkArtistFilterer: f];
			break;
		case TimeFilterType:
			return [self checkTimeFilterer: f];
			break;
		case CostFilterType:
			return [self checkCostFilterer: f];
			break;
		case DurationFilterType:
			return [self checkDurationFilterer: f];
			break;
		case LocationFilterType:
			return [self checkLocationFilterer: f];
			break;
		default:
			return false;
			break;
	}
	
	return false;
}

-(bool)checkNameFilterer: (Filterer *) f {
	return ((f != NULL) && (f->name != NULL));
}

-(bool)checkArtistFilterer: (Filterer *) f {
	return ((f != NULL) && (f->artist != NULL));
}

-(bool)checkTimeFilterer: (Filterer *) f {
	if((f != NULL) && (f->start != NULL) && (f->end != NULL)) {
		/* Check if the start is before the end date */
		return ([f->start earlierDate: f->end] == f->start);
	}
	return false;
}

-(bool)checkCostFilterer: (Filterer *) f {
	/* Check to see if the max is greater than or equal to the min and that the min is 
	   greater than or equal to 0 */
	return ((f != NULL) && (f->minCost <= f->maxCost) && (f->minCost >= 0));
}

-(bool)checkDurationFilterer: (Filterer *) f {
	/* Check to see if the max is greater than or equal to the min and that the min is 
	   greater than or equal to 0 */
	return ((f != NULL) && (f->minLength <= f->maxLength) && (f->minLength >= 0));
}

-(bool)checkLocationFilterer: (Filterer *) f {
	/* I don't know what has to be valid for this yet */
	return true;
}

-(void)setFilterType: (FilterType) t {
	type = t;
}

-(FilterType)getFilterType {
	return type;
}

-(bool)setFilterer: (Filterer *) f {
	if([self checkFilterer: f]) {
		filterer = f;
		return true;
	}
	return false;
}

-(Filterer *)getFilterer {
	return filterer;
}

@end
