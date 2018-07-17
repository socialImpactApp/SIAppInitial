//
//  User.h
//  socialImpactApp
//
//  Created by Ezra Bekele on 7/17/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFUser.h"
#import <Parse/Parse.h>

@interface User : PFUser<PFSubclassing>

@property PFFile *profileImage;
@property NSString *username;
@property NSString *contactNumber;
@property NSArray *oppsDone;
@property NSString *email;

@end