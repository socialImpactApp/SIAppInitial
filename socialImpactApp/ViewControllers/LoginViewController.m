//
//  LoginViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/15/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "LoginViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import "User.h"

@interface LoginViewController ()

@property (strong,nonatomic) User *loggedInUser;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loginUser {
    NSString *username = self.username.text;
    NSString *password = self.password.text;

    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"There was an error logging in: %@", error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {            [self dismissViewControllerAnimated:YES completion:^{
            }];
            }];
            
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:^{
            }];
        }
        else {
            User *newUser = [User user];
            newUser.favoritedOpps= [[NSMutableArray alloc] init];
            self.loggedInUser = [User currentUser];
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (IBAction)didTapAway:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)didTapLogin:(id)sender {
    [self loginUser];
    [self dismissViewControllerAnimated:true completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
