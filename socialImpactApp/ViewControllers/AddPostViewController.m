//
//  AddPostViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/16/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//


//THINGS TO DO HERE
// HAVE A SCROLL ONCE DESCRIPTION GETS TOUCHED
//HAVE THE HUD PROGRESS IMAGE SHOW UP
#import "AddPostViewController.h"
#import "AddTagViewController.h"
#import "Post.h"
#import <UIKit/UIKit.h>


@interface AddPostViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, AddTagViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *hoursView;
@property (weak, nonatomic) IBOutlet UITextView *spotsView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UITextView *dateView;
@property (weak, nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) AddTagViewController *tagViewController;


@end

@implementation AddPostViewController {
    //this is where our tags of strings array is
    NSArray<NSString *> *_collectionOfTags;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view.
    
    //LOOK UP WHAT THIS MEANS
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.tagViewController.delegate = self;
    
}

-(void)showSelectedDate {
    self.dateView.text = [NSString stringWithFormat:@"%@",self.datePicker.date];
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

//spots is a NSNumber
- (IBAction)didTapPost:(id)sender {
    if(![self.postImageView.image isEqual:[UIImage imageNamed:@"placeholder"]] && ![self.titleView.text isEqualToString:@""]){
        [Post postUserOpp:self.postImageView.image
                withTitle:self.titleView.text
           withDescripton:self.descriptionView.text
                withHours:self.hoursView.text
                withSpots:self.spotsView.text
                 //withTags:_collectionOfTags
           withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
               if(succeeded){
                   self.postImageView.image = [UIImage imageNamed:@"placeholder"];
                   self.titleView.text = @"";
                   self.hoursView.text = @"";
                   self.spotsView.text = @"";
                   self.descriptionView.text = @"";
                   NSLog(@"posted!!");
                   [self dismissViewControllerAnimated:YES completion:nil];
               }
               else {
                   NSLog(@"ERROR: @%" , error.localizedDescription);
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

-(void)didTapSaveFilter:(NSArray<NSString *> *)tags {
    _collectionOfTags = [tags copy];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
