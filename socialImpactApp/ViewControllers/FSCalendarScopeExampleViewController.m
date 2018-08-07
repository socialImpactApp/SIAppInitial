//
//  FSCalendarScopeExampleViewController.m
//  socialImpactApp
//
//  Created by Ezra Bekele on 8/1/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "FSCalendarScopeExampleViewController.h"
#import "FSCalendar.h"
#import "TimelineViewController.h"
#import "VolunteerOpportunityCell.h"
#import "User.h"
#import "VolunteerOpportunity.h"
#import "AppDelegate.h"
#import "Colours.h"
#import "DetailViewController.h"
#import "TimelineTableViewCell.h"
#import <EventKit/EventKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSCalendarScopeExampleViewController()<UITableViewDataSource,UITableViewDelegate,FSCalendarDataSource,FSCalendarDelegate,UIGestureRecognizerDelegate>
{
    void * _KVOContext;
}

@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *volunteerOpportunities;
@property (strong, nonatomic) NSMutableArray *filteredVolunteerOpportunities;
@property (strong, nonatomic) NSMutableArray *selectedDateOpps;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;

- (IBAction)toggleClicked:(id)sender;

@end

NS_ASSUME_NONNULL_END

@implementation FSCalendarScopeExampleViewController {
    NSMutableArray *postsOne;

}

#pragma mark - Life cycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy/MM/dd";
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loggedInUser = [User currentUser];

    
    if ([[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        self.calendarHeightConstraint.constant = 400;
    }
    
    [self.calendar selectDate:[NSDate date] scrollToDate:YES];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.calendar action:@selector(handleScopeGesture:)];
    panGesture.delegate = self;
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:panGesture];
    self.scopeGesture = panGesture;
    
    // While the scope gesture begin, the pan gesture of tableView should cancel.
    [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:panGesture];
    
    [self.calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
    
    self.calendar.scope = FSCalendarScopeWeek;
    
    // For UITest
    self.calendar.accessibilityIdentifier = @"calendar";
    
    postsOne = [[NSMutableArray alloc]  init];
    [self.tableView reloadData];
    if (self.volunteerOpportunities == NULL)
    {
        self.volunteerOpportunities = [[NSMutableArray alloc] init];
    }
    [self fetch];
}

-(void)fetch {
    User *currentUser = [User currentUser];
    //    postsOne = [[NSMutableArray alloc] init];
    //    self->postsOne = self.volunteerOpportunities;
    
    PFQuery *query = [VolunteerOpportunity query];
    
    //in the future we will filter the data
    [query orderByAscending:@"createdAt"];
    [query includeKey:@"author"];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.volunteerOpportunities = [posts mutableCopy];
            //            self->postsOne = posts;
            
            User *loggedInUser = [User currentUser];
            NSArray *timelinePostIDs = loggedInUser.timelineOpps;
            
            if (self.filteredVolunteerOpportunities == NULL) {
                self.filteredVolunteerOpportunities = [[NSMutableArray alloc] init];
            }
            
            for (VolunteerOpportunity *vol in self.volunteerOpportunities){
                if ([timelinePostIDs containsObject:vol.objectId])
                {
                    [self.filteredVolunteerOpportunities addObject:vol];
                }
            }
            [self.tableView reloadData];
            
        } else {
            NSLog(@"error in fetch timeline");
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    //[self.refreshControl endRefreshing];
}

- (void)dealloc
{
    [self.calendar removeObserver:self forKeyPath:@"scope" context:_KVOContext];
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == _KVOContext) {
        FSCalendarScope oldScope = [change[NSKeyValueChangeOldKey] unsignedIntegerValue];
        FSCalendarScope newScope = [change[NSKeyValueChangeNewKey] unsignedIntegerValue];
        NSLog(@"From %@ to %@",(oldScope==FSCalendarScopeWeek?@"week":@"month"),(newScope==FSCalendarScopeWeek?@"week":@"month"));
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - <UIGestureRecognizerDelegate>

// Whether scope gesture should begin
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top;
    if (shouldBegin) {
        CGPoint velocity = [self.scopeGesture velocityInView:self.view];
        switch (self.calendar.scope) {
            case FSCalendarScopeMonth:
                self.toggleCalendar.selected = YES;
                return velocity.y < 0;
            case FSCalendarScopeWeek:
                self.toggleCalendar.selected = NO;
                return velocity.y > 0;
        }
    }
    return shouldBegin;
}

#pragma mark - <FSCalendarDelegate>

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    //    NSLog(@"%@",(calendar.scope==FSCalendarScopeWeek?@"week":@"month"));
    _calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    NSDate *newDate = date;
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);

    
    // old date
    
    NSLog(@"DATE STRING");
    NSLog(@"%@", dateString);
    
    if (self.selectedDateOpps == NULL)
    {
        self.selectedDateOpps = [[NSMutableArray alloc] init];
    }
    [self.selectedDateOpps removeAllObjects];
    
    for (VolunteerOpportunity *opp in self.filteredVolunteerOpportunities)
    {
        NSString *selectedDate = opp.date;
        NSString *NoAMPM = [selectedDate substringToIndex:(selectedDate.length-3)];
        NSString *justDateOfOpp = [NoAMPM substringFromIndex:6];

        NSLog(@"%@", dateString);
        dateString = [dateString stringByReplacingOccurrencesOfString:@", " withString:@","];
        NSLog(@"%@", dateString);

        justDateOfOpp = [justDateOfOpp stringByReplacingOccurrencesOfString:@" 0" withString:@" "];
        
//        int nLength = [dateString length];
//        int numbercount = 0;
//        for (int number = 0; number < nLength; number++){
//            unichar c = [dateString characterAtIndex:number];
//            if (c >= '0'  &&  c <= '9'){
//                if (c >= '0'  &&  c <= '9')
//                {
//                    numbercount++;
//                }
//            }
//        }
//        if (numbercount==1){
//            
//            NSString *original = @" ";
//            NSString *replacement = @" 0";
//            
//            NSRange rOriginal = [dateString rangeOfString:original];
//            
//            if (NSNotFound != rOriginal.location) {
//                dateString = [dateString stringByReplacingCharactersInRange:rOriginal withString:replacement];
//            }
//        }
        
        NSLog(@"before if statement");
        if ([dateString isEqualToString:justDateOfOpp])
        {
            [self.selectedDateOpps addObject:opp];
        }
    }
    
    
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[self.dateFormatter stringFromDate:obj]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
    [self.tableView reloadData];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numbers = self.selectedDateOpps.count;
    return numbers;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        NSString *identifier = @[@"cell_month",@"cell_week"][indexPath.row];
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//
//        return cell;
//    } else
    
        TimelineTableViewCell *postCell = [tableView dequeueReusableCellWithIdentifier:@"timelineCell"];
        
        VolunteerOpportunity *post = self.selectedDateOpps[indexPath.row];
        [postCell configureCell:post];

        return postCell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section == 0) {
//        FSCalendarScope selectedScope = indexPath.row == 0 ? FSCalendarScopeMonth : FSCalendarScopeWeek;
//        [self.calendar setScope:selectedScope animated:self.animationSwitch.on];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

#pragma mark - Target actions

- (IBAction)toggleClicked:(id)sender
{
    if (self.calendar.scope == FSCalendarScopeMonth) {
        [self.calendar setScope:FSCalendarScopeWeek];
        self.toggleCalendar.selected = YES;
    } else {
        [self.calendar setScope:FSCalendarScopeMonth];
        self.toggleCalendar.selected = NO;
    }
}

-(BOOL)checkForCalendar:(NSString *)eventName{
    //get an array of the user's calendar using your instance of the eventStore
    NSArray *calendarArray = [self.loggedInUser.store calendarsForEntityType:EKEntityTypeEvent];
    
    // The name of the calendar to check for. You can also save the calendarIdentifier and check for that if you want
    NSString *calNameToCheckFor = eventName;
    
    EKCalendar *cal;
    
    for (int x = 0; x < [calendarArray count]; x++) {
        
        cal = [calendarArray objectAtIndex:x];
        NSString *calTitle = [cal title];
        
        // if the calendar is found, return YES
        if ([calTitle isEqualToString:calNameToCheckFor]) {
            
            return YES;
        
            }
    }
            // Calendar name was not found, return NO;
            return NO;
    

}

- (IBAction)didTapExportAll:(id)sender {
    if (self.exportAllButton.selected == NO)
    {
        self.exportAllButton.selected = YES;
    }
    else
    {
        self.exportAllButton.selected = NO;
    }
    for (VolunteerOpportunity *vol in self.filteredVolunteerOpportunities)
        {
            if ([self checkForCalendar:vol.title] == NO)
            {
                self.exportAllButton.selected = NO;
                [self.loggedInUser.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                    if (!granted) { return; }
                    EKEvent *event = [EKEvent eventWithEventStore:self.loggedInUser.store];
                    event.title = vol.title;
                    NSString *fullDateAndTime = vol.date;
                    fullDateAndTime = [fullDateAndTime stringByReplacingOccurrencesOfString:@"," withString:@" "];
                    NSString *day = [fullDateAndTime componentsSeparatedByString:@" "][2];
                    NSString *newDay = day;
                    if ([[day substringToIndex:1] isEqualToString:@"0"])
                    {
                        newDay = [day substringFromIndex:1];
                    }
                    day = [[@" " stringByAppendingString:day] stringByAppendingString:@" "];
                    NSString *spaceBeforeAfter = [[@" " stringByAppendingString:newDay] stringByAppendingString:@" "];
                    newDay = spaceBeforeAfter;
                    fullDateAndTime = [fullDateAndTime stringByReplacingOccurrencesOfString:day withString:newDay];
                
                
                    //Date format
                    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormat setLocale:[NSLocale currentLocale]];
                    //[dateFormat setDateFormat:@"MMMMdyhma"];
                    [dateFormat setDateFormat:@"hh:mm MMMM dd y a"];
                    [dateFormat setFormatterBehavior:NSDateFormatterBehaviorDefault];
                    NSDate *newDate = [dateFormat dateFromString:fullDateAndTime];
                
                
                
                    event.startDate = newDate; //today
                    NSLog(@"%@", event.startDate);
                
                    NSTimeInterval hoursInSeconds = [vol.hours intValue] *60*60;
                    event.endDate = [event.startDate dateByAddingTimeInterval:hoursInSeconds];
                    event.calendar = [self.loggedInUser.store defaultCalendarForNewEvents];
                    NSError *err = nil;
                    [self.loggedInUser.store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
                    //self.savedEventId = event.eventIdentifier;  //save the event id if you want to access this later
                }];
        }
    }


}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    VolunteerOpportunity *post = self.selectedDateOpps[indexPath.row];

    if ([segue.identifier isEqualToString:@"timelineDetailsSegue"])
    {
        DetailViewController *detailedController = [segue destinationViewController];
        detailedController.post = post;
        NSLog(@"checking detailedPost");
    }
}

@end
