//
//  placeModel.h
//  Creative
//
//  Created by Mr Wei on 16/1/20.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface placeModel : NSObject

@property (nonatomic , copy) NSString *strID;
@property (nonatomic , assign) NSInteger areaLevel;
@property (nonatomic , copy) NSString *areaName;
@property (nonatomic , assign) NSInteger createBy;
@property (nonatomic , assign) NSInteger createDate;
@property (nonatomic , assign) NSInteger delDate;
@property (nonatomic , copy) NSString *delFlg;
@property (nonatomic , copy) NSString *parentId;
@property (nonatomic , assign) NSInteger updateBy;
@property (nonatomic , assign) NSInteger updateDate;

@property (nonatomic , copy) NSString *cityId;
@property (nonatomic , copy) NSString *cityName;
@property (nonatomic , copy) NSString *directionType;
@property (nonatomic , copy) NSString *directTypeName;

@property (nonatomic , copy) NSString *sqlLine;

@property (nonatomic , copy) NSString *theme;//活动名称
@property (nonatomic , copy) NSString *strType;//活动分类	0:大赛；1：座谈会；2：培训会；3：户外活动；4：其他；5：路演
@property (nonatomic , copy) NSString *isFree;//是否免费
@property (nonatomic , copy) NSString *activityType;//项目进行分类	0：即将开始 1：正在进行 2：已经结束
@property (nonatomic , copy) NSString *timeType;//时间模糊查询	1：今天 2：近三天 3：近一周 4： 近一个月 5：精确时间查询
@property (nonatomic , copy) NSString *startTime; // 开始时间
@property (nonatomic , copy) NSString *endTime;


@property (nonatomic , copy) NSString *name;	//项目名称
//type	项目分类 strType
//cityId	热门地区
@property (nonatomic , copy) NSString *cooperationStage;	//项目阶段
// directionType;	//项目方向
@property (nonatomic , copy) NSString *strMoneyType;	//项目投资 initMoneyType
@property (nonatomic , copy) NSString *teamNum;	//团队人数
@property (nonatomic , copy) NSString *existingFundsType;	//现有资金分类	0:50万以下；1:50~100万；2:100~200万；3:200~500万；4：500~1000万；5：1000万以上
@property (nonatomic , copy) NSString *partnerType;


@property (nonatomic , copy) NSString *ageType;









@end
