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
#import <UIKit/UIKit.h>


@interface AddVolunteerOpportunityViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, AddTagViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *hoursView;
@property (weak, nonatomic) IBOutlet UITextView *spotsView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UITextField *dateView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) AddTagViewController *tagViewController;


@end

@implementation AddVolunteerOpportunityViewController {
    //this is where our tags of strings array is
    NSMutableArray<NSString *> *_collectionOfTags;
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
    _collectionOfTags = [tags copy];
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
           withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
               if(succeeded){
                   NSLog(@"%@", self->_collectionOfTags);
                   self.postImageView.image = [UIImage imageNamed:@"placeholder"];
                   self.titleView.text = @"";
                   self.hoursView.text = @"";
                   self.spotsView.text = @"";
                   self.descriptionView.text = @"";
                   NSLog(@"posted!!");
                   [self dismissViewControllerAnimated:YES completion:nil];
               }
               else {
                   NSLog(@"ERROR:@%" , error.localizedDescription);
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
    //UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
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
 }


@end
