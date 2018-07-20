//
//  EditUserProfileViewController.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/19/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@protocol EditUserProfileViewControllerDelegate

-(void)didTapSaveUser:(PFUser *) user;

@end

@interface EditUserProfileViewController : UIViewController

@property (strong, nonatomic) id<EditUserProfileViewControllerDelegate> delegate;

@end
