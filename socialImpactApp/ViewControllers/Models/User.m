//
//  User.m
//  socialImpactApp
//
//  Created by Ezra Bekele on 7/17/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "User.h"
#import <ParseUI/ParseUI.h>

@implementation User
@dynamic profileImage;

//@dynamic favoritedOpps;

@dynamic contactNumber;
@dynamic name; 
@dynamic username;
@dynamic oppsDone;
@dynamic email;
@dynamic store;


//if plus cant do self plus is only class
+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
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


//+ (PFFile *)getPFFileFromPFImage: (PFImageView * _Nullable)image{
//    NSData *imageData = UIImagePNGRepresentation(image);
//    return [PFFile fileWithName:@"image.png" data:imageData];
//    
//}
 

@end
