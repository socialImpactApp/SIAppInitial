//
//  DetailTableViewCell.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 8/7/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VolunteerOpportunity.h"
#import "User.h"

@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *largeDescription;
@property (weak, nonatomic) IBOutlet UILabel *Location;
@property (weak, nonatomic) IBOutlet UILabel *contactInfo;
@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UILabel *spotsLeft;
@property (strong, nonatomic) VolunteerOpportunity *post;
@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UILabel *volunteerOppTitle;
@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (weak, nonatomic) IBOutlet UILabel *filtersLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *shareTitle;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
-(void)configureCell: (VolunteerOpportunity *) volunOpp;

@end
