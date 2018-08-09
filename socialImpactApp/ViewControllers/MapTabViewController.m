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
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
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
    CLGeocoder *geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [CATransaction begin];
//    [CATransaction setCompletionBlock:^{
//        [self showAllLocs:vopps];
//    }];
    self.mapView.delegate = self;
    [self.mapView setUserInteractionEnabled:YES];
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

-(void)showAllLocs:(NSMutableArray <VolunteerOpportunity *>*)allVopps {
    geocoder = [[CLGeocoder alloc] init];
    int i = 0;
    dispatch_group_t myGroup = dispatch_group_create();
    for (VolunteerOpportunity *vopp in allVopps) {
        i++; 
        NSLog(@"%@", vopp.location);
        dispatch_group_enter(myGroup);
        __weak typeof(self) weakSelf = self;
            [self->geocoder geocodeAddressString:vopp.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            dispatch_group_leave(myGroup);
            if(!error){
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                NSLog(@"TEST TEST TEST%f",placemark.location.coordinate.latitude);
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
                __strong MapTabViewController *strongself = weakSelf;
                if (strongself){
                    [strongself.mapView addAnnotation:pointView.annotation];
                    [strongself.mapView setRegion:locationRegion animated:true];
                    strongself->_blockCompleted = YES;
                }
            }
            else {
                NSLog(@" ERRRRRROR %@", error.localizedDescription);
                __strong MapTabViewController *strongself = weakSelf;
                if (strongself){
                    strongself->_blockCompleted = YES;
                }
            }
            
        }];
}
    dispatch_group_notify(myGroup, dispatch_get_main_queue(), ^{
        NSLog(@"Finished all requests.");
    });
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
            [self.mapView setRegion:locationRegion animated:true];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
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
