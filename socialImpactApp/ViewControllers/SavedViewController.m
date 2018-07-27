//
//  SavedViewController.m
//  socialImpactApp
//
//  Created by Ezra Bekele on 7/17/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "SavedViewController.h"
#import "VolunteerOpportunityCell.h"

#import "User.h"
#import "VolunteerOpportunity.h"
#import "AppDelegate.h"

@interface SavedViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *favoriteOpps;
@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) NSMutableArray *favoriteOppsIds;

@end

@implementation SavedViewController {
    NSMutableArray *postsOfOpps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 150;
    postsOfOpps = [[NSMutableArray alloc]  init];

    [self.tableView reloadData];
    if (self.favoriteOpps == NULL)
    {
        self.favoriteOpps = [[NSMutableArray alloc] init];
    }
    if (self.posts == NULL)
    {
        self.posts = [[NSMutableArray alloc] init];
    }
    [self fetch];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) filterPosts
{
    User *loggedInUser = [User currentUser];
    NSArray *favPostIDs = loggedInUser.favoritedOpps;
    NSLog(@"%@", loggedInUser.favoritedOpps);
    NSLog(@"posts of opps");
    NSLog(@"%@", postsOfOpps);
    NSInteger count = 0;
    VolunteerOpportunity *volunOpp = [[VolunteerOpportunity alloc] init];
    for (VolunteerOpportunity* post in postsOfOpps)
    {
        if (post.objectId == favPostIDs[count])
        {
            volunOpp = postsOfOpps[count];
            [self.favoriteOpps addObject:volunOpp];
        }
        count+=1;
    }
}



-(void)fetch {
    PFQuery *query = [VolunteerOpportunity query];
    
    //in the future we will filter the data
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self->postsOfOpps = posts;
            [self.tableView reloadData];
            
            User *loggedInUser = [User currentUser];
            NSArray *favPostIDs = loggedInUser.favoritedOpps;
            
            for (VolunteerOpportunity *vol in posts){
            if ([favPostIDs containsObject:vol.objectId])
                 {
                     [self.posts addObject:vol];
                 }
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"we are in cellforRow");
    VolunteerOpportunityCell *postCell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell"];
    NSLog(@"%@", self.posts);
    NSLog(@"%@", postCell.volunteerOpportunity.postID);
    NSLog(@"%@", postCell.descriptionLabel.text);
    VolunteerOpportunity *post = self.posts[indexPath.row];
    NSLog(@"checking post");
    NSLog(@"%@", post.postID);
    [postCell configureCell:post];
    
    return postCell;
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
