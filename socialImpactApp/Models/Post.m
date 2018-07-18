//
//  Post.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/16/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "PFObject.h"
#import "Constants.h"
#import "Post.h"

@implementation Post
@dynamic postID;
@dynamic title;
@dynamic userID;
@dynamic author;
@dynamic description;
@dynamic image;
@dynamic hours;
//@dynamic contact;
@dynamic spotsLeft;
@dynamic lng;
@dynamic lat;
//@gnamic date

//this is the parse class name that we have to instantiate
+ (nonnull NSString *)parseClassName {
    return @"Post";
}

//method to make a post
+ (void) postUserOpp: ( UIImage * _Nullable )image withTitle:( NSString * _Nullable )title withDescripton:( NSString * _Nullable )description withHours:( NSString * _Nullable )hours withSpots:( NSNumber * _Nullable )spots withCompletion: (PFBooleanResultBlock  _Nullable)completion{
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.description = description;
    newPost.title = title;
    newPost.hours= hours;
    newPost.spotsLeft = spots;
    //(@"%@", Tags.animal);
    //NSLog(Tags.);
    
    [newPost saveInBackgroundWithBlock:completion]; 
}


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
