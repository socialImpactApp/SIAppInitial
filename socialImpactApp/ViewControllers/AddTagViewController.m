//
//  AddTagViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/18/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "AddTagViewController.h"
#import "Constants.h"
#import "VolunteerOpportunity.h"
#import "Colours.h"


@interface AddTagViewController ()
@property (weak, nonatomic) IBOutlet UIButton *animalButton;
@property (weak, nonatomic) IBOutlet UIButton *childButton;
@property (weak, nonatomic) IBOutlet UIButton *constructionButton;
@property (weak, nonatomic) IBOutlet UIButton *educationButton;
@property (weak, nonatomic) IBOutlet UIButton *environmentalButton;
@property (weak, nonatomic) IBOutlet UIButton *foodButton;
@property (weak, nonatomic) IBOutlet UIButton *fundraisingButton;
@property (weak, nonatomic) IBOutlet UIButton *medicalButton;
@property (strong, nonatomic) IBOutlet UIView *backView;

@end

@implementation AddTagViewController {
    NSMutableArray<NSString *> *tagCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tagCollection = [[NSMutableArray alloc] init];
     self.backView.backgroundColor = [UIColor snowColor];
    self.animalButton.layer.cornerRadius = 10.0;
    self.animalButton.layer.borderWidth = 0.7f;
    self.animalButton.layer.borderColor =[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
    
    self.childButton.layer.cornerRadius = 10.0;
    self.childButton.layer.borderWidth = 0.7f;
    self.childButton.layer.borderColor =[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
    
    self.constructionButton.layer.cornerRadius = 10.0;
    self.constructionButton.layer.borderWidth = 0.7f;
    self.constructionButton.layer.borderColor =[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
    
    self.educationButton.layer.cornerRadius = 10.0;
    self.educationButton.layer.borderWidth = 0.7f;
    self.educationButton.layer.borderColor =[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
    
    self.environmentalButton.layer.cornerRadius = 10.0;
    self.environmentalButton.layer.borderWidth = 0.7f;
    self.environmentalButton.layer.borderColor =[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
    
    self.foodButton.layer.cornerRadius = 10.0;
    self.foodButton.layer.borderWidth = 0.7f;
    self.foodButton.layer.borderColor =[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
    
    self.fundraisingButton.layer.cornerRadius = 10.0;
    self.fundraisingButton.layer.borderWidth = 0.7f;
    self.fundraisingButton.layer.borderColor =[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
    
    self.medicalButton.layer.cornerRadius = 10.0;
    self.medicalButton.layer.borderWidth = 0.7f;
    self.medicalButton.layer.borderColor =[[UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapTag:(UIButton *)sender
{
    
    switch(sender.tag) {
        case 0:
            [self _triggerCollectionStateChange:Tags.animalWelfare
                                         sender:sender];
            break;
        case 1:
            [self _triggerCollectionStateChange:Tags.childrenAndYouth
                                         sender:sender];
            break;
        case 2:
            [self _triggerCollectionStateChange:Tags.construction
                                         sender:sender];
            break;
        case 3:
            [self _triggerCollectionStateChange:Tags.education
                                         sender:sender];
            break;
        case 4:
            [self _triggerCollectionStateChange:Tags.environmental
                                         sender:sender];
            break;
        case 5:
            [self _triggerCollectionStateChange:Tags.foodService
                                         sender:sender];
            break;
        case 6:
            [self _triggerCollectionStateChange:Tags.fundraising
                                         sender:sender];
            break;
        case 7:
            [self _triggerCollectionStateChange:Tags.medical
                                         sender:sender];
            break;
    }
}

- (void)_triggerCollectionStateChange:(NSString *)tagType
                               sender:(UIButton *)sender {
    NSLog(@"%@", tagType);
    if ([tagCollection containsObject:tagType]) {
        [tagCollection removeObject:tagType];
        sender.backgroundColor = [UIColor clearColor];
        sender.selected = NO;
    } else {
        [tagCollection addObject:tagType];
        sender.selected = YES;
        sender.backgroundColor = [UIColor colorWithRed:3/255.0 green:121/255.0 blue:113/255.0 alpha:0.7];
       
    }
}

- (IBAction)didTapSaveFilter:(id)sender {
    [self.delegate didTapSaveFilter:tagCollection];
    [self dismissViewControllerAnimated:YES completion:nil];
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
