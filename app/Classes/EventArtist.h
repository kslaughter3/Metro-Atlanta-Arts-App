//
//  EventArtist.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EventArtist : NSObject {
	int artistID;
	NSString *name;
	NSString *description;
	NSString *imageURL;
	NSString *websiteURL;
	//NSMutableArray *events; /* List of events for this artist */

}

/* Initializers */
-(EventArtist *)initEmptyArtist;

-(EventArtist *)initWithArtist: (EventArtist *) art;

-(EventArtist *)initWithArtistName: (NSString *) n Description: (NSString *) desc;

-(EventArtist *)initWithArtistName:(NSString *)n ImageURL: (NSString *) url;

-(EventArtist *)initWithArtistName:(NSString *)n Description:(NSString *)desc 
	ImageURL: (NSString *) url;

-(BOOL)isArtistIDEqual:(EventArtist *)other;

/* Getters and Setters */
-(void)setArtistID:(int)num;
-(int)getArtistID;

-(void)setName: (NSString *) str;
-(NSString *)getName;

-(void)setDescription: (NSString *) str;
-(NSString *)getDescription;

-(void)setImageURL: (NSString *) url;
-(NSString *)getImageURL;

-(void)setWebsite: (NSString *) url;
-(NSString *)getWebsite;

/* End Getters and Setters */

@end
