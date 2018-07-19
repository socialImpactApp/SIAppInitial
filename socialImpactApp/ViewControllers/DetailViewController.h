//
//  DetailViewController.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/15/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Post.h"
#import "User.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet PFImageView *backgroundPic;
@property (weak, nonatomic) IBOutlet UILabel *largeDescription;
@property (weak, nonatomic) IBOutlet UILabel *Location;
@property (weak, nonatomic) IBOutlet UILabel *contactInfo;
@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UILabel *spotsLeft;
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UILabel *volunteerOppTitle;


@end
