//
//  SingletonCalendar.m
//  socialImpactApp
//
//  Created by Ezra Bekele on 8/7/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "SingletonCalendar.h"

@implementation SingletonCalendar

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

//- (void)setCalendar: (EKEventStore *)calendar {
//    self.sh
//    [SingletonCalendar sharedInstance] = calendar;
//}

@end
