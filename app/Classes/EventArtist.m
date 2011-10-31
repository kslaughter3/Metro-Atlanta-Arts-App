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
-(EventArtist *)initEmptyArtist {
	self = [super init];
	
	if(self != nil) {
		return self;
	}
	
	return nil;
}

-(EventArtist *)initWithArtist:(EventArtist *)art {
	self = [super init];
	
	if(self != nil) {
		name = [[NSString alloc] initWithString: [art getName]];
		description = [[NSString alloc] initWithString: [art getDescription]];
		imageURL = [[NSURL alloc] initWithString: [[art getImageURL] absoluteString]];
		return self;
	}
	
	return nil;
}

-(EventArtist *)initWithArtistName: (NSString *) n Description: (NSString *) desc {
	if((n == nil) || (desc == nil)) {
		return nil;
	}

	self = [super init];
	
	if(self != nil) {
		name = [[NSString alloc] initWithString: n];
		description = [[NSString alloc] initWithString: desc];
		return self;
	}
	
	return nil;
}

-(EventArtist *)initWithArtistName: (NSString *) n ImageURL: (NSString *) url {
	if((n == nil) || (url == nil)) {
		return nil;
	}
	
	self = [super init];
	
	if(self != nil) {
		name = [[NSString alloc] initWithString: n];
		imageURL = [[NSURL alloc] initWithString: url];
		return self;
	}
	
	return nil;
}

-(EventArtist *)initWithArtistName: (NSString *) n Description: (NSString *) desc 
	ImageURL: (NSString *) url {
	if((n == nil) || (desc == nil) || (url == nil)) {
		return nil;
	}
	
	self = [super init];
	
	if(self != nil) {
		name = [[NSString alloc] initWithString: n];
		description = [[NSString alloc] initWithString: desc];
		imageURL = [[NSURL alloc] initWithString: url];
		return self;
	}
	
	return nil;
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



-(void)setImageURL: (NSURL *) url {
	imageURL = url;
}

-(NSURL *)getImageURL {
	return imageURL;
}

/* End Getters and Setters */

@end
