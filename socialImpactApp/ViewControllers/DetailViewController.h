//
//  DetailViewController.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/15/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "VolunteerOpportunity.h"
#import "User.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *largeDescription;
@property (weak, nonatomic) IBOutlet UILabel *Location;
@property (weak, nonatomic) IBOutlet UILabel *contactInfo;
@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UILabel *spotsLeft;
@property (strong, nonatomic) VolunteerOpportunity *post;
@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UILabel *volunteerOppTitle;
@property (weak, nonatomic) IBOutlet UILabel *orgLabel;
@property (weak, nonatomic) IBOutlet PFImageView *orgImageView;
@property (weak, nonatomic) IBOutlet PFImageView *backgroundVoppView;
@property (weak, nonatomic) IBOutlet UIButton *signButton;

@end
