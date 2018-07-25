//
//  SearchTableViewCell.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/25/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

-(void)configureCell: (NSString *) string;

@end
