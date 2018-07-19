//
//  PostCell.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/16/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <ParseUI/ParseUI.h>


@interface PostCell : UITableViewCell
@property (strong, nonatomic)  Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *oppImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoritedButton;


//going to access this publicly in MenuViewController
-(void)configureCell: (Post *) post;

@end
