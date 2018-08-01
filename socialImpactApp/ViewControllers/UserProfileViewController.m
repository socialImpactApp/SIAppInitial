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
#import "Colours.h"



@interface UserProfileViewController () <EditUserProfileViewControllerDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet PFImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *oppsDoneLabel;
@property (weak, nonatomic) User *user;
@property (strong, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UILabel *orgLabel;

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
    self.orgLabel.text = user.organization;

    self.userView.backgroundColor = [UIColor snowColor];
    [super viewDidLoad];
//    CGFloat customRefreshControlHeight = 50.0f;
//    CGFloat customRefreshControlWidth = 320.0f;
//    CGRect customRefreshControlFrame = CGRectMake(0.0f,
//                                                  -customRefreshControlHeight,
//                                                  customRefreshControlWidth,
//                                                  customRefreshControlHeight);
//    
//    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:customRefreshControlFrame]; 
    
    [self.userView addSubview:self.refreshControl];
}



- (void)viewDidAppear:(BOOL)isAnimated {
    [super viewDidAppear:true];
    User *user = [User currentUser];
    self.nameLabel.text = user.name;
    self.usernameLabel.text = user.username;
    self.contactLabel.text = user.contactNumber;
    self.emailLabel.text = user.email;
    self.userImageView.file = user.profileImage;
    self.orgLabel.text = user.organization;
    __weak typeof(self) weakSelf = self;
    [self.userImageView loadInBackground:^(UIImage * _Nullable image, NSError * _Nullable error) {
        [weakSelf.userView setNeedsLayout];
    }];
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
