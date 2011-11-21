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

-(BOOL)isArtistIDEqual:(EventArtist *)other	{
	return artistID == [other getArtistID];
}

/* Getters and Setters */
-(void)setArtistID:(int)num {
	artistID = num;
}

-(int)getArtistID {
	return artistID;
}

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
	imageURL = url;
}

-(NSString *)getImageURL {
	return imageURL;
}

/* End Getters and Setters */

-(void)setWebsite:(NSString *)url {
	websiteURL = url;
}

-(NSString *)getWebsite {
	return websiteURL;
}

-(BOOL)isEqual:(id)object {
	EventArtist *other = (EventArtist *)object;
	
	if(artistID != [other getArtistID]) {
		return NO;
	}
	
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
	
	return YES;
}

-(void)dealloc {
	[name release];
	[description release];
	[imageURL release];
	[websiteURL release];
	[super dealloc];
}

@end
