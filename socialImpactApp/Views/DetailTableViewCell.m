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
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.layer.zPosition = -100;
    PFObject *postAuthor = volunOpp[@"author"];
    //loadinbackground
    self.largeDescription.text = volunOpp[@"description"];
    self.contactInfo.text = postAuthor[@"contactNumber"];
    self.hours.text = volunOpp[@"hours"]; // good
    self.spotsLeft.text = volunOpp[@"spotsLeft"]; //good
    self.volunteerOppTitle.text = volunOpp[@"title"];
    
    self.Location.text = volunOpp[@"location"];
    self.signButton.layer.cornerRadius = 10.0;
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
