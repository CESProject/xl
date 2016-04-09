//
//  EducationCont.h
//  Creative
//
//  Created by huahongbo on 16/1/21.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EducationCont : NSObject
//
@property(nonatomic,   copy) NSString *academyName;
@property(nonatomic,   copy) NSString *createBy;    //3
@property(nonatomic,   copy) NSString *schoolName;
@property(nonatomic,   copy) NSString *delDate;    //3
@property(nonatomic,   copy) NSString *firstLetter;
@property(nonatomic,   copy) NSString *updateBy;    //3
@property(nonatomic,   copy) NSString *educationID;    //3
@property(nonatomic, assign) double  updateDate;      //3
@property(nonatomic, assign) double  createDate;     //3
@property(nonatomic, assign) int  delFlg;     //101
@property(nonatomic, assign) int  entranceYear;
@property(nonatomic, assign) int  schoolType;

//
@property(nonatomic,   copy) NSString *cityId;
@property(nonatomic,   copy) NSString *cityName;
@property(nonatomic,   copy) NSString *introduction;
@property(nonatomic,   copy) NSString *organizationName;
@property(nonatomic,   copy) NSString *position;
@property(nonatomic,   copy) NSString *provinceId;
@property(nonatomic,   copy) NSString *provinceName;
@property(nonatomic, assign) double  workEndDate;
@property(nonatomic, assign) double  workStartDate;

//
@property(nonatomic,   copy) NSString *footprintTime;
@property(nonatomic,   copy) NSString *incident;

@end
