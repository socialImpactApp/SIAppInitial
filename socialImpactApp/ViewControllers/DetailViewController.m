//
//  DetailViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/15/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "DetailViewController.h"
#import "Post.h"
#import "PostCell.h"
#import <ParseUI/ParseUI.h>
#import "User.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configureCell:self.post];
    
}

-(void)configureCell: (Post *) post {
    self.backgroundPic.file = post[@"image"];
    
    User *user = [User currentUser];
    self.largeDescription.text = post[@"description"]; // good
//    self.Location.text = [[self.post[@"lat"] stringByAppendingString:@" "] stringByAppendingString:self.post[@"lng"]];
    self.contactInfo.text = post[@"author"];
    self.hours.text = post[@"hours"]; // good
    self.spotsLeft.text = post[@"spotsLeft"]; //good
    self.volunteerOppTitle.text = post[@"title"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
