//
//  MyUser.m
//  Creative
//
//  Created by huahongbo on 16/1/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import "MyUser.h"
#import "User.h"
@implementation MyUser
+ (User*)currentUser
{
    User *loginM = [HMFileManager getObjectByFileName:@"User"];
    return loginM;
}
+ (NSString*)userId
{
    return [[self currentUser] userId];
}
+ (NSString*)userLoginName
{
    return [[self currentUser] loginName];
}
+ (NSString*)userimageDiyBgVo
{
    return [[self currentUser] imageDiyBgVo];
}
+ (NSString*)userName
{
    return [[self currentUser] userName];
}
+ (NSString*)password
{
    return [[self currentUser] password];
}
@end
