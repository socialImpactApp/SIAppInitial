//
//  CalendarSingleton.m
//  socialImpactApp
//
//  Created by Ezra Bekele on 8/8/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "CalendarSingleton.h"

@implementation CalendarSingleton

#pragma mark - singleton method

+ (EKEventStore*)sharedInstance
{
    static dispatch_once_t predicate = 0;
    static EKEventStore *sharedObject = nil;
    //static id sharedObject = nil;  //if you're not using ARC
    dispatch_once(&predicate, ^{
        sharedObject = [[EKEventStore alloc] init];
    });
    return sharedObject;
}

@end
