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


@implementation VolunteerOpportunityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void)configureCell: (VolunteerOpportunity *) volunOpp {
    self.post = volunOpp;
    self.oppImageView.file = volunOpp[@"image"];
    [self.oppImageView loadInBackground];
    self.oppImageView.layer.cornerRadius = self.oppImageView.frame.size.height/2;
    self.titleLabel.text = volunOpp[@"title"];
    self.hoursLabel.text = volunOpp[@"hours"];
    self.descriptionLabel.text = volunOpp[@"description"];
    self.dateLabel.text = volunOpp[@"date"];
    self.locationLabel.text = volunOpp[@"location"];
    self.backCellView.backgroundColor = [UIColor whiteColor];
    self.backCellView.layer.cornerRadius = 2.0;
    self.contentView.backgroundColor = [UIColor snowColor];
    self.backCellView.layer.masksToBounds = NO;
    self.backCellView.layer.shadowColor = [[UIColor coolGrayColor] CGColor];
    self.backCellView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.backCellView.layer.shadowOpacity = 0.5;
    
    
}

- (IBAction)didTapFavorite:(id)sender {
    User *loggedInUser = [User currentUser];
    PFQuery *friendQuery = [PFUser query];
    //NSLog(@"%@", user.contactNumber);
    [friendQuery whereKey:@"username" equalTo:loggedInUser.username];
    [friendQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
    {
        /* This is how you add 'userNameToAdd' to the Array called friendsList that
         * belongs to the special parse class called User (PFUser type): */

        // This is your current user
        // Adds object to friendList array
        [loggedInUser.favoritedOpps addObject:self.post.postID];

        // Saves the changes on the Parse server. This is necessary to update the actual Parse server. If you don't "save" then the changes will be lost
        [loggedInUser saveInBackground];
        NSLog(@"added to favoriteOpps");
    }];

//    if (self.favoritedButton.selected)
//    {
//
//
//    }

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    if ([segue.identifier isEqualToString:@"showLocationSeg"]) {
//        ShowLocationViewController *showController =
//        segue.destinationViewController;
//        showController.delegate = self;
//    }
    
}



@end
