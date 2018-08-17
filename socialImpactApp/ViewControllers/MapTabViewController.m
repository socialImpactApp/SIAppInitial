//
//  MapTabViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 8/2/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "MapTabViewController.h"
#import "VolunteerOpportunity.h"
#import "SearchTableViewCell.h"

@interface MapTabViewController ()<MKLocalSearchCompleterDelegate, MKMapViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *allVopps;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) MKLocalSearchCompleter *searchCompleter;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (strong,nonatomic) NSArray *results;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;



@end

@implementation MapTabViewController{
    BOOL _blockCompleted;
    NSMutableArray *vopps;
    NSString *tappedLocation;
    NSString *tappedAddress;
    NSString *tappedCity;
    NSString *tappedState;
    CLGeocoder *_geocoder;
    dispatch_group_t _myGroup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [CATransaction begin];
    //    [CATransaction setCompletionBlock:^{
    //        [self showAllLocs:vopps];
    //    }];
    self.resultsTableView.rowHeight = UITableViewAutomaticDimension;
    self.mapView.delegate = self;
    [self.mapView setUserInteractionEnabled:YES];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        //lets user authorize own permission
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.mapView.showsUserLocation= YES;
    //delays the method by 1 second
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC),dispatch_get_main_queue(), ^{
        [self.mapView setRegion: MKCoordinateRegionMake(self.mapView.userLocation.coordinate, MKCoordinateSpanMake(0.1, 0.1)) animated:YES];
    });
    self.searchCompleter =  [[MKLocalSearchCompleter alloc] init];
    self.searchCompleter.delegate = self;
    self.searchCompleter.filterType = MKSearchCompletionFilterTypeLocationsAndQueries;
    
    //setting textfield to self
    self.searchField.delegate = self;
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.resultsTableView setHidden:YES];
    
    //setting tableview delegates
    self.resultsTableView.delegate=self;
    self.resultsTableView.dataSource=self;
    
    
    self.allVopps = [[NSMutableArray alloc] init];
    [self fetch];
    //    [CATransaction commit];
    //self.allVopps = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetch {
    PFQuery *query = [VolunteerOpportunity query];
    //in the future we will filter the data
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            for (VolunteerOpportunity *vol in posts){
                [self.allVopps addObject:vol];
            }
            [self showAllLocs:self.allVopps];
            
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
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

-(void)showAllLocs:(NSMutableArray <VolunteerOpportunity *>*)allVopps{
    for (VolunteerOpportunity *vopp in allVopps) {
        NSNumber *lat = vopp.longLat[0];
        NSNumber *lon = vopp.longLat[1];
        MKCoordinateSpan span;
        span.latitudeDelta = 20;
        span.longitudeDelta = 20;
        
        MKCoordinateRegion locationRegion;
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake([lat doubleValue],[lon doubleValue]);
        locationRegion.center = center;
        locationRegion.span = span;
        //check if need to allocate
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        MKAnnotationView *pointView = [[MKAnnotationView alloc] initWithAnnotation:point reuseIdentifier:Nil];
        point.coordinate = center;
        point.title = vopp.location;
        //this is where I am setting the pin's tag number
        [pointView setTag:[allVopps indexOfObject:vopp]];
        [self.mapView addAnnotation:pointView.annotation];
        [self.mapView setRegion:locationRegion animated:true];        
    }
    
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
    tappedLocation = resultCell.title;
    tappedAddress = resultCell.subtitle;
    NSLog(@"%@", address);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(!error){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"%f",placemark.location.coordinate.latitude);
            NSLog(@"%f",placemark.location.coordinate.longitude);
            NSLog(@"%@",placemark.locality);
            self->tappedCity = placemark.locality;
            self->tappedState = placemark.administrativeArea;
            
            
            CLLocationCoordinate2D center = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
            MKCoordinateSpan span;
            span.latitudeDelta = 0.1;
            span.latitudeDelta = 0.1;
            
            MKCoordinateRegion locationRegion;
            locationRegion.center = center;
            //we
            //locationRegion.span = span;
            //check if need to allocate
            //            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            //            point.coordinate = center;
            //            [self.mapView addAnnotation:point];
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



- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views
{
    NSLog(@"Added annotiation");
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
