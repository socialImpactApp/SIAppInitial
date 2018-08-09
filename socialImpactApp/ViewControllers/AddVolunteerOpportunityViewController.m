//
//  AddVolunteerOpportunityViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/16/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//


//THINGS TO DO HERE
// HAVE A SCROLL ONCE DESCRIPTION GETS TOUCHED
//HAVE THE HUD PROGRESS IMAGE SHOW UP
#import "AddVolunteerOpportunityViewController.h"
#import "AddTagViewController.h"
#import "VolunteerOpportunity.h"
#import "AddLocationViewController.h"
#import <UIKit/UIKit.h>
#import "Colours.h"


@interface AddVolunteerOpportunityViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, AddTagViewControllerDelegate, AddLocationViewControllerDelegate> 
@property (weak, nonatomic) IBOutlet UITextView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *hoursView;
@property (weak, nonatomic) IBOutlet UITextView *spotsView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UITextField *dateView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) AddTagViewController *tagViewController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *locationView;

@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;

@end

@implementation AddVolunteerOpportunityViewController {
    //this is where our tags of strings array is
    NSMutableArray<NSString *> *_collectionOfTags;
    NSMutableArray *tagArray;
    NSString *_volunteerLocation;
    NSString *_volunteerAddress;
    NSString *_city;
    NSString *_state;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view
    
    //we declare this in the segue view controller
    //self.tagViewController.delegate = self;
    
    [self.hoursView setKeyboardType:UIKeyboardTypeDecimalPad];
    [self.spotsView setKeyboardType:UIKeyboardTypeDecimalPad];
    
    //LOOK UP WHAT THIS MEANS
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [self.datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.dateView.inputView = self.datePicker;
    self.scrollView.backgroundColor = [UIColor snowColor];
    self.postImageView.layer.cornerRadius = self.postImageView.frame.size.height/2;
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.titleView.frame.size.height - 1, self.titleView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    [self.titleView.layer addSublayer:bottomBorder];
    
    
    CALayer *bottomBorder1 = [CALayer layer];
    bottomBorder1.frame = CGRectMake(0.0f, self.locationView.frame.size.height - 1, self.locationView.frame.size.width, 1.0f);
    bottomBorder1.backgroundColor = [UIColor grayColor].CGColor;
    [self.locationView.layer addSublayer:bottomBorder1];
    
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.frame = CGRectMake(0.0f, self.hoursView.frame.size.height - 1, self.hoursView.frame.size.width, 1.0f);
    bottomBorder2.backgroundColor = [UIColor grayColor].CGColor;
    [self.hoursView.layer addSublayer:bottomBorder2];
    
    CALayer *bottomBorder3 = [CALayer layer];
    bottomBorder3.frame = CGRectMake(0.0f, self.spotsView.frame.size.height - 1, self.spotsView.frame.size.width, 1.0f);
    bottomBorder3.backgroundColor = [UIColor grayColor].CGColor;
    [self.spotsView.layer addSublayer:bottomBorder3];
    
    CALayer *bottomBorder4 = [CALayer layer];
    bottomBorder4.frame = CGRectMake(0.0f, self.dateView.frame.size.height - 1, self.dateView.frame.size.width, 1.0f);
    bottomBorder4.backgroundColor = [UIColor grayColor].CGColor;
    [self.dateView.layer addSublayer:bottomBorder4];
    
    CALayer *bottomBorder5 = [CALayer layer];
    bottomBorder5.frame = CGRectMake(0.0f, self.descriptionView.frame.size.height - 1, self.descriptionView.frame.size.width, 1.0f);
    bottomBorder5.backgroundColor = [UIColor grayColor].CGColor;
    [self.descriptionView.layer addSublayer:bottomBorder5];
    
    self.navigationItem.title = @"Create a Vopp!";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"News Cycle" size:21]}];
    
}


- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm MMMM dd,yyyy";
    //self.dateView.text = [dateFormatter stringFromDate:[NSDate date]];
    self.dateView.text = [dateFormatter stringFromDate:datePicker.date];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    
}
- (IBAction)didTapAway:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)didTapImage:(id)sender {
    [self getImage];
}

-(void)didTapSaveFilter:(NSMutableArray<NSString *> *)tags {
    _collectionOfTags = [[NSMutableArray alloc] init ];
    tagArray = [[NSMutableArray alloc] init ];
    _collectionOfTags = [tags copy];
    for (NSString *tag in _collectionOfTags){
        if ([tag isEqualToString:@"animalWelfare"]){
            [tagArray addObject:@"Animal Welfare"];
        }
        else if ([tag isEqualToString:@"childrenAndYouth"]){
            [tagArray addObject:@"Children and Youth"];
        }
        else if ([tag isEqualToString:@"construction"]){
            [tagArray addObject:@"Construction"];
        }
        else if ([tag isEqualToString:@"education"]){
            [tagArray addObject:@"Education"];
        }
        else if ([tag isEqualToString:@"environmental"]){
            [tagArray addObject:@"Environmental"];
        }
        else if ([tag isEqualToString:@"foodService"]){
            [tagArray addObject:@"Food Service"];
        }
        else if ([tag isEqualToString:@"fundraising"]){
            [tagArray addObject:@"Fundraising"];
        }
        else if ([tag isEqualToString:@"medical"]){
            [tagArray addObject:@"Medical"];
        }
        
    }
     self.tagsLabel.text = [tagArray componentsJoinedByString:@", " ];
}

-(void)didTapAddLocation:(NSString *)locationName withAddress:(NSString *)addressName withCity:(NSString *)cityName withState:(NSString *)stateName{
    _volunteerLocation = locationName;
    _volunteerAddress = addressName;
    _city = cityName;
    _state = stateName;
    self.locationView.text = _volunteerLocation;
}

//spots is a NSNumber
- (IBAction)didTapPost:(id)sender {
    if(![self.postImageView.image isEqual:[UIImage imageNamed:@"placeholder"]] && ![self.titleView.text isEqualToString:@""]){
        [VolunteerOpportunity postUserOpp:self.postImageView.image
                withTitle:self.titleView.text
           withDescripton:self.descriptionView.text
                withHours:self.hoursView.text
                withSpots:self.spotsView.text  
            withTags:_collectionOfTags
        withDate:self.dateView.text
         withLocation:[NSString stringWithFormat:@"%@ %@" , _volunteerLocation, _volunteerAddress]
         withCityState:[NSString stringWithFormat:@"%@, %@", _city, _state]
           withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
               if(succeeded){
                   NSLog(@"%@", self->_collectionOfTags);
                   self.postImageView.image = [UIImage imageNamed:@"placeholder"];
                   self.titleView.text = @"";
                   self.hoursView.text = @"";
                   self.spotsView.text = @"";
                   self.descriptionView.text = @"";
                   self.locationView.text = @"";
                   NSLog(@"posted!!");
                   [self dismissViewControllerAnimated:YES completion:nil];
               }
               else {
                   NSLog(@"ERROR:@%", error.localizedDescription);
               }
           }];
    }
}

-(void)getImage{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    //setting the delegates and the data source
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    //ASK
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//implementing the delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Getting image captured by the PickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Do something with the images (based on your use case)
    //WHY CALL TO SELF ASK
    UIImage *newResizedImage = [self resizeImage:editedImage withSize:CGSizeMake(400.0, 400.0)];
    self.postImageView.image = newResizedImage;
    
    //Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     if ([segue.identifier isEqualToString:@"tagsSeg"]) {
         AddTagViewController *tagViewController =
         segue.destinationViewController;
         tagViewController.delegate = self;
     }
     else if ([segue.identifier isEqualToString:@"locationSeg"]){
         AddLocationViewController *locationViewController = segue.destinationViewController;
         locationViewController.delegate = self;
     }
 }


@end
