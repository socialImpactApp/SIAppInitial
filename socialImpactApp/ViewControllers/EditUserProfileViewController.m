//
//  EditUserProfileViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/19/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "EditUserProfileViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>



@interface EditUserProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *usernameLabel;
@property (weak, nonatomic) IBOutlet UITextView *emailLabel;
@property (weak, nonatomic) IBOutlet UITextView *contactLabel;
//@property (weak, nonatomic) IBOutlet PFImageView *proImageView;
@property (weak, nonatomic) IBOutlet UIImageView *proImageView;


@end

@implementation EditUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapSaveUser:(id)sender {
    //do something here to pass the data back
    User *user = [User currentUser];
    UIImage *image = self.proImageView.image;
    if (image) {
        user.profileImage = [User getPFFileFromImage:image];
    }
    [self.delegate didTapSaveUser:user]; 
    user.name = self.nameLabel.text;
    user.username = self.usernameLabel.text;
    user.email = self.emailLabel.text;
    user.contactNumber = self.contactLabel.text;
    [user saveInBackground];
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)didTapImage:(id)sender {
    [self getImage];
}
- (IBAction)didTapAway:(id)sender {
    [self.view endEditing:YES];   
}

-(void) getImage {
    //set up image picker, and read from photolibrary
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //present
    [self presentViewController:imagePicker animated:YES completion:nil];
}

//delegagte method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    UIImage *newResizedImage = [self resizeImage:originalImage withSize:CGSizeMake(400, 400)];
    
    //set image
    self.proImageView.image = newResizedImage;
    
    //dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
