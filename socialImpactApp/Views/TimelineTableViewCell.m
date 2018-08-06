//
//  TimelineTableViewCell.m
//  socialImpactApp
//
//  Created by Ezra Bekele on 8/3/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "TimelineTableViewCell.h"
#import "Parse/Parse.h"
#import <ParseUI/ParseUI.h>
#import "User.h"
#import "VolunteerOpportunity.h"
#import "FSCalendarScopeExampleViewController.h"
#import <EventKit/EventKit.h>

@implementation TimelineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)configureCell: (VolunteerOpportunity *) volunOpp {
    self.titleLabel.text = volunOpp[@"title"];
    self.titleText = volunOpp[@"title"];
    self.fullDateAndTime = volunOpp.date;
    NSString *justTimeOfOpp = [[self.fullDateAndTime substringToIndex:5] stringByAppendingString:[self.fullDateAndTime substringFromIndex:(self.fullDateAndTime).length-3]];
    self.timeLabel.text = justTimeOfOpp;
    self.hours = volunOpp.hours;
}

- (IBAction)didTapExport:(id)sender {
    
    if (self.posted == false)
    {
        self.posted = true;
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = self.titleText;
        self.fullDateAndTime = [self.fullDateAndTime stringByReplacingOccurrencesOfString:@"," withString:@" "];
        NSString *day = [self.fullDateAndTime componentsSeparatedByString:@" "][2];
        NSString *newDay = day;
        if ([[day substringToIndex:1] isEqualToString:@"0"])
        {
            newDay = [day substringFromIndex:1];
        }
        day = [[@" " stringByAppendingString:day] stringByAppendingString:@" "];
        NSString *spaceBeforeAfter = [[@" " stringByAppendingString:newDay] stringByAppendingString:@" "];
        newDay = spaceBeforeAfter;
        self.fullDateAndTime = [self.fullDateAndTime stringByReplacingOccurrencesOfString:day withString:newDay];
        
        
        //Date format
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
        [dateFormat setLocale:[NSLocale currentLocale]];
        //[dateFormat setDateFormat:@"MMMMdyhma"];
        [dateFormat setDateFormat:@"hh:mm MMMM dd y a"];
        [dateFormat setFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDate *newDate = [dateFormat dateFromString:self.fullDateAndTime];
        
        
        
        event.startDate = newDate; //today
        NSLog(@"%@", event.startDate);
        
        NSTimeInterval hoursInSeconds = [self.hours intValue] *60*60;
        event.endDate = [event.startDate dateByAddingTimeInterval:hoursInSeconds];
        //set 1 hour meeting
        event.calendar = [store defaultCalendarForNewEvents];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        //self.savedEventId = event.eventIdentifier;  //save the event id if you want to access this later
    }];
    }
}


@end
