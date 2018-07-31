//
//  ShowLocationViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/26/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "ShowLocationViewController.h"

@interface ShowLocationViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation ShowLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self didTapShowLocation:self.post[@"location"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapClear:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)didTapShowLocation:(NSString *)locationName{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.post[@"location"] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(!error){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"%f",placemark.location.coordinate.latitude);
            NSLog(@"%f",placemark.location.coordinate.longitude);
            
            CLLocationCoordinate2D center = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
            MKCoordinateSpan span;
            span.latitudeDelta = 0.1;
            span.latitudeDelta = 0.1;
            
            MKCoordinateRegion locationRegion;
            locationRegion.center = center;
            locationRegion.span = span;
            //check if need to allocate
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = center;
            point.title = self.post[@"location"];
            [self.mapView addAnnotation:point];
            [self.mapView setRegion:locationRegion animated:true];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}


@end
