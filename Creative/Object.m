//
//  Object.m
//  Creative
//
//  Created by huahongbo on 16/1/11.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "Object.h"

@implementation Object
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"roadId": @"id",@"proDescription": @"description",@"cszijin":@"initMoney"
             };
}
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"rewardList": @"Reward",@"attachmentList":@"Attachment"
             };
}

@end
