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



@interface VolunteerOpportunityCell : UITableViewCell
@property (strong, nonatomic)  VolunteerOpportunity *post;
@property (weak, nonatomic) IBOutlet PFImageView *oppImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoritedButton;
@property (weak, nonatomic) IBOutlet UIView *backCellView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;

//going to access this publicly in MenuViewController
-(void)configureCell: (VolunteerOpportunity *) volunOpp;

@end
