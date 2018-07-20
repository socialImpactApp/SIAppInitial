//
//  VolunteerOpportunity.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/16/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "PFObject.h"
//#import "Constants.h" WHY IS THIS CAUSING AN ERROR
#import "VolunteerOpportunity.h"

@implementation VolunteerOpportunity
@dynamic postID;
@dynamic title;
@dynamic userID;
@dynamic author;
@dynamic description;
@dynamic image;
@dynamic hours;
//@dynamic contact;
@dynamic spotsLeft;
//@dynamic lng;
//@dynamic lat;
//@dynamic date
@dynamic tags;


//this is the parse class name that we have to instantiate
+ (nonnull NSString *)parseClassName {
    return @"VolunteerOpportunity";
}

//method to make a post
//postUserOppWithoutTags
+ (PFObject *) postUserOpp: ( UIImage * _Nullable )image
                 withTitle:( NSString * _Nullable )title
            withDescripton:( NSString * _Nullable )description
                 withHours:( NSString * _Nullable )hours
                 withSpots:( NSNumber * _Nullable )spots
            withTags:(NSMutableArray <NSString * > *_Nullable)tags
            withDate:(NSString * _Nullable)date
            withCompletion: (PFBooleanResultBlock  _Nullable)completion{
    VolunteerOpportunity *newPost = [VolunteerOpportunity new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.description = description;
    newPost.title = title;
    newPost.hours= hours;
    newPost.spotsLeft = spots;
    newPost.tags = tags;
    newPost.date = date; 
    [newPost saveInBackgroundWithBlock:completion];
    return newPost;

}


//modified post with tags
+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFile fileWithName:@"image.png" data:imageData];
}


@end
