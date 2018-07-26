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
#import "Colours.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray *volunteerOpportunities;

@end

@implementation MenuViewController{
    NSMutableArray *postsOne;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 200;
    self.tableView.backgroundColor = [UIColor snowColor];
    self.refreshControl = [[UIRefreshControl alloc] init];
     [self.refreshControl addTarget:self action:@selector(fetch) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.layer.zPosition = -1;
    [self.view addSubview:self.refreshControl];
    
    [self fetch]; 
    self.volunteerOpportunities = [[NSMutableArray alloc] init];
    NSLog(@"%@", self.volunteerOpportunities);
}

-(void)refreshTableView {
    [self.tableView reloadData];
    //[self.refreshIndicator stopAnimating];
    [self.refreshControl endRefreshing];
    
}

-(void)fetch {
   
    User *currentUser = [User currentUser];
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
            self->postsOne = posts; 
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [self.refreshControl endRefreshing];

    //[self.refreshControl endRefreshing];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapAdd:(id)sender {
    [self performSegueWithIdentifier:@"postSeg" sender:nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.volunteerOpportunities.count;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"we are in cellforRow");
    VolunteerOpportunityCell *postCell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell"];
    NSLog(@"%@", postCell.volunteerOpportunity.postID);
    NSLog(@"%@", postCell.descriptionLabel.text);
    NSLog(@"%@", postCell);
    VolunteerOpportunity *post = self.volunteerOpportunities[indexPath.row];
    NSLog(@"checking post");
    NSLog(@"%@", post.postID);
    [postCell configureCell:post];
    
    
    
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    VolunteerOpportunity *theCurrentVolunOpp = self.volunteerOpportunities[indexPath.row];
    
    if ([segue.identifier isEqualToString:@"detailsSegue"])
    {
        DetailViewController *detailedController = [segue destinationViewController];
        detailedController.post = theCurrentVolunOpp;
        NSLog(@"checking detailedPost");
}
}


@end
