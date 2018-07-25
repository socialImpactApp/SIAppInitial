//
//  LocationViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/23/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "LocationViewController.h"
#import "SearchTableViewCell.h"
#import "Colours.h"

@interface LocationViewController () <CLLocationManagerDelegate,MKLocalSearchCompleterDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (strong, nonatomic) MKLocalSearchCompleter *searchCompleter;
@property (strong, nonatomic) NSArray *results;


@end

@implementation LocationViewController

@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    //setting up the clloactionmanager
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        //lets user authorize own permission
        [locationManager requestWhenInUseAuthorization];
    }
    self.mapView.showsUserLocation= YES;
    [locationManager requestLocation];
    
    //setting the search completion
    self.searchCompleter =  [[MKLocalSearchCompleter alloc] init];
    self.searchCompleter.delegate = self;
    self.searchCompleter.filterType = MKSearchCompletionFilterTypeLocationsAndQueries;
    
    //setting textfield to self
    self.searchField.delegate = self;
    
    self.resultsTableView.delegate=self;
    self.resultsTableView.dataSource=self;
    
    [self.resultsTableView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapAway:(id)sender {
    [self.view endEditing:YES];
      self.resultsTableView.hidden = true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    NSLog(@"we are here!!");
    self.searchCompleter.queryFragment = self.searchField.text;
    if (self.searchCompleter.results >0){
        self.resultsTableView.hidden = false;
        self.results = self.searchCompleter.results;
        [self.resultsTableView reloadData];
    }
    else {
        self.resultsTableView.hidden = true;
    }
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MKLocalSearchCompletion *searchResults = self.results[indexPath.row];
    SearchTableViewCell *searchCell = [self.resultsTableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell"];
    NSString *location = [NSString stringWithFormat:@"%@", searchResults.title];
    NSString *address = [NSString stringWithFormat:@"%@", searchResults.subtitle];
    NSLog(@"we are hereeee: %@", searchResults.title );
    [searchCell configureCell:location withAddress:address];
    return searchCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MKLocalSearchCompletion *resultCell = self.results[indexPath.row];
    NSString *address = [NSString stringWithFormat:@"%@ %@", resultCell.title,resultCell.subtitle];
    self.searchField.text = address;
    NSLog(@"%@", address);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(!error){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"%f",placemark.location.coordinate.latitude);
            NSLog(@"%f",placemark.location.coordinate.longitude);
            //NSLog(@"%@",[NSString stringWithFormat:@"%@",[placemark description]]);
            
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
            [self.mapView addAnnotation:point];
            [self.mapView setRegion:locationRegion animated:true];

        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}

- (void)completerDidUpdateResults:(MKLocalSearchCompleter *)completer{
    for (MKLocalSearchCompletion *completion in completer.results) {
        NSLog(@"---%@",completion.description);
    }
}
- (void)completer:(MKLocalSearchCompleter *)completer didFailWithError:(NSError *)error{
    NSLog(@"%@",error.localizedDescription);

}


#pragma mark - CLLDelegateManagerDelegate function
//-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
//    if ([[CLLocationManager status]==kCLAuthorizationStatusAuthorizedWhenInUse]){
//
//
//    };
//}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations lastObject];
    NSLog(@"Lat %f, Long: %f", location.coordinate.latitude, location.coordinate.longitude);
    //MKCoordinateSpan span;
    self.mapView.region = MKCoordinateRegionMakeWithDistance(location.coordinate,0.05,0.05);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"@%", error.localizedDescription);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
