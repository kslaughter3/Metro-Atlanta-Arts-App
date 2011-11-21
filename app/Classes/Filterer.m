//
//  Filterer.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/16/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "Filterer.h"


@implementation Filterer

@synthesize query,
			name,
			artist,
			start,
			end,
			minCost,
			maxCost,
			minDuration,
			maxDuration,
			loc,
			radius,
			day,
			startTime,
			endTime;

-(Filterer *)initEmptyFilterer {
	self = [super init];
	
	return self;
}

-(void)dealloc {
	[query release];
	[name release];
	[artist release];
	[start release];
	[end release];
	[loc release];
	[day release];
	[super dealloc];
}

@end
