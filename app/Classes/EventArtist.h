//
//  EventArtist.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/*******************************************************
 * Event Artist Class
 *
 * Holds all the data about an Artist: id, name, 
 * description, image, and website
 *
 ******************************************************/

#import <Foundation/Foundation.h>



@interface EventArtist : NSObject {
	int artistID;
	NSString *name;
	NSString *description;
	NSString *imageURL;
	NSString *websiteURL;
}

/* Initializers */
-(EventArtist *)initEmptyArtist;

-(EventArtist *)initWithArtist: (EventArtist *) art;

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
