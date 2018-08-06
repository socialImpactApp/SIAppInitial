//
//  FSCalendarScopeExampleViewController.h
//  socialImpactApp
//
//  Created by Ezra Bekele on 8/1/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface FSCalendarScopeExampleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *toggleCalendar;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (nonatomic, assign) BOOL *postedAll;
@property (nonatomic, retain) EKEventStore *store;


@end
