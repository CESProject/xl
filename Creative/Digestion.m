//
//  Digestion.m
//  Creative
//
//  Created by Mr Wei on 16/1/5.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "Digestion.h"
#import "moveModel.h"
#import "objlistModel.h"
#import "imageDicModel.h"
#import "NSObject+MJProperty.h"
#import "ProjectModel.h"

@implementation Digestion

+ (void)replacefmoveModelKey
{
    
    [moveModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"strCode":@"code"
                 };
    }];
}

+ (void)replacefobjlistModelKey
{
    
    [objlistModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"strID":@"id"
                 };
    }];
}

+ (void)replacefimageDicModelKey
{
    
    [imageDicModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"strID":@"id",
                 @"strSize":@"size",
                 @"strType":@"type",
                 @"strWidth":@"width"
                 };
    }];
}

+ (void)replaceProjectModelKey
{
    
    [ProjectModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"strID":@"id",
                 @"strMoney":@"initMoney",
                 @"strType":@"type",
                 @"strMoneyType":@"initMoneyType",
                 @"strDescription":@"description"
                 };
    }];
}

@end
