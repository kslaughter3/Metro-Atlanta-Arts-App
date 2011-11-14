//
//  SelfCuratedEntry.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 11/14/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SelfCuratedEntry : NSObject {
	int selfCuratedID;
	NSString *name;
	NSString *occupation;
	NSString *image;
	NSString *plan;
	NSString *website;
}

-(SelfCuratedEntry *)initEmptySelfCuratedEntry;

-(void)setSelfCuratedID: (int)num;
-(int)getSelfCuratedID;

-(void)setName: (NSString *)str;
-(NSString *)getName;

-(void)setOccupation: (NSString *) str;
-(NSString *)getOccupation;

-(void)setImage: (NSString *)url;
-(NSString *)getImage;

-(void)setPlan: (NSString *)str;
-(NSString *)getPlan;

-(void)setWebsite:(NSString *)url;
-(NSString *)getWebsite;

@end
