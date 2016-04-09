//
//  UserInfo.h
//  Creative
//
//  Created by huahongbo on 16/1/11.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property(nonatomic,   copy) NSString *academicTitle;
@property(nonatomic,   copy) NSString *birthday;
@property(nonatomic,   copy) NSString *birthdayFormat;
@property(nonatomic,   copy) NSString *createDate;
@property(nonatomic,   copy) NSString *email;
@property(nonatomic,   copy) NSString *userId;
@property(nonatomic,   copy) NSString *imageUrl;
@property(nonatomic,   copy) NSString *individualResume;
@property(nonatomic,   copy) NSString *cityName;
@property(nonatomic,   copy) NSString *commentNum;
@property(nonatomic,   copy) NSString *intimatePhone;
@property(nonatomic, assign) BOOL  gender;
@property(nonatomic, assign) BOOL  isLock;
@property(nonatomic, assign) int  age;
@property(nonatomic, assign) int  allowLoginFromMobile;
@property(nonatomic, assign) int  attentionAmount;
@property(nonatomic, assign) int  cityId;
@property(nonatomic, assign) int  delFlg;
@property(nonatomic, assign) int  imageCount;
@property(nonatomic, assign) int  imageId;
@property(nonatomic, assign) int  industry;
@property(nonatomic, assign) int  integral;
@property(nonatomic, assign) int  level;
@property(nonatomic,   copy) NSString *loginName;
@property(nonatomic,   copy) NSString *oneSentenceDesc;
@property(nonatomic, assign) int  orgId;
@property(nonatomic,   copy) NSString *orgName;
@property(nonatomic, assign) int  personType;
@property(nonatomic, assign) int  phoneNumber;
@property(nonatomic, assign) int  provinceId;
@property(nonatomic, assign) int  qq;
@property(nonatomic, assign) int  receiveMessage;
@property(nonatomic, assign) int  secId;
@property(nonatomic,   copy) NSString *speciality;
@property(nonatomic, assign) int  streamCount;
@property(nonatomic, assign) double  updateDate;
@property(nonatomic, assign) int  viewPhone;
@property(nonatomic, assign) NSString *userName;
@property(nonatomic,   copy) NSString *userImgUrl;
@property(nonatomic,   copy) NSString *roadId;

@end
