//
//  MoneyContent.m
//  Creative
//
//  Created by huahongbo on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "MoneyContent.h"

@implementation MoneyContent
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"zijinID": @"id"
             };
}
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"needDataList": @"NeedDataList",@"investmentTradeList": @"InvestmentTradeList"
             };
}
@end
