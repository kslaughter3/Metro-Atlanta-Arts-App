//
//  NameFilterer.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NameFilterer : NSObject {
	NSString *name;
}

-(void)setName: (NSString *) n;
-(NSString *)getName;

@end
