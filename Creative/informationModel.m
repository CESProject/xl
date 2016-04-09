//
//  informationModel.m
//  addcellTest
//
//  Created by Mr Wei on 16/1/25.
//  Copyright © 2016年 Mr Wei. All rights reserved.
//

#import "informationModel.h"

@implementation informationModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"strID": @"id"
             };
}

- (void)setStrID:(NSString *)strID
{
    if (_strID != strID) {
        _strID = strID;
    }
    
}

@end
