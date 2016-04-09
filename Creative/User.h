//
//  User.h
//  Creative
//
//  Created by huahongbo on 16/1/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>
@property(nonatomic,   copy) NSString *userId;
@property(nonatomic,   copy) NSString *loginName;
@property(nonatomic,   copy) NSString *imageDiyBgVo;

@property(nonatomic,   copy) NSString *userName;
@property(nonatomic,   copy) NSString *password;

@property (nonatomic , copy) NSString *address;
@property (nonatomic , copy) NSString *email;
@property (nonatomic , copy) NSString *gender;
@property (nonatomic , copy) NSString *personType; // 用户身份
@property (nonatomic , assign) double birthday;
@property (nonatomic , copy) NSString *qq;
@property (nonatomic , copy) NSString *weixin;
@property (nonatomic , copy) NSString *industry;//从事行业
@property (nonatomic , copy) NSString *speciality;//个人特长
@property (nonatomic , copy) NSString *oneSentenceDesc;//一句话介绍自己
@property (nonatomic , copy) NSString *individualResume;//个人简介
@property (nonatomic , copy) NSString *cityId;
@property (nonatomic , copy) NSString *cityName;
@property (nonatomic , copy) NSString *provinceId;
@property (nonatomic , copy) NSString *provinceName;

@end
