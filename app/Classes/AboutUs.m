//
//  AboutUs.m
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import "AboutUs.h"


@implementation AboutUs

-(AboutUs *)initEmptyAboutUs {
	self = [super init];
	if(self != nil) {
		return self;
	}
	
	return nil;
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

-(void)setImage: (NSString *) str {
	imageURL = str;
}

-(NSString *)getImage {
	return imageURL;
}

-(void)setWebsite: (NSString *) str {
	websiteURL = str;
}

-(NSString *)getWebsite {
	return websiteURL;
}

@end
