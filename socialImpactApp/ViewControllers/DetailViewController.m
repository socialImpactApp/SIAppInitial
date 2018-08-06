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
#import "User.h"
#import "ShowLocationViewController.h"
#import "Colours.h"

@interface DetailViewController () <UIScrollViewDelegate>

@end

@implementation DetailViewController{
    NSMutableArray *tagArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backgroundVoppView.layer.zPosition = -1;
    [self configureCell:self.post];
    self.signButton.layer.cornerRadius = 10.0;
    self.signButton.layer.borderWidth = 0.7f;
    self.signButton.layer.borderColor =[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    CGSize scrollSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 800);
    self.scrollView.contentSize = scrollSize;

   // self.scrollView.contentSize = CGSizeMake(375, 800);
    [self.view addSubview:self.scrollView];
 
//    UIFont * customFont = [UIFont fontWithName:@"NewsCycle" size:12]; //custom font
//    NSString * text = [self description];
//
//    CGRect labelSize = [text boundingRectWithSize:CGSizeMake(380.0, 20.0)
//                                          options:NSStringDrawingTruncatesLastVisibleLine
//                                       attributes:nil
//                                          context:nil];
//
 
//  boundingRectWithSize:CGSizeMake(380.00, 20.00) options:NSStringDrawingTruncatesLastVisibleLine attributes:nil context:nil];
    //ASK EZRA WHAT THIS IS
//    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 20, 10)];
//    fromLabel.text = text;
//    fromLabel.font = customFont;
//    fromLabel.numberOfLines = 1;
//    fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
//    fromLabel.adjustsFontSizeToFitWidth = YES;
//    fromLabel.minimumScaleFactor = 10.0f/12.0f;
//    fromLabel.clipsToBounds = YES;
//    fromLabel.backgroundColor = [UIColor clearColor];
//    fromLabel.textColor = [UIColor blackColor];
//    fromLabel.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:fromLabel];
}

-(void)configureCell: (VolunteerOpportunity *) volunOpp {
    tagArray = [[NSMutableArray alloc] init ]; 
    PFObject *postAuthor = volunOpp[@"author"];
    self.backgroundVoppView.file = volunOpp[@"image"];
    //loadinbackground
    [self.backgroundVoppView loadInBackground];
    self.largeDescription.text = volunOpp[@"description"]; // good
    self.contactInfo.text = postAuthor[@"contactNumber"];
    self.hours.text = volunOpp[@"hours"]; // good
    self.spotsLeft.text = volunOpp[@"spotsLeft"]; //good
    self.volunteerOppTitle.text = volunOpp[@"title"];
    self.Location.text = volunOpp[@"location"];
    self.orgLabel.text = postAuthor[@"organization"];
    self.orgLabel.layer.shadowRadius = 2.0;
    self.orgLabel.layer.masksToBounds = NO;
    self.orgLabel.layer.shadowColor = [[UIColor coolGrayColor] CGColor];
    self.orgLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.orgLabel.layer.shadowOpacity = 0.5;
    self.orgImageView.layer.cornerRadius = self.orgImageView.frame.size.height/2;
    self.orgImageView.file = postAuthor[@"profileImage"];
 
    for (NSString *tag in volunOpp[@"tags"]){
        if ([tag isEqualToString:@"animalWelfare"]){
            [tagArray addObject:@"Animal Welfare"];
        }
        else if ([tag isEqualToString:@"childrenAndYouth"]){
            [tagArray addObject:@"Children and Youth"];
        }
        else if ([tag isEqualToString:@"construction"]){
            [tagArray addObject:@"Construction"];
        }
        else if ([tag isEqualToString:@"education"]){
            [tagArray addObject:@"Education"];
        }
        else if ([tag isEqualToString:@"environmental"]){
            [tagArray addObject:@"Environmental"];
        }
        else if ([tag isEqualToString:@"foodService"]){
            [tagArray addObject:@"Food Service"];
        }
        else if ([tag isEqualToString:@"fundraising"]){
            [tagArray addObject:@"Fundraising"];
        }
        else if ([tag isEqualToString:@"medical"]){
            [tagArray addObject:@"Medical"];
        }
        
    }
    self.filtersLabel.text = [tagArray componentsJoinedByString:@", " ];
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
    linkContent.contentURL = [NSURL URLWithString:@"http://voppIshaEzra://"];
    //linkContent.quote = @"hi i am the description ;)";
    FBSDKShareDialog *shareDialog = [FBSDKShareDialog new];
    shareDialog.shareContent = linkContent;
    [FBSDKShareDialog showFromViewController:self withContent:linkContent delegate:nil];

  
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
