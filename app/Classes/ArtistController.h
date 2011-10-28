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
	IBOutlet UIWebView *myWebView;
}

@property(nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;
@property(nonatomic, retain) IBOutlet UIWebView *myWebView;
@property(nonatomic, retain) IBOutlet UIImageView *myImageView;

-(NSString *)buildHTMLString;

-(IBAction)close: (id) sender;
-(void)setArtist: (EventArtist *) a;
-(EventArtist *)getArtist;

@end
