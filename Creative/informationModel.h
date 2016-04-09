//
//  informationModel.h
//  addcellTest
//
//  Created by Mr Wei on 16/1/25.
//  Copyright © 2016年 Mr Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface informationModel : NSObject

@property (nonatomic , copy) NSString *strID;
@property (nonatomic , copy) NSString *provinceId;
@property (nonatomic , copy) NSString *provinceName;
@property (nonatomic , copy) NSString *cityId;
@property (nonatomic , copy) NSString *cityName;
@property (nonatomic , copy) NSString *organizationName;//单位名称
@property (nonatomic , copy) NSString *workStartDate;// 工作开始
@property (nonatomic , copy) NSString *workEndDate;// 工作结束
@property (nonatomic , copy) NSString *position; //所在部门

@property (nonatomic , copy) NSString *schoolType;   //学校类型 0：大学；1：大专；2：高中；3：初中；4：小学；5其他
@property (nonatomic , copy) NSString *schoolName;   //学校名称
@property (nonatomic , copy) NSString *entranceYear; //入学年份
@property (nonatomic , copy) NSString *academyName;  //院系名

@property (nonatomic , copy) NSString *footprintTime; // 足迹
@property (nonatomic , copy) NSString *incident;

@end
