//
//  AddTagViewController.h
//  socialImpactApp
//
//  Created by Roesha Nigos on 7/18/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AddTagViewControllerDelegate

-(void)didTapSaveFilter:(NSMutableArray <NSString *> *) tags;


@end

@interface AddTagViewController : UIViewController

@property (strong, nonatomic) id<AddTagViewControllerDelegate> delegate;
//@property (strong, nonatomic)  Post *post;

@end
