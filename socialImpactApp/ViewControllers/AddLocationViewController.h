//
//  AddLocationViewController.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/23/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol AddLocationViewControllerDelegate

-(void)didTapAddLocation:(NSString *)locationName withAddress:(NSString *)addressName  withCity:(NSString *)cityName  withState:(NSString *)stateName withLong:(NSNumber*)lon withLat:(NSNumber *)lat;

@end

@interface AddLocationViewController : UIViewController<CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) id<AddLocationViewControllerDelegate> delegate;


@end
