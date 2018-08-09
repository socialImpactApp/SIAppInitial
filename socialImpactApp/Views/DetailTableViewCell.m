//
//  DetailTableViewCell.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 8/7/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "Colours.h"
@implementation DetailTableViewCell{
     NSMutableArray *tagArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell: (VolunteerOpportunity *) volunOpp {
    tagArray = [[NSMutableArray alloc] init ];
    self.contentView.backgroundColor = [UIColor snowColor];
    PFObject *postAuthor = volunOpp[@"author"];
    //loadinbackground
    self.largeDescription.text = volunOpp[@"description"]; // good
    self.contactInfo.text = postAuthor[@"contactNumber"];
    self.hours.text = volunOpp[@"hours"]; // good
    self.spotsLeft.text = volunOpp[@"spotsLeft"]; //good
    self.volunteerOppTitle.text = volunOpp[@"title"];
    
//    CALayer *bottomBorder = [CALayer layer];
//    bottomBorder.frame = CGRectMake(0.0f, self.volunteerOppTitle.frame.size.height - 1, self.volunteerOppTitle.frame.size.width, 1.0f);
//    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
//    [self.volunteerOppTitle.layer addSublayer:bottomBorder];
    
    self.Location.text = volunOpp[@"location"];
    
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
@end
