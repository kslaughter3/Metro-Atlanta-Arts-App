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
		imageURL = [[NSString alloc] initWithString: [art getImageURL]];
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
		hasImage = NO;
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
		imageURL = [[NSString alloc] initWithString: url];
		hasImage = YES;
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
		imageURL = [[NSString alloc] initWithString: url];
		hasImage = YES;
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



-(void)setImageURL: (NSString *) url {
	if(url != nil) {
		hasImage = YES;
	}
	else {
		hasImage = NO;
	}
	
	imageURL = url;
}

-(NSString *)getImageURL {
	return imageURL;
}

/* End Getters and Setters */

-(BOOL)hasImage {
	return hasImage;
}

-(BOOL)isEqual:(id)object {
	EventArtist *other = (EventArtist *)object;
	
	if(((name == nil) && ([other getName] != nil)) || ((name != nil) && ([other getName] == nil))) {
		return NO;
	}
	if((name != nil) && ([name isEqualToString: [other getName]] == NO)) {
		return NO;
	}
	
	if(((description == nil) && ([other getDescription] != nil)) || ((description != nil) && ([other getDescription] == nil))) {
		return NO;
	}
	if((description != nil) && ([description isEqualToString: [other getDescription]] == NO)) {
		return NO;
	}
	
	if(((imageURL == nil) && ([other getImageURL] != nil)) || ((imageURL != nil) && ([other getImageURL] == nil))) {
		return NO;
	}
	if((imageURL != nil) && ([imageURL isEqualToString: [other getImageURL]] == NO)) {
		return NO;
	}
	
	
	if(hasImage != [other hasImage]) {
		return NO;
	}
	
	return YES;
}

@end
