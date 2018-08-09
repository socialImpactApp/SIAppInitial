//
//  TimelineTableViewCell.h
//  socialImpactApp
//
//  Created by Ezra Bekele on 8/3/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VolunteerOpportunity.h"
#import <ParseUI/ParseUI.h>
#import "User.h"

@interface TimelineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong,nonatomic) VolunteerOpportunity *volunteerOpportunity;
@property (strong,nonatomic) NSString *justDate;

@property (weak, nonatomic) IBOutlet UIButton *exportToAppleCalendar;
@property (strong,nonatomic) NSString *fullDateAndTime;
@property (strong,nonatomic) NSString *hours;
@property (strong,nonatomic) NSString *titleText;
@property (nonatomic, assign) BOOL *posted;

-(void)configureCell: (VolunteerOpportunity *) volunOpp;

@end
