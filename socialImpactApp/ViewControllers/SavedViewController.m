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
#import "Colours.h"
#import "DetailViewController.h"
@interface SavedViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, senderForUnfavoriteDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *favoriteOpps;
@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) NSMutableArray *favoriteOppsIds;
@property (strong, nonatomic) NSMutableArray *volunteerOpportunities;
@property (nonatomic,strong) UIRefreshControl *refreshControl;

@end

@implementation SavedViewController {
    NSMutableArray *postsOfOpps;
    NSMutableDictionary *indexPaths;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 200;
    self.tableView.backgroundColor = [UIColor snowColor];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetch) forControlEvents:UIControlEventValueChanged];
    //self.refreshControl.layer.zPosition = -1;
    [self.tableView addSubview:self.refreshControl];
//    [self.scrollView insertSubview:self.refreshControl atIndex:0];
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
    self.loggedInUser = [User currentUser];

    indexPaths = [[NSMutableDictionary alloc] init];
    
    //MAKE SAVED PAGE RELOAD AUTOMATICALLY
//    for (VolunteerOpportunity *vol in self.posts){
//        if (!vol.favorited){
//            [self.posts removeObject:vol];
//            [self.tableView reloadData];
//        }
//    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self.tableView reloadData];
}

// MAKE SAVED PAGE RELOAD AUTOMATICALLY
// - (void) viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self fetch];
//    for (VolunteerOpportunity *vol in self.posts){
//        if (!vol.favorited){
//            [self.posts removeObject:vol];
//            [self.tableView reloadData];
//        }
//    }
//    [self.tableView reloadData];
//    NSLog(@"go into view will appear");
//}

- (void) viewWillAppear:(BOOL)animated {
    NSLog(@"INSIDE VIEW WILL APPEAR");
    [super viewWillAppear:YES];
    [self fetch];
    [self.tableView reloadData];
}

- (void) reloadMethod {
    [self.tableView reloadData];
}

-(void)sendSenderToSaved:(id)sender
{
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    VolunteerOpportunity *theCurrentVolunOpp = self.volunteerOpportunities[indexPath.row];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Change the selected background view of the cell.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

<<<<<<< HEAD
=======
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

>>>>>>> ca0f55b2a1e58a3a04ab82521e90e46383348d17

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
            
            NSMutableArray *objectIds = [[NSMutableArray alloc] init];
            
            for (VolunteerOpportunity *vol in self.posts){
                [objectIds addObject:vol.objectId];
            }
            
            for (VolunteerOpportunity *vol in posts){
            if ([favPostIDs containsObject:vol.objectId])
                 {
                     if ([objectIds containsObject:vol.objectId])
                     {
                         NSLog(@"contains object");
                     }
                     else
                     {
                         [self.posts addObject:vol];
                     }
                 }
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [self.refreshControl endRefreshing];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"we are in cellforRow");
    VolunteerOpportunityCell *postCell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell"];
    
    VolunteerOpportunity *post = self.posts[indexPath.row];
    
    
    // indexpath stuff
    postCell.favoritedButton.tag = 1;
    NSLog(@"%ld", (long)postCell.favoritedButton.tag);
    
    postCell.favoritedButton.tag = indexPath.row;
    NSLog(@"favoritedbuttontag");
    NSLog(@"%ld", (long)postCell.favoritedButton.tag);
    NSLog(@"indexpathrow");
    NSLog(@"%ld", (long)indexPath.row);
    
    NSString *key = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    [indexPaths setObject:indexPath forKey:key];

    
    [postCell configureCell:post];

    NSIndexPath *testIndexPath = [indexPaths objectForKey:key];

    NSLog(@"testIndexPath row");
    NSLog(@"%ld", (long)testIndexPath.row);
    
    return postCell;
}

- (IBAction)didUnfavorite:(id)sender {
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    VolunteerOpportunity *theCurrentVolunOpp = self.posts[indexPath.row];
    
    
        // Do whatever data deletion you need to do...
        //[self.posts removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
    
    PFQuery *friendQuery = [PFUser query];
    //NSLog(@"%@", user.contactNumber);
    //Ask Morgan about whereKey
    [friendQuery whereKey:@"username" equalTo:self.loggedInUser.username];
    [friendQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
     {
         UIButton *favoritedButton = sender;
         NSInteger indexPathRow =  favoritedButton.tag;
         NSString *newKey = [NSString stringWithFormat:@"%ld", favoritedButton.tag];

         NSIndexPath *currentIndexPath = [indexPaths objectForKey:newKey];
         [indexPaths removeObjectForKey:newKey];
         
         //old way which works??
         VolunteerOpportunity *removedVolunOpp =self.posts[indexPathRow];
         removedVolunOpp.favorited = NO;
         NSLog(@"PRE DELETE");
         NSLog(@"%@", self.loggedInUser.favoritedOpps);
         
         [self.loggedInUser.favoritedOpps removeObject:removedVolunOpp.objectId];
         [self.posts removeObject:removedVolunOpp];
         
         // cellremove code used to be here
         
         NSLog(@"POST DELETE");
         
         NSLog(@"%@", self.loggedInUser.favoritedOpps);
         
         
         [self.loggedInUser setObject:self.loggedInUser.favoritedOpps forKey:@"favoritedOpps"];
         [self.loggedInUser saveInBackground];
         
         NSLog(@"deleted from favoriteOpps and saved in Parse");
         //self.favoritedButton.selected = YES;
         //         self.delegate =
         //         [self.delegate sendSenderToSaved:sender];
         //
         //
         //
         //         //animate disappear
         //         int index;
         //         for ()
         //
         
        // UITableViewCell *tappedCell = sender;
              //    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
         //UIButton *favoritedButton = sender;
         
         //indexPath.row = favoritedButton.tag;
         NSLog(@"%@", indexPath);
         //         VolunteerOpportunity *theCurrentVolunOpp = self.volunteerOpportunities[indexPath.row];
         [CATransaction begin];
         [self.tableView beginUpdates];
         [CATransaction setCompletionBlock: ^{
             [self.tableView reloadData];
         }];
         [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:currentIndexPath, nil] withRowAnimation:UITableViewRowAnimationLeft ];
         [self.tableView endUpdates];
         [CATransaction commit];
     }];
    

    
}

//- (void)tableView:(UITableView *)tableView  forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView beginUpdates];
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Do whatever data deletion you need to do...
//        [self.productItems removeObjectAtIndex:indexPath.row];
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationRight ];
//    }
//    [tableView endUpdates];
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    VolunteerOpportunity *theCurrentVolunOpp = self.posts[indexPath.row];
    
    if ([segue.identifier isEqualToString:@"detailsSegue"])
    {
        DetailViewController *detailedController = [segue destinationViewController];
        detailedController.post = theCurrentVolunOpp;
        NSLog(@"checking detailedPost");
    }
}


@end
