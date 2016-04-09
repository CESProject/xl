//
//  ModelImage.m
//  CoreDataSample
//
//  Created by zgy on 16/1/8.
//  Copyright © 2016年 zgy. All rights reserved.
//

#import "ModelImage.h"

@implementation ModelImage
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"imageID": @"id"
             };
}
@end
