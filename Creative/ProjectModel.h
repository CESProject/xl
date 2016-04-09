//
//  ProjectModel.h
//  Creative
//
//  Created by Mr Wei on 16/1/8.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectModel : NSObject

@property (nonatomic , copy) NSString *strID;
@property (nonatomic , copy) NSString *strDescription;
@property (nonatomic , copy) NSString *cityId;
@property (nonatomic , copy) NSString *commentNum;
@property (nonatomic , copy) NSString *createBy;
@property (nonatomic , copy) NSString *createDate;
@property (nonatomic , copy) NSString *currentCrowdfundingAmount;
@property (nonatomic , copy) NSString *currentCrowdfundingNum;
@property (nonatomic , copy) NSString *currentScanNum;
@property (nonatomic , copy) NSString *delDate;
@property (nonatomic , copy) NSString *directionType;
@property (nonatomic , copy) NSString *endDate;
@property (nonatomic , copy) NSString *engineeringProperty;
@property (nonatomic , copy) NSString *isLimitAmount;
@property (nonatomic , copy) NSString *limitAmount;
@property (nonatomic , copy) NSString *logoId;
@property (nonatomic , copy) NSString *piId;
@property (nonatomic , copy) NSString *praiseCount;
@property (nonatomic , copy) NSString *provinceId;
@property (nonatomic , copy) NSString *publicityType;
@property (nonatomic , copy) NSString *shelfDate;
@property (nonatomic , copy) NSString *status;
@property (nonatomic , copy) NSString *updateBy;
@property (nonatomic , copy) NSString *updateDate;
@property (nonatomic , copy) NSString *videoId;

//////
@property (nonatomic , copy) NSString *address;
@property (nonatomic , copy) NSString *advantage;
@property (nonatomic , copy) NSString *amount;
@property (nonatomic , copy) NSString *attachmentId;
@property (nonatomic , copy) NSString *bidLimitDate;
@property (nonatomic , copy) NSString *briefDescription;
@property (nonatomic , copy) NSString *cellphone;
@property (nonatomic , copy) NSString *cityName;
@property (nonatomic , copy) NSString *cooperationStage;
@property (nonatomic , copy) NSString *countyId;
@property (nonatomic , copy) NSString *countyName;
@property (nonatomic , copy) NSString *crowdfundingStage;
@property (nonatomic , copy) NSString *declaration;
@property (nonatomic , copy) NSString *delFlg;
@property (nonatomic , copy) NSString *demand;
@property (nonatomic , copy) NSString *displayType;
@property (nonatomic , copy) NSString *email;
@property (nonatomic , copy) NSString *existingFunds;
@property (nonatomic , copy) NSString *exitStrategy;
@property (nonatomic , copy) NSString *feedbackStatus;
@property (nonatomic , copy) NSString *financleAmount;
@property (nonatomic , copy) NSString *financleDays;
@property (nonatomic , copy) NSString *finishDate;
@property (nonatomic , copy) NSString *fullTimeNum;
@property (nonatomic , strong) NSMutableDictionary *strImage;
@property (nonatomic , copy) NSString *imageURL;
@property (nonatomic , copy) NSString *investorIncomeRate;
@property (nonatomic , copy) NSString *linkman;
@property (nonatomic , copy) NSString *minAmount;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *oneSentenceDesc;
@property (nonatomic , copy) NSString *partnerType;
@property (nonatomic , copy) NSString *peName;
@property (nonatomic , copy) NSString *promulgatorContribution;
@property (nonatomic , copy) NSString *promulgatorIncomeRate;
@property (nonatomic , copy) NSString *prospectMoney;
@property (nonatomic , copy) NSString *prospectYear;
@property (nonatomic , copy) NSString *provinceName;
@property (nonatomic , copy) NSString *qq;
@property (nonatomic , copy) NSString *subscriptionNum;
@property (nonatomic , copy) NSString *teamNum;
@property (nonatomic , copy) NSString *telephone;
@property (nonatomic , copy) NSString *thirdPartyUrl;

@property (nonatomic , copy) NSString *totalFinancle;
@property (nonatomic , copy) NSString *transferRate;

@property (nonatomic , copy) NSString *typeName;
@property (nonatomic , copy) NSString *weixin;

@property (nonatomic , copy) NSString *strMoney; // initMoney
@property (nonatomic , copy) NSString *strMoneyType; //initMoneyType
@property (nonatomic , copy) NSString *strType;


@end
