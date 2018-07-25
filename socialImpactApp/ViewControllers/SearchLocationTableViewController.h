//
//  SearchLocationTableViewController.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/24/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class SearchLocationTableViewController;

@protocol SearchLocationTableViewControllerDelegate

- (void)searchLocationViewController:(SearchLocationTableViewController *)controller didPickLocationWithLattitude:(NSNumber *)lattitude longitude:(NSNumber *)longitude;

@end

@interface SearchLocationTableViewController : UITableViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) id<SearchLocationTableViewControllerDelegate> delegate;
@end
