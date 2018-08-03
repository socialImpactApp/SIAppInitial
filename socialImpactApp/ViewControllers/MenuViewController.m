//
//  MenuViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/15/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "MenuViewController.h"
#import "VolunteerOpportunity.h"
#import "AppDelegate.h"
#import "VolunteerOpportunityCell.h"
#import "DetailViewController.h"
#import "LoginViewController.h"
#import "ShowLocationViewController.h"
#import "ShowAllLocationsViewController.h"
#import "AddTagViewController.h"
#import <Parse/Parse.h>
#import "Colours.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, AddTagViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray *volunteerOpportunities;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *filteredData;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;


@end

@implementation MenuViewController{

    NSString *volunteerLocation;
    NSIndexPath *indexPathLocation;
    NSMutableArray *postsOne;
    NSMutableArray *filteredAuthorData;
    //make this posts
    NSMutableArray <NSString *> *postsForMapView;
    VolunteerOpportunity *vopp;
    NSMutableArray<NSString *> *_collectionOfTags;
    NSMutableArray *postsOfOpps;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchBar.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 200;
    self.tableView.backgroundColor = [UIColor snowColor];
    self.topView.backgroundColor = [UIColor snowColor];
    self.refreshControl = [[UIRefreshControl alloc] init];
     [self.refreshControl addTarget:self action:@selector(fetch) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.layer.zPosition = -1;
    [self.view addSubview:self.refreshControl];
    
    [self fetch]; 
    self.volunteerOpportunities = [[NSMutableArray alloc] init];
    postsForMapView = [[NSMutableArray alloc] init];
    
    NSDictionary *barButtonAppearanceDict = @{NSFontAttributeName : [UIFont fontWithName:@"News Cycle" size:21], NSForegroundColorAttributeName: [UIColor whiteColor]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:barButtonAppearanceDict forState:UIControlStateNormal];

}

-(void)refreshTableView {
    [self.tableView reloadData];
    //[self.refreshIndicator stopAnimating];
    [self.refreshControl endRefreshing];
    
}

-(void)fetch {
   
    postsOne = [[NSMutableArray alloc] init];
    self->postsOne = self.volunteerOpportunities;
    PFQuery *query = [VolunteerOpportunity query];
    
    //in the future we will filter the data
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = [posts mutableCopy];
            self.volunteerOpportunities = posts;
            self.filteredData = self.volunteerOpportunities;
            self->postsOne = posts;
            //we have to reload data at
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [self.refreshControl endRefreshing];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapAdd:(id)sender {
    [self performSegueWithIdentifier:@"postSeg" sender:nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filteredData.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VolunteerOpportunityCell *postCell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell"];
    //setting each button to have a tag
    postCell.locationButton.tag = indexPath.row;
    VolunteerOpportunity *post = self.filteredData[indexPath.row];
    NSLog(@"%@", post.postID);
    [postCell configureCell:post];
    NSDate *newDate = postCell.volunteerOpportunity.createdAt;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yy";
    
    return postCell;
}


- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        
        // [self performSegueWithIdentifier:@"backSegue" sender:nil]; DONT DO THIS!
        //creating a new app delegate (configuration file) has a delegate property (an object) ACCESS THAT APP DEL OBJECT
        // instantiating a VC and want it to show completely and tell app delegate do this
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        appDelegate.window.rootViewController = loginViewController;
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 00.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 00.0;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    filteredAuthorData = [[NSMutableArray alloc] init];
    if (searchText.length != 0) {
        self.filteredData = [self.volunteerOpportunities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(title contains[c] %@ OR author.organization contains[c] %@ OR cityState contains[c] %@)", searchText, searchText, searchText]];
        NSLog(@"%@", self.filteredData);
    }
    else {
        self.filteredData = self.volunteerOpportunities;
    }
    [self.tableView reloadData];
}

-(void)didTapSaveFilter:(NSMutableArray<NSString *> *)tags {
    _collectionOfTags = [[NSMutableArray alloc] init ];
    _collectionOfTags = [tags copy];
    [self filterVopps];
}



-(void)filterVopps {
    PFQuery *query = [VolunteerOpportunity query];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    NSMutableArray *arrayWithObjectIDs = [[NSMutableArray alloc] init];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self->postsOfOpps = posts;
//            for (VolunteerOpportunity *vopp in self.filteredData){
//                [self.filteredData removeObject:vopp];
//            }
            [self.tableView reloadData];
            for (VolunteerOpportunity *vopp in posts){
                for (NSString *tag in _collectionOfTags){
                    if ([vopp.tags containsObject:tag]){
                        NSLog(@"%@", vopp.objectId);
                        [arrayWithObjectIDs addObject:vopp.objectId];
                    }
                }
                [self.tableView reloadData];
            }
        }
        //NSString *string = @"s3GKrB4wQX";
        self.filteredData = [self.volunteerOpportunities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(objectId IN %@)",arrayWithObjectIDs]];
        [self.tableView reloadData];
    }];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITableViewCell *tappedCell = sender;
    UIButton *button = (UIButton *)sender;
//    NSLog(@"we are in prepare for seg %ld", (long)button.tag);
    vopp = self.posts[button.tag];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    VolunteerOpportunity *theCurrentVolunOpp = self.posts[indexPath.row];
    
    for (int  i = 0; i<self.volunteerOpportunities.count; i++){
        NSLog(@"checking location: %@", self.volunteerOpportunities[i][@"location"]);
        [postsForMapView addObject:self.volunteerOpportunities[i][@"location"]];
    }

    if ([segue.identifier isEqualToString:@"detailsSegue"])
    {
        DetailViewController *detailedController = [(UINavigationController*)segue.destinationViewController topViewController];
        detailedController.post = theCurrentVolunOpp;
}
    else if ([segue.identifier isEqualToString:@"showLocationSeg"])
    {
        ShowLocationViewController *showLocationController = [segue destinationViewController];
        showLocationController.post = vopp;

    }
    else if ([segue.identifier isEqualToString:@"allLocsSeg"])
    {
        ShowAllLocationsViewController *showAllLocsController = [segue destinationViewController];
        showAllLocsController.allLocs = postsForMapView;
        showAllLocsController.allVopps = self.volunteerOpportunities; 
    }
    
    else if ([segue.identifier isEqualToString:@"menuFilterSeg"]) {
        AddTagViewController *tagViewController =
        segue.destinationViewController;
        tagViewController.delegate = self;
    }
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//
//    GoalDetailsViewController *goalsDetailsViewController = [(UINavigationController*)segue.destinationViewController topViewController];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@", [[self.arrCategoryTitle objectAtIndex:indexPath.row] objectAtIndex:indexOfCategory]]);
//    goalsDetailsViewController.goalName = @"Exercise Daily";
//
//}

@end
