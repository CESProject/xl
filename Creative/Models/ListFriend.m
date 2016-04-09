//
//  ListFriend.m
//  CoreDataSample
//
//  Created by zgy on 16/1/8.
//  Copyright © 2016年 zgy. All rights reserved.
//

#import "ListFriend.h"

@implementation ListFriend
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"roadId": @"id",@"proDescription": @"description"
             };
}
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"attachmentList": @"Attachmen"
             };
}

@end
