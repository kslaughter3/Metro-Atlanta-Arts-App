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
	IBOutlet UINavigationBar *myTitleBar;
	IBOutlet UIImageView *myImageView;
	IBOutlet UITextView *myTextView;
}

@property(nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;
@property(nonatomic, retain) IBOutlet UITextView *myTextView;
@property(nonatomic, retain) IBOutlet UIImageView *myImageView;


-(IBAction)close: (id) sender;
-(void)setArtist: (EventArtist *) a;
-(EventArtist *)getArtist;

@end
