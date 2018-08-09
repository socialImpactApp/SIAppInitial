//
//  CalendarSingleton.h
//  socialImpactApp
//
//  Created by Ezra Bekele on 8/8/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <EventKit/EventKit.h>
#import <EventKit/EventKit.h>

@interface CalendarSingleton : EKEventStore

+(EKEventStore*) sharedInstance;

@end
