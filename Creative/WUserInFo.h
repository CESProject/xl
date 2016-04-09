//
//  WUserInFo.h
//  Creative
//
//  Created by huahongbo on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WUserInFo : NSObject
@property(nonatomic,   copy) NSString *infoId;
@property(nonatomic,   copy) NSString *pageInfo;
@property(nonatomic,   copy) NSString *categoryId;
@property(nonatomic,   copy) NSString *loginName;//登陆名
@property(nonatomic,   copy) NSString *signature;//个性签名
@property(nonatomic,   copy) NSString *qq;
@property(nonatomic,   copy) NSString *weixin;
@property(nonatomic,   copy) NSString *phoneNumber;
@property(nonatomic,   copy) NSString *telephone;
@property(nonatomic,   copy) NSString *imageId;
@property(nonatomic,   copy) NSString *userName;    //用户名
@property (nonatomic , copy) NSString *trueName;    //真实姓名
@property(nonatomic,   copy) NSString *title;
@property(nonatomic,   copy) NSString *email;
@property(nonatomic,   copy) NSString *address;
@property(nonatomic,   copy) NSString *website;
@property(nonatomic,   copy) NSString *firstLetter;
@property (nonatomic , copy)NSString *trueFirstLetter;
@property(nonatomic, assign) BOOL  isLock;
@property(nonatomic, assign) double  createDate;
@property(nonatomic, assign) double  updateDate;
@property(nonatomic, assign) double  deductionDate;
@property(nonatomic, assign) double  birthday;
@property(nonatomic, assign) int  streamCount;
@property(nonatomic,   copy) NSString *imageUrl;   //头像
@property(nonatomic, assign) int  imageCount;
@property(nonatomic, assign) int  gender;            //0 女 1 男
@property(nonatomic, assign) int  receiveMessage;
@property(nonatomic, assign) int  orgId;
@property(nonatomic, assign) int  allowLoginFromMobile;
@property(nonatomic,   copy) NSString *lastLogin;
@property (nonatomic , copy) NSString *orgName;

@property(nonatomic, assign) int  reversionRate;   //回复率
@property(nonatomic, assign) int  attentionAmount;//已关注 66
@property(nonatomic, assign) int  attentionMeAmount;//被关注38
@property(nonatomic, assign) int  evaluation; // 没有此字段  评价数
@property(nonatomic,   copy) NSString *contact; // 没有此字段 联系人
@property(nonatomic,   copy) NSString *industry;//从事行业 0-20
@property(nonatomic,   copy) NSString *industryName; 
@property(nonatomic,   copy) NSString *educationDate;//教育经历
@property(nonatomic,   copy) NSString *individualResume; //个人简历
@property (nonatomic , copy) NSString *speciality;   //个人专长

@end
