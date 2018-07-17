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
@end
