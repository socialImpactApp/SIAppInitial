//
//  LocationViewController.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/23/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController : UIViewController<CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

@end
