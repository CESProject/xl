//
//  ProjectModel.m
//  Creative
//
//  Created by Mr Wei on 16/1/8.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "ProjectModel.h"

@implementation ProjectModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"ProjectModel.h *** value : %@ --> key : %@",value,key);
}

@end
