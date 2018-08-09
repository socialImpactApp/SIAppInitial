
//
//  MenuViewController.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/15/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VolunteerOpportunity.h"
#import "User.h"

@interface MenuViewController : UIViewController

@property (nonatomic, strong) VolunteerOpportunity *currentPost;
@property (strong,nonatomic) User *loggedInUser;

@end
