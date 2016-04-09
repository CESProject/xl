//
//  MoneyContent.h
//  Creative
//
//  Created by huahongbo on 16/1/19.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelImage.h"
#import "WUserInFo.h"
#import "NeedDataList.h"
#import "InvestmentTradeList.h"
@interface MoneyContent : NSObject
@property(nonatomic,   copy) NSString *areaId;
@property(nonatomic,   copy) NSString *areaName;
@property(nonatomic,   copy) NSString *fundTypeName;
@property(nonatomic,   copy) NSString *image;
@property(nonatomic,   copy) NSString *investmentCase;
@property(nonatomic,   copy) NSString *investmentOverview;
@property(nonatomic,   copy) NSString *investmentTrade;
@property(nonatomic,   copy) NSString *investmentType;
@property(nonatomic,   copy) NSString *investmentTypeName;
@property(nonatomic,   copy) NSString *zijinID;
@property(nonatomic,   copy) NSString *investmentArea;
@property(nonatomic,   copy) NSString *remark;
@property(nonatomic, assign) double  createDate;
@property(nonatomic, assign) double  delDate;
@property(nonatomic, assign) double  shelfDate;
@property(nonatomic, assign) double  updateDate;
@property(nonatomic, assign) int  clickRate;
@property(nonatomic, assign) int  createBy;
@property(nonatomic, assign) int  delFlg;
@property(nonatomic, assign) int  deliveryNumber;
@property(nonatomic, assign) int  fundType;
@property(nonatomic, assign) int  investmentAmount;
@property(nonatomic, assign) int  isDeliver;
@property(nonatomic, assign) int  isRecommend;
@property(nonatomic, assign) int  isUpfrontCost;
@property(nonatomic, assign) int  needData;
@property(nonatomic, assign) int  status;

@property(nonatomic,   copy) NSString *logoId;
@property(nonatomic,   copy) NSString *piId;
@property(nonatomic,   copy) NSString *title;
@property(nonatomic,   copy) NSString *updateBy;
@property(nonatomic,   copy) NSString *upfrontCostAmount;
@property(nonatomic, strong) ModelImage *userImage;
@property(nonatomic, strong) WUserInFo *userInfo;
@property(nonatomic, strong) NSArray *needDataList;
@property(nonatomic, strong) NSArray *investmentTradeList;
@property(nonatomic, strong) NSArray *investmentAreaList;  //无model
@end
