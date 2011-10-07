//
//  EventArtist.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventArtist.h"


@implementation EventArtist

/* Initializers */
-(EventArtist *)initializeArtist: (NSString *) n Description: (NSString *) desc {
	if((n == NULL) || (desc == NULL)) {
		return NULL;
	}
	
	self = [super init];
	
	if(self != NULL) {
		[self setName: n];
		[self setDescription: desc];
		
		return self;
	}
	
	return NULL;
}

/* Getters and Setters */
-(void)setName: (NSString *) str {
	name = str;
}

-(NSString *)getName {
	return name;
}

-(void)setDescription: (NSString *) str {
	description = str;
}

-(NSString *)getDescription {
	return description;
}

/* End Getters and Setters */

@end
