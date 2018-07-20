//
//  userSession.m
//  socialImpactApp
//
//  Created by Ezra Bekele on 7/19/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserSession.h"

@implementation UserSession

static User *loggedInUser;

+ (User *)loggedInUser {
    return loggedInUser;
}

+ (void)setLoggedInUser:(User *)user {
    loggedInUser = user;
}

@end
