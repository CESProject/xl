//
//  ImageHead.h
//  Creative
//
//  Created by huahongbo on 16/1/15.
//  Copyright © 2016年 王文静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageHead : NSObject
@property(nonatomic,   copy) NSString *absoluteImagePath;
@property(nonatomic, assign) int  commentCount;
@property(nonatomic,   copy) NSString *createDate;
@property(nonatomic,   copy) NSString *createId;
@property(nonatomic, strong) NSArray *imageList;
@property(nonatomic,   copy) NSString *maxUri;
@property(nonatomic,   copy) NSString *maxUrl;
@property(nonatomic,   copy) NSString *midUri;
@property(nonatomic,   copy) NSString *midUrl;
@property(nonatomic,   copy) NSString *minUri;
@property(nonatomic,   copy) NSString *minUrl;
@property(nonatomic,   copy) NSString *flag;
@property(nonatomic,   copy) NSString *hdheadId;
@property(nonatomic,   copy) NSString *name;
@property(nonatomic,   copy) NSString *orgId;
@property(nonatomic,   copy) NSString *praiseCount;
@property(nonatomic,   copy) NSString *remark;
@property(nonatomic,   copy) NSString *type;
@property(nonatomic,   copy) NSString *size;

@end
