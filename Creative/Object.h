//
//  Object.h
//  Creative
//
//  Created by huahongbo on 16/1/11.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelImage.h"
#import "UserInfo.h"
#import "Reward.h"
#import "Attachment.h"
#import "ImageHead.h"
@interface Object : NSObject
@property(nonatomic,   copy) NSString *address;
@property(nonatomic,   copy) NSString *advantage;
@property(nonatomic,   copy) NSString *amount;
@property(nonatomic,   copy) NSString *attachment;
@property(nonatomic,   strong) NSArray *attachmentList;
@property(nonatomic,   copy) NSString *linkman;
@property(nonatomic,   copy) NSString *telephone;
@property(nonatomic,   copy) NSString *cellphone;
@property(nonatomic,   copy) NSString *briefDescription;
@property(nonatomic,   copy) NSString *categoryId;
@property(nonatomic,   copy) NSString *email;
@property(nonatomic,   copy) NSString *cityId;
@property(nonatomic,   copy) NSString *cityName;
@property (nonatomic , copy) NSString *provinceName;
@property(nonatomic,   copy) NSString *commentNum;
@property(nonatomic,   copy) NSString *createBy;
@property(nonatomic,   copy) NSString *currentNum;
@property(nonatomic,   copy) NSString *upperLimit;
@property(nonatomic,   copy) NSString *cost;
@property (nonatomic , copy)NSString *detail;
@property(nonatomic, assign) double  createDate;
@property(nonatomic, assign) double  delDate;
@property(nonatomic, assign) double  bidLimitDate;   //投标截止日期
@property(nonatomic, assign) double  finishDate;   //众筹（奖励模式）截止时间
@property(nonatomic, assign) double  endDate;      //项目（招募）截止日期
@property(nonatomic, assign) double  startDate;
@property(nonatomic, assign) int  delFlg;
@property(nonatomic,   copy) NSString *currentScanNum;
@property(nonatomic, assign) int  directionType;
@property(nonatomic, assign) int  financleAmount;
@property(nonatomic, assign) int  financleDays;
@property(nonatomic,   copy) NSString *demand;
@property (nonatomic , copy) NSString *declaration;
@property(nonatomic,   copy) NSString *roadId;
@property(nonatomic, strong) ModelImage *image;///< 碰见字典就可以建一个模型
@property(nonatomic, strong) ImageHead *imageHead;
@property(nonatomic,   copy) NSString *oneSentenceDesc;
@property(nonatomic, assign) int  isLimitAmount;
@property(nonatomic, assign) int  limitAmount;
@property(nonatomic, assign) int  logoId;
@property(nonatomic,   copy) NSString *peName;
@property(nonatomic,   copy) NSString *proDescription;
@property(nonatomic,   copy) NSString *videoAddress;
@property(nonatomic,   copy) NSString *isNeedPartner;
@property(nonatomic,   copy) NSString *type;
@property(nonatomic,   copy) NSString *typeName;
@property(nonatomic,   copy) NSString *name;
@property(nonatomic,   copy) NSString *qq;
@property(nonatomic, assign) int  percent;
@property(nonatomic, assign) int  piId;
@property(nonatomic, assign) int  praiseCount;
@property(nonatomic,   copy) NSString *provinceId;
@property(nonatomic, assign) int  publicityType;
@property(nonatomic, assign) double  shelfDate;
@property(nonatomic, assign) int  status;
@property(nonatomic, assign) int  updateBy;
@property(nonatomic, assign) int  updateDate;
@property(nonatomic, assign) int  cooperationStage;
@property(nonatomic,   copy) NSString *thirdPartyUrl;
@property(nonatomic, assign) int  videoId;
@property(nonatomic,strong)NSArray *rewardList;
@property(nonatomic,strong)UserInfo *userInfo;
//判断活动是否已报名， 0已报名1未报名
@property(nonatomic, assign) int  isEnroll;
@property(nonatomic,   copy) NSString *cszijin;
@property(nonatomic, assign) int  prospectYear;  //市场前景年字段
@property(nonatomic, assign) int  prospectMoney;  //市场前景金额字段
@property(nonatomic,   copy) NSString *teamNum;  //团队人数
@property(nonatomic,   copy) NSString *fullTimeNum; //全职人数
@property (nonatomic , copy) NSString *userName;// 评论人名字
@property (nonatomic , copy) NSString *content; //评论内容
@property (nonatomic , copy) NSString *createDatecom; // 评论的时间
@property (nonatomic , copy) NSString *imageUrl; // 评论人的头像

@property (nonatomic , copy) NSString *loginName; // 留言的 用户名

@end
