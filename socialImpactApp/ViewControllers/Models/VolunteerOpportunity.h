//
//  VolunteerOpportunity.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/16/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "PFObject.h"
#import <Parse/Parse.h>

@interface VolunteerOpportunity : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString * _Nullable postID;
@property (nonatomic, strong) NSString * _Nullable title;
@property (nonatomic, strong) NSString * _Nullable userID;
@property (nonatomic, strong) PFUser * _Nullable author;
@property (nonatomic, strong) NSString * _Nullable description;
@property (nonatomic, strong) PFFile * _Nullable image;
@property (nonatomic, strong) NSString * _Nullable hours;
//@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSNumber * _Nullable spotsLeft;
//@property (nonatomic, strong) NSNumber *lng;
//@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSString * _Nullable date;
//***These are the tags for each volunteer post***
@property (nonatomic, strong) NSMutableArray <NSString *> * _Nullable tags;


+ (PFObject *_Nullable) postUserOpp: ( UIImage * _Nullable )image
                 withTitle:( NSString * _Nullable )title
            withDescripton:( NSString * _Nullable )description
                 withHours:( NSString * _Nullable )hours withSpots:( NSNumber * _Nullable )spotsLeft
                  withTags:(NSMutableArray <NSString * > *_Nullable)tags
                  withDate:(NSString * _Nullable)date
            withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (PFFile *_Nullable)getPFFileFromImage: (UIImage * _Nullable)image;

@end
