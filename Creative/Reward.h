//
//  Reward.h
//  Creative
//
//  Created by huahongbo on 16/1/11.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reward : NSObject
@property(nonatomic,   copy) NSString *attachmentList;
@property(nonatomic,   copy) NSString *engineeringId;
@property(nonatomic,   copy) NSString *engineeringName;
@property(nonatomic,   copy) NSString *zcId;
@property(nonatomic,   copy) NSString *rewardContent;

@property(nonatomic, assign) double  createDate;
@property(nonatomic, assign) int  carriage;
@property(nonatomic, assign) int  createBy;
@property(nonatomic, assign) int  limitNum;
@property(nonatomic, assign) int  num;
@property(nonatomic, assign) int  rewardDay;
@property(nonatomic, assign) int  supportMoney;
@end
