//
//  ShowAllLocationsViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/29/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "ShowAllLocationsViewController.h"
#import "SearchTableViewCell.h"
#import "DetailViewController.h"

@interface ShowAllLocationsViewController () <MKLocalSearchCompleterDelegate, MKMapViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (strong, nonatomic) MKLocalSearchCompleter *searchCompleter;
@property (strong,nonatomic) NSArray *results;
@property (nonatomic) NSInteger *tagNumber;
@property (nonatomic, retain) CLLocationManager *locationManager;
@end

@implementation ShowAllLocationsViewController {
    BOOL _blockCompleted;
    NSString *tappedLocation;
    NSString *tappedAddress;
    NSString *tappedCity;
    NSString *tappedState;
    NSInteger *tagNumber;
    VolunteerOpportunity *voppSelected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchCompleter =  [[MKLocalSearchCompleter alloc] init];
    self.searchCompleter.delegate = self;
    self.searchCompleter.filterType = MKSearchCompletionFilterTypeLocationsAndQueries;
    
    //setting textfield to self
    self.searchField.delegate = self;
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.resultsTableView setHidden:YES];
    self.mapView.delegate = self;
    
    //setting tableview delegates
    self.resultsTableView.delegate=self;
    self.resultsTableView.dataSource=self;
    
    tagNumber = 0;
    [self.mapView setUserInteractionEnabled:YES];
    [self showAllLocs:self.allVopps];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        //lets user authorize own permission
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.mapView.showsUserLocation= YES;
    [self.locationManager requestLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapAway:(id)sender {
    [self.view endEditing:YES ];
    self.resultsTableView.hidden = YES;
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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
- (void)mapView:(MKMapView *)mapView
didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"we tapped on a pin!!!");
    voppSelected = self.allVopps[view.tag];
//    UIStoryboardSegue *segue;
     [self performSegueWithIdentifier:@"allLocsDetailSeg" sender:self];
    //[[self navigationController] pushViewController:detailView animated:YES];
    //[detailView release];
}



- (void)completerDidUpdateResults:(MKLocalSearchCompleter *)completer{
    for (MKLocalSearchCompletion *completion in completer.results) {
        NSLog(@"---%@",completion.description);
    }
}
- (void)completer:(MKLocalSearchCompleter *)completer didFailWithError:(NSError *)error{
    NSLog(@"%@",error.localizedDescription);
}


-(void)showAllLocs:(NSMutableArray <VolunteerOpportunity *>*)allVopps {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    self.allLocs = [[NSMutableArray alloc] init];
    //dispatch_group_t group = dispatch_group_create();
    
    for (VolunteerOpportunity *vopp in allVopps) {
        //NSLog(@"%@",address);
        //dispatch_group_enter(group);
        __weak typeof(self) weakSelf = self;
        _blockCompleted = NO;
        [geocoder geocodeAddressString:vopp.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(!error){
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                NSLog(@"%f",placemark.location.coordinate.latitude);
                NSLog(@"%f",placemark.location.coordinate.longitude);
                
                CLLocationCoordinate2D center = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
                MKCoordinateSpan span;
                span.latitudeDelta = 80;
                span.longitudeDelta = 10;
                
                MKCoordinateRegion locationRegion;
                locationRegion.center = center;
                locationRegion.span = span;
                //check if need to allocate
                MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                MKAnnotationView *pointView = [[MKAnnotationView alloc] initWithAnnotation:point reuseIdentifier:Nil];
                point.coordinate = center;
                point.title = vopp.location;
                [pointView setTag:[allVopps indexOfObject:vopp]];
                __strong ShowAllLocationsViewController *strongself = weakSelf;
                if (strongself){
                    [strongself.mapView addAnnotation:pointView.annotation];
                    [strongself.mapView setRegion:locationRegion animated:true];
                    strongself->_blockCompleted = YES;
                }
            }
            else {
                NSLog(@"%@", error.localizedDescription);
                __strong ShowAllLocationsViewController *strongself = weakSelf;
                if (strongself){
                    strongself->_blockCompleted = YES;
                }
            }
           // dispatch_group_leave(group);
        }];
        
        while(!_blockCompleted) {
            [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"%@", allLocs);
//    });
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations lastObject];
    NSLog(@"Lat %f, Long: %f", location.coordinate.latitude, location.coordinate.longitude);
    //MKCoordinateSpan span;
    self.mapView.region = MKCoordinateRegionMakeWithDistance(location.coordinate,0.05,0.05);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error.localizedDescription);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"allLocsDetailSeg"]){
        DetailViewController *detailView=[(UINavigationController*)segue.destinationViewController topViewController];;
        detailView.post = voppSelected;
    }
 
}


@end
