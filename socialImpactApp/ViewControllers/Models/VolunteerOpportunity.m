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
@dynamic date;
@dynamic location;
@dynamic tags;
@dynamic savedEventId;


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
                 withSpots:( NSString * _Nullable )spots
            withTags:(NSMutableArray <NSString * > *_Nullable)tags
          withSavedEventId:(NSString *_Nullable)savedEventId
            withDate:(NSString * _Nullable)date
            withLocation:(NSString * _Nullable)location
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
    newPost.location = location;
    newPost.savedEventId = savedEventId;
    
   //will use this to get a map view of the actual place later
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(!error){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"%f",placemark.location.coordinate.latitude);
            NSLog(@"%f",placemark.location.coordinate.longitude);
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    
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
