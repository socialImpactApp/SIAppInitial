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
#import "Post.h"

@interface User : PFUser<PFSubclassing>

@property NSMutableArray <NSString *> *favoritedOpps;
@property PFFile *profileImage;
@property NSString *username;
@property NSString *contactNumber;
@property NSArray *oppsDone;
@property NSString *email;
 

@end
