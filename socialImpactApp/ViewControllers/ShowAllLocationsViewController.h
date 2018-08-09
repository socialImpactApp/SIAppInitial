//
//  ShowAllLocationsViewController.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/29/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "VolunteerOpportunityCell.h"
#import "VolunteerOpportunity.h"

typedef void (^LocationCompletionBlock) (NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error);


@interface ShowAllLocationsViewController : UIViewController
@property (strong, nonatomic) NSMutableArray <NSString *> * _Nullable allLocs;
@property (strong, nonatomic) NSMutableArray <VolunteerOpportunity *> * _Nullable allVopps;


@end
