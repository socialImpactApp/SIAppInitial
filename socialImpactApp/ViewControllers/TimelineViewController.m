//
//  TimelineViewController.m
//  socialImpactApp
//
//  Created by Ezra Bekele on 7/25/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "TimelineViewController.h"
#import "VolunteerOpportunityCell.h"
#import "User.h"
#import "VolunteerOpportunity.h"
#import "AppDelegate.h"
#import "Colours.h"
#import "DetailViewController.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *volunteerOpportunities;
@property (strong, nonatomic) NSMutableArray *filteredVolunteerOpportunities;

@end

@implementation TimelineViewController {
    NSMutableArray *postsOne;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    postsOne = [[NSMutableArray alloc]  init];
    [self.tableView reloadData];
    if (self.volunteerOpportunities == NULL)
    {
        self.volunteerOpportunities = [[NSMutableArray alloc] init];
    }
    [self fetch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetch {
    User *currentUser = [User currentUser];
    //    postsOne = [[NSMutableArray alloc] init];
    //    self->postsOne = self.volunteerOpportunities;
    
    PFQuery *query = [VolunteerOpportunity query];
    
    //in the future we will filter the data
    [query orderByAscending:@"createdAt"];
    [query includeKey:@"author"];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.volunteerOpportunities = [posts mutableCopy];
            //            self->postsOne = posts;
            
            User *loggedInUser = [User currentUser];
            NSArray *timelinePostIDs = loggedInUser.timelineOpps;
            
            if (self.filteredVolunteerOpportunities == NULL) {
                self.filteredVolunteerOpportunities = [[NSMutableArray alloc] init];
            }
            
            for (VolunteerOpportunity *vol in self.volunteerOpportunities){
                if ([timelinePostIDs containsObject:vol.objectId])
                {
                    [self.filteredVolunteerOpportunities addObject:vol];
                }
            }
            [self.tableView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    //[self.refreshControl endRefreshing];
}



// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"we are in cellforRow");
    VolunteerOpportunityCell *postCell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell"];
    VolunteerOpportunity *post = self.filteredVolunteerOpportunities[indexPath.row];
    [postCell configureCell:post];
    
    NSDate *newDate = postCell.volunteerOpportunity.createdAt;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yy";
    
    NSString *dateString =  [dateFormatter stringFromDate:newDate];
    
    NSLog(@"DATE STRING");
    NSLog(@"%@", dateString);
    return postCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filteredVolunteerOpportunities.count;
    
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
