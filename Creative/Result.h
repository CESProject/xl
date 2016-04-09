//
//  Result.h
//  Creative
//
//  Created by huahongbo on 16/1/5.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListFriend.h"
@interface Result : NSObject

// 还是一样，只写你需要的属性就行

@property(nonatomic, strong) NSArray *content; ///< 这个数组里是ListFriend对象， .m告诉这个库
@property(nonatomic, assign) int  firstPage;
@property (nonatomic, strong) NSString *introduction;
@property(nonatomic, assign) int  lastPage;
@property(nonatomic, assign) int  number;
@property(nonatomic, assign) int  numberOfElements;
@property(nonatomic, assign) int  size;
@property(nonatomic, strong) NSArray *sort; ///< 这个sort也可以再建一个模型
@property(nonatomic , copy) NSString *totalElements;
@property(nonatomic, assign) int  totalPages;


@property (nonatomic , copy) NSString *luyanID;
@property (nonatomic , copy) NSString *iconImag; // 头像
@property (nonatomic , copy)NSString*name;
@property (nonatomic , assign)int directionType; //方向
@property (nonatomic , copy)NSString*type;
@property (nonatomic , copy)NSString*categoryId;
@property (nonatomic , copy)NSString*briefDescription; // 简要说明
@property (nonatomic , copy) NSString *luyanContent;
@property (nonatomic , strong)NSMutableArray *attachmentArr;
@property (nonatomic , assign)NSNumber *threeDate;

@property (nonatomic , copy)NSString*diquID;
@property (nonatomic , copy)NSString*diquCode;
@property (nonatomic , copy)NSString*diquName;
@property (nonatomic , copy)NSString*diquTab;
@property (nonatomic , copy)NSString*diquType;
@property (nonatomic , copy)NSString *createDate;// 开始时间
@property (nonatomic , copy)NSString *praiseCount;// 点赞数
@property (nonatomic , copy)NSString *cellphone; // 电话
@property (nonatomic , copy)NSString *qq;
@property (nonatomic , copy)NSString *wechat; //微信
@property (nonatomic , copy)NSString *mobile; //手机
@property (nonatomic , copy)NSString *applyRule; // 报名规则
@property (nonatomic , copy)NSString *detail; // 详细说明
@property (nonatomic , copy)NSString *address; // 详细地址
@property (nonatomic , copy)NSString *typeName; //方向
@property (nonatomic , copy)NSString *commentNum; //评论数


@end
