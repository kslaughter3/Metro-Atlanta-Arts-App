//
//  DetailsController.h
//  Metro-Atlanta-Arts-App
//
//  Created by Gendreau, Anthony S on 10/12/11.
//  Copyright 2011 ART PAPERS, INC. All rights reserved.
//

/*******************************************************
 * Details Controller Class
 *
 * Handles displaying the details about the given: Event,
 * Artist, Location, SelfCurated Entry, or the About Us 
 *
 *******************************************************/

#import <UIKit/UIKit.h>
#import "Content.h"
#import "Event.h"
#import "EventArtist.h"
#import "EventLocation.h"
#import "SelfCuratedEntry.h"
#import "AboutUs.h"

typedef enum DetailsType {
	EventDetails = 0,
	FirstType = EventDetails,
	ArtistDetails,
	LocationDetails,
	SelfCuratedDetails,
	AboutUsDetails,
	LastType = AboutUsDetails
} DetailsType;

@interface DetailsController : UIViewController <UIWebViewDelegate> {
	IBOutlet UINavigationBar *myTitleBar;
	IBOutlet UIWebView *myWebView;
	DetailsType detailsType;
	Event *event;
	EventArtist *artist;
	EventLocation *location;
	SelfCuratedEntry *selfCurated;
	AboutUs *aboutUs;
}

@property(nonatomic, retain) IBOutlet UINavigationBar *myTitleBar;
@property(nonatomic, retain) IBOutlet UIWebView *myWebView;
@property(nonatomic, retain) Event *event;
@property(nonatomic, retain) EventArtist *artist;
@property(nonatomic, retain) EventLocation *location;
@property(nonatomic, retain) SelfCuratedEntry *selfCurated;
@property(nonatomic, retain) AboutUs *aboutUs;

-(void)setUpTitle;

-(NSString *)buildHTMLString;
-(NSString *)buildEventString;
-(NSString *)buildArtistString;
-(NSString *)buildLocationString;
-(NSString *)buildSelfCuratedString;
-(NSString *)buildAboutUsString;
 
-(void)setDetailsType: (DetailsType) type;
-(IBAction)close:(id)sender;


@end
