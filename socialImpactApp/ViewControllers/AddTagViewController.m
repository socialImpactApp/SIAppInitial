//
//  AddTagViewController.m
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/18/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import "AddTagViewController.h"
#import "Post.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapAnimal:(id)sender {
    
    //    if(self.post.didTapAnimal) {
    //        self.animalButton.selected = NO;
    //        self.post.didTapAnimal = NO;
    //        [self.post saveInBackground];
    //
    //    }
    //    else {
    //        self.animalButton.selected = YES;
    //        self.post.didTapAnimal = YES;
    //        [self.post saveInBackground];
    //
    //    }
    
}

- (IBAction)didTapTag:(UIButton *)sender
{
    switch(sender.tag) {
        case 0:
            [self _triggerCollectionStateChange:@"Animal Welfare"
                                         sender:sender];
            
    }
    
}

- (void)_triggerCollectionStateChange:(NSString *)tagType
                               sender:(UIButton *)sender {
    if ([tagCollection containsObject:tagType]) {
        [tagCollection removeObject:tagType];
        sender.backgroundColor = UIColor.whiteColor;
    } else {
        [tagCollection addObject:tagType];
        sender.backgroundColor = UIColor.redColor;
    }
}



- (IBAction)didTapSaveFilter:(id)sender {
    [self.delegate didTapSaveFilter:self.post];
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
