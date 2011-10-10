//
//  ArtistController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/10/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventArtist.h"

@interface ArtistController : UIViewController {
	EventArtist *artist;
}

-(void)setArtist: (EventArtist *) a;
-(EventArtist *)getArtist;

@end
