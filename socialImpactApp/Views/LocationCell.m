//
//  LocationCell.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/24/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "LocationCell.h"
@interface LocationCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@end

@implementation LocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithLocation:(NSDictionary *)location {
    self.nameLabel.text = location[@"name"];
    self.addressLabel.text = [location valueForKeyPath:@"location.address"];
    NSArray *categories = location[@"categories"];
    if (categories && categories.count > 0) {
        NSDictionary *category = categories[0];
        NSString *urlPrefix = [category valueForKeyPath:@"icon.prefix"];
        NSString *urlSuffix = [category valueForKeyPath:@"icon.suffix"];
        NSString *urlString = [NSString stringWithFormat:@"%@bg_32%@", urlPrefix, urlSuffix];
        
//        NSURL *url = [NSURL URLWithString:urlString];
//        [self.categoryImageView setImageWithURL:url];
    }
}

@end
