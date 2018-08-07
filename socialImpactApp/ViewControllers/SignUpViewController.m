//
//  SignUpViewController.m
//  socialImpactApp
//
//  Created by Ezra Bekele on 7/18/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginViewController.h"
#import "User.h"

@interface SignUpViewController ()

@property (strong,nonatomic) User *loggedInUser;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) registerUser {
    
 
    //checking if empty
    if ([self.username.text isEqual:@""] || [self.password.text isEqual:@""]) {
        // we crete a new alert
        NSLog(@"there is an empty field here");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty Field" message:@"Please make sure both username and password fields are completed" preferredStyle:UIAlertControllerStyleAlert];
        
        // create an action(button)N for that alert
        //handler is what happens after press action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {            //[self dismissViewControllerAnimated:YES completion:^{
            // more extra stuff just want to dismiss
                    //}
                //];
        }];
        
        //how to actually apply it
        [alert addAction:okAction];
        
        //want to present after programming error
        [self presentViewController:alert animated:YES completion:^{
            // for when the controler is finished
        }];
    }
    else {
        // initalizes a new user object ..  making a new user
        User *newUser = [User user];
        newUser.favoritedOpps = [[NSMutableArray alloc] init];
        newUser.store = [[EKEventStore alloc] init];
        
        // set user properties
        newUser.username = self.username.text;
        newUser.password = self.password.text;
        
        // call sign up function
        [newUser signUpInBackgroundWithBlock:^(BOOL suceeded, NSError *error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            }
            else {
                NSLog(@"User registered sucessfully");
                self.loggedInUser = [User currentUser];
                NSLog(self.loggedInUser.username );
                [self performSegueWithIdentifier:@"signup" sender:nil];
                
            }
        }];
    }
}


- (IBAction)didTapAway:(id)sender {
    [self.view endEditing:YES];
}



- (IBAction)didTapSignUp:(id)sender {
    [self registerUser];
}


 #pragma mark - Navigation
 /*
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     
     
 }
 */



@end
