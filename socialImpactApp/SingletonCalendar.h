//
//  SingletonCalendar.h
//  socialImpactApp
//
//  Created by Ezra Bekele on 8/7/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface SingletonCalendar : NSObject

@property (nonatomic,strong) EKEventStore *sharedObject;

+(SingletonCalendar*) sharedInstance;

@end
