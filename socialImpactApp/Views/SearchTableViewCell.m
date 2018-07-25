 //
//  SearchTableViewCell.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/25/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(NSString *)string{
    self.resultLabel.text = string;    
}


@end
