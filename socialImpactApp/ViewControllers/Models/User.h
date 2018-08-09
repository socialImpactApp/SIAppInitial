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
@property (strong, nonatomic) NSMutableArray <NSString *> * _Nullable timelineOpps;
@property (nonatomic, weak) PFFile * _Nullable profileImage;
@property (nonatomic, weak) NSString * _Nullable name;
@property (nonatomic, strong) NSString * _Nullable username;
@property (nonatomic, weak) NSString * _Nullable contactNumber;
@property (nonatomic, weak) NSMutableArray * _Nullable oppsDone;
@property (nonatomic, strong) NSString * _Nullable email;
@property (nonatomic, strong) NSString * _Nullable organization;

+ (PFFile *_Nullable)getPFFileFromImage: (UIImage * _Nullable)image;
//+ (PFFile *)getPFFileFromPFImage: (PFImageView * _Nullable)image;
@end
