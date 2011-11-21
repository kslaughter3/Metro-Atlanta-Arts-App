//
//  SelfCuratedEntry.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/14/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "SelfCuratedEntry.h"


@implementation SelfCuratedEntry

-(SelfCuratedEntry *)initEmptySelfCuratedEntry {
	self = [super init];
	
	if(self != nil) {
		return self;
	}
	
	return nil;
}

-(void)setSelfCuratedID: (int)num {
	selfCuratedID = num;
}

-(int)getSelfCuratedID {
	return selfCuratedID;
}

-(void)setName: (NSString *)str {
	name = str;
}

-(NSString *)getName {
	return name;
}

-(void)setOccupation: (NSString *) str {
	occupation = str;
}

-(NSString *)getOccupation {
	return occupation;
}

-(void)setImage: (NSString *)url {
	image = url;
}

-(NSString *)getImage {
	return image;
}

-(void)setPlan: (NSString *)str {
	plan = str;
}

-(NSString *)getPlan {
	return plan;
}

-(void)setWebsite:(NSString *)url {
	website = url;
}

-(NSString *)getWebsite {
	return website;
}

-(void)dealloc {
	[name release];
	[occupation release];
	[image release];
	[plan release];
	[website release];
	[super dealloc];
}

@end
