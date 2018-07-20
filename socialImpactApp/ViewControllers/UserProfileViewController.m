//
//  UserProfileViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/19/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "UserProfileViewController.h"
#import "EditUserProfileViewController.h"
#import <ParseUI/ParseUI.h>
#import "User.h"


@interface UserProfileViewController () <EditUserProfileViewControllerDelegate>
//@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet PFImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *oppsDoneLabel;
@property (weak, nonatomic) User *user;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    User *user = [User currentUser];
    PFFile *profile_image = user.profileImage;
    self.userImageView.file = profile_image;
    self.userImageView.layer.cornerRadius= self.userImageView.frame.size.height/2;

    [self.userImageView loadInBackground];
    
    self.nameLabel.text = user.name;
    self.usernameLabel.text = user.username;
    self.contactLabel.text = user.contactNumber;
    self.emailLabel.text = user.email;
    
}

- (void)viewDidAppear {
    User *user = [User currentUser];
    self.nameLabel.text = user.name;
    self.usernameLabel.text = user.username;
    self.contactLabel.text = user.contactNumber;
    self.emailLabel.text = user.email;
    self.userImageView.file = user.profileImage;
    [self.userImageView loadInBackground];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didTapSaveUser:(User *)user{
    self.nameLabel.text = user.name;
    self.usernameLabel.text = user.username;
    self.contactLabel.text = user.contactNumber;
    self.emailLabel.text = user.email;
    self.userImageView.file = user.profileImage;
    [self.userImageView loadInBackground];

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"editUserSeg"]) {
        EditUserProfileViewController *editUserViewController =
        segue.destinationViewController;
        editUserViewController.delegate = self;
    }
}


@end
