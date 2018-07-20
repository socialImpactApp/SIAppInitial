//
//  SavedViewCell.h
//  socialImpactApp
//
//  Created by Ezra Bekele on 7/17/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VolunteerOpportunity.h"

@interface SavedViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *savedDescription;
@property (weak, nonatomic) IBOutlet UILabel *savedTitle;
@property (weak, nonatomic) IBOutlet UILabel *savedLocation;
@property (weak, nonatomic) IBOutlet UIImageView *savedImage;
@property (strong, nonatomic) VolunteerOpportunity *post;

-(void)configureCell: (VolunteerOpportunity *) post;


@end
