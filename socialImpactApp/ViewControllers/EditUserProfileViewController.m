//
//  EditUserProfileViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/19/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "EditUserProfileViewController.h"
#import "Colours.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>



@interface EditUserProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *orgField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *contactField;

@property (weak, nonatomic) IBOutlet UIImageView *proImageView;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;



@end

@implementation EditUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.scrollView addSubview:self.contentView];
    User *user = [User currentUser];
    self.nameField.text = user[@"name"];
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.nameField.frame.size.height - 1, self.nameField.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    [self.nameField.layer addSublayer:bottomBorder];
    
    self.emailField.text = user[@"email"];
    self.emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    CALayer *bottomBorder1 = [CALayer layer];
    bottomBorder1.frame = CGRectMake(0.0f, self.emailField.frame.size.height - 1, self.emailField.frame.size.width, 1.0f);
    bottomBorder1.backgroundColor = [UIColor grayColor].CGColor;
    [self.emailField.layer addSublayer:bottomBorder1];
   
    self.usernameField.text = user[@"username"];
    self.usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.frame = CGRectMake(0.0f, self.usernameField.frame.size.height - 1, self.usernameField.frame.size.width, 1.0f);
    bottomBorder2.backgroundColor = [UIColor grayColor].CGColor;
    [self.usernameField.layer addSublayer:bottomBorder2];
    
    self.contactField.text = user[@"contactNumber"];
    self.contactField.clearButtonMode = UITextFieldViewModeWhileEditing;
    CALayer *bottomBorder3 = [CALayer layer];
    bottomBorder3.frame = CGRectMake(0.0f, self.contactField.frame.size.height - 1, self.contactField.frame.size.width, 1.0f);
    bottomBorder3.backgroundColor = [UIColor grayColor].CGColor;
    [self.contactField.layer addSublayer:bottomBorder3];
    
    self.orgField.text = user[@"organization"];
    self.orgField.clearButtonMode = UITextFieldViewModeWhileEditing;
    CALayer *bottomBorder4 = [CALayer layer];
    bottomBorder4.frame = CGRectMake(0.0f, self.orgField.frame.size.height - 1, self.orgField.frame.size.width, 1.0f);
    bottomBorder4.backgroundColor = [UIColor grayColor].CGColor;
    [self.orgField.layer addSublayer:bottomBorder4];
    
    self.proImageView.layer.cornerRadius= self.proImageView.frame.size.height/2;
    
    self.backView.backgroundColor = [UIColor snowColor];

    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapSaveUser:(id)sender {
    //do something here to pass the data back
    User *user = [User currentUser];
    [self.delegate didTapSaveUser:user];
    UIImage *image = self.proImageView.image;
    if (![image isEqual:[UIImage imageNamed:@"placeholder"]]) {
        user.profileImage = [User getPFFileFromImage:image];
        [user.profileImage saveInBackground];
    }
    if (![self.nameField.text isEqualToString:@""]){
    user.name = self.nameField.text;
    }
    if (![self.usernameField.text isEqualToString:@""]){
        user.username = self.usernameField.text;
    }
    if (![self.emailField.text isEqualToString:@""]){
        user.email = self.emailField.text;
    }
    if (![self.contactField.text isEqualToString:@""]){
        user.contactNumber = self.contactField.text;
    }
    if (![self.orgField.text isEqualToString:@""]){
        user.organization = self.orgField.text;
    }
 
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

//delegagte method for image taking
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
