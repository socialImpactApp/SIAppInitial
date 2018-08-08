//
//  DetailViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/15/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "DetailViewController.h"
#import "VolunteerOpportunity.h"
#import "VolunteerOpportunityCell.h"
#import "DetailTableViewCell.h"
#import "User.h"
#import "ShowLocationViewController.h"
#import "Colours.h"

@interface DetailViewController () < UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@end

@implementation DetailViewController{
    NSMutableArray *tagArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
    self.backgroundVoppView.layer.zPosition = -1;
    //[self configureCell:self.post];
    self.signButton.layer.cornerRadius = 10.0;
    self.signButton.layer.borderWidth = 0.7f;
    self.signButton.layer.borderColor =[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
    PFObject *postAuthor = self.post[@"author"];
    self.backgroundVoppView.file = self.post[@"image"];
    //loadinbackground
    [self.backgroundVoppView loadInBackground];
    self.orgLabel.text = postAuthor[@"organization"];
    self.orgLabel.layer.shadowRadius = 2.0;
    self.orgLabel.layer.masksToBounds = NO;
    self.orgLabel.layer.shadowColor = [[UIColor coolGrayColor] CGColor];
    self.orgLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.orgLabel.layer.shadowOpacity = 0.5;
    self.orgImageView.layer.cornerRadius = self.orgImageView.frame.size.height/2;
    self.orgImageView.file = postAuthor[@"profileImage"];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapSignUp:(id)sender {
    User *loggedInUser = [User currentUser];
    if (loggedInUser.timelineOpps == NULL) {
        loggedInUser.timelineOpps = [[NSMutableArray alloc] init];
    }
    [loggedInUser.timelineOpps addObject:self.post.objectId];
    loggedInUser[@"timelineOpps"] = loggedInUser.timelineOpps;
    [loggedInUser saveInBackground];

}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapShare:(id)sender {
    NSLog(@"WE ARE SHARING");
    //FBSDKShareLinkContent *linkContent = [FBSDKShareLinkContent new];
    FBSDKShareLinkContent *linkContent = [[FBSDKShareLinkContent alloc] init];
    linkContent.contentURL = [NSURL URLWithString:@"https://dry-meadow-94919.herokuapp.com/"];
    //linkContent.quote = @"hi i am the description ;)";
    FBSDKShareDialog *shareDialog = [FBSDKShareDialog new];
    shareDialog.shareContent = linkContent;
    [FBSDKShareDialog showFromViewController:self withContent:linkContent delegate:nil];

  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailTableViewCell *postCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"];
    //setting each button to have a tag
    [postCell configureCell:self.post];
    return postCell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showLocSeg"]) {
        ShowLocationViewController *showLocViewController =
        segue.destinationViewController;
        showLocViewController.post = self.post;
    }
}


@end
