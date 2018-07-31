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
#import <ParseUI/ParseUI.h>
#import "User.h"
#import "ShowLocationViewController.h"

@interface DetailViewController () 

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configureCell:self.post];
    
    UIFont * customFont = [UIFont fontWithName:@"NewsCycle" size:12]; //custom font
    NSString * text = [self description];
    
    CGRect labelSize = [text boundingRectWithSize:CGSizeMake(380.0, 20.0)
                                          options:NSStringDrawingTruncatesLastVisibleLine
                                       attributes:nil
                                          context:nil];
                        
    

    
//                        boundingRectWithSize:CGSizeMake(380.00, 20.00) options:NSStringDrawingTruncatesLastVisibleLine attributes:nil context:nil];
    
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 20, 10)];
    fromLabel.text = text;
    fromLabel.font = customFont;
    fromLabel.numberOfLines = 1;
    fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    fromLabel.adjustsFontSizeToFitWidth = YES;
    fromLabel.minimumScaleFactor = 10.0f/12.0f;
    fromLabel.clipsToBounds = YES;
    fromLabel.backgroundColor = [UIColor clearColor];
    fromLabel.textColor = [UIColor blackColor];
    fromLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:fromLabel];
}

-(void)configureCell: (VolunteerOpportunity *) post {
    self.backgroundPic.file = post[@"image"];
    
    User *user = [User currentUser];
    self.largeDescription.text = post[@"description"]; // good
//    self.Location.text = [[self.post[@"lat"] // might use this for location later stringByAppendingString:@" "] stringByAppendingString:self.post[@"lng"]];
    self.contactInfo.text = user[@"contactNumber"];
    self.hours.text = post[@"hours"]; // good
    self.spotsLeft.text = post[@"spotsLeft"]; //good
    self.volunteerOppTitle.text = post[@"title"];
    self.Location.text = post[@"location"];
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
