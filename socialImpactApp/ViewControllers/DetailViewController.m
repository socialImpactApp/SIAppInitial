//
//  DetailViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/15/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "DetailViewController.h"
#import "VolunteerOpportunity.h"
#import "VolunteerOpportunityCell.h"
#import "DetailTableViewCell.h"
#import "User.h"
#import <EventKit/EventKit.h>
#import "ShowLocationViewController.h"
#import "Colours.h"

@interface DetailViewController () < UITableViewDataSource, UITableViewDelegate, FBSDKSharingDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@end

@implementation DetailViewController{
    NSMutableArray *tagArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.view.backgroundColor = [UIColor snowColor];
  self.backgroundVoppView.layer.zPosition = -1;
    //[self configureCell:self.post];
//    self.signButton.layer.cornerRadius = 10.0;
//    self.signButton.layer.borderWidth = 0.7f;
//    self.signButton.layer.borderColor =[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
    PFObject *postAuthor = self.post[@"author"];
    self.backgroundVoppView.file = self.post[@"image"];
    //loadinbackground
    [self.backgroundVoppView loadInBackground];
    self.orgLabel.text = postAuthor[@"organization"];
    self.orgLabel.layer.shadowRadius = 2.0;
    self.orgLabel.layer.masksToBounds = NO;
    self.orgLabel.layer.shadowColor = [[UIColor coolGrayColor] CGColor];
    self.orgLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.orgLabel.layer.shadowOpacity = 0.5;
    self.orgImageView.layer.cornerRadius = self.orgImageView.frame.size.height/2;
    self.orgImageView.file = postAuthor[@"profileImage"];
    CGFloat borderWidth = 2.0f;
    self.orgImageView.frame = CGRectInset(self.orgImageView. frame, -borderWidth, -borderWidth);
    self.orgImageView. layer.borderColor = [[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
    self.orgImageView. layer.borderWidth = borderWidth;
    self.heartButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    self.heartButton.layer.cornerRadius = self.heartButton.frame.size.height/2;


    //[self configureCell:self.post];
    
    self.loggedInUser = [User currentUser];
    UIFont * customFont = [UIFont fontWithName:@"NewsCycle" size:12]; //custom font
    NSString * text = [self description];
    
    CGSize labelSize = [text sizeWithFont:customFont constrainedToSize:CGSizeMake(380, 20) lineBreakMode:NSLineBreakByTruncatingTail];
    
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, labelSize.width, labelSize.height)];
    fromLabel.text = text;
    fromLabel.font = customFont;
    fromLabel.numberOfLines = 1;
    fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    fromLabel.adjustsFontSizeToFitWidth = YES;
    fromLabel.adjustsLetterSpacingToFitWidth = YES;
    fromLabel.minimumScaleFactor = 10.0f/12.0f;
    fromLabel.clipsToBounds = YES;
    fromLabel.backgroundColor = [UIColor clearColor];
    fromLabel.textColor = [UIColor blackColor];
    fromLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:fromLabel];
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapSignUp:(id)sender {
    if (self.loggedInUser.timelineOpps == NULL) {
        self.loggedInUser.timelineOpps = [[NSMutableArray alloc] init];
    }
    [self.loggedInUser.timelineOpps addObject:self.post.objectId];
    self.loggedInUser[@"timelineOpps"] = self.loggedInUser.timelineOpps;
    [self.loggedInUser saveInBackground];
}

-(BOOL)checkForCalendar:(NSString *)eventName{
    //get an array of the user's calendar using your instance of the eventStore
    NSArray *calendarArray = [[CalendarSingleton sharedInstance] calendarsForEntityType:EKEntityTypeEvent];
    
    // The name of the calendar to check for. You can also save the calendarIdentifier and check for that if you want
    NSString *calNameToCheckFor = eventName;
    NSDate* endDate =  [NSDate dateWithTimeIntervalSinceNow:[[NSDate distantFuture] timeIntervalSinceReferenceDate]];

    EKCalendar *cal;
    
    for (int x = 0; x < [calendarArray count]; x++) {
        
        cal = [calendarArray objectAtIndex:x];
        NSArray *calArray = [NSArray arrayWithObject:cal];
        NSPredicate *fetchCalendarEvents = [[CalendarSingleton sharedInstance] predicateForEventsWithStartDate:[NSDate date] endDate:endDate calendars:calArray];
        NSArray *eventList = [[CalendarSingleton sharedInstance] eventsMatchingPredicate:fetchCalendarEvents];
        for(int i=0; i < eventList.count; i++){
            NSLog(@"Event Title:%@", [[eventList objectAtIndex:i] title]);
            NSString *caltitle =[[eventList objectAtIndex:i] title];
            if ([caltitle isEqualToString:calNameToCheckFor]) {
                            return YES;
                }
            }
        
        
//        NSString *calTitle = [cal title];
//        
//        // if the calendar is found, return YES
//        if ([calTitle isEqualToString:calNameToCheckFor]) {
//            
//            return YES;
//            
//        }
    }
    // Calendar name was not found, return NO;
    return NO;
    
    
}

- (IBAction)didTapExport:(id)sender {
    if ([self checkForCalendar:self.post.title] == NO)
    {
        self.exportButton.selected = YES;
    [[CalendarSingleton sharedInstance] requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:[CalendarSingleton sharedInstance]];
        
        // date formatting
        self.fullDateAndTime = self.post.date;
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
        
        
        
        // Convert date object to desired output format
        
        event.title = self.post.title;
        event.startDate = newDate; //today
        NSLog(@"%@", event.startDate);
        NSTimeInterval hoursInSeconds = [self.post.hours intValue]*60*60;
        event.endDate = [event.startDate dateByAddingTimeInterval:hoursInSeconds];
        event.calendar = [[CalendarSingleton sharedInstance] defaultCalendarForNewEvents];
        NSError *err = nil;
        [[CalendarSingleton sharedInstance] saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        self.post.savedEventId = event.eventIdentifier;  //save the event id if you want to access this later
        [self.post saveInBackground];
    }];
    }
    else{
        self.exportButton.selected = NO;
        
        [[CalendarSingleton sharedInstance] requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (!granted) { return; }
            EKEvent* eventToRemove = [[CalendarSingleton sharedInstance] eventWithIdentifier:self.post.savedEventId];
            if (eventToRemove) {
                NSError* error = nil;
                [[CalendarSingleton sharedInstance] removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
            }
        }];
    }
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/100001137325839"]
                                       options:@{}
     
     
     
                             completionHandler:nil];
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapFavorite:(id)sender {
    
}

- (IBAction)didTapShare:(id)sender {
    NSLog(@"WE ARE SHARING");
    //FBSDKShareLinkContent *linkContent = [FBSDKShareLinkContent new];
    FBSDKShareLinkContent *linkContent = [[FBSDKShareLinkContent alloc] init];
    linkContent.contentURL = [NSURL URLWithString:@"https://vopp.herokuapp.com/"];
    //linkContent.quote = @"hi i am the description ;)";
    FBSDKShareDialog *shareDialog = [FBSDKShareDialog new];
    shareDialog.shareContent = linkContent;
    [FBSDKShareDialog showFromViewController:self withContent:linkContent delegate:self];
    
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailTableViewCell *postCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"];
    //setting each button to have a tag
    [postCell configureCell:self.post];
    return postCell;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showLocSeg"]) {
        ShowLocationViewController *showLocViewController =
        segue.destinationViewController;
        showLocViewController.post = self.post;
    }
}


@end
