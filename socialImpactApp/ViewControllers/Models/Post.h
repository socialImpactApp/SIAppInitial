//
//  Post.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/16/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "PFObject.h"
#import <Parse/Parse.h>

@interface Post : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) PFFile *image;
@property (nonatomic, strong) NSString *hours;
//@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSNumber *spotsLeft;
//@property (nonatomic, strong) NSNumber *lng;
//@property (nonatomic, strong) NSNumber *lat;
//@property (nonatomic, strong) NSString *date;

//***These are the tags for each volunteer post***
//@property (nonatomic) BOOL didTapAnimal;
//@property (nonatomic) BOOL didTapChildYouth;
//@property (nonatomic) BOOL didTapConstruct;
//@property (nonatomic) BOOL didTapEducation;
//@property (nonatomic) BOOL didTapEnvironment;
//@property (nonatomic) BOOL didTapFood;
//@property (nonatomic) BOOL didTapFund;
//@property (nonatomic) BOOL didTapMed;

@property (nonatomic, strong) NSArray <NSString *> *tags;




+ (PFObject *) postUserOpp: ( UIImage * _Nullable )image withTitle:( NSString * _Nullable )title withDescripton:( NSString * _Nullable )description withHours:( NSString * _Nullable )hours withSpots:( NSNumber * _Nullable )spotsLeft withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image;

@end
