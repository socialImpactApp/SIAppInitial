//
//  ShowLocationViewController.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/26/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "VolunteerOpportunityCell.h"
#import "VolunteerOpportunity.h"
//
@protocol showLocationDelegate
//-(void)didTapShowLocation:(NSString *) location;
@end

@interface ShowLocationViewController : UIViewController 
@property (strong, nonatomic) VolunteerOpportunity *post;
@property (strong,nonatomic) NSString *location; 
//@property (strong, nonatomic) id<showLocationDelegate> delegate;



@end
