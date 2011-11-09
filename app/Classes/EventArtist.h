//
//  EventArtist.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EventArtist : NSObject {
	NSString *name;
	NSString *description;
	NSString *imageURL;
	BOOL   hasImage;
	//NSMutableArray *events; /* List of events for this artist */

}

/* Initializers */
-(EventArtist *)initEmptyArtist;

-(EventArtist *)initWithArtist: (EventArtist *) art;

-(EventArtist *)initWithArtistName: (NSString *) n Description: (NSString *) desc;

-(EventArtist *)initWithArtistName:(NSString *)n ImageURL: (NSString *) url;

-(EventArtist *)initWithArtistName:(NSString *)n Description:(NSString *)desc 
	ImageURL: (NSString *) url;

/* Getters and Setters */
-(void)setName: (NSString *) str;
-(NSString *)getName;

-(void)setDescription: (NSString *) str;
-(NSString *)getDescription;

-(void)setImageURL: (NSString *) url;
-(NSString *)getImageURL;

-(BOOL)hasImage;

/* End Getters and Setters */

@end
