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
#import "VolunteerOpportunity.h"

@interface User : PFUser<PFSubclassing>

@property NSMutableArray <NSString *> * _Nullable favoritedOpps;
@property (strong, nonatomic) NSMutableArray <NSString *> *timelineOpps;

@property PFFile * _Nullable profileImage;
@property NSString * _Nullable name;
@property NSString * _Nullable username;
@property NSString * _Nullable contactNumber;
@property NSMutableArray * _Nullable oppsDone;
@property NSString * _Nullable email;


+ (PFFile *_Nullable)getPFFileFromImage: (UIImage * _Nullable)image;
//+ (PFFile *)getPFFileFromPFImage: (PFImageView * _Nullable)image;
@end
