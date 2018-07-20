//
//  userSession.h
//  socialImpactApp
//
//  Created by Ezra Bekele on 7/19/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "User.h"

@interface UserSession : NSObject

+ (User *)loggedInUser;

+ (void)setLoggedInUser: (User *)user;

@end
