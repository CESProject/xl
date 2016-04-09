//
//  ListFriend.h
//  CoreDataSample
//
//  Created by zgy on 16/1/8.
//  Copyright © 2016年 zgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelImage.h"

@interface ListFriend : NSObject


// 还是一样，只写你需要的属性就行
@property (nonatomic, strong) NSString *aboutMe;
@property (nonatomic, strong) NSString *createName;
@property(nonatomic,   copy) NSString *address;
@property(nonatomic,   copy) NSString *advantage;
@property(nonatomic,   copy) NSString *applyRule;
@property(nonatomic,   copy) NSString *attachment;
@property(nonatomic,   copy) NSString *briefDescription;
@property(nonatomic,   copy) NSString *capitalUse;
@property(nonatomic,   copy) NSString *cellphone;
@property(nonatomic,   copy) NSString *cityId;
@property(nonatomic,   copy) NSString *cityName;
@property(nonatomic,   copy) NSString *commentNum;
@property(nonatomic,   copy) NSString *createBy;
@property(nonatomic, assign) int  isRelation;
@property(nonatomic, assign) double  createDate;
@property(nonatomic, assign) double  delDate;
@property(nonatomic, assign) double  shelfDate;
@property(nonatomic, assign) double  deadline;
@property(nonatomic, assign) int  delFlg;
@property(nonatomic,   copy) NSString *demandOrientation;
@property(nonatomic,   copy) NSString *detail;
@property(nonatomic, assign) int  directionType;
@property(nonatomic, assign) int  financleAmount;
@property(nonatomic, assign) int  financleDays;
@property(nonatomic,   copy) NSString *growingData;
@property(nonatomic,   copy) NSString *roadId;
@property(nonatomic,   copy) NSString *videoId;
@property(nonatomic, strong) ModelImage *image;///< 碰见字典就可以建一个模型
@property(nonatomic, assign) int praiseCount;
@property(nonatomic, assign) int isLike;  //点赞状态
@property(nonatomic,   copy) NSString *peName;
@property(nonatomic,   copy) NSString *proDescription;
@property(nonatomic,   copy) NSString *isNeedPartner;
@property(nonatomic,   copy) NSString *type;
@property(nonatomic,   copy) NSString *typeName;
@property(nonatomic,   copy) NSString *name;
@property(nonatomic,   copy) NSString *theme;
@property(nonatomic,   copy) NSString *sponsor;

@property(nonatomic,   copy) NSString *content;
@property(nonatomic,   strong)NSArray *attachmentList;

@property (nonatomic , copy) NSString *userName;

@property (nonatomic , copy) NSString *loginName; // 留言的 用户名
@property (nonatomic , strong) id vo;
@property (nonatomic , copy) NSString *imageUrl;


@property(nonatomic,   copy) NSString *infoId;
@property(nonatomic,   copy) NSString *pageInfo;
@property(nonatomic,   copy) NSString *categoryId;
@property(nonatomic,   strong) NSArray *signature;//个性签名
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *currentPrice;


@property(nonatomic,   copy) NSString *qq;
@property(nonatomic,   copy) NSString *weixin;
@property(nonatomic,   copy) NSString *phoneNumber;
@property(nonatomic,   copy) NSString *telephone;
@property(nonatomic,   copy) NSString *imageId;
@property(nonatomic,   copy) NSString *birthday;
@property (nonatomic , copy) NSString *trueName;    //真实姓名
@property(nonatomic,   copy) NSString *title;
@property(nonatomic,   copy) NSString *email;
@property(nonatomic,   copy) NSString *website;
@property(nonatomic,   copy) NSString *firstLetter;
@property (nonatomic , copy)NSString *trueFirstLetter;
@property(nonatomic, assign) BOOL  isLock;
@property(nonatomic, assign) double  updateDate;
@property(nonatomic, assign) double  deductionDate;
@property(nonatomic, assign) int  streamCount;
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
@property(nonatomic,   copy) NSString *educationDate;//教育经历
@property(nonatomic,   copy) NSString *individualResume; //个人简历

@property(nonatomic,   copy) NSString *maxSize;//会议室最大面积m2
@property(nonatomic,   copy) NSString *maxCapacity;//最多可纳人数
@property(nonatomic,   copy) NSString *meetingRoomNum;//会议室数量
@property (nonatomic , copy) NSString *maxLevelLength;//会议室最大层高m
@property (nonatomic , copy) NSString *guestRoomNum;//客房数量
@property (nonatomic , copy) NSString *guestRoomPrice;// 客房参考价格
@property (nonatomic , copy) NSString *serviceFacility;// 场地服务设施
@property (nonatomic , copy) NSString *meetingServiceFacility;//会议服务设施
@property (nonatomic , copy) NSString *diningFacilitity;//场地餐饮设施
@property (nonatomic , copy) NSString *roomFacilityService;//客房设施服务
@property (nonatomic , copy) NSString *meetingHistory;//曾举办会议
//@property (nonatomic , copy) NSString *
//@property (nonatomic , copy) NSString *

@end
