//
//  AboutUs.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/11/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AboutUs : NSObject {
	NSString *name;
	NSString *description;
	NSString *imageURL;
	NSString *websiteURL;
}

-(AboutUs *)initEmptyAboutUs;

-(void)setName: (NSString *) str;
-(NSString *)getName;

-(void)setDescription: (NSString *) str;
-(NSString *)getDescription;

-(void)setImage: (NSString *) str;
-(NSString *)getImage;

-(void)setWebsite: (NSString *) str;
-(NSString *)getWebsite;
@end
