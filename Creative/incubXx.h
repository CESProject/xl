//
//  incubXx.h
//  Creative
//
//  Created by huahongbo on 16/3/11.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Qualification.h"
@interface incubXx : NSObject
@property (nonatomic , strong) NSArray *qualificationList;//孵化器资质
@property (nonatomic , copy) NSString *individualResume;//企业简介
@property (nonatomic , copy) NSString *postcode;//邮编
@property (nonatomic , copy) NSString *companyWebsite;//单位网址
@property (nonatomic , copy) NSString *industry;//所属行业
@property (nonatomic , copy) NSString *address;//地址
@property (nonatomic , copy) NSString *cityName;
@property (nonatomic , copy) NSString *fax;//传真
@property (nonatomic , copy) NSString *companyName;//单位名称
@property (nonatomic , copy) NSString *incubId;
@property(nonatomic, assign) double settledDate; //时间

@property (nonatomic , copy) NSString * maxHatchDuration;//企业最长孵化时间
@property(nonatomic, assign) double hatchTotalArea; //孵化总面积
@property(nonatomic, assign) double utilizationArea; //在孵化企业使用面积
@property (nonatomic , copy) NSString * hatchContainer;//孵化容器（容纳工位数）
@property(nonatomic, assign) double hatchFund;//孵化基金
@property (nonatomic , copy) NSString * graduationEnterpriseNum;//毕业企业数量
@property (nonatomic , copy) NSString * hatchEnterpriseNum;//在孵化企业数量

@property (nonatomic , assign) int managementServicePersonnelNum;//孵化器内管理与服务人员数量
@property (nonatomic , assign) int totalEmploymentNum;//孵化器内总就业数量
@end
