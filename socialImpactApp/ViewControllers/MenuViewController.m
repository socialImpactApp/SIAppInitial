//
//  MenuViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/15/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "MenuViewController.h"
#import "Post.h"
#import "AppDelegate.h"
#import "PostCell.h"


@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 150;

    [self fetch]; 
}


-(void)fetch {
    //[self.refreshIndicator startAnimating];
    
    //PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    PFQuery *query = [Post query];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    //  [query whereKey:@"likesCount" greaterThan:@100];
    //query.limit = post_count;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            [self.tableView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
            //[self.tableView reloadData];
        }
        //[self.refreshIndicator stopAnimating];
    }];
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
    return self.posts.count;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"we are in cellforRow");
    PostCell *postCell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell"];
    Post *post = self.posts[indexPath.row];
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
