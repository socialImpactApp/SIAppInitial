//
//  VolunteerOpportunityCell.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/16/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

//QUESTIONS AND CONCERNS
//why does it need to loadInBackground???? LINE 31
#import "VolunteerOpportunityCell.h"
#import "Parse/Parse.h"
#import <ParseUI/ParseUI.h>
#import "User.h"
#import "VolunteerOpportunity.h"
#import "Colours.h"

#import "ShowLocationViewController.h"


#import "SavedViewController.h"


@implementation VolunteerOpportunityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.loggedInUser = [User currentUser];
    if (self.loggedInUser.favoritedOpps == NULL)
    {
        self.loggedInUser.favoritedOpps = [[NSMutableArray alloc] init];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}




-(void)configureCell: (VolunteerOpportunity *) volunOpp {
    self.volunteerOpportunity = volunOpp;
    //NSLog(@"%@", volunOpp.objectId);
    self.oppImageView.layer.cornerRadius = self.oppImageView.frame.size.height/2;
    self.oppImageView.file = volunOpp[@"image"];
    [self.oppImageView loadInBackground];
    self.titleLabel.text = volunOpp[@"title"];
    self.hoursLabel.text = volunOpp[@"hours"];
    self.descriptionLabel.text = volunOpp[@"description"];
    self.dateLabel.text = volunOpp[@"date"];
    self.locationLabel.text = volunOpp[@"cityState"];

    //self.dateLabel.text = volunOpp[@"date"];
    
    NSDate *newDate = volunOpp.createdAt;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yy";
    NSString *dateString =  [dateFormatter stringFromDate:newDate];
    NSLog(@"DATE STRING");
    NSLog(@"%@", volunOpp[@"date"]);
    NSLog(@"%@", dateString);
    NSLog(@"%@", self.dateLabel.text);
    self.dateLabel.text = dateString;
    
    //MERGE CONFLICT
    //self.dateLabel.text = volunOpp[@"date"];
    self.locationLabel.text = volunOpp[@"location"];
    self.backCellView.backgroundColor = [UIColor whiteColor];
    self.backCellView.layer.cornerRadius = 2.0;
    self.contentView.backgroundColor = [UIColor snowColor];
    self.backCellView.layer.masksToBounds = NO;
    self.backCellView.layer.shadowColor = [[UIColor coolGrayColor] CGColor];
    self.backCellView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.backCellView.layer.shadowOpacity = 0.5;
    
    
    User *loggedInUser = [User currentUser];
    if ([loggedInUser.favoritedOpps containsObject:volunOpp.objectId])
    {
        self.favoritedButton.selected = YES;
    }
    else
    {
        self.favoritedButton.selected = NO;
    }
}

- (IBAction)didTapFavorite:(id)sender {
    if (self.favoritedButton.selected)
    {
        PFQuery *friendQuery = [PFUser query];
        //NSLog(@"%@", user.contactNumber);
        //Ask Morgan about whereKey
        [friendQuery whereKey:@"username" equalTo:self.loggedInUser.username];
        [friendQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             self.volunteerOpportunity.favorited = NO;
             NSLog(@"PRE DELETE");
             NSLog(@"%@", self.loggedInUser.favoritedOpps);
             
             
             [self.loggedInUser.favoritedOpps removeObject:self.volunteerOpportunity.objectId];
             
             NSLog(@"POST DELETE");
             
             NSLog(@"%@", self.loggedInUser.favoritedOpps);
             
             
             [self.loggedInUser setObject:self.loggedInUser.favoritedOpps forKey:@"favoritedOpps"];
             [self.loggedInUser saveInBackground];
             
             NSLog(@"deleted from favoriteOpps and saved in Parse");
             self.favoritedButton.selected = NO;
         }];
        
        
    }
    
    else {
        {
            PFQuery *friendQuery = [PFUser query];
            //NSLog(@"%@", user.contactNumber);
            //Ask Morgan about whereKey
            [friendQuery whereKey:@"username" equalTo:self.loggedInUser.username];
            [friendQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
             {
                 NSLog(@"test post ID for null");
                 NSLog(@"%@", self.volunteerOpportunity.postID);
                 [self.loggedInUser.favoritedOpps addObject:self.volunteerOpportunity.objectId];
                 NSLog(@"%@", self.loggedInUser.favoritedOpps);
                 self.loggedInUser[@"favoritedOpps"] = self.loggedInUser.favoritedOpps;
                 [self.loggedInUser saveInBackground];
                 NSLog(@"%lu", self.loggedInUser.favoritedOpps);
                 NSLog(@"added to favoriteOpps");
                 self.favoritedButton.selected = YES;
             }];
            
        }
        
    }
    
}


}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    if ([segue.identifier isEqualToString:@"showLocationSeg"]) {
//        ShowLocationViewController *showController =
//        segue.destinationViewController;
//        showController.delegate = self;
//    }
    
}





@end
