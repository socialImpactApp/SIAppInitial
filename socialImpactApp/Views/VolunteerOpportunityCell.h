//
//  VolunteerOpportunityCell.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/16/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VolunteerOpportunity.h"
#import <ParseUI/ParseUI.h>
#import "User.h"


@interface VolunteerOpportunityCell : UITableViewCell

@property (strong, nonatomic)  VolunteerOpportunity *volunteerOpportunity;
@property (weak, nonatomic) IBOutlet PFImageView *oppImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoritedButton;

@property (strong,nonatomic) User *loggedInUser;
@property (strong, nonatomic) NSMutableArray <NSString *> *favoritedOpps;

//going to access this publicly in MenuViewController
-(void)configureCell: (VolunteerOpportunity *) volunOpp;

@end
