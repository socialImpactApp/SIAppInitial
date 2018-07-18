//
//  Constants.h
//  socialImpactApp
//
//  Created by Ezra Bekele on 7/18/18.
//  Copyright © 2018 teamMorgan. All rights reserved.
//

extern const struct CategoryTag
{
    __unsafe_unretained NSString *animalWelfare;
    __unsafe_unretained NSString *childrenAndYouth;
    __unsafe_unretained NSString *construction;
    __unsafe_unretained NSString *education;
    __unsafe_unretained NSString *environmental;
    __unsafe_unretained NSString *foodService;
    __unsafe_unretained NSString *fundraising;
    __unsafe_unretained NSString *medical;

} Tags;

const struct CategoryTag Tags =
{
    .animalWelfare = @"animalWelfare",
    .childrenAndYouth = @"childrenAndYouth",
    .construction = @"construction",
    .education = @"education",
    .environmental = @"environmental",
    .foodService = @"foodService",
    .fundraising = @"fundraising",
    .medical = @"medical",

};
