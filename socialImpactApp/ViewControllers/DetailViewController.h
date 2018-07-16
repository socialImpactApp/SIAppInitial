//
//  DetailViewController.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/15/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundPic;
@property (weak, nonatomic) IBOutlet UILabel *largeDescription;
@property (weak, nonatomic) IBOutlet UILabel *Location;
@property (weak, nonatomic) IBOutlet UILabel *contactInfo;
@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UILabel *spotsLeft;


@end
