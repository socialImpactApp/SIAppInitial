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
    self.titleLabel.text = volunOpp[@"title"];
    self.hoursLabel.text = volunOpp[@"hours"];
    self.descriptionLabel.text = volunOpp[@"description"];
}

- (IBAction)didTapFavorite:(id)sender {
//    User *loggedInUser = [[User alloc] init];
    User *user = [User currentUser];
    PFQuery *friendQuery = [PFUser query];
    NSLog(@"%@", user.contactNumber);
    //[friendQuery whereKey:@"username" equalTo:loggedInUser.username];
//    [friendQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
//    {
//        /* This is how you add 'userNameToAdd' to the Array called friendsList that
//         * belongs to the special parse class called User (PFUser type): */
//
//        // This is your current user
//        // Adds object to friendList array
//        [loggedInUser.favoritedOpps addObject:self.post.postID];
//
//        // Saves the changes on the Parse server. This is necessary to update the actual Parse server. If you don't "save" then the changes will be lost
//        [loggedInUser saveInBackground];
//        NSLog(@"added to favoriteOpps");
//    }];

//    if (self.favoritedButton.selected)
//    {
//
//
//    }

}



@end
