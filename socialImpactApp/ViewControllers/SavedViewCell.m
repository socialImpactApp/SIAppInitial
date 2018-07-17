//
//  SavedViewCell.m
//  socialImpactApp
//
//  Created by Ezra Bekele on 7/17/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "SavedViewCell.h"
#import "Post.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import "User.h"

@implementation SavedViewCell

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
    User *user = [User currentUser];
    self.savedDescription.text = post[@"description"];
    self.savedTitle.text = post[@"title"];
    self.savedLocation.text = [[post[@"lat"] stringByAppendingString:@" "]  stringByAppendingString:post[@"lng"]];
    self.savedImage.image = post[@"image"];
    
}

@end
