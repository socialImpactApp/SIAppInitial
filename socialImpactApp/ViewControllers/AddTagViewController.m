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


@interface AddTagViewController ()
@property (weak, nonatomic) IBOutlet UIButton *animalButton;
@property (weak, nonatomic) IBOutlet UIButton *childButton;
@property (weak, nonatomic) IBOutlet UIButton *constructionButton;
@property (weak, nonatomic) IBOutlet UIButton *educationButton;
@property (weak, nonatomic) IBOutlet UIButton *environmentalButton;
@property (weak, nonatomic) IBOutlet UIButton *foodButton;
@property (weak, nonatomic) IBOutlet UIButton *fundraisingButton;
@property (weak, nonatomic) IBOutlet UIButton *medicalButton;


@end

@implementation AddTagViewController {
    NSMutableArray<NSString *> *tagCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tagCollection = [[NSMutableArray alloc] init];
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
        sender.backgroundColor = UIColor.whiteColor;
    } else {
        [tagCollection addObject:tagType];
        sender.backgroundColor = UIColor.grayColor;
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