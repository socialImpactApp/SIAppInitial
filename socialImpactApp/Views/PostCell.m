//
//  PostCell.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/16/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

//QUESTIONS AND CONCERNS
//why does it need to loadInBackground???? LINE 31
#import "PostCell.h"
#import "Parse/Parse.h"
#import <ParseUI/ParseUI.h>
#import "User.h"
#import "Post.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell: (Post *) post {
    self.post = post;
    self.oppImageView.file = post[@"image"];
    [self.oppImageView loadInBackground];
    self.titleLabel.text = post[@"title"];
    self.hoursLabel.text = post[@"hours"];
    self.descriptionLabel.text = post[@"description"];
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



@end
